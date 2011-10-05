From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [RFC/PATCH] Add multiple workdir support to branch/checkout
Date: Wed, 5 Oct 2011 13:17:13 -0400
Message-ID: <CAG+J_Dz-GXvRbYUXSoyfyHfOO-_BszcOza9x=ysHhmL5YBW-Jw@mail.gmail.com>
References: <1317786204-57335-1-git-send-email-jaysoffian@gmail.com>
	<CACsJy8AqYq+YF+rvUp=BBeFUAtUz783iF2jbUp3fO58yLp9ptQ@mail.gmail.com>
	<CAG+J_DygQTD5ibco=-NOiKg0BLgBGFJnvV8zPyhngC2iZv_H8g@mail.gmail.com>
	<7vpqib8jzk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 05 19:17:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBV5s-00020X-CX
	for gcvg-git-2@lo.gmane.org; Wed, 05 Oct 2011 19:17:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934555Ab1JERRP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Oct 2011 13:17:15 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:62755 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934481Ab1JERRO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Oct 2011 13:17:14 -0400
Received: by ggnv2 with SMTP id v2so903561ggn.19
        for <git@vger.kernel.org>; Wed, 05 Oct 2011 10:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=NHtynY97DmBu0gd2ucMOqU8x5ee9HaNWVbt38bE9iFs=;
        b=q6zlO1l3lm+ENmENepx3O6OAysz5/6oMBT2ySkbLee0W9X4CreDBbydOJJdcVJJu8j
         KN/Bs0wgKw6fWVrXNoYqhxK48dz7pdtskkEu4zlNAaysPcnlsT7tWMklsREPH5YGfekk
         kSJB1gsC+QB9gul3Pg1L+ZQcFgbSmv5C6KBPQ=
Received: by 10.236.155.1 with SMTP id i1mr15466830yhk.8.1317835033984; Wed,
 05 Oct 2011 10:17:13 -0700 (PDT)
Received: by 10.147.32.18 with HTTP; Wed, 5 Oct 2011 10:17:13 -0700 (PDT)
In-Reply-To: <7vpqib8jzk.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182863>

On Wed, Oct 5, 2011 at 12:46 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> In this case, each workdir needs its own key, so I'd have to record
>> the key somewhere, unless you meant using a key of "checkout:
>> </path/to/workdir>".
>
> That actually is how I read his message.
>
> I do not think "we cannot off the top of our heads think of the reason
> other than the branch is checked out that we might want to forbid its
> update" is a very good excuse to cast the word "checkout" in the UI; you
> would paint yourself in a difficult corner that you have to expend more
> energy to get out of by later adding backward compatibility support.

Git has survived w/o needing to lock branches till now. What are these
use cases we cannot already think of today?

> I think "switch_branches()" that updates HEAD to point at a local branch
> is one good place to lock the branch, but I do not know if it is a good
> idea to hook the check into the codepaths for deletion of the branch using
> "branch -[dD]" and check-out of the branch using "checkout $branch". I
> wonder if it makes sense to add the "checking" hook into much lower level
> in the callchain, perhaps delete_ref(), rename_ref() and update_ref() to
> catch attempts to update "your" current branch by other people.

I don't think so. There are lots of ways to shoot yourself in the foot
at the plumbing level. Besides, this is not about all refs, just local
branches.

Aside, there's nothing wrong with renaming a checked out branch.

> For that
> matter, instead of switch_branches(), would it make more sense to add this
> lock/unlock logic to symbolic_ref() that repoints HEAD to other branch?

I think you mean create_symref()? Looking at it's callers that seems
too low-level.

Maybe you could sketch out how you think this should work, I'm not seeing it.

- Where/how should the lock be recorded?
- Which function(s) should record/release the lock?

j.
