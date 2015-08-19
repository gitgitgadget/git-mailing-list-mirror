From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v12 10/13] tag.c: use 'ref-filter' data structures
Date: Wed, 19 Aug 2015 21:21:04 +0530
Message-ID: <CAOLa=ZTL-3A1t9qM=Qa=A47qB6TekquKOuS_v58=rZ6-9=L9bw@mail.gmail.com>
References: <1439923052-7373-1-git-send-email-Karthik.188@gmail.com>
 <1439923052-7373-11-git-send-email-Karthik.188@gmail.com> <vpqzj1n2upc.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Aug 19 17:51:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZS5eN-0007oW-Ja
	for gcvg-git-2@plane.gmane.org; Wed, 19 Aug 2015 17:51:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751602AbbHSPvf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2015 11:51:35 -0400
Received: from mail-ob0-f169.google.com ([209.85.214.169]:33489 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751010AbbHSPve (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2015 11:51:34 -0400
Received: by obbhe7 with SMTP id he7so7856926obb.0
        for <git@vger.kernel.org>; Wed, 19 Aug 2015 08:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=O8F5XISBMFjt644vy3p/ZPvtniUTMY2dEbA9iSAxlMU=;
        b=UyOdWVWYah7QoC/hBM+8xaum9T9udNf0sTFmIBuC8r/WkhnXTlNoAeuWC5EIbdKUOv
         58NM8672QXgVjRyNyN9vYZfzTRA/yB/sHurDXgBD0/lYcYiEMgvsj5OJ6vbGoiu7EySQ
         BrqlohZDxcqP62uicZBr81A28/+Gwn9SNRb6S5emw1YLiYFLu2PVpyFiqnrcmWeTyo+d
         mbSbYb7XJstXk2+3tKiQjnvOalt6fhKKAomgYZ/Ie2n9Q9WR6B+KvCtVulOFaHKDSKWp
         I0+umNR73nqHrLlBHStKbuLk2YacbaV7vhbIMb35oImf8r8qypvYk7jhyCMqYYykmeSC
         SnEg==
X-Received: by 10.182.33.38 with SMTP id o6mr11019181obi.41.1439999494023;
 Wed, 19 Aug 2015 08:51:34 -0700 (PDT)
Received: by 10.182.59.102 with HTTP; Wed, 19 Aug 2015 08:51:04 -0700 (PDT)
In-Reply-To: <vpqzj1n2upc.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276199>

On Wed, Aug 19, 2015 at 8:26 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> This is a temporary step before porting 'tag.c' to use 'ref-filter'
>> completely. As this is a temporary step, most of the code
>> introduced here will be removed when 'tag.c' is ported over to use
>> 'ref-filter' APIs
>
> If you resend: missing '.' at the end of sentence.
>

Ok will add.

>> -     if (lines != -1)
>> +     if (filter.lines != -1)
>>               die(_("-n option is only allowed with -l."));
>> -     if (with_commit)
>> +     if (filter.with_commit)
>>               die(_("--contains option is only allowed with -l."));
>> -     if (points_at.nr)
>> +     if (filter.points_at.nr)
>>               die(_("--points-at option is only allowed with -l."));
>
> It may make sense to factor these checks into a function like
>
>   void check_filter_consistancy(struct ref_filter *filter)
>
> in ref-filter.c, since for-each-ref, branch and tag will eventually have
> the same set of constraints on the options.
>

Ah! this is needed only in branch and tag where we need to see if the options
are used with tag.c and both have a different sort of check for this.
Might need more of a cleanup in branch.c and tag.c before we could do something
like this so that we could have a similar check.

for reference branch.c uses:

    if (!!delete + !!rename + !!new_upstream +
        list + unset_upstream > 1)
        usage_with_options(builtin_branch_usage, options);

whereas tag.c uses what you stated above.

-- 
Regards,
Karthik Nayak
