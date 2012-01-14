From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: git grep doesn't follow symbolic link
Date: Sat, 14 Jan 2012 16:50:54 +0700
Message-ID: <CACsJy8BfvhWxqBOj=+7AiF8dZBVEASAuxiOsjOvpmfE3uPrO3A@mail.gmail.com>
References: <CAPRVejc7xND_8Y=Pb5rYGEcaKYUaX7_WkSro-_EL8tTGxkfY3Q@mail.gmail.com>
 <CALkWK0=-LZH4MYhX50v-RWpGA2r+6q50YxsKaOxc0mJ__yuK7g@mail.gmail.com>
 <877h0zlvwd.fsf@thomas.inf.ethz.ch> <7vwr8za04q.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Rast <trast@student.ethz.ch>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Bertrand BENOIT <projettwk@users.sourceforge.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Pang Yan Han <pangyanhan@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 14 10:51:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rm0HB-0001tU-Ch
	for gcvg-git-2@lo.gmane.org; Sat, 14 Jan 2012 10:51:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753521Ab2ANJv3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jan 2012 04:51:29 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:55905 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753272Ab2ANJv2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jan 2012 04:51:28 -0500
Received: by bkuw12 with SMTP id w12so526336bku.19
        for <git@vger.kernel.org>; Sat, 14 Jan 2012 01:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=YX8HH30CanFMZmQxids+ISB7olyFbq31SZGDtkfKaZQ=;
        b=DrU7n+dUrh0YqwjiJgadNMQG9KEn5iOJhY4Ly20H36qMnd0VAMtBNCEFahyEbv/E+z
         hj0/PjtBqncGSqitnQnUMuF1naM3gHPat7fJR1O//c17X/y6/W/GaPM00nFZmKrpoERa
         +hj5+6hZ24Q9FtKbSLUmi1ngKfe5tpJyTwC0E=
Received: by 10.205.132.14 with SMTP id hs14mr1705099bkc.130.1326534685154;
 Sat, 14 Jan 2012 01:51:25 -0800 (PST)
Received: by 10.204.66.77 with HTTP; Sat, 14 Jan 2012 01:50:54 -0800 (PST)
In-Reply-To: <7vwr8za04q.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188558>

(Pang's patch [1] caught my attention so I returned to the original discussion)

[1] http://thread.gmane.org/gmane.comp.version-control.git/188552

On Wed, Jan 11, 2012 at 1:22 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Thomas Rast <trast@student.ethz.ch> writes:
>
>>> I'd imagine so: symbolic links are not portable across different file
>>> systems; Git's internal representation of a symbolic link is a file
>>> containing the path of the file to be linked to.
>>
>> I'd actually welcome a fix to this general area,...
>
> Even though some platforms may lack symbolic links, where they are
> supported, they have a clear and defined meaning and that is what Git
> tracks as contents: where the link points at.
>
> So we would want our "git diff" to tell us, even if you moved without
> content modification the symbolic link target that lives somewhere on your
> filesystem but is outside the control of Git, and updated a symbolic link
> that is tracked by Git to point to a new location, that you updated the
> link. On the other hand, if you did not update a tracked symbolic link,
> even if the location the link points at that may or may not be under the
> control of Git, we do not want "git diff" to show anything. As far as that
> link is concerned, nothing has changed.
>
> Changing this would not be a fix; it would be butchering.

That's a good default. But git should allow me to say "diff the files
that symlinks point to". Link target is content from git perspective,
not from user perspective.

So instead changing the default behavior specifically for git-grep as
Pang did, I think adding --follow-symlinks option, that could be
passed to grep or any of diff family, would be a better approach.
-- 
Duy
