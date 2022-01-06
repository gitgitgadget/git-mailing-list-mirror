Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB905C433F5
	for <git@archiver.kernel.org>; Thu,  6 Jan 2022 21:32:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244251AbiAFVcL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Jan 2022 16:32:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239110AbiAFVcK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jan 2022 16:32:10 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ACC8C061245
        for <git@vger.kernel.org>; Thu,  6 Jan 2022 13:32:10 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id kj16so3652993qvb.2
        for <git@vger.kernel.org>; Thu, 06 Jan 2022 13:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NgPFKM56cUfbCZE4VUFqGRxOVJsw73bz0F3nl0IrIyc=;
        b=YbcIzKJxITY3TBXMwtB6vgLKudf7pjdQ7J6BQpDlF1hJEdL6mkMj2mCTAIDzIONwrr
         tiJToHRTnYZIn9ZFlYPGaQ7cvUuJM1Fhlz2yMMzF8xFiaU+SN+p/T3Dk6Q4s+PWV3B61
         8r4F3LTrNMwbPO9t0L8VdEkOCRwS5bxOEts6NDrfMS9xkRKzx+o70kQWRjgfD1rBGdzf
         cxpH6JI0KGCG3zoVr0iOZvHwJm6AraAp0fPLQNhCo8IWj80/1yW0CID+ICd8QWjjZew1
         zneRwS8FLNGDrLUHMdqJv8EtY5UhaspNl8rTTHWfgRF8Gsqrwf5dJkNFPRoJgu3PmHz2
         QWFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NgPFKM56cUfbCZE4VUFqGRxOVJsw73bz0F3nl0IrIyc=;
        b=hb9xcYyJPRL2RDRnCPxTPBc6vMeL9Fm8VqlAOcwj8DCsihsVwnx9+WBHB405DrZSKU
         q4iV+zTSZgZS2pJ6VT88XTHGE1ioyJRGd73+i0iEeQvKwmeVg35D3cwPvzbp6sAHxiBR
         ROmji+mbm6enrfmT6luKs0xlAJe+lfMVS6SGA+CxWv908Xvah4XLZpjYxtdhnkD9rvtr
         XYMCqNQZEzeVWIKlSAFd89/a0nci2aK01apldZLV0gKJg6vt5x0lTfWvQ16DCn6JrLP/
         /yal7RU2pdOMav+pj+stf4ou9837NgzVe+QyL3dyBWftlPDKcDFV+nEhaUZkufAr4wdf
         /pdg==
X-Gm-Message-State: AOAM53244nJMXE76fYVglLaSXcU29pTL6onHoQAheJCaNolPAYRiakGg
        mRxUrbdvAGMq9sWiYdt42UEyZr5/C2gBsg==
X-Google-Smtp-Source: ABdhPJznwYOxfXMeZpucCDoHsqcWzt+7jo/38LxKagU6H1KdNk3ZryCbSUH7bdHlcU3dwTCMY+UzCw==
X-Received: by 2002:a05:6214:19ca:: with SMTP id j10mr2832181qvc.5.1641504729403;
        Thu, 06 Jan 2022 13:32:09 -0800 (PST)
Received: from [192.168.1.211] (pool-108-35-55-112.nwrknj.fios.verizon.net. [108.35.55.112])
        by smtp.gmail.com with ESMTPSA id z14sm2492167qtw.59.2022.01.06.13.32.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jan 2022 13:32:08 -0800 (PST)
From:   John Cai <johncai86@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, =?utf-8?q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v5] builtin/reflog.c: use parse-options api for expire, delete subcommands
Date:   Thu, 06 Jan 2022 16:32:08 -0500
X-Mailer: MailMate Trial (1.14r5852)
Message-ID: <4F3BFC1C-99A4-41E4-A32F-286F1287374A@gmail.com>
In-Reply-To: <xmqq1r1kd11v.fsf@gitster.g>
References: <pull.1175.v4.git.git.1641355561700.gitgitgadget@gmail.com>
 <pull.1175.v5.git.git.1641495981650.gitgitgadget@gmail.com>
 <xmqq1r1kd11v.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 6 Jan 2022, at 16:09, Junio C Hamano wrote:

> "John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> From: John Cai <johncai86@gmail.com>
>>
>> Switching out manual arg parsing for the parse-options API for the
>> expire and delete subcommands.
>>
>> Move explicit_expiry flag into cmd_reflog_expire_cb struct so callback=
s
>> can set both the value of the timestamp as well as the explicit_expiry=

>> flag.
>>
>> Signed-off-by: "John Cai" <johncai86@gmail.com>
>> ---
>
> Thanks.  Will queue.
>
>>      @@ builtin/reflog.c: static void set_reflog_expiry_param(struct c=
md_reflog_expire_c
>>       +	const struct option options[] =3D {
>>       +		OPT_BIT(0, "dry-run", &flags, N_("do not actually prune any e=
ntries"),
>>       +			EXPIRE_REFLOGS_DRY_RUN),
>>      -+		OPT_BIT(0, "rewrite", &flags,
>>      ++			OPT_BIT(0, "rewrite", &flags,
>>       +			N_("rewrite the old SHA1 with the new SHA1 of the entry that=
 now precedes it"),
>
> I think this change is a fat-finger; will correct while queuing.

Oops, yes. Thanks for that and helping me through the review process :)
