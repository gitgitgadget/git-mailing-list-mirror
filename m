From: Evgeniy Ivanov <lolkaantimat@gmail.com>
Subject: Re: Git merge: conflict is expected, but not detected
Date: Sun, 1 Dec 2013 15:02:40 +0400
Message-ID: <CAO6Ho0f2S9==GYy3-Rjmyn8-sPrnz0U_nGXqUAXDxTxQhCTDCg@mail.gmail.com>
References: <CAO6Ho0d=JHk4ydd1PdcWP1XHxvXpjfYVK+B_QLgd0vpyFTh_xQ@mail.gmail.com>
	<CAH3AnroU9cP67iQnC1pwed_J-CDCHZm06G1e48R-nOtA5+591A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Seymour <jon.seymour@gmail.com>, sandals@crustytoothpaste.net,
	mackyle@gmail.com
X-From: git-owner@vger.kernel.org Sun Dec 01 12:03:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vn4nn-0004AJ-Mk
	for gcvg-git-2@plane.gmane.org; Sun, 01 Dec 2013 12:03:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751522Ab3LALCn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Dec 2013 06:02:43 -0500
Received: from mail-ie0-f171.google.com ([209.85.223.171]:34476 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751227Ab3LALCm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Dec 2013 06:02:42 -0500
Received: by mail-ie0-f171.google.com with SMTP id ar20so19267273iec.30
        for <git@vger.kernel.org>; Sun, 01 Dec 2013 03:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=V8LbQivGqyJ+R3SYwP0hjDoz6w2Vte+5894y/1/+b6I=;
        b=m7G22yJqZ38TFRrApY2GGkkf/ebl62GePAN2EW+GGgBpmGAZfvTtmwftr99NsdjPGC
         +VmNpFVZC0oMOMFyC4u7mY59/HZfcUYXNIjEvunMSw0tIJW9pDqmZ8Ebp482hduIdOKV
         69K8L02qA0A9iEplj7QyE9bHBItaoY6wI6yXAV2joyiPsVkbur11h70yOhSs54LHnfiR
         cfDR3Ox26E35lx7OAFyhuTFr/hZFcUUQkNi/hgcB55xpkD1GSD/ujvW46QnvT8D/NZjt
         7ETExgKD0Y1eJZIpzu9AA1pEaP7Ht61dmK0RuraEiwxwwq0WvrlRm/Hi2I8zfs3FRrfm
         5cjw==
X-Received: by 10.43.103.133 with SMTP id di5mr819142icc.38.1385895760166;
 Sun, 01 Dec 2013 03:02:40 -0800 (PST)
Received: by 10.64.77.52 with HTTP; Sun, 1 Dec 2013 03:02:40 -0800 (PST)
In-Reply-To: <CAH3AnroU9cP67iQnC1pwed_J-CDCHZm06G1e48R-nOtA5+591A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238585>

Jon, Kyle, Brian,

Thanks a lot for your answers!

On Sat, Nov 30, 2013 at 12:51 PM, Jon Seymour <jon.seymour@gmail.com> wrote:
> From the perspective of topic there had been no change to the
> definition of bar(), hence there was no change to contribute to the
> eventual merge with master.
>
> One way to avoid this kind of problem is to avoid making (or
> cherry-picking) the same change on different branches, but instead use
> a merge of a branch with a common base to implement changes needed on
> multiple branches.
>
> So, assuming you recognized the need to delete bar() from both topic
> and master, create a new branch from the merge-base of topic and
> master and delete bar() in that branch. Then merge this branch into
> both topic and master.
>
> If you subsequently decide to revert the removal of bar() on topic
> then when you decide to merge topic back into master, git will see
> that the removal branch has been merged into both branches and will
> see the subsequent revert on topic as a change that needs to be merged
> and you will get the result you are looking for.
>
> So, as a general rule of thumb, try to avoid making the same change on
> two different branches and instead factor out a change needed in
> multiple places into a separate branch which is then merged into the
> branches that need iit.
>
>
> On Sat, Nov 30, 2013 at 1:26 AM, Evgeniy Ivanov <lolkaantimat@gmail.com> wrote:
>> Hi!
>>
>> Let's say I have two identical branches: master and topic. In master I
>> remove some code, i.e. function bar(). In topic I do the same (commit)
>> and after some time I realize I need bar() and revert previous commit
>> with removal.
>> So I end with master with no bar() and topic with bar() in its
>> original state. When I merge I get code without bar() and no merge
>> conflict (recursive or resolve strategies). Is it possible to detect
>> such situations as conflicts? When bar() is C++ virtual there is no
>> possibility to catch this with compiler.
>>
>> Please, CC me since I'm not subscribed.
>>
>> Thanks in advance!
>>
>> --
>> Cheers,
>> Evgeniy
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Cheers,
Evgeniy
