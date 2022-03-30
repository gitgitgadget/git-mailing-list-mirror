Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C78C433EF
	for <git@archiver.kernel.org>; Wed, 30 Mar 2022 22:54:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233870AbiC3W4U (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 18:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233874AbiC3W4S (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 18:56:18 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2299433E0C
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 15:54:30 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id c62so26166569edf.5
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 15:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=nXAwes5Jvb16Z/siglemYlOxFsmfIn7An534P+I7p00=;
        b=DL/pwbN62xqicj86sQrY3XDgOknAA8yDW6sAQ+Mg98oa47YQOaKHjUiAxv68M+U/j2
         yoT4IdTIaMBSDKqBBzmIoV5JFoUfueDQDj1sB2bz5X0r6VJQZDs/LBSlLikCxPmSFu86
         UFpP3yrncDSt15UfdhV/oTx9yh5ZQFtMtVQBNddA8IPPYKNIenXupP/+o0GMjOqSdDJK
         3mahssJQDBwtKZSKY37rEXopcTMYESUSqeecMFnUghL3CVmhbeWqF2qHxV2JgVCmNjkB
         8ZjKX9JJp3gMdRrpncpsZW3WqE4RNMs/f6cA2H//4bUEYWyR1jagYnofkW62A4s2qFRW
         V5SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=nXAwes5Jvb16Z/siglemYlOxFsmfIn7An534P+I7p00=;
        b=7AydCluC5cDCK3BIxSzkdpz4shGoFyaFx9YeWXD05akjz2aRJFdllwiEhSLwkFyS7a
         pzYJ48tpXea0DoEnM0YrDS3Q+/wXqvKu4i8ajXO2Rx62WTqSANLCd9kqqmNTnqEU4tAJ
         37+k6n3nc/4KxntGDUOgPwAgBnyRuDgbAD5ye8fl5lmSPULGbTNZMYLOYqLkfv8U+wOv
         VovRVyKVR/kwXMrwPx5hnpTfJUcNSSoZgQTy/Qrv45KkwzmKCvPTX9+7+iTh9TLt9Wgd
         LLa8iSdnE6wGsWNsUkmKgdWn+PrQUeduBwPYmY2DWFRM1oDOTpm7bcyQs4F2tc64w9aE
         mquQ==
X-Gm-Message-State: AOAM532//6VVYZDNg94fW05YiVo7eF7eoZQ/n3im8HkMRlRVsL5+F97U
        IxP3twBFvqZcI6DWZ2lp9+c=
X-Google-Smtp-Source: ABdhPJzAdNooA7F4Vtce/llX6fdt9Hs3xqJY2GBekN8aukDVcyeQz54E8nlPV5tL0LYxCtD4RqJPdQ==
X-Received: by 2002:a50:9fa5:0:b0:418:e7c4:cf96 with SMTP id c34-20020a509fa5000000b00418e7c4cf96mr13618202edf.30.1648680868640;
        Wed, 30 Mar 2022 15:54:28 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id hr13-20020a1709073f8d00b006dfcc331a42sm8569412ejc.203.2022.03.30.15.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 15:54:28 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nZhCt-0004Ry-2h;
        Thu, 31 Mar 2022 00:54:27 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Glen Choo <chooglen@google.com>,
        Tao Klerks <tao@klerks.biz>
Subject: Re: [PATCH v5] tracking branches: add advice to ambiguous refspec
 error
Date:   Thu, 31 Mar 2022 00:51:50 +0200
References: <pull.1183.v4.git.1648553209157.gitgitgadget@gmail.com>
 <pull.1183.v5.git.1648624810866.gitgitgadget@gmail.com>
 <220330.864k3fpo32.gmgdl@evledraar.gmail.com> <xmqqmth76use.fsf@gitster.g>
 <220330.86o81nta6k.gmgdl@evledraar.gmail.com> <xmqqzgl75c35.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqqzgl75c35.fsf@gitster.g>
Message-ID: <220331.86y20rrqzg.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 30 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>>>>> +				 "To support setting up tracking branches, ensure that\n"
>>>>> +				 "different remotes' fetch refspecs map into different\n"
>>>>> +				 "tracking namespaces."),
>>>>> +			       orig_ref,
>>>>> +			       remotes_advice.buf
>>>>> +			       );
>>>>
>>>> Nit: The usual style for multi-line arguments is to "fill" lines until
>>>> you're at 79 characters, so these last three lines (including the ");")
>>>> can all go on the "tracking namespaces" line (until they're at 79, then
>>>> wrap)>
>>>
>>> I didn't know about the magic "79" number.  It makes the resulting
>>> source code extremely hard to read, though, while making it easier
>>> to grep for specific messages.
>>
>> I'm referring to the "80 characters per line", but omitted the \n, but
>> yeah, I should have just said 80.
>
> No, what I meant was that you do not want the rule to be to cut *AT*
> exactly the column whatever random rule specifies, which would
> result in funny wrapping in the middle of the word, e.g.
>
>         "To support setting up tracking branches, ensure that diff"
>         "erent remotes' fetch refspecs map into different tracking"
>         " namespaces."
>
> and "at 79, then wrap" somehow sounded to me like that.  I do not
> think you meant to imply that (instead, I think you meant to suggest
> "wrap the line so that the string constant is not longer than 79
> columns"), but it risks to be mistaken by new contributors.
>
> FWIW, I'd actually prefer to see both the sources to be readable by
> wrapping to keep the source code line length under certain limit
> (the current guideline being 70-something), counting the leading
> indentation, and at the same time keep it possible and easy to grep
> messages in the source.
>
> That requires us to notice when our code has too deeply nested,
> resulting in overly indented lines, and maintain the readability
> (refatoring the code may be a way to help in such cases).

Yes, I didn't mean to say it was a hard rule. In particular as this code
has the strings themselves over 80 characters. It can be good to break
that guideline when it doesn't help readability.

I just meant that this made sense as a fix-up, in this case:

diff --git a/branch.c b/branch.c
index 5c28d432103..4ccf5f79e83 100644
--- a/branch.c
+++ b/branch.c
@@ -282,10 +282,8 @@ static void setup_tracking(const char *new_ref, const =
char *orig_ref,
 				 "\n"
 				 "To support setting up tracking branches, ensure that\n"
 				 "different remotes' fetch refspecs map into different\n"
-				 "tracking namespaces."),
-			       orig_ref,
-			       ftb_cb.remotes_advice.buf
-			       );
+				 "tracking namespaces."), orig_ref,
+			       ftb_cb.remotes_advice.buf);
 		exit(status);
 	}
=20

Which I'd also be tempted to do as:

diff --git a/branch.c b/branch.c
index 5c28d432103..b9f6fda980b 100644
--- a/branch.c
+++ b/branch.c
@@ -283,9 +283,7 @@ static void setup_tracking(const char *new_ref, const c=
har *orig_ref,
 				 "To support setting up tracking branches, ensure that\n"
 				 "different remotes' fetch refspecs map into different\n"
 				 "tracking namespaces."),
-			       orig_ref,
-			       ftb_cb.remotes_advice.buf
-			       );
+			       orig_ref, ftb_cb.remotes_advice.buf);
 		exit(status);
 	}
=20
But I find it generally helpful to do it consistently when possible, as
when running into merge conflicts it makes things easier.
