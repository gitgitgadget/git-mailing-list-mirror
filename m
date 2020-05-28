Return-Path: <SRS0=eul5=7K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F82C433E0
	for <git@archiver.kernel.org>; Thu, 28 May 2020 13:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB63B20723
	for <git@archiver.kernel.org>; Thu, 28 May 2020 13:16:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UAGCPWXE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390229AbgE1NQp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 May 2020 09:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390160AbgE1NQn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 May 2020 09:16:43 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B31FFC05BD1E
        for <git@vger.kernel.org>; Thu, 28 May 2020 06:16:43 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id ci23so3091227pjb.5
        for <git@vger.kernel.org>; Thu, 28 May 2020 06:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=zerLEgtFvjPm2td/IslGtmUp/4aEjbJJXuJv7ThsMn0=;
        b=UAGCPWXEmGIr2Hgujd8fOoF0qHAsrHNQjxyrx6vQq7a3TLcRkXttATgFgcjasjMjBp
         Jh92A1PUvIeY03bOkaU9Z/wA7jdK/uZopkNGtp7LkVx7u0vnmUByotMdCF++uwlO/TAG
         X2vVB9umYdVXHHFF0Ye2WGa/Z4o8g9QRCBmRKGeOIj8bSgHCGT7HxpXdKjEVgZ2XXexO
         Mls9D78Tc+GOJvUD5fNEFOod4ySaI0bVaFz8lfU1gkuc+P2wR5pvicGANHh/T+vybTUH
         aLKjPw3gKCGVB9ixQBQx5xAFjtWe3UD5wU30TfCk4XGWMC2EVTOy/YmX2DFHZfl/xJIA
         BFUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=zerLEgtFvjPm2td/IslGtmUp/4aEjbJJXuJv7ThsMn0=;
        b=P4Wv4CzpEoq4X5snFVUsObEawut1PvyX0AL0kvWd4X476AAcpDlIWtapdd92I73vDh
         McbhdY9gCMx7tJiYy4OTGjDy2IL5AxTNXtKv3jHHjtkIprlv92WXQ496Uv6ug+pooBcn
         DFQx+Tyoj0sQOQulk/40nfh9ZAKwQEjxicv1tdufD3OUEMP1B6dyAsZIVzI3hhXyc2LZ
         Ey1VJxdMRNc16tLA6pzHijWWSjyevxTtPkq3MdeRMRnsEvtABNNo+6NeEc8WOnadR0IL
         YavVNPbB1DYnXZ2jLdPqd6MH2SLTfFTEc7TMnGpcLAWq1IXt5eqSitioAzqqTpqbKFKc
         iJlg==
X-Gm-Message-State: AOAM531EHMBpZYrnhXodf8bw5mjXDlTqIdA5Y67IPzFdd4wBXscEpede
        GPrsbkBMNnDEfHmZTxNFiqs=
X-Google-Smtp-Source: ABdhPJyHHOSP0U1Fd8zCJGqX3Rh5Gq3vqy6cwhbi+sSN92qIdNT4LNuuxcJ1eEhF/LNFy3WYt8g4jA==
X-Received: by 2002:a17:90a:c246:: with SMTP id d6mr3763831pjx.60.1590671802937;
        Thu, 28 May 2020 06:16:42 -0700 (PDT)
Received: from [100.78.168.153] ([106.198.22.96])
        by smtp.gmail.com with ESMTPSA id 128sm4662878pfd.114.2020.05.28.06.16.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 May 2020 06:16:42 -0700 (PDT)
Date:   Thu, 28 May 2020 18:45:31 +0530
User-Agent: K-9 Mail for Android
In-Reply-To: <20200527162048.GA19421@konoha>
References: <20200527162048.GA19421@konoha>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [GSoC] Shourya's Blog
To:     Shourya Shukla <shouryashukla.oo@gmail.com>, git@vger.kernel.org
CC:     christian.couder@gmail.com, gitster@pobox.com,
        Johannes.Schindelin@gmx.de, heba.waly@gmail.com, stolee@gmail.com,
        jnareb@gmail.com
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <6A4BE88D-40E8-4481-9959-891B26B05BAA@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Shourya,


On 27 May 2020 21:50:48 GMT+05:30, Shourya Shukla <shouryashukla=2Eoo@gmai=
l=2Ecom> wrote:
>Hello,
>
>This is the third installation of my GSoC blog covering week 3
>https://shouryashukla=2Eblogspot=2Ecom/2020/05/gsoc-week-3=2Ehtml
>
>All feedbacks and suggestions are welcome! :)

I'll mention a couple of things that came to me after re-reading the blog=
=2E The blog reads:

> And the final one, comments should be not confusing=2E to solve the 1st =
issue in v3, I put up a comment which was:
>
>    The `quiet` option is present for backward compatibility but is curre=
ntly not used=2E
>
> Do I even need to explain how ambiguous this is (something which took me=
 one whole patch to realise)?

While you don't have to explain the ambiguity for someone who has read the=
 review discussion, it is possible that someone who has not read Junio's e-=
mail[1] might not understand what ambiguity is present in that comment=2E S=
o, it would've been nice if you had explained the ambiguity=2E

Another thing, you thank Junio for the updated comment (which is nice)=2E =
But it's not clear from the blog how Junio contributed to that comment=2E T=
his could've been avoided by adding more information about the context whic=
h in this case is (again) Junio's e-mail about the ambiguous comment=2E

Things to keep in mind for future blogs :)

---
Footnotes:

[1]: https://public-inbox=2Eorg/git/xmqqk115ruux=2Efsf@gitster=2Ec=2Egoogl=
ers=2Ecom/

--=20
Sivaraam

Sent from my Android device with K-9 Mail=2E Please excuse my brevity and =
possible "typso"=2E
