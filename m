From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] gitweb: Consolidate escaping/validation of query string
Date: Sun, 24 Sep 2006 13:36:13 +0200
Message-ID: <20060924113613.GM20017@pasky.or.cz>
References: <20060923221841.18063.56589.stgit@rover> <ef4csl$7vk$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 24 13:36:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRSHT-0006pa-8X
	for gcvg-git@gmane.org; Sun, 24 Sep 2006 13:36:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752007AbWIXLgQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Sep 2006 07:36:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752015AbWIXLgQ
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Sep 2006 07:36:16 -0400
Received: from w241.dkm.cz ([62.24.88.241]:20164 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1752007AbWIXLgP (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Sep 2006 07:36:15 -0400
Received: (qmail 6482 invoked by uid 2001); 24 Sep 2006 13:36:13 +0200
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <ef4csl$7vk$1@sea.gmane.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27658>

Dear diary, on Sun, Sep 24, 2006 at 12:36:13AM CEST, I got a letter
where Jakub Narebski <jnareb@gmail.com> said that...
> Petr Baudis wrote:
> > (click on the funny =__ify file)
> 
> Aaargh? Why this name?

You tell me... ;-)

> > I have also made esc_param() escape [?=&;]. Not escaping [&;] was downright
> > buggy and [?=] just feels better escaped. ;-) YMMV.
..snip..
> I'd rather have new esc_param() or esc_param_value() quote like escape
> subroutine from CGI::Util, with the esception of _not_ escaping '/'
> (it makes funny bookmark, and lot less readable query string), and rename
> current esc_param() to esc_query_string() or esc_params().

Huh, well, what's the point with the rename and why not keep it as it is
with just removing the four characters above? Escaped stuff looks ugly
in a URL. ;-)

BTW, looking at CGI::Util innards, what sick mind serves CGIs from an
EBCDIC machine?

> Perhaps we should have also esc_arg() for things like title attribute
> of <a> (link) element (or other element)

Yes. I wanted to implement your few months old wish to have full string
of abbreviated column contents in title attributes but delayed it for
now because we have no such function yet.

> and filename="..." part of Content-disposition: HTTP header.

This is not HTML-ish so you need quotemeta() here, using entities makes
no sense in this case.

> By the way, the validate_input() should be split into separate subroutines:
> validate_ref() for validating hash, hash_base, hash_parent, hash_parent_base,
> and validate_path() for validating project,

Yes, that would be nice.

> file_name and file_parent parameters.

What's the point in validating those?

> We should _never_ use esc_html except during the output, or just before output.
> It certainly shouldn't take place in parse_* subroutine (or in the fake parse
> like in git_blobdiff)!

Yes, I agree. Will send a fixed patch.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
