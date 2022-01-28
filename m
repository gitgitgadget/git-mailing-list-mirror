Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3085C433F5
	for <git@archiver.kernel.org>; Fri, 28 Jan 2022 11:04:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347976AbiA1LE4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Jan 2022 06:04:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiA1LEz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jan 2022 06:04:55 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F8EC061714
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 03:04:54 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id f17so10209217wrx.1
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 03:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=COyw9RD9V6Mv7//bL0nJXN1b11OzKl+vRG3zaUXKfPM=;
        b=GClik4mpaunTxUlqr5IyMJhhc6TCb8rvqMN8ru63qFZJyIK5ciRohYRgOlhdGYY0cC
         pz/HEs/q/4pTo7guBP//b5e2PRkFjRHkZyhAe9jGrZ3fAWkhCTLOeFmma2LM37IbDB1w
         5z2maAh26UEEAsPfyN3POBDNJg3tIRXwtqHmPyzY96LbfZF/PphOIXxANAvkonrw3k5a
         SlnC3MJWWuk7ke1Wse7OFL4udn6JgqFzlVdCsetmcfRGbd8WkH0qucapyosZd4l4Le5/
         1w0yg4yGfggNvi54g5+yGUaHSzXsbKjEhbscMq/MCwFBQ6H9rvbDir0oN9XKvWFMSHWG
         XBTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=COyw9RD9V6Mv7//bL0nJXN1b11OzKl+vRG3zaUXKfPM=;
        b=BdQUcMOsOB93QanPXO2ASQ169aQkW5r6ZzmkSoVIUkV+gDGi2gJjGratNipxLxT+RT
         PvRZ3XNOZ+GRiMyOL4LMqrBc7WwreZBVWvLeroHGWceyZ3Y8vJ1+UCMQIeANIuOqRjNQ
         PYgS/V9fly8ytq1z8LuYqk3tUriIw1o8GsV8lDA1NK0ixeG+aehFrU6eaQUd61TViULN
         d48AvN8koImGu/MqGnKlB/3W+75Xfajglut6giux1q6dCu1EcMgMJXk/KrwEJFtzUrxb
         MmGL8yCUgBe2x2wqm0xb1SWztTJ7r4PDoQXAUgFVOr5jhyj85tmkDVeEE4dkzGXGUbU5
         HDhA==
X-Gm-Message-State: AOAM533Wl0tc8OB+KmykSEoSKzbi9a1VVZ6hfiUah626ozqwZI2m6v5p
        gjj21EH1AThAWeDQewfRoEf8kwPG8aI=
X-Google-Smtp-Source: ABdhPJz9QJQd4GfX8jwx6Bc8s8desSCRkucHDrKi8zdVr3ss+Bc1YjvpC/arsYNJVTN/DNL0wqOJeg==
X-Received: by 2002:adf:f291:: with SMTP id k17mr6448462wro.623.1643367893285;
        Fri, 28 Jan 2022 03:04:53 -0800 (PST)
Received: from localhost ([77.75.179.5])
        by smtp.gmail.com with ESMTPSA id h6sm1683618wmq.26.2022.01.28.03.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 03:04:52 -0800 (PST)
References: <20220127153714.1190894-1-t.gummerer@gmail.com>
 <xmqqmtjh0x5f.fsf@gitster.g>
User-agent: mu4e 1.4.15; emacs 27.2
From:   "Thomas Gummerer" <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] fetch --prune: exit with error if pruning fails
In-reply-to: <xmqqmtjh0x5f.fsf@gitster.g>
Date:   Fri, 28 Jan 2022 11:04:48 +0000
Message-ID: <87lez0p1db.fsf@coati.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Junio C Hamano writes:

> Thomas Gummerer <t.gummerer@gmail.com> writes:
>
>> When pruning refs fails, we currently print an error to stderr, but
>> still exit 0 from 'git fetch'.  Since this is a genuine error fetch
>> should be exiting with some non-zero exit code.  Make it so.
>>
>> The --prune option was introduced in f360d844de ("builtin-fetch: add
>> --prune option", 2009-11-10).  Unfortunately it's unclear from that
>> commit whether ignoring the exit code was an oversight or
>> intentional, but it feels like an oversight.
>
> It is a good idea to signal, with a non-zero status, that the user
> needs to inspect the situation and possibly take a corrective
> action.  I however do not know if it is sufficient to just give the
> same exit status as returned by prune_refs(), which may or may not
> happen to crash with other possible non-zero exit status to make it
> indistinguishable from other kinds of errors.

Not sure I understand this correctly.  Are you saying that we should
take the return value from prune refs, and always munge that to the same
exit code for 'git fetch --prune' if it fails?  E.g. so prune_refs()
could return 1 or 2 or 3 or whatever, but we would always want the exit
code for 'fetch' to be 1?

Happy to implement that.

>> diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
>> index 20f7110ec1..df824cc3d0 100755
>> --- a/t/t5510-fetch.sh
>> +++ b/t/t5510-fetch.sh
>> @@ -164,6 +164,16 @@ test_expect_success 'fetch --prune --tags with refspec prunes based on refspec'
>>  	git rev-parse sometag
>>  '
>>
>> +test_expect_success REFFILES 'fetch --prune fails to delete branches' '
>> +	cd "$D" &&
>> +	git clone . prune-fail &&
>> +	cd prune-fail &&
>> +	git update-ref refs/remotes/origin/extrabranch main &&
>> +	>.git/packed-refs.new &&
>> +	test_must_fail git fetch --prune origin
>
> Is it because the lockfile ".new" on packed-refs prevents deletion
> of refs but does not block creation and updates to existing refs
> that it is an effective test for the "--prune" issue?  If we somehow
> "locked" the whole ref updates, then the fetch would fail even
> without "--prune", so it may be "effective", but smells like knowing
> too much implementation detail.  Yuck, but I do not offhand think of
> any better way (it is easier to think of worse ways), so without
> further input, I would say that this is the best (or "least bad") we
> can do.

Yes, that's correct.  New refs will be created as loose refs, so they
don't care about packed-refs.  However deletions can potentially be
happening in packed-refs, and that's why it fails when 'packed-refs.new'
exists.

I don't love the test either, but I also can't think of a better way to
do this.

> Another tangent #leftoverbits is that many tests in this script are
> so old-style that chdir around without isolating themselves in
> subshells, while some do.  We may want to clean them up when the
> file is quiescent.
>
> Thanks.
