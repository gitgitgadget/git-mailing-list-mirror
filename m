From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: Git merge: conflict is expected, but not detected
Date: Sat, 30 Nov 2013 19:51:24 +1100
Message-ID: <CAH3AnroU9cP67iQnC1pwed_J-CDCHZm06G1e48R-nOtA5+591A@mail.gmail.com>
References: <CAO6Ho0d=JHk4ydd1PdcWP1XHxvXpjfYVK+B_QLgd0vpyFTh_xQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Evgeniy Ivanov <lolkaantimat@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 30 09:51:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VmgHC-0003T7-SD
	for gcvg-git-2@plane.gmane.org; Sat, 30 Nov 2013 09:51:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751114Ab3K3Iv1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Nov 2013 03:51:27 -0500
Received: from mail-la0-f42.google.com ([209.85.215.42]:57097 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750988Ab3K3Iv0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Nov 2013 03:51:26 -0500
Received: by mail-la0-f42.google.com with SMTP id ec20so7473488lab.29
        for <git@vger.kernel.org>; Sat, 30 Nov 2013 00:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=VeFYddyUYlrVx7+RSMSyQnYmT3rEbxSGMQTaPQ3h0Bo=;
        b=aA3wWdLR1AJ1vZk5x4ouhzEc0cb+r1uWqkyUmzv+leN0PC5UG2mWzDjRHQEpK/Yrsn
         bh502C1x5STcVuF1wUnl8IiqkIGS1p3oL34DkNzyxUq9KlY8RV2V2/+8T1/lZxjxi45z
         9EgruKcrSRNOLryUrpKDo32TjNq4aZE7KYTjUceOp9Lp6lwbPZeUWkXUw7KZoRaxqOH/
         DKm9v1NozuU6Piofe1LwDLXdkyowasMf9OSossP71cuYaraVRSokCyYN/x77VtWPfw3v
         52vWIyGr9fFSxYnPKFc6Z5DSjaccZB2RfOmm3yJCUMdmGBTcw75sORrzymoyrUOGzdnS
         iN3Q==
X-Received: by 10.152.234.170 with SMTP id uf10mr49634lac.43.1385801484811;
 Sat, 30 Nov 2013 00:51:24 -0800 (PST)
Received: by 10.114.185.102 with HTTP; Sat, 30 Nov 2013 00:51:24 -0800 (PST)
In-Reply-To: <CAO6Ho0d=JHk4ydd1PdcWP1XHxvXpjfYVK+B_QLgd0vpyFTh_xQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238547>

>From the perspective of topic there had been no change to the
definition of bar(), hence there was no change to contribute to the
eventual merge with master.

One way to avoid this kind of problem is to avoid making (or
cherry-picking) the same change on different branches, but instead use
a merge of a branch with a common base to implement changes needed on
multiple branches.

So, assuming you recognized the need to delete bar() from both topic
and master, create a new branch from the merge-base of topic and
master and delete bar() in that branch. Then merge this branch into
both topic and master.

If you subsequently decide to revert the removal of bar() on topic
then when you decide to merge topic back into master, git will see
that the removal branch has been merged into both branches and will
see the subsequent revert on topic as a change that needs to be merged
and you will get the result you are looking for.

So, as a general rule of thumb, try to avoid making the same change on
two different branches and instead factor out a change needed in
multiple places into a separate branch which is then merged into the
branches that need iit.


On Sat, Nov 30, 2013 at 1:26 AM, Evgeniy Ivanov <lolkaantimat@gmail.com> wrote:
> Hi!
>
> Let's say I have two identical branches: master and topic. In master I
> remove some code, i.e. function bar(). In topic I do the same (commit)
> and after some time I realize I need bar() and revert previous commit
> with removal.
> So I end with master with no bar() and topic with bar() in its
> original state. When I merge I get code without bar() and no merge
> conflict (recursive or resolve strategies). Is it possible to detect
> such situations as conflicts? When bar() is C++ virtual there is no
> possibility to catch this with compiler.
>
> Please, CC me since I'm not subscribed.
>
> Thanks in advance!
>
> --
> Cheers,
> Evgeniy
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
