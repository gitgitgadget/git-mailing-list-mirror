From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [PATCH 2/2] log: remove redundant check for merge commit
Date: Sat, 28 Jul 2012 21:57:49 -0700
Message-ID: <CAOeW2eELzcqnecZqea2K0vO818PTYf-P=xEoSKb5GcW7W0Nf+A@mail.gmail.com>
References: <1343409699-27199-1-git-send-email-martin.von.zweigbergk@gmail.com>
	<1343409699-27199-3-git-send-email-martin.von.zweigbergk@gmail.com>
	<7vfw8czvj5.fsf@alter.siamese.dyndns.org>
	<CAOeW2eFROgZ+taqFvCHoSTVrQZnaQZo567e=73BcA+d5uSjKDA@mail.gmail.com>
	<7v7gtoxw80.fsf@alter.siamese.dyndns.org>
	<7vzk6kwf6l.fsf@alter.siamese.dyndns.org>
	<CAOeW2eG4mKTWm7PEGF_t0F9c_X1gkQaDw7HSrCiZaDte7PvOdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jul 29 06:57:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SvLZk-0005n5-HM
	for gcvg-git-2@plane.gmane.org; Sun, 29 Jul 2012 06:57:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751475Ab2G2E5v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jul 2012 00:57:51 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:44844 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751291Ab2G2E5u (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jul 2012 00:57:50 -0400
Received: by pbbrp8 with SMTP id rp8so7673659pbb.19
        for <git@vger.kernel.org>; Sat, 28 Jul 2012 21:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=QxMIsiEMo8QqJdLOR6wwDiCRlXJf2kDW32F54+fC92s=;
        b=iMxQZkxate+4Cc4aYjxIVkBSl/+0P14qdJGC2DTr65l2jlfdhlPK3/279N3xgR0L5l
         pg2ZlYB34BELtd5o4jXPWJ6rd9IWZywHRgTvPb1T2I8FKu9IsDcIeWePWM3bpXPQdq/F
         pXL/o0p4zWe2XmbyO5KVzY9IsdE78LKieiZeJ6rXThavPzgJQrL/hJ6rWiJU9tcI2e09
         7cRGvP+ML8f7v9qB7t6G7LpHosaeSdCjdujL5kGzwsv7LiVpHXliS5Qm/8fktZSI35P3
         B5e8bSypsqCIRS5sSSpkb3wQ6OvYpfC5X/PCQmtZzi4/h51EKJsaUnWUjPhPy7NIR949
         r5WA==
Received: by 10.66.73.5 with SMTP id h5mr15741477pav.79.1343537869842; Sat, 28
 Jul 2012 21:57:49 -0700 (PDT)
Received: by 10.68.42.164 with HTTP; Sat, 28 Jul 2012 21:57:49 -0700 (PDT)
In-Reply-To: <CAOeW2eG4mKTWm7PEGF_t0F9c_X1gkQaDw7HSrCiZaDte7PvOdQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202467>

Sorry, I meant to CC the list. See below.

On Sat, Jul 28, 2012 at 9:56 PM, Martin von Zweigbergk
<martin.von.zweigbergk@gmail.com> wrote:
> On Fri, Jul 27, 2012 at 11:52 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>> It seems to have some interaction with your other topic, though.
>> These two patches alone will pass the existing tests, but merging it
>> with mz/rebase-range breaks t3412.  I didn't look into it, but
>> perhaps this breaks "git cherry" in some way?
>
> Yes, it breaks "git cherry" quite badly, by not ignoring merges at
> all. I incorrectly assumed that ignore_merges was about revision
> traversal, but now I think it's only diff output from 'git log' (and
> possibly others). What I think tricked me was seeing that
> "ignore_merges = 1" closely followed by a comment saying "ignore
> merges". But now I think the explicit code to "ignore merges" is
> necessary (as show by the failing test case), but can be replaced by
> "rev_info.max_parents = 1". Setting "ignore_merges = 1", OTOH, now
> seems doubly redundant: not only does it set the same value as was set
> in init_revisions, but it's also irrelevant. Since cherry doesn't
> generate any diff output, I think ignore_merges is never used.
> Flipping the values of all of "ignore_merges", "combine_merges" and
> "diff" does not have any effect on test cases at least. I hope my
> explanation makes some sense at least...
>
> I'll send a reroll when I get time.
