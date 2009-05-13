From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Trying to sync two svn repositories with git-svn (repost)
Date: Wed, 13 May 2009 13:28:04 -0400
Message-ID: <32541b130905131028i5c4b1a31j7f760f8157507df6@mail.gmail.com>
References: <20090501142811.GI15420@raven.wolf.lan> <20090502215852.GJ15420@raven.wolf.lan> 
	<32541b130905040858v2a0b7a6br5b056a365fcb6855@mail.gmail.com> 
	<20090504211423.GK15420@raven.wolf.lan> <20090506185224.GM15420@raven.wolf.lan> 
	<32541b130905061223h7efddeecvcc52a369093a6b50@mail.gmail.com> 
	<20090506225042.GN15420@raven.wolf.lan> <32541b130905081344m634a78d5l984f4903ec1515eb@mail.gmail.com> 
	<20090508235821.GO15420@raven.wolf.lan> <20090513120922.GP15420@raven.wolf.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Wong <normalperson@yhbt.net>
To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org,
	Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 13 19:28:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4IFu-0003yY-Kj
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 19:28:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759844AbZEMR2Z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 May 2009 13:28:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758702AbZEMR2Y
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 13:28:24 -0400
Received: from mail-gx0-f166.google.com ([209.85.217.166]:50610 "EHLO
	mail-gx0-f166.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753296AbZEMR2X convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 May 2009 13:28:23 -0400
Received: by gxk10 with SMTP id 10so1435006gxk.13
        for <git@vger.kernel.org>; Wed, 13 May 2009 10:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=iUV+2XslJm6ab6NkxLqZ/Sb8xb9InHl+GZKe+90b3Yo=;
        b=FxUTBL9Mm0vE7U2FTaTzzQ5OirlBkm9RlT33nrzJPvtsVlClFBzj8nF40EA1DR4hRe
         uLxn3RB5hN3+QQiZB90teX6OEmgBdadDBj0w+Ddkqa0LdgcEaQSvglg1bLsamDJbqZD7
         B0py8MiXiOgoJaArgFUhE4JWuazbN0KHwdrIc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=SmuljuK9kbEVpkeXQRfx5dWrsi9ZeNFvOS2OqnbKkxp6hZM4uetMD2mxK7cXgnRkKu
         ml46ltG8OdsfWQZZUiuHblsyja63FJH4WKPPFkcZtIdDe2OVIBDd3547FsLf4Zx+cZVA
         KoDShFZgd0zmj+tLlFcCFxOJIyyyu9ja4I3iY=
Received: by 10.150.202.11 with SMTP id z11mr1599836ybf.92.1242235704065; Wed, 
	13 May 2009 10:28:24 -0700 (PDT)
In-Reply-To: <20090513120922.GP15420@raven.wolf.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119073>

On Wed, May 13, 2009 at 8:09 AM, Josef Wolf <jw@raven.inka.de> wrote:
> Now here's the problem: =A0This last dcommit does simply a reset, bec=
ause
> nothing has changed since the last dcommit. =A0So a5cf3..c3ff2 are _n=
ot_
> marked as ancestors of svn-2/trunk, causing those cherries to be reba=
sed
> at the next dcommit with real changes.

I find this a *bit* curious, since each dcommit should be adding the
cherry-picked changes you just now picked from the opposite branch,
right?  If you weren't going to change anything, then you wouldn't
have needed to do the cherry picks at all; you could have just done a
merge -s ours in both directions in the first place.

Anyway, regardless of the above, AFAIK there's no way to force svn to
make an empty commit, which is a problem in this case.  You can make a
nonempty commit, though; I've done this in the past by just adding a
newline to the end of some arbitrary file.  Basically:

git merge -s ours whatever
echo >>Makefile
git add Makefile
git commit --amend
git svn dcommit

Silly, but it works.

> Unfortunately, dcommit doesn't seem to have an option to force rebase
> instead of resetting.

Well, in fact it *is* rebasing, which throws away the extra commit
because it thinks that commit didn't do anything.  I've experienced
this problem a few times in the past, but I knew what was happening
and I figured my case was too rare to matter.  Perhaps not.

This could be considered a bug in git-svn, so I cc:'d Eric Wong, who I
think is the main git-svn developer.  Anyway, try the workaround
above.

Good luck,

Avery
