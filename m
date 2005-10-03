From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Honor extractor's umask in git-tar-tree.
Date: Mon, 3 Oct 2005 11:18:15 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510031113500.31407@g5.osdl.org>
References: <20050930160353.F025C352B7B@atlas.denx.de>
 <Pine.LNX.4.64.0510010934290.3378@g5.osdl.org> <7vr7b53y0n.fsf@assigned-by-dhcp.cox.net>
 <7vk6gx3vkt.fsf_-_@assigned-by-dhcp.cox.net> <433F52DC.5090906@zytor.com>
 <pan.2005.10.02.09.55.52.564046@smurf.noris.de> <4340B73B.1090409@zytor.com>
 <7virwfuqwv.fsf@assigned-by-dhcp.cox.net> <43415C9A.1090502@zytor.com>
 <Pine.LNX.4.64.0510031028370.31407@g5.osdl.org> <434172FD.7020302@zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 03 20:20:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EMUtO-00050r-W4
	for gcvg-git@gmane.org; Mon, 03 Oct 2005 20:18:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932494AbVJCSSY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Oct 2005 14:18:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932497AbVJCSSY
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Oct 2005 14:18:24 -0400
Received: from smtp.osdl.org ([65.172.181.4]:37510 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932494AbVJCSSX (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Oct 2005 14:18:23 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j93IIG4s026223
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 3 Oct 2005 11:18:16 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j93IIFfP010987;
	Mon, 3 Oct 2005 11:18:15 -0700
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <434172FD.7020302@zytor.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.118 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9643>



On Mon, 3 Oct 2005, H. Peter Anvin wrote:
>
> Linus Torvalds wrote:
> > 
> > As to tar: I think the current
> > 
> >         if (S_ISDIR(mode) || S_ISREG(mode))
> >                 mode |= (mode & 0100) ? 0777 : 0666;
> > 
> > is wrong. It makes things world-writable by default, and that's just
> > dangerous.
> 
> That's standard in the Unix world, though; of course, the user's umask
> shouldn't be set to zero unless things are in very special circumstances.  In
> the case of tar, the umask is applied on extraction unless the user explicitly
> specifies -p.

Is it? The only place umask is mentioned in the man-page is

       --no-same-permissions
              apply  user?s  umask  when  extracting files instead of recorded
              permissions

but if tar really does honor umask, then hey, that 0777/0666 is fine.

(Ahh, googling a bit more, it appears that "-p" is default for root, which 
explains why you'd need the "anti-flag").

		Linus
