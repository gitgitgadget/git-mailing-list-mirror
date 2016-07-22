Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B01E203E2
	for <e@80x24.org>; Fri, 22 Jul 2016 20:00:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752570AbcGVUA4 (ORCPT <rfc822;e@80x24.org>);
	Fri, 22 Jul 2016 16:00:56 -0400
Received: from mail-it0-f47.google.com ([209.85.214.47]:36359 "EHLO
	mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751998AbcGVUAz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2016 16:00:55 -0400
Received: by mail-it0-f47.google.com with SMTP id f6so44675293ith.1
        for <git@vger.kernel.org>; Fri, 22 Jul 2016 13:00:54 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=GFRe01BhDv5ftsIgQqXYOOBJOuleR8lDxBawZFQ8vvI=;
        b=PM1HBHrjWb8CnrjojW13HvEW5+6RAMQfKZRA7nOO46QodKo0nS7FvC2TvttS3y50LL
         SAeG3v0lF4U58IsD8ANJlD9AQEKIvUCVc3I1fX/bxdYEryGdA48ZMxSH7vA/GaD9Zu64
         GwHN+N5LawO3sBGnfGEGrvcF8rHBmvOPkqq9/3KD8qRIa0Md1AETYE5Mhtb2H3D7ws8F
         RE07+0Z/s5jogyPyYJnxEep1mw5R6pCoQoKPMJyrt24ShLBcElQzyTc0Ld5fmtWz//9l
         ksC6MbByjiqZAoNjD9fT9B2Aqyinj+6KvyqYtzO9lusfAbe0d4kg/mx617DTvWsmg2E8
         nt5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=GFRe01BhDv5ftsIgQqXYOOBJOuleR8lDxBawZFQ8vvI=;
        b=PiEEpWlUTtAZa6/DxgyYZZWBof7J4AHcq1yfTvU8xkDtBlEhRywW90oAoqQMF37v4u
         OA4YQU9JoUoypaACKNgwr5IpgcAfXz+nfqwrjFQBraIrPg+Z9b3H+7bbKCHWDLjjHxJ2
         qhLMjQwC7qlzdkmsI2aVk6ZC8flsygz2WDQTLzPcJu1SJ9O/eZTnHk0DZR5YysM35Fs3
         tHlgeKPlT6JqCGkbG81NkRoxrzdeIfwgd0Tb6MHs1GMirpdoHXlFE07Z1qj6ZjmKrjVX
         ZdBLTVU1/duct78KOXe5ri5eyXC+sfoNaz4sKMG0iFdTjW8iGVTOQk6qFm9P2q0Ro94Q
         LM+w==
X-Gm-Message-State: ALyK8tJhvYTRoH1e/QqspxO3aOQmsvIl0s99XfqEbKarD0KFGZRzmqJu0OPOHh3C8+kvw7DBzMTci94ViRvT6GnH
X-Received: by 10.36.228.138 with SMTP id o132mr68330567ith.49.1469217654078;
 Fri, 22 Jul 2016 13:00:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Fri, 22 Jul 2016 13:00:53 -0700 (PDT)
In-Reply-To: <xmqq60rxa1sl.fsf@gitster.mtv.corp.google.com>
References: <8c0e116b-b604-ee83-197a-538eedf6e0ea@kdbg.org>
 <4d40da99-2f66-a380-840f-1828dc5b9324@kdbg.org> <CAGZ79kbiVwyyTZLxQP+ioLBoC6r8dcJV4SdDUL_bn58bFUbsWg@mail.gmail.com>
 <xmqq60rxa1sl.fsf@gitster.mtv.corp.google.com>
From:	Stefan Beller <sbeller@google.com>
Date:	Fri, 22 Jul 2016 13:00:53 -0700
Message-ID: <CAGZ79kaoxo9qM-r9nNzG8GV4aCfun4RaK8jpsdSgbyix1bJBFg@mail.gmail.com>
Subject: Re: [PATCH 2/2] submodule-helper: fix indexing in clone retry error
 reporting path
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Johannes Sixt <j6t@kdbg.org>,
	Git Mailing List <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jul 22, 2016 at 12:52 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> The approach to tests is different though. I like yours better than mine,
>> as it doesn't add more tests, but strengthens existing tests.
>
> So... are you retracting
> http://thread.gmane.org/gmane.comp.version-control.git/299995 and
> instead giving an Ack to these two?
>

I like this series better
* for the approach
* for the tests
* for the commit message

So I do think this should be applied instead of what I sent.

I am tempted to send a squash proposal like:
(broken whitespaces)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 6f6d67a..77be97e 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -796,6 +796,8 @@ static int update_clone_task_finished(int result,
  return 0;
  } else {
  idx -= suc->list.nr;
+ if (idx >= suc->failed_clones_nr)
+ die("BUG: idx too large???");
  ce  = suc->failed_clones[idx];
  strbuf_addf(err, _("Failed to clone '%s' a second time, aborting"),
     ce->name);
