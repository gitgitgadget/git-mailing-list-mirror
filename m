Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1536C4332F
	for <git@archiver.kernel.org>; Thu, 29 Dec 2022 10:41:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233104AbiL2Kle (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Dec 2022 05:41:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233354AbiL2Kla (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Dec 2022 05:41:30 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF2C10E8
        for <git@vger.kernel.org>; Thu, 29 Dec 2022 02:41:29 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id u18so24793322eda.9
        for <git@vger.kernel.org>; Thu, 29 Dec 2022 02:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QXHkSTH7klkWV39rp444SKEcLk/brbvmB77Hi+rHKgc=;
        b=cwlWKWiD3CldtoEePl8uLNUOqHoS+YGjNaVWhZLWo0bgdCIHzWfrJu7jsO14Yw5pPE
         BEt6bSeExBRifDLiBSLzJ4HVQwup+7h5Q9uwB7dtHTHIZLpg17xjJF7IZYOynk+79kp0
         Fzgy9MFqdYBS6HQqlOwcFC0rxVycwNAMVPNv4FJAwNM7jNr81V8eMZM84IfJHyDw+qzJ
         AsW34LK8bj1M03mmZXoe7es4nh+ToZB8U1LdhPIl7XHATVfB8A/H+PrYDHGY4XZoSD4v
         VXVD97hgQ3Dd7Wbj7v6F/wLFYQr7N5mmTXBm0ZoFgljeWtRePKN/7DrV0Ja5cU28aYmy
         PqkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QXHkSTH7klkWV39rp444SKEcLk/brbvmB77Hi+rHKgc=;
        b=rCr10qnFbAP6avi7oeXw+Uw+E14ZgqMo4BfpXZVdjUqIRzjwMgThKa1HSM+9aSbdNl
         pvSP0GQIyqS9m6x1ZL2ZggUAt1fAUVIpNz62fRdrKOshujrQxuf/EnNDNTnbjxIAP6he
         +nQDQVagPMHN8ilzhh0UKzGHr8CRLOW7nzrtjhTG9RKfBdMugrcvrg3yJcNP7uqVOAZY
         gVqLNm6Wa42Oc6bKqTRFv8aCWq1TFo2stLVIlLJg6suLK97PHQLTIvHUmN3/auRtZVXA
         /oqBe9ttiJ1xcBvOwIp7bKrlBAjgvFMnmw2NvV2qeU1ZwKxPZaLPy68N56xdPWOgxvr3
         G/Lg==
X-Gm-Message-State: AFqh2krNB8LVCCRK8qAHURarLCzGSoCnkHpsuQPCOFeJmTLAo9Y73caX
        d1Rzdv0YnbJuroKVMCCGGeE=
X-Google-Smtp-Source: AMrXdXtwHAvc60/NvptUQDcuEC3LjXxSKLIjKzIUZt51/MTnmlC5RLz0HRd/9TG1PVfCyL2tdC/qVA==
X-Received: by 2002:a50:8e5d:0:b0:46f:a73d:6bdb with SMTP id 29-20020a508e5d000000b0046fa73d6bdbmr24612134edx.25.1672310487416;
        Thu, 29 Dec 2022 02:41:27 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id f20-20020a17090631d400b007bf24b8f80csm6277073ejf.63.2022.12.29.02.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 02:41:26 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pAqLm-00AJAG-1S;
        Thu, 29 Dec 2022 11:41:26 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 05/20] clone: use free() instead of UNLEAK()
Date:   Thu, 29 Dec 2022 11:20:51 +0100
References: <cover-00.20-00000000000-20221228T175512Z-avarab@gmail.com>
 <patch-05.20-49e6714939d-20221228T175512Z-avarab@gmail.com>
 <xmqqk02amvjw.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <xmqqk02amvjw.fsf@gitster.g>
Message-ID: <221229.86zgb6tru1.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Dec 29 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> Change an UNLEAK() added in 0c4542738e6 (clone: free or UNLEAK further
>> pointers when finished, 2021-03-14) to use a "to_free" pattern
>> instead. In this case the "repo" can be either this absolute_pathdup()
>> value, or in the "else if" branch seen in the context the the
>> "argv[0]" argument to "main()".
>>
>> We can only free() the value in the former case, hence the "to_free"
>> pattern.
>
> Many other patches in the series, especially the ones that touch the
> library-ish parts that can be called unbounded number of times, do
> make sense, but this patch helps nobody.  Not even the leak checker,
> who should already be happy with the existing UNLEAK() marking.  The
> only thing it does is to free() a piece of memory obtained from a
> one-time allocation that will be discarded upon program exit anyway.

The changes in this series that deal with UNLEAK() take it as a given
that it's a good thing to replace these trivial cases with a free().

But the rationale is in ac95f5d36ad (built-ins: use free() not UNLEAK()
if trivial, rm dead code, 2022-11-08) in the earlier topic, this is the
follow-up.

We only have 15 UNLEAK() invocations in-tree left, with this series
(which made no special effort to get the rest, but just the remaining
very low hanging fruit) it's 13.

If our built-ins were using this pattern consistently I think it would
be worth keeping & using UNLEAK() like this, but they aren't.

Even the "display_repo" variable seen in the context of this patch is
free()'d, see 46da295a770 (clone/fetch: anonymize URLs in the reflog,
2020-06-04), along with the rest in this function and others (with the
exception of the remaining UNLEAK(...)), e.g. "remote_name" etc.

So I think keeping it just makes the code more confusing, one wonders
why this particular variable is being UNLEAK()'d, instead of just
free()'d like the rest.

As the comment on the SUPPRESS_ANNOTATED_LEAKS macro notes we only get
the benefit from it if you compile with SUPPRESS_ANNOTATED_LEAKS, so
e.g. if you use SANITIZE=3Dleak it'll kick in, but not on a normal build
and e.g.:

	valgrind --leak-check=3Dfull ./git commit-graph verify

Which will with UNLEAK() report the leak fixed in 04/20 here (I'm just
using it in this example since easier to reproduce), but with free() we
won't report it.

I agree it has a marginal benefit, e.g. it won't contribute to the
linux-leaks job, as it uses SUPPRESS_ANNOTATED_LEAKS, but the above is
why I think it's worth changing the remaining low-hanging UNLEAK() fruit
to free().

We do have cases where it's much tricker to replace those UNLEAK() with
free(). I think it's much better if we narrow its use to those cases at
this point.
