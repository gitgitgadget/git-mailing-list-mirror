From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: Re: [PATCH 09/19] reset.c: replace switch by if-else
Date: Thu, 10 Jan 2013 22:35:47 -0800
Message-ID: <CANiSa6gz-DBv+2gUDPdhgmeYdHg3-OVO80a7NvdLn4vYRyKEnA@mail.gmail.com>
References: <1357719376-16406-1-git-send-email-martinvonz@gmail.com>
	<1357719376-16406-10-git-send-email-martinvonz@gmail.com>
	<7vhamq5e1v.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 11 07:36:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TtYDq-0000m1-AS
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jan 2013 07:36:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753208Ab3AKGfu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2013 01:35:50 -0500
Received: from mail-ie0-f180.google.com ([209.85.223.180]:40849 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751522Ab3AKGft (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2013 01:35:49 -0500
Received: by mail-ie0-f180.google.com with SMTP id c10so1882851ieb.39
        for <git@vger.kernel.org>; Thu, 10 Jan 2013 22:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=SJCy8GyEeez4pXjV0fZsBr58J+fziD6G6AuRo24QR/E=;
        b=SW/Ou/r2G/BbUyAQbQS2JQLJYnVffF827UmkcFM7yA1qM3vUXg+9GftPsr1xpbm2Bz
         kihTAW/LZSjfuJZY/VL45C+XGjnCIRiniuMa7YoKB0dIZGEQH/BAHT3SbT2+qJ5Ilr5X
         Vx5xwRQo8QLgHuW7uofi3bKSHngStqVE4CK+T5JmAgKeNq26PkuJFr8UIjT7kKGSf2++
         2A3MnQP0rMVNXfaiAggqK+KXyMdiWjKkiY3XaR68JG/G0j2LT54nVgFR0RgGIEqzKoyd
         APXBrEogsMmKRgIyqhD4IJJsEyPUEjg3NGHE7eQi21dplDISi1c2B4HZhvY7K6yeElfw
         nqZQ==
Received: by 10.50.42.169 with SMTP id p9mr8114172igl.17.1357886148007; Thu,
 10 Jan 2013 22:35:48 -0800 (PST)
Received: by 10.64.86.68 with HTTP; Thu, 10 Jan 2013 22:35:47 -0800 (PST)
In-Reply-To: <7vhamq5e1v.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213181>

On Wed, Jan 9, 2013 at 11:53 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Martin von Zweigbergk <martinvonz@gmail.com> writes:
>
>> ---
>>  builtin/reset.c | 13 +++----------
>>  1 file changed, 3 insertions(+), 10 deletions(-)
>>
>> diff --git a/builtin/reset.c b/builtin/reset.c
>> index 42d1563..05ccfd4 100644
>> --- a/builtin/reset.c
>> +++ b/builtin/reset.c
>> @@ -351,18 +351,11 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
>>        * saving the previous head in ORIG_HEAD before. */
>>       update_ref_status = update_refs(rev, sha1);
>>
>> -     switch (reset_type) {
>> -     case HARD:
>> -             if (!update_ref_status && !quiet)
>> -                     print_new_head_line(commit);
>> -             break;
>> -     case SOFT: /* Nothing else to do. */
>> -             break;
>> -     case MIXED: /* Report what has not been updated. */
>> +     if (reset_type == HARD && !update_ref_status && !quiet)
>> +             print_new_head_line(commit);
>> +     else if (reset_type == MIXED) /* Report what has not been updated. */
>>               update_index_refresh(0, NULL,
>>                               quiet ? REFRESH_QUIET : REFRESH_IN_PORCELAIN);
>> -             break;
>> -     }
>
> Justification?

Clairvoyance -- the HARD case will soon be the only non-empty case.
It's also missing KEEP and MERGE (but the empty SOFT block is there).

I'll update the message. I will also move the patch a little later in
the series, closer to where it will be useful.
