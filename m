Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E596DC4338F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 21:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CADC561139
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 21:41:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235364AbhHXVmE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 17:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231474AbhHXVmE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 17:42:04 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 464A5C061757
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 14:41:19 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id lc21so14828607ejc.7
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 14:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=qHXznY3n3OcqCPl47S4wOHjFQJ77FVY7ncruS2l/IQc=;
        b=uDI1etYlos1RQIvSSL7qDL9GZhdos84M6ubB5C6+XZHwCF1anZNnNyAP9KsXnsLH/Q
         d1PJvCkBjVEeATA15XaTSwWniZBSP32TjMGDi/llK/zosLJxTQf7gekSUpvjoD2CfvYF
         DKJmL+qS6XCYMQdes/VrCU/Sly0wPCpVZ4GL2jYhL3rfDa3b9sPYPbRkXI0ZXz8FRI5F
         S0Ib6vVhQjUP/t/LtujMJZPX7UUAIfBkEn9ea4o4x1xXS9zJUVABgZPinMh9uDEOywsS
         H9x3SWkUW8WsKji5rz5c9p26cS6Fj3ve+QX5pygtWn2wF+Gf3Qp3SobfFf24cslHaavu
         aivg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=qHXznY3n3OcqCPl47S4wOHjFQJ77FVY7ncruS2l/IQc=;
        b=l31VmZ6H3w0wQrinCMkMHRGLrDFO93L4mgA/x8eZ6OqhyMHhbr3eII4X6VJBBn5yNK
         peRec6KYZFuyBWFl1/BwEdjsL14kxipGiKiETrqWPF6pvoYMpG0aOQxFStcFwevf2Q4G
         KQYDd7slVZTEhuLA45b2sVrSAMgjBMrDudVcaAcBS8p8tYJC0ohIlzH/Cclrk1/YF0Yu
         2qMqwp0Rqti3ca2TYI/AhzQPW6tO9G3xaVLrxGnUTUWJfT7vsO82DwBqKGzXbrcxdypa
         GzLGZR0mA+q7kwLWmyScY3xoGg2WtGNVCU+uA3cmBSCZRyVzhfxAENongFiim+DMwzWg
         7ihQ==
X-Gm-Message-State: AOAM532Wwrv6urZpNtBHkjiSghn2lAEadOt51FBECGHdBOAfNVe/3iQt
        toKIknCPaM7BGnd5hTE4w4E=
X-Google-Smtp-Source: ABdhPJyS0m13QzeoRW7MlNd1aSdAG476w+GFOBEm1Vp2wqyJ1QBgLNdMSbxdWgo4tBLJfVFHEhVANA==
X-Received: by 2002:a17:906:3e16:: with SMTP id k22mr13182830eji.280.1629841277867;
        Tue, 24 Aug 2021 14:41:17 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id d2sm9867319ejo.13.2021.08.24.14.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 14:41:17 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/4] index-pack: add --progress-title option
Date:   Tue, 24 Aug 2021 23:40:05 +0200
References: <cover-0.4-0000000000-20210727T004015Z-avarab@gmail.com>
 <cover-v2-0.4-00000000000-20210823T110136Z-avarab@gmail.com>
 <patch-v2-3.4-67197064a8b-20210823T110136Z-avarab@gmail.com>
 <f081ac63-cb5c-1777-d9df-828382637ed1@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <f081ac63-cb5c-1777-d9df-828382637ed1@gmail.com>
Message-ID: <87a6l6ed1e.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Aug 24 2021, Derrick Stolee wrote:

> On 8/23/2021 7:02 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> +--progress-title::
>> +	For internal use only.
>> ++
>> +Set the title of the "Receiving objects" progress bar (it's "Indexing
>> +objects" under `--stdin`).
>
> May I suggest a minor edit:
>
>   Set the title of the progress bar. The title is "Receiving objects"
>   by default and "Indexing objects" when `--stdin` is specified.

Thanks.

>> @@ -1806,6 +1808,10 @@ int cmd_index_pack(int argc, const char **argv, c=
onst char *prefix)
>>  				input_len =3D sizeof(*hdr);
>>  			} else if (!strcmp(arg, "-v")) {
>>  				verbose =3D 1;
>> +			} else if (!strcmp(arg, "--progress-title")) {
>
> Unfortunate that we are not using the parse-opts API. Not your fault.
>
>> +				if (progress_title || (i+1) >=3D argc)
>
> style nit:
>
> 	if (progress_title || i + 1 >=3D argc)
>
> Although, I notice a similar line elsewhere in the file, so this gets
> a pass.
>
> 	if (index_name || (i+1) >=3D argc)

Yeah, it's exactly copy/pasted from another thing doing the same sort of
parsing in this file. Will keep it the same for this new code, and just
note it.

I think any subsequent change to refactor it will be easier if it's all
consistent, v.s. some using i + 1, another putting it in parenthesis
etc.

>> +					usage(index_pack_usage);
>> +				progress_title =3D argv[++i];
>
> One downside to this organization is that `--progress-title=3DX` will
> not work here. There are other `--<option-name>=3DX` options in this
> builtin, and the index output name is specified with the short name
> `-o X`. We should probably err to match the `--<option-name>=3DX`
> pattern in this file for now. An eventual conversion to standard
> option parsing would be helpful here, but I don't think is worth
> blocking this series.

*nod*.
