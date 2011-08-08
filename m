From: Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 05/48] t6039: Add tests for content issues with
 modify/rename/directory conflicts
Date: Mon, 8 Aug 2011 09:49:40 -0600
Message-ID: <CABPp-BHn=zbQZyOKjmM96SRLifyOdJj5YfRmonCG7etxX43Aiw@mail.gmail.com>
References: <1307518278-23814-1-git-send-email-newren@gmail.com>
	<1307518278-23814-6-git-send-email-newren@gmail.com>
	<7vvcuzdusv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, jgfouca@sandia.gov
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 08 17:49:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QqS5L-0001WW-4C
	for gcvg-git-2@lo.gmane.org; Mon, 08 Aug 2011 17:49:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752430Ab1HHPtm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Aug 2011 11:49:42 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:59795 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751907Ab1HHPtl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2011 11:49:41 -0400
Received: by fxh19 with SMTP id 19so5500280fxh.19
        for <git@vger.kernel.org>; Mon, 08 Aug 2011 08:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=O10OWJbrP0nSBrVp+8nxcFFg7qe/GcjOYQi4fujkTpk=;
        b=D5R6/awt5XFe4VOcNvDEU4nzTdBg/HWHVfb/GJB31sJ8oKb9IHSjJl0vXnzatHtG/b
         9jUIIpH3E/j7GbYvy+AYLGt1JGCUnDjdAFiXCDVs1bbETt23jWAiv5OzOvgSwfUE48wO
         AQc/pdD5cJHqrFhYU4qF1w6oxBubcnrG/1LpQ=
Received: by 10.223.68.136 with SMTP id v8mr300776fai.54.1312818580314; Mon,
 08 Aug 2011 08:49:40 -0700 (PDT)
Received: by 10.223.123.13 with HTTP; Mon, 8 Aug 2011 08:49:40 -0700 (PDT)
In-Reply-To: <7vvcuzdusv.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178959>

Hi,

Thanks for the many detailed reviews.  I've spent much of the weekend
(and before) trying to go through and clean things up, and am still
working on it.  There are some things to comment on outside of the
series re-roll I am putting together...

On Mon, Jul 18, 2011 at 5:37 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Could you add a description for this? Your description on 06/48 is
> beautifly done. Here is my attempt.
...
Done. :-)  It'll be in the reroll I submit.

> I think I said this in my earlier review, and this is not limited to 05/48
> but also applies to 03/48 and 04/48 as well, but there won't be perfect
> rename detection, and the rename detection logic could change (improve)
> over time. Ideally, I think the test should declare either case as a
> success: (1) detection succeeds and avoids unnecessary conflict, or (2)
> rename is missed and conflict is reported, but otherwise there is no data
> loss. If it expects only one but not the other, any time the rename logic
> is improved, the behaviour could change between (1) and (2) and it will
> cause a false positive "breakage" of these tests.

The same could be said for all the rename tests, but I'm a bit worried
about doing this, particularly for the set of tests I added.  I came
up with my testcases by carefully reviewing the code looking for ways
I could trigger problems (which were almost never covered by an
existing regression test), plus trying a few small modifications of
any tests I did come up with.  The tests I added that involve renames
really are specifically designed to test renaming situations.  If
rename detection logic is modified in a way that affects these tests,
and these tests aren't updated, then we are turning some useful unique
tests into mere duplication of simpler tests we have elsewhere.

If you are worried that these tests lack robustness in the face of
rename-detection changes, perhaps we should modify the tests to use
file contents that are more likely to continue being detected as
renames (e.g. longer lines or maybe more of them)?  Or, maybe add an
earlier check in the test to independently verify that the rename is
detected?
