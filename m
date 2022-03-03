Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF10C433EF
	for <git@archiver.kernel.org>; Thu,  3 Mar 2022 15:45:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234653AbiCCPqg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Mar 2022 10:46:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbiCCPqe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Mar 2022 10:46:34 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE9331959D7
        for <git@vger.kernel.org>; Thu,  3 Mar 2022 07:45:48 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id qa43so11472307ejc.12
        for <git@vger.kernel.org>; Thu, 03 Mar 2022 07:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=sAo2skfAt7q9a/34LY7VhvP7PEyRtD21d8pDWGik5lA=;
        b=P4asPDEz/pT+xUqujwZc5pxy5n25y3Qmki3ztAzaCscGoV6oSLvuB5c5j1i53Zn4nD
         jLeurW9ZfMUIw6D6S9eXsJrVb+S09ZmySirkV6xbm8WXlLOV4i4apo4FLioYcCJDjNce
         iXCWaePyr1QylWwAkaZDhm0G2kpFbsmxjAgWr2w0OSbkXvZVynWoz53BZrGGmuohZnzQ
         k5mQgenYmuUm2bfiSCPgjSF8EVIai/ES4JgGKrcF23tKQ41s9/omZuUbQsV0+fN9DXGi
         nw1kNkSXHddnlhYrHIqYb4goYzXg85E6LHhL1H/qc0untCNmaCJhRzkIQhe6/nSTp924
         itXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=sAo2skfAt7q9a/34LY7VhvP7PEyRtD21d8pDWGik5lA=;
        b=cWxdzbqut9UedubHjhWeP23ivktQWGoQi+aMpFAKI9FY1cbrhMr3UuDqMAiMGvULeb
         BpCqZLbxgZocb2pfYK8ZzhWwXa/wqVwRcl718Yx+XocOpAWKmvpZEYnrfZwX1R9+GM27
         cBqoc8fsmGu6g9+dXCooSTpu/VyU9LONfG4WTtGaB1CuV1qGHRN4LUOD0JQ5v/68PUKC
         MZynDWtbO8lc7RFbh0KO8jv7oIISTSoUljYVzeHQ8yRyQ+r3MQZvpw7jtLHZ8/AY6nVZ
         3PzGxzdifHVxaGIXgWlsPnFqpcrm3T+YQ+eIAAwdJRswMIp/KD44uw72HCXm9OIOdBJ2
         cvlg==
X-Gm-Message-State: AOAM531vA/4lrflurm3JuF+UsC/e9tQCPLLDyo4ig1X4/PGM2+pPl+b2
        XfBboZgNBTpno8dp5RMqpIs=
X-Google-Smtp-Source: ABdhPJwMB7S/3LmS3+TVfTScivZq/yFtoV0tFhzMM2J71wn9lzxS67pEVNHLXEqDLq/HFm3J/iWw1w==
X-Received: by 2002:a17:906:2bc5:b0:6cd:e676:3624 with SMTP id n5-20020a1709062bc500b006cde6763624mr27785935ejg.277.1646322346823;
        Thu, 03 Mar 2022 07:45:46 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id hc43-20020a17090716ab00b006d70d2ff51bsm871501ejc.27.2022.03.03.07.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 07:45:46 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nPneD-000bfh-K5;
        Thu, 03 Mar 2022 16:45:45 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Shubham Mishra <shivam828787@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 00/15] tests: don't ignore "git" exit codes
Date:   Thu, 03 Mar 2022 16:35:16 +0100
References: <cover-00.15-00000000000-20220302T171755Z-avarab@gmail.com>
 <76a1ff22-3eb0-08fb-5aa9-e612ee5b522f@github.com>
 <e3090436-4479-bbc2-3b62-00473f6f530e@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <e3090436-4479-bbc2-3b62-00473f6f530e@gmail.com>
Message-ID: <220303.864k4f3uqe.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Mar 03 2022, Phillip Wood wrote:

> On 03/03/2022 02:02, Derrick Stolee wrote:
>> On 3/2/2022 12:27 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>> As an aside we still have various potential issues with hidden
>>> segfaults etc. in the test suite after this that are tricked to solve,
>>> because:
>>>
>>>   * Our tests will (mostly) catch segfaults and abort(), but if we
>>>     invoke a command that invokes another command it needs to ferry the
>>>     exit code up to us.
>>>
>>>   * run-command.c notably does not do that, so for e.g. "git push"
>
> I'm not sure what you mean by this, the return value of run_command()
> already indicates which signal if any killed the child see for example=20
> run_specified_editor() which re-raises SIGINT and SIGQUIT if the
> editor is killed by those signals.

Yes, it returns the correct status code, but that doesn't help with
(pseudo)code like:

	if (run_command("foo")) /* exits with e.g. 123 */
		die("oh no, foo failed"); /* exits with 128 */

I should have said "code using run-command.c does not do that...",
sorry.

I.e. if "pack-objects" or whatever invoked by a "git push" segfaults
we might exit with status 128, not the code that the underlying command
failed with, and thus lose the segfault or abort().

If you add the appropriate "log_path" to LSAN_OPTIONS and run the test
suite you can see where this fails. I'm adding a mode to test-lib.sh
sooner than later (waiting on the outstanding ab/test-leak-diag) to make
it trivial to report on those.

>>>     tests where we expect a failure and an underlying "git" command
>>>     fails we won't ferry up the segfault or abort exit code.
>>
>> Perhaps run-command.c could auto-exit for certain well-known error
>> codes that could only happen on certain kinds of failures (segfault,
>> for example). A simple die() might be something that is expected to
>> be handled by the top-level command in some cases.
>
> I think we need to be careful that run_command() does not re-raise a
> signal before the caller has a chance to do any cleanup. A caller to=20
> run_command() can already check the return value and choose to die
> based on that after doing any cleanup. If run_command() starts dying
> we'll end up adding more unsafe signal handlers to do the cleanup.

I think the method I described in
https://lore.kernel.org/git/220303.86fsnz5o9w.gmgdl@evledraar.gmail.com/
in the side-thread doesn't suffer from those problems.

I.e. I think the solution to this is not to interrupt whatever code
calls run-command, we'll let it and whatever else the calling program
wants to do run to completion.

We'll just ignore whatever exit(status) we picked at the very end and
exit instead with the status of our a failing child process we invoked,
if any of them returned a status that "test_must_fail" would count as
"failed but BAD!"
