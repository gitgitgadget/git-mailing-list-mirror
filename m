From: "Reece Dunn" <msclrhd@googlemail.com>
Subject: Re: git clone questions relating to cpio
Date: Tue, 2 Oct 2007 22:09:52 +0100
Message-ID: <3f4fd2640710021409q104a4204r522391912d5b5c8c@mail.gmail.com>
References: <3f4fd2640710011228w61ce34b5ve47ea529eed384fd@mail.gmail.com>
	 <200710012342.37352.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Johan Herland" <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue Oct 02 23:10:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Icp0J-0007y4-Qh
	for gcvg-git-2@gmane.org; Tue, 02 Oct 2007 23:10:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755331AbXJBVJ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2007 17:09:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755276AbXJBVJ5
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Oct 2007 17:09:57 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:14048 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755140AbXJBVJz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2007 17:09:55 -0400
Received: by nf-out-0910.google.com with SMTP id g13so3412160nfb
        for <git@vger.kernel.org>; Tue, 02 Oct 2007 14:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=u6xAI937lNCJO+s43CwA1t+ldaSJx5RJJ3B/8SdMo0M=;
        b=HFi6Wly1vtEz4Y4t3L/KzmCn/YYdwRC5pPeyYegkPAagPmZ6JLl1qVDGun5TgHx2UxJ4+CwbGPXOaLgVMbeeflJzjVJBotjcLY17/rImIckTGO5D5ZUgqVQ79mtdpozk7pdngCBRj838E8a2lIQ0Y3MQBz7aU+pu0eKhEQCuOJo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZGMfoUUtx9nL4hz0/BNNZlXjjgeiHoHjNPW6/wFm4Gj3D2G8QJZ7q9aK00/s8CKOgg0Xa6kJrYBdUqQfJO55sy1vh5yUqZ+X9RAxXMIIhO6/XkC/qd2MP2e/D2gvaIEhHcy5bMkWu7DEG/2DvPjBOxantbph9czJHsCH6Ceh0Gs=
Received: by 10.78.204.7 with SMTP id b7mr8440590hug.1191359392554;
        Tue, 02 Oct 2007 14:09:52 -0700 (PDT)
Received: by 10.141.23.10 with HTTP; Tue, 2 Oct 2007 14:09:52 -0700 (PDT)
In-Reply-To: <200710012342.37352.johan@herland.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59740>

On 01/10/2007, Johan Herland <johan@herland.net> wrote:
> On Monday 01 October 2007, Reece Dunn wrote:
> > Hi,
> >
> > I am running a Linux From Scratch 6.2 system that does not have cpio
> > installed on it. This means that I can't clone a local repository
> > unless I install cpio. Is it possible to use a fallback method if cpio
> > is not present, as there is no NO_CPIO option on make like there is
> > for OpenSSH, cURL and expat?
>
> Using "file://" when specifying the source repo will force git-clone to use
> the git protocol, instead of doing a copy/hardlink.
>
> I.e. change "git clone foo bar" to "git clone file://foo bar" in order to
> prevent git-clone from calling cpio.

Thanks for the tip.

> However, grepping for cpio in the git source tree reveals a couple of uses
> in git-merge, so you might bump into problems there...

Looks like I'll need to install cpio, then (also allowing me to take
advantage of the fast local clones via hardlinks).

Do you know if cpio is listed anywhere in required dependencies?

> > Also, I have an external USB hardrive that is mounted onto the virtual
> > filesystem. Will clones from the USB harddrive (or a USB flash drive
> > that is mounted) result in a copy being performed, not a hardlink?
>
> Hardlinks are impossible across filesystems. If you're cloning to a
> different filesystem git will _have_ to make a full copy.

Exactly. I was asking this to clarify cpio (and therefore git)
behaviour in this situation.

> > Ideally, the hard linking for local clones should be optional.
>
> <quote src="git-clone(1)">...</quote>

Indeed, they are. Thanks for the info.

> And as I said above, you can use "file://" to force the "git aware"
> transport mechanism, which bypasses the whole local copy/hardlink issue
> entirely.

Sure.

> > What if I want to move a repository because, for example, I have imported
> > a CVS repository and now want to push it to a new bare repository?
>
> Even if you were to use hardlinks, cloning a repo followed by deleting the
> original will be safe (as long as you don't supply '--shared' to
> git-clone). That's the beauty of hardlinks.

That is good to know.

> I also think it's fairly safe to just 'mv' the whole repository to its new
> location.

This also works, as long as you are not moving between a bare and
standard repository.

> Have fun! :)

Will do :)

Thanks,
- Reece
