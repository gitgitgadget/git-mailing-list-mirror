From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Best way to merge two repos with same content, different history
Date: Fri, 5 Jun 2009 13:01:00 -0400
Message-ID: <32541b130906051001k1ea4d960m4fcf7679b5b4f740@mail.gmail.com>
References: <63BEA5E623E09F4D92233FB12A9F794303117DBF@emailmn.mqsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Kelly F. Hickel" <kfh@mqsoftware.com>
X-From: git-owner@vger.kernel.org Fri Jun 05 19:01:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCcnK-00040K-0I
	for gcvg-git-2@gmane.org; Fri, 05 Jun 2009 19:01:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751673AbZFERBU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Jun 2009 13:01:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751419AbZFERBU
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jun 2009 13:01:20 -0400
Received: from mail-gx0-f214.google.com ([209.85.217.214]:34711 "EHLO
	mail-gx0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751379AbZFERBU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Jun 2009 13:01:20 -0400
Received: by gxk10 with SMTP id 10so2984419gxk.13
        for <git@vger.kernel.org>; Fri, 05 Jun 2009 10:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=NU0I4vJfz8fZDma3j6Zid3brdqrSexOU0oKTH0mCtBg=;
        b=yIcZyCknZDsTHmKYjD/djbmwZxlQNlbxnaFddB7QkvzEhXxXsSqKr5MHM84q3xUNUp
         LzYZ39Q95v3AnRZmT7uznYUX2xyaYtApnayhYeBTNf0ARiXB+BXHNZIzdKJAyf4Fs3Dw
         /z9c+F3rckKIdCX4VECtte+ZI5Tqu7cPjEdCA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=wmjXAPLF/Fp1CoW20KCk9Q/X00ltsHfNBIh9BK0OQkkaXm5AGmTtMMhWtTNIO/GIN4
         bIB/ODzzC5oKaFzkJ6JW0UeXTVfIGbQ7E41gyEhokezf04CTOUTYInidN9Like0LPzLt
         HlBXW86czWqN0vsaIPLpDZlFH2USom0EtcU2A=
Received: by 10.151.158.21 with SMTP id k21mr6327986ybo.298.1244221281459; 
	Fri, 05 Jun 2009 10:01:21 -0700 (PDT)
In-Reply-To: <63BEA5E623E09F4D92233FB12A9F794303117DBF@emailmn.mqsoftware.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120811>

On Fri, Jun 5, 2009 at 12:30 PM, Kelly F. Hickel <kfh@mqsoftware.com> w=
rote:
> =A0 =A0 =A0 =A0Stated another way, I have two repositories, "new" and=
 "old",
> where the files in the initial commit on branch "B1" in "new" have
> exactly the same content as the last commit on branch "B1" in "old".
> There also exist various branches in "new" based on "B1". =A0I'd like=
 to
> merge all the commits from "new" into "old", but the SHA1s are
> different, presumably because the history leading up to those points =
are
> different.
>
> =A0 =A0 =A0 =A0Other than using manually format-patch on every branch=
 in new,
> then applying the patches (presumably with regular old patch, since t=
he
> ancestor commit IDs won't match), is there any "good" way to merge "n=
ew"
> into "old"?

The usual replacement for "manually using format-patch" is to use "git
rebase."  It does pretty much exactly what you're describing, assuming
you don't do too many complicated merges in the meantime.

Another option is to use the .git/info/grafts file.  Here's a brief
intro: http://git.or.cz/gitwiki/GraftPoint

You'd use that to pretend the parent of your top-skimmed branch is
actually the equivalent commit in your new branch.  Then could run
"git filter-branch" to make the graft permanent, and get all your
users to switch to the new repository.

Or you could skip the filter-branch stuff and keep the really hold
history somewhere else, available for use if someone installs the
graft in their local repo.  This would lead to a smaller repository in
the general case.  (I gather that's what the Linux kernel does for
per-2.6.11 versions.)

Have fun,

Avery
