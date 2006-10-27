X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Improve git-prune -n output
Date: Fri, 27 Oct 2006 03:45:01 +0200
Message-ID: <20061027014501.GU20017@pasky.or.cz>
References: <200610261138.24761.andyparkins@gmail.com> <4540F16F.4060604@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 27 Oct 2006 02:00:06 +0000 (UTC)
Cc: Andy Parkins <andyparkins@gmail.com>, junkio@cox.net,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <4540F16F.4060604@shadowen.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30272>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GdGmV-0001gx-37 for gcvg-git@gmane.org; Fri, 27 Oct
 2006 03:45:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1946087AbWJ0BpH (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006
 21:45:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946101AbWJ0BpH
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 21:45:07 -0400
Received: from w241.dkm.cz ([62.24.88.241]:38279 "EHLO machine.or.cz") by
 vger.kernel.org with ESMTP id S1946087AbWJ0BpC (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006 21:45:02 -0400
Received: (qmail 7679 invoked by uid 2001); 27 Oct 2006 03:45:01 +0200
To: Andy Whitcroft <apw@shadowen.org>
Sender: git-owner@vger.kernel.org

Junio wrote:
> - We do not enclose a single statement in {}.

I don't think we need to enforce this rule in particular too rigorously
since in comparison with other style slips, it doesn't put you off by
unusual styling when you are reading the code, its only effect at all is
slight vertical space waste (but it isn't a pure loss anyway, for that
matter).


Dear diary, on Thu, Oct 26, 2006 at 07:33:35PM CEST, I got a letter
where Andy Whitcroft <apw@shadowen.org> said that...
> Andy Parkins wrote:
> > prune_object() in show_only mode would previously just show the path to the
> > object that would be deleted.  The path the object is stored in shouldn't be
> > shown to users, they only know about sha1 identifiers so show that instead.
> > 
> > Further, the sha1 alone isn't that useful for examining what is going to be
> > deleted.  This patch also adds the object type to the output, which makes it
> > easy to pick out, say, the commits and use git-show to display them.
> > Signed-off-by: Andy Parkins <andyparkins@gmail.com>
> > ---
> >  builtin-prune.c |    7 ++++++-
> >  1 files changed, 6 insertions(+), 1 deletions(-)
> > 
> > diff --git a/builtin-prune.c b/builtin-prune.c
> > index 7290e6d..e3bcf5f 100644
> > --- a/builtin-prune.c
> > +++ b/builtin-prune.c
> > @@ -16,8 +16,13 @@ static struct rev_info revs;
> >  
> >  static int prune_object(char *path, const char *filename, const unsigned char *sha1)
> >  {
> > +	char type[20];
> > +
> >  	if (show_only) {
> > -		printf("would prune %s/%s\n", path, filename);
> > +		if (sha1_object_info(sha1, type, NULL)) {
> > +			strcpy( type, "unknown type" );
> > +		}
> > +		printf("would prune %s %s\n", sha1_to_hex( sha1 ), type );
> >  		return 0;
> >  	}
> >  	unlink(mkpath("%s/%s", path, filename));
> 
> If we are changing the format would it not make more sense to be in the
> same order as the tool that lets you use it?
> 
> I thought that was git cat-file <type> <commit-ish>

Seconded and please use just 'unknown' for the type string, so that you
can split the lines on spaces in scripts.

Besides, in what situation do we actually get the unknown output?

Thanks,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
