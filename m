Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0A2420899
	for <e@80x24.org>; Wed, 23 Aug 2017 19:34:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932719AbdHWTeO (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Aug 2017 15:34:14 -0400
Received: from mail-yw0-f169.google.com ([209.85.161.169]:33153 "EHLO
        mail-yw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932576AbdHWTeN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2017 15:34:13 -0400
Received: by mail-yw0-f169.google.com with SMTP id h127so6783417ywf.0
        for <git@vger.kernel.org>; Wed, 23 Aug 2017 12:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KEjYRLk5DYYLBE0SVZIyRk7vS8nit8qOiWE8VTGCrvk=;
        b=AlUNDyQJ9gV3Hi5hqcnhdWi56FTpjgdEyh2W3d1ymWKHSXiYp/G8sJyHVkWHZCrZa1
         DGreWFCCj9b+XXJ1bw8ihwdOLLxwz7rR2rr3TSPuI90DzIUqS43U2K1o5JXhONa5U1kk
         APwXcznbDLTnA0eBLLJw+0YMwuF4uJq+ag9CA/AtPbNRwEBltd22eBjObOX+8LXkz0hW
         XI1WLaq44ZExj1jBWHMt9rfyfwjwF5hOg0P7IWMbAuS9hVqGIgmeKmpYIeBWFPs3R0TF
         ZxtuN45au1dN6fRAwQNRX9u6XRrAOKuwhSiHTno6jd/H3DzvyCqRPoTTUmb5nxpYqOvk
         wI2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KEjYRLk5DYYLBE0SVZIyRk7vS8nit8qOiWE8VTGCrvk=;
        b=Uac8TvdlKbJJReMzN9GQhHoKtnqGcbncpl51brsOR8d7/P7uBHe9o4syIbJxIJBxIf
         0Hu4UMbi8TaJSqyLZTin1tCuwqGCd09sDiXcefY/qIJ2ycsQB5x75m5eKiRhstMZdF2n
         U4cyFIM0GgJdZFmNRcNhoRgKL15zzpTz7KeDHrvm7/1JHZf5VB0KlP3DN27GwC8LqTn9
         DB3MGWzQMkLGkCa5LSyAm/whfE3N5HyvoryLilo77fEhiRRLgwj1rou9gGlabbbBKIki
         uWlIr2pIRCSXdxvEmLD9tqwDHWtrgmzMfIPoUJHdNn0KnEB6xQvRFD73thy4LYrNr5o7
         O0xg==
X-Gm-Message-State: AHYfb5iTcSVU8aeyXZ5m+P/tvbwzsTsOSZS66jaR6JDmi/JoSaSXZCED
        cwDSPZc8anVYJQg9VsC2B+CFFgys+hTRMJWFlg==
X-Google-Smtp-Source: ADKCNb7lo9cQZ678pQNsLgqfuZx6jTrRAIE/OKM9JXWW9mOnTjTtxXcaRoabn/wZ7R/8PBnYmDY3pCgfsok9uCmKVks=
X-Received: by 10.13.206.132 with SMTP id q126mr2895651ywd.337.1503516853118;
 Wed, 23 Aug 2017 12:34:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.214.133 with HTTP; Wed, 23 Aug 2017 12:34:12 -0700 (PDT)
In-Reply-To: <20170823123704.16518-6-pclouds@gmail.com>
References: <20170823123704.16518-1-pclouds@gmail.com> <20170823123704.16518-6-pclouds@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 23 Aug 2017 12:34:12 -0700
Message-ID: <CAGZ79kZ2e5+trudmcft39UC_PrROwvrrAE0w_-a_b_3s7ZjFQQ@mail.gmail.com>
Subject: Re: [PATCH v4 05/16] refs.c: refactor get_submodule_ref_store(),
 share common free block
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 23, 2017 at 5:36 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =
<pclouds@gmail.com> wrote:
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
> ---
>  refs.c | 17 ++++++-----------
>  1 file changed, 6 insertions(+), 11 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index dec899a57a..522c4ab74f 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1636,7 +1636,6 @@ struct ref_store *get_submodule_ref_store(const cha=
r *submodule)
>  {
>         struct strbuf submodule_sb =3D STRBUF_INIT;
>         struct ref_store *refs;

Do we need to assign NULL here, to cover the early outs?

> -       int ret;
>
>         if (!submodule || !*submodule) {
>                 /*
> @@ -1648,19 +1647,14 @@ struct ref_store *get_submodule_ref_store(const c=
har *submodule)
>
>         refs =3D lookup_ref_store_map(&submodule_ref_stores, submodule);

Answering the question from above, no we do not need to
assign NULL as we have an unconditional assignment
here and any early outs are after this.

Thanks,
Stefan
