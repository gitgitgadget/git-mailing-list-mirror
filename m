From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [RFC/PATCH] Add multiple workdir support to branch/checkout
Date: Thu, 6 Oct 2011 09:38:52 +1100
Message-ID: <CACsJy8D9xgLtYTkgWWkiuQPbonfM7zY49WDxaW9ng=e7x_Pk5g@mail.gmail.com>
References: <1317786204-57335-1-git-send-email-jaysoffian@gmail.com>
 <CACsJy8AqYq+YF+rvUp=BBeFUAtUz783iF2jbUp3fO58yLp9ptQ@mail.gmail.com>
 <CAG+J_DygQTD5ibco=-NOiKg0BLgBGFJnvV8zPyhngC2iZv_H8g@mail.gmail.com> <7vpqib8jzk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 06 00:39:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBa7c-0002R8-JN
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 00:39:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935467Ab1JEWjX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Oct 2011 18:39:23 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:34154 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934803Ab1JEWjX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Oct 2011 18:39:23 -0400
Received: by bkbzt4 with SMTP id zt4so2670454bkb.19
        for <git@vger.kernel.org>; Wed, 05 Oct 2011 15:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Z8jZvnsGPJGWNnGu67kVsW+TllAXXZ34ECa9z2U6GVA=;
        b=K5Cfg0CAogLgz4QDdX6kz9QGE3fkbzaoNyDKW8nXI8nozorfSqvccVY5pp3lBetOY3
         HOeyXQ4o8zKxFG7sX9YVXkrd5Xv/Vne2+faH4ZHlyiQrNLb25xJJywClx9JV88S+vEPE
         6ODQAXHpyjNiLtA07O8tKv8PiKxZRvFUuM+mA=
Received: by 10.204.141.134 with SMTP id m6mr7773bku.199.1317854362124; Wed,
 05 Oct 2011 15:39:22 -0700 (PDT)
Received: by 10.204.120.75 with HTTP; Wed, 5 Oct 2011 15:38:52 -0700 (PDT)
In-Reply-To: <7vpqib8jzk.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182898>

On Thu, Oct 6, 2011 at 3:46 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jay Soffian <jaysoffian@gmail.com> writes:
>
>> On Wed, Oct 5, 2011 at 12:02 AM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
>>> Could you please consider a more generic approach? What I have in mind
>>> is a mechanism to "lock" a branch, so that only commands that have the
>>> key can update it.
>>>
>>> So instead of branch.<name>.checkout, I would have something like
>>> branch.<name>.locked = <key>, where <key> is just a string. Only
>>> commands that provide the matching <key> are allowed to update the
>>> branch. In checkout case, <key> could be "checkout: worktree".
>>
>> In this case, each workdir needs its own key, so I'd have to record
>> the key somewhere, unless you meant using a key of "checkout:
>> </path/to/workdir>".
>
> That actually is how I read his message.

That's what I meant.

> I think "switch_branches()" that updates HEAD to point at a local branch
> is one good place to lock the branch, but I do not know if it is a good
> idea to hook the check into the codepaths for deletion of the branch using
> "branch -[dD]" and check-out of the branch using "checkout $branch". I
> wonder if it makes sense to add the "checking" hook into much lower level
> in the callchain, perhaps delete_ref(), rename_ref() and update_ref() to
> catch attempts to update "your" current branch by other people.

I'd aim at low-level ref manipulation because too me it affects more
than just "git checkout".

> For that
> matter, instead of switch_branches(), would it make more sense to add this
> lock/unlock logic to symbolic_ref() that repoints HEAD to other branch?

Couldn't find symbolic_ref() in current code. If you meant
create_symref(), yes that would make sense.
-- 
Duy
