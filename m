Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3252DC4332F
	for <git@archiver.kernel.org>; Tue, 20 Dec 2022 20:44:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233939AbiLTUoq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Dec 2022 15:44:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbiLTUoo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2022 15:44:44 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3A718695
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 12:44:41 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id s5so19189458edc.12
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 12:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=a5tUaD5Ezdmal8SeFC+q+N3G7QRTUR1tc2sTOPN1lQw=;
        b=kULZxc92EOpVkv8GZQSblwT7aIW5nXfPkbiMZoOHb9J9ODAubXdmdXPY5iM3b+AmYl
         k2kfqdyrGThsM5y6FDLlxwUGRrmeIE/Stj0c+7FydUXFJQICwXlqr5s70GYx88kFQxVJ
         VzhlS0m7R+T9zN/PlBfZyaoDYASpIDNAYpKs3/A43cr3mcuTGjMQN1w8Cp31Aq/3hfMf
         JICDK7jXT/88XglCs+HXcr4qbgAC62rQCN9Num822JPWKnAwJpvD8zy7mHGPFqxL6qYS
         1yjAb3KtNmKCmi8dCeZQJIVdaYr3rub1giMIa88vzQiCQ3E8ahuYVA7Fn2gDXQ5+dWQ+
         WIXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a5tUaD5Ezdmal8SeFC+q+N3G7QRTUR1tc2sTOPN1lQw=;
        b=sDU1T8o4ZCylq2WW7EN8HUDRH+AZSpQdSMAmeoTYRmqd3DcV8th+M4D+Xk4jwkL+Yd
         VRrTYDmCXx7M/FtzHjirnpUvQV3Ax9PKrED71nOQO1ssXAvovW95Kh1QeoT/b2jCq72d
         2+aM1Y6I6agoIIZX1JquAdYwKtT4lzgW4pZAMr1ibsANHtMR0/NHNg4KTJc6E2TAo4tY
         uMAY5lxnoGVgxhAq9jWNS2aupYv4H1AUEPF6CesVwUpSZDEOavzZS5nnXXTHtZzMnStD
         Su2ZDPblid+RTIpfsZdJjpMdSrj09OUNtek+M61cxUBQTrUXTlnBWqtXenug+BJBliOh
         MnWw==
X-Gm-Message-State: ANoB5pmgrq2UYOyUENCg6PiqOTmQg19OvWSPTOdftOV9pIQvh/pM/sNm
        w6mQdqOxI8S1AqTWSqWV+VQkVOH7m80FeQ==
X-Google-Smtp-Source: AA0mqf7Mhs+6AJrup7moX7D9jfx4v6IRPPjx0R/heQ3dLGc0rfmhCD0wuEVzQSZE8bjOvbg9rShZSw==
X-Received: by 2002:a05:6402:142:b0:46f:f36b:a471 with SMTP id s2-20020a056402014200b0046ff36ba471mr44603394edu.22.1671569080257;
        Tue, 20 Dec 2022 12:44:40 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id f7-20020a056402194700b00463a83ce063sm6006690edz.96.2022.12.20.12.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 12:44:39 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p7jTb-007WyO-0O;
        Tue, 20 Dec 2022 21:44:39 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, peff@peff.net, vdye@github.com,
        gitster@pobox.com
Subject: Re: [PATCH 3/3] bundle-uri: remove GIT_TEST_BUNDLE_URI env variable
Date:   Tue, 20 Dec 2022 21:41:05 +0100
References: <pull.1443.git.1670866407.gitgitgadget@gmail.com>
 <aafee168fbae2a1887f53febc4abd15522b12bc2.1670866407.git.gitgitgadget@gmail.com>
 <221219.86len3zlqj.gmgdl@evledraar.gmail.com>
 <de1aca07-dd03-3f46-9f56-1cc7616b573a@github.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <de1aca07-dd03-3f46-9f56-1cc7616b573a@github.com>
Message-ID: <221220.86o7rxx0so.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Dec 20 2022, Derrick Stolee wrote:

> On 12/19/22 6:09 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>=20
>> On Mon, Dec 12 2022, Derrick Stolee via GitGitGadget wrote:
>>=20
>>> From: Derrick Stolee <derrickstolee@github.com>
>>>
>>> The GIT_TEST_BUNDLE_URI environment variable is used in the t573* suite
>>> of tests that consume the bundle URIs advertised by the Git server. This
>>> variable is equivalent to setting transfer.bundleURI=3Dtrue, so we can =
do
>>> that in these tests instead.
>>=20
>> I think this is probably OK. I can't remember why I added both the env
>> variable and the setting in what became 0ef961dda05 (bundle-uri client:
>> add boolean transfer.bundleURI setting, 2022-12-05).
>>=20
>> But I think this commit message really doesn't explain why it's OK to
>> remove it. In general we do have GIT_TEST_* settings that duplicate
>> config, e.g. GIT_TEST_PROTOCOL_VERSION.
>>=20
>> We do so because we'd like the environment variable to override the
>> setting, or the other way around (I think depending on the GIT_TEST_*
>> variable it's either-or, it's a mess).
>
> If the variable is named GIT_TEST_* then it should be intended for
> use within tests. However, it provides _no value_ over the existing
> config option, so the tests are updated to use the config value
> instead.
>
> As mentioned, the one exception is where we don't want to uddate
> every test to use the config variable and instead want to set the
> GIT_TEST_* variable across all tests and see how it interacts with
> other tests. However, _as mentioned in the commit message_ this
> variable would not have any effect in other tests because the
> advertisement depends on other config options on the server side.

Makes sense, I think I had a bit of a mental block on it in my initial
look at it. Re-reading your commit message it does make sense.

I think it makes sense to squash this in:
=09
	diff --git a/transport.c b/transport.c
	index 77a61a9d7bb..efc8fa43183 100644
	--- a/transport.c
	+++ b/transport.c
	@@ -1523,7 +1523,7 @@ int transport_fetch_refs(struct transport *transport=
, struct ref *refs)
=09=20
	 int transport_get_remote_bundle_uri(struct transport *transport)
	 {
	-	int value =3D 0;
	+	int value;
	 	const struct transport_vtable *vtable =3D transport->vtable;
=09=20
	 	/* Check config only once. */

The reason we init'd the variable was because we were looking for this
either in the environment or the config, so we needed to have a fallback
in case we used the env var.

But with the logic after your fix-up we know that if we end up in the
RHS of the "||" that "value" was initialized, as we returned 0 from the
config API call.

