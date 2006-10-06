From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: gitweb: using quotemeta
Date: Fri, 6 Oct 2006 11:21:05 -0700 (PDT)
Message-ID: <20061006182105.17519.qmail@web31806.mail.mud.yahoo.com>
References: <20061006135019.GN20017@pasky.or.cz>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 06 20:21:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GVuJz-0001qZ-8G
	for gcvg-git@gmane.org; Fri, 06 Oct 2006 20:21:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422814AbWJFSVJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Oct 2006 14:21:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422820AbWJFSVI
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Oct 2006 14:21:08 -0400
Received: from web31806.mail.mud.yahoo.com ([68.142.207.69]:58462 "HELO
	web31806.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1422816AbWJFSVG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Oct 2006 14:21:06 -0400
Received: (qmail 17521 invoked by uid 60001); 6 Oct 2006 18:21:05 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=phNeJMUO1IM7yem6AEEkQYtQ/wWiLSdCHQD11GTgEeg4ofZmfV14L2E2JNrlXHD3sM5iqZ6ralmASnJDOADPNStgFpV+IRB2GtAky7LxPyHgdjIi6T5VNnzH2w0wLQD51ZHfG9bDRjmicTVuRwxQAG5l/WLZQ8KxD8Q7YMIhGwY=  ;
Received: from [64.215.88.90] by web31806.mail.mud.yahoo.com via HTTP; Fri, 06 Oct 2006 11:21:05 PDT
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20061006135019.GN20017@pasky.or.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28425>

--- Petr Baudis <pasky@suse.cz> wrote:
> Dear diary, on Mon, Oct 02, 2006 at 10:12:56PM CEST, I got a letter
> where Luben Tuikov <ltuikov@yahoo.com> said that...
> > Escaping for the purposes of HTML _view_ and URL generation is ok,
> > but it is not ok when _saving_ the file with a file name.
> > 
> > A file name is just a string of chars, and I want to _save_ the file
> > name as its name is. No changes or interpretations please.  I don't
> > care what the string is, what chars it is made of, etc.
> > 
> > Please don't interpret file names and their characters when the files
> > are _saved_ by the user's browser.
> > 
> > The file name in my filesystem should be the exact same file name
> > as it appears on any other filesystem hosting the same git repo.
> > 
> > I don't want this translation:
> > Server FS: linux-2.6.git-5c2d97cb31fb77981797fec46230ca005b865799.tar.gz
> > Quotemeta: linux\-2\.6\.git\-5c2d97cb31fb77981797fec46230ca005b865799\.tar\.gz
> > User FS: linux\-2\.6\.git\-5c2d97cb31fb77981797fec46230ca005b865799\.tar\.gz
> 
> Then the user agent is buggy - which browser exhibits this behaviour?

Latest greatest Firefox for Linux.  And no, I don't think that
the browser is broken.

> According to RFC2183, the filename is a value. According to RFC2045, a
> value is either a token (uninteresting) or a quoted-string. According to
> RFC822:
> 
>      quoted-string = <"> *(qtext/quoted-pair) <">; Regular qtext or
>                                                  ;   quoted chars.
> 
>      qtext       =  <any CHAR excepting <">,     ; => may be folded
>                      "\" & CR, and including
>                      linear-white-space>
> 
>      quoted-pair =  "\" CHAR                     ; may quote any char
> 
> So what we emit is completely correct.

(Your quotations do not seem correct according to 
  ftp://ftp.rfc-editor.org/in-notes/rfc2045.txt !)

Petr, I agree with your that what we emit is "completely correct".

But is is _mangled_.  I.e. why mangle the filename from "a.b" to
"a\.b" ?  Indeed the latter _is_ qtext but it is not the original name
given to the file.

What actually happened is that _gitweb_ itself mangles the name.

> Of course I have nothing against escaping just ", \ and CR. I don't mind
> just substituting CR with some other string, but please just quote " and
> \ correctly.

Indeed, these three are the only chars NOT ALLOWED in qtext.
Will quote those.  Thanks for pointing this out.

> As of now, gitweb will not handle any filenames containing those three
> characters properly because of now.

Will fix.

Thanks,
   Luben



> 
> -- 
> 				Petr "Pasky" Baudis
> Stuff: http://pasky.or.cz/
> #!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
> $/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
> lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
> 
