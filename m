From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/3] fast-export: improve argument parsing
Date: Thu, 9 May 2013 18:02:21 -0500
Message-ID: <CAMP44s2RYPENwsPAcoaKjmHxkuVA52vvRrQ_stmT_qY-Pmt6HA@mail.gmail.com>
References: <1368063095-22861-1-git-send-email-felipe.contreras@gmail.com>
	<1368063095-22861-2-git-send-email-felipe.contreras@gmail.com>
	<7vzjw37q7o.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 10 01:02:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaZr5-00085g-M3
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 01:02:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758770Ab3EIXC0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 May 2013 19:02:26 -0400
Received: from mail-lb0-f178.google.com ([209.85.217.178]:34812 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756779Ab3EIXCX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 May 2013 19:02:23 -0400
Received: by mail-lb0-f178.google.com with SMTP id x10so3567263lbi.23
        for <git@vger.kernel.org>; Thu, 09 May 2013 16:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=w/d3jhphBERWBDABxGtB0F3CXa4ALXxRM9vE8J1bqB0=;
        b=tqnBuqAeeq5OYX1ky61qMCRawzE72K4woJAlTWHg2CR3jZG6ipYNoVQny5uhhR1pX7
         v0wIRyMQQqu5k+zDDVDuPggJPi6RgHHTF9X3BJk2RRfIj/Bojh3kGauYPGMwKUz5DhGA
         kXdLN7SvPKFtDtna0ZLGRVYr38bAyI9vlO/a2QHNopP98OugYik0mdu5CnWEyjKxhPpg
         Ek2VZs8TMwQKGgIsKydDv9vdwjpqcYg5RdppCaiMt/XI+Pv2IFQZplhwyVl8Ksg5s8we
         KTzCT5Bp9uPMM3kzmJyAR9aH7LSrNsFN2lmD36UbdjSCFMH1spJQBkKKkzDuyQicvoJg
         diVQ==
X-Received: by 10.152.116.71 with SMTP id ju7mr6471622lab.38.1368140541514;
 Thu, 09 May 2013 16:02:21 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Thu, 9 May 2013 16:02:21 -0700 (PDT)
In-Reply-To: <7vzjw37q7o.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223796>

On Thu, May 9, 2013 at 5:17 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> We don't want to pass arguments specific to fast-export to
>> setup_revisions.
>
> Interesting.  What bad things happen with the current order?
>
> Does "fast-export --export-marks=foo" causes setup_revisions() to
> mistakenly eat --export-marks=foo and barf?

No, apparently it skips them. But try 'git fast-export --export-marks
marks HEAD'.

>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>> ---
>>  builtin/fast-export.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/builtin/fast-export.c b/builtin/fast-export.c
>> index d60d675..6e46057 100644
>> --- a/builtin/fast-export.c
>> +++ b/builtin/fast-export.c
>> @@ -686,8 +686,9 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
>>       revs.topo_order = 1;
>>       revs.show_source = 1;
>>       revs.rewrite_parents = 1;
>> +     argc = parse_options(argc, argv, prefix, options, fast_export_usage,
>> +                     PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_KEEP_UNKNOWN);
>>       argc = setup_revisions(argc, argv, &revs, NULL);
>> -     argc = parse_options(argc, argv, prefix, options, fast_export_usage, 0);
>>       if (argc > 1)
>>               usage_with_options (fast_export_usage, options);
>
> There is a SP between the function name and its arguments here ;-)

Yeah, and I already did my part: I sent a patch to fix this style. Not
that it has anything to do with this patch.

-- 
Felipe Contreras
