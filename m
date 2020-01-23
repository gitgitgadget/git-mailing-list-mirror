Return-Path: <SRS0=ZAU+=3M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C051C2D0DB
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 14:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C49AB214AF
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 14:16:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GDoW6amC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbgAWOQc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jan 2020 09:16:32 -0500
Received: from mail-wm1-f51.google.com ([209.85.128.51]:36889 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbgAWOQc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jan 2020 09:16:32 -0500
Received: by mail-wm1-f51.google.com with SMTP id f129so2711187wmf.2
        for <git@vger.kernel.org>; Thu, 23 Jan 2020 06:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=vXRa/IrqCs48r6DvCfgydMrb98o/fX8izBIuDx72MHM=;
        b=GDoW6amC1IbybmH3HHPWpAB2fT1x4PUae0+PkIE8EZg8uFVBuJL9PdOvmkkDJSOPFz
         W9OIOmoXBcSjkItWTzGq33oDiCDBPL3ZVEtBZpI6fnJrhkAkUk8mNtZnTS8syM8qhIDM
         F3I+lJxH59xlDT9xxAVZe08sQYA6R6qkzSR/cSm3o17o5/OquNiTCFizQG+yJgZqlRgL
         xNWKiEIwtlBsMOm9SL/sFQ6oKN9oOefFjLFTuTmMiWHoDvKM9EMuugY15NtjpiUd9mwN
         /r+GudrDQKk4L03h7OS4aqTWuus4iqXOiFB9pZOxanjSwGjcCm/s1WPJVHfNsqHz8UKs
         7KVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=vXRa/IrqCs48r6DvCfgydMrb98o/fX8izBIuDx72MHM=;
        b=XbO2H9JOa++g37OeMf3Wk2UQZyLB6usx2qJQBYOtH8k43JORGOCsUm1FxeQH7/hGR4
         b9m8qNQgaljZDn+28DbEGy5LAVFfEQjnc6V/oFTzRTli79k6vqSlymMor8YDIv2ClY8x
         oBatnmv9z/rxdId5PfFsSX44R9hm3w999xPe55JaOky28pdNUQ3P+Z+6H2IF1FhiNLZT
         QLhyf7PGqSfXjNXJpp1J0LVEQWrhrnbPCs1PinMb+ZUUfEx9EVZ2/ba/VuM7WdK7Has+
         pld8mKRoBH1RdJvbAdGQXZpibuMau94CuPS19+Qy//tPjHIIw6Rw9L0ksAo2iS4mignX
         A3DA==
X-Gm-Message-State: APjAAAUppMAnsZj0jlVTWU4S08YXHYpGogfERPjI1MbLeveKKhX03f0/
        caxTG9iJHV1BoE5n/6yGMIU=
X-Google-Smtp-Source: APXvYqxc50+zBEhYCi1oEC9EHHfU0HCXiMjtBnAvAyviD8u3RjvUqKNdoe3Gm3GKY6LRaEqWrX5mBA==
X-Received: by 2002:a1c:23cf:: with SMTP id j198mr4483417wmj.188.1579788989815;
        Thu, 23 Jan 2020 06:16:29 -0800 (PST)
Received: from szeder.dev (x4db607d2.dyn.telefonica.de. [77.182.7.210])
        by smtp.gmail.com with ESMTPSA id p15sm2676588wma.40.2020.01.23.06.16.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Jan 2020 06:16:28 -0800 (PST)
Date:   Thu, 23 Jan 2020 15:16:26 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Yang Zhao <yang.zhao@skyboxlabs.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (Jan 2020, #04; Wed, 22)
Message-ID: <20200123141626.GB6837@szeder.dev>
References: <xmqqr1zr5e5e.fsf@gitster-ct.c.googlers.com>
 <20200122235333.GA6837@szeder.dev>
 <xmqqftg6671g.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqftg6671g.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 22, 2020 at 10:06:19PM -0800, Junio C Hamano wrote:
> SZEDER Gábor <szeder.dev@gmail.com> writes:
> 
> > On Wed, Jan 22, 2020 at 02:18:05PM -0800, Junio C Hamano wrote:
> >> * yz/p4-py3 (2020-01-15) 14 commits
> >>  - ci: also run linux-gcc pipeline with python3.5 environment
> >
> > I still think that this last patch needs to be reworked before this
> > series is merged any further.
> >
> > The only Python script we have is 'git p4', so the Python version is
> > only relevant for 'git p4' tests ('t98*'), while the rest of Git and
> > the test suite couldn't care less [1].  This patch, however, not only
> > builds Git and runs the full test suite for each of the two Python
> > versions, but, worse, runs the full test suite _twice_ for each, first
> > as a "regular" test run and then again with all the GIT_TEST_* knobs
> > enabled.  Consequently, it adds ~50mins to every build's runtime.
> >
> > That's just too wasteful.
> 
> Thanks for a reminder.  Yes, I do recall you raised the above point
> and I agree with the assessment.
> 
> What's the ideal endgame wrt the tests?  Build with Py$N and run
> full test suite once, and run full test suite again with the unusual
> knobs enabled, which is what is done without this series, plus build
> with Py(5-$N) and run and run only t98?? tests?

Running the 'linux-clang' job with Python 2 and the 'linux-gcc' job
with Python 3 would be the simplest and cheapest, I'd think.  We'd
only need to add the appropriate 'PYTHON_PATH=...' to out MAKEFLAGS.
As far as Travis CI is concerned, their Xenial image (i.e. the Linux
image we're using) comes with both 'python2' and 'python3' in PATH, at
versions v2.7 and v3.5, with the former being the default.

Perhaps we could do the same with the OSX Clang and GCC jobs as well,
dunno.  Travis CI's OSX image, too, comes with both 'python2' and
'python3' in PATH, though Python 3 is already at v3.7, but still v2.7
is the default.

(Note that 'contrib/svn-fe/svnrdump_sim.py' is not added to
SCRIPT_PYTHON in our Makefile, so it is not affected by the
PYTHON_PATH we'd set in MAKEFLAGS, and it's shebang line remains
'#!/usr/bin/env python'.)

I think the choice of compiler to build Git and the choice of Python
version to run 'git p4' are completely independent, and it's not worth
to check all their possible combinations.

Furthermore, to re-run only a subset of the test suite with 'prove'
we'd need to tweak our $GIT_PROVE_OPTS, because the '--state=' option
that we have in there, will cause us troubles:

  $ cd t/
  # I have the prove state file from the last full test run:
  $ ls -l .prove
  -rw-r--r-- 1 szeder szeder 188758 Jan 23 14:02 .prove
  # Let's try to run only a 'git p4' test script with the default
  # '--state=' option from our $GIT_PROVE_OPTS:
  $ make DEFAULT_TEST_TARGET=prove \
    GIT_PROVE_OPTS=--state=failed,slow,save T=t9800-git-p4-basic.sh 
  rm -f -r 'test-results'
  *** prove ***
  t9001-send-email.sh ................................ 23/?
  <... snip ...>
  # Uh-oh, it proceeds to run all the test scripts that are recorded
  # in the prove state file, i.e. the whole test suite.
  
  # Now let's try that without the '--state=' option:
  $ make DEFAULT_TEST_TARGET=prove GIT_PROVE_OPTS= T=t9800-git-p4-basic.sh 
  rm -f -r 'test-results'
  *** prove ***
  t9800-git-p4-basic.sh .. ok    
  All tests successful.
  Files=1, Tests=21, 12 wallclock secs ( 0.02 usr  0.01 sys +  3.46 cusr
  2.04 csys =  5.53 CPU)
  Result: PASS

I couldn't find a set of 'prove' options that allow us to run slowest
tests first, but run only the tests that are explicitly specified as
cmdline arguments.

So we'd need to tweak how $GIT_PROVE_OPTS is used in our CI builds to
drop the '--state=' option but still keep all other options
('--jobs'!) when re-running only the 'git p4' tests.

