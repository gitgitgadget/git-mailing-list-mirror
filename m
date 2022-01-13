Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 714F3C433EF
	for <git@archiver.kernel.org>; Thu, 13 Jan 2022 13:12:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234979AbiAMNMF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jan 2022 08:12:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbiAMNMD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jan 2022 08:12:03 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A38BC06173F
        for <git@vger.kernel.org>; Thu, 13 Jan 2022 05:12:03 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id q25so22900389edb.2
        for <git@vger.kernel.org>; Thu, 13 Jan 2022 05:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=WVWxFP17MIS3k/s3Ym1mM2hj2a2n9eUnAqzBV4nETqw=;
        b=ne21kWV19920dLsafitLFvDVo71MaD7NY4c0ca9LA1SEKQnnjiCu4MOzcohqodDWha
         fdaBSkChRF5ij198B83co71zey4ZMtW5JWG35oUDjOVb3HqzRrtp0RIkh1vmX6rweoyD
         +IyVzpvMkCzSSdJJgOuLSzPxIZxvunGOkCYdgPKDDsKR2Em6IfbjsUcfXOF2ttXKyV33
         VQyTyjqARaGJoc58ScOjSMd1YBMEgT67AlHV106dbA8YbebiOMbulZPBUq4xQZb+jGmW
         v/VYe8jnc2jyROIKz31DNUNfOSI2u9VEi15ZPNs/kj5rJQmfX3AU9stm3/ZC8/nZ+nAJ
         bNjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=WVWxFP17MIS3k/s3Ym1mM2hj2a2n9eUnAqzBV4nETqw=;
        b=iucqf6PY4AHQOnKpd1OWC3iwtO27j30YDHi+AscbRSHrD/zxVLeQYHZXxVp/y5Y9Kf
         fp5ZfRDNw2r7pJ6R4Wd++r4dMGt2arELk7abI2G25CEgi1PveEcF7Vl22vivBFimE5fy
         pqP1zcrTLDd7BiCGUG9OD+HCxKiG1o4BnXxn9LwUD/zmQsUY57vVDB9mbyip3L/DU8cu
         LPElIFFuncUlO/YizYL4KZQVsG9GeDGV+Wl5S9JhOtHQM8TzkGkry7N7gqMT/nQprRy6
         oYDLlZLnXKS/xZIQa2SYF1FoCkKAh1oCn/O+wVur4n8xWb9cwIsDBLjzn5+SqXfYFnWu
         qtrw==
X-Gm-Message-State: AOAM530rqbAQF1MLCANv1mZBm77UIUJVWCQmS6BhM/JVWluJc2xseMob
        6DY2hyxJSELsWT1N4MrkXvQ=
X-Google-Smtp-Source: ABdhPJwm6eVDeROj8FUiCBDmVWTlB4j8HIlnMiGZuH4pXG4b8Zf2uYs2re/ektpeaS2iKECEsavYcw==
X-Received: by 2002:a05:6402:147:: with SMTP id s7mr4137803edu.8.1642079521963;
        Thu, 13 Jan 2022 05:12:01 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id ec25sm1130774edb.51.2022.01.13.05.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 05:12:01 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1n7ztY-000vki-L0;
        Thu, 13 Jan 2022 14:12:00 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Bryan Turner <bturner@atlassian.com>,
        Waleed Khan <me@waleedkhan.name>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v3 6/6] refs: skip hooks when deleting uncovered packed
 refs
Date:   Thu, 13 Jan 2022 14:04:38 +0100
References: <cover.1641556319.git.ps@pks.im>
 <cover.1642054003.git.ps@pks.im>
 <279eadc41cda9ceea4c5317d6a4c358c18d50ce9.1642054003.git.ps@pks.im>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <279eadc41cda9ceea4c5317d6a4c358c18d50ce9.1642054003.git.ps@pks.im>
Message-ID: <220113.868rvjvkyn.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jan 13 2022, Patrick Steinhardt wrote:

> [[PGP Signed Part:Undecided]]
> When deleting refs from the loose-files refs backend, then we need to be
> careful to also delete the same ref from the packed refs backend, if it
> exists. If we don't, then deleting the loose ref would "uncover" the
> packed ref. We thus always have to queue up deletions of refs for both
> the loose and the packed refs backend. This is done in two separate
> transactions, where the end result is that the reference-transaction
> hook is executed twice for the deleted refs.

But do we (which would be an issue before this series) delete the loose
and and then the packed one, thus racily exposing the stale ref to any
concurrent repository reader, or do we first update the packed ref to
the valu of the now-locked loose ref to avoid such a race?

> [...]
> Fix this behaviour and don't execute the reference-transaction hook at
> all when refs in the packed-refs backend if it's driven by the files
> backend. This works as expected even in case the refs to be deleted only
> exist in the packed-refs backend because the loose-backend always queues
> refs in its own transaction even if they don't exist such that they can
> be locked for concurrent creation. And it also does the right thing in
> case neither of the backends has the ref because that would cause the
> transaction to fail completely.

I do wonder if the fundimental approach here is the right
one. I.e. changing the hook to only expose "real" updates, as opposed to
leaving it as a lower-level facility to listed in on any sort of ref
updates.

In such a scenario we could imagine adding a third parameter or
otherwise flag the update as "real" to the hook, so a dumber hook
consumer could ignore the more verbose inter-transactional chatter.

I say that because this change does the right thing for the use-case you
have in mind, but if you e.g. imagine a more gentle background-friendly
"gc" such a thing could be implemented by backing off as soon as it sees
an ongoing transaction being started.

With my ae35e16cd43 (reflog expire: don't lock reflogs using previously
seen OID, 2021-08-23) not getting that more chatty data should be be OK
for such a hypothetical hook.

But we might have more avoidable tripping over locks as the gc and ref
transaction race one another to lock various things in the repository.

Or maybe nobody cares in practice, just food for thought.
