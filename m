Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 646CC1F97E
	for <e@80x24.org>; Sun, 14 Oct 2018 12:30:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbeJNUJX (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 Oct 2018 16:09:23 -0400
Received: from mail-it1-f176.google.com ([209.85.166.176]:35638 "EHLO
        mail-it1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbeJNUJW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Oct 2018 16:09:22 -0400
Received: by mail-it1-f176.google.com with SMTP id p64-v6so23947780itp.0
        for <git@vger.kernel.org>; Sun, 14 Oct 2018 05:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3Ek17nvAzeJd37AelATHUTJRLbbDDf10gsUohXgUITY=;
        b=jiJjvKiCo22rBtl4VMUwUrm+idTXsNJwhRBTNW8Il3zgYBtEMssBkN3l+cOX1SjztA
         Eym5nwc/QgXU6vHY/TOtt8Y7t/HdMCA1kHg34p4VEyRpFOSucP0qqY4mV6A6vDTv2Hf+
         u51IE+qIeTah/NxyWRlLZ6YH6sqwXo/nNNaUQwgnfxvaR8fUaNNLFj3JNo0IQfqdSicx
         CTVP2Azl8k9pHNsVgixh5MgO8S9ClSQtvnFr7lbgV5etEGw2LsFI8rduO9uGmf36l4KS
         /Stz9Ilnx+8McXxEfLeCOnigLlQPjef3b2+CzSbqOwodjBDDMP5Rl2smc4U1m95lw5xb
         UTWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3Ek17nvAzeJd37AelATHUTJRLbbDDf10gsUohXgUITY=;
        b=rDCFMDbSBp3EGYUapGBPHowZ34WG5zPv8hotOQhzc+3Euss3j2WH8V5BqD3Wiazr6F
         EHYTxhtwtz5V3rUa4lmL/JcGnW6GmFeAH1NBK01DMDRxsB/Y0XS73HAYqHzBvA4l3pxy
         Cz5YIWcBjwrD9M2zRHrd+J8jCq+xP0rG1x7TS9wTteObFxEflO76+HCW2au7F0qPF/20
         blRszPmifARYf3swPJWnfgWNTwL0ObptNIE6ozCQg4OIDPQyfwrktYP61+xkJJYcX0+T
         luRP06NvYdI2pUxYiLoAp6CH44h1eW6IEQMk+kEfTAxEn8dOrGsMIA65k4tOGEqIKTFW
         SHpw==
X-Gm-Message-State: ABuFfoj2zc3Nez97aKWjjaUvSwr4x/kGOp6KeZX2h4mZIFmjtg8MmjKX
        Bqw1LVsIM6f7ticRbghQnNPBJ2zyIk1swHTtBxo=
X-Google-Smtp-Source: ACcGV62StY2KLWg8dLhuwPynnf0+ulhZlSK0aYbid/FgTzRhLuM3GF6WQnf8xA6ASVDzHD7fBeY9LcdCNVgRyxE32Yw=
X-Received: by 2002:a24:7804:: with SMTP id p4-v6mr9806697itc.123.1539520111569;
 Sun, 14 Oct 2018 05:28:31 -0700 (PDT)
MIME-Version: 1.0
References: <20180823154053.20212-1-benpeart@microsoft.com> <20181010155938.20996-1-peartben@gmail.com>
In-Reply-To: <20181010155938.20996-1-peartben@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 14 Oct 2018 14:28:05 +0200
Message-ID: <CACsJy8CyG0DWPyq5cSUteFUiz1ZCpmmVFjYjt8Gxm3Hnvd5q9g@mail.gmail.com>
Subject: Re: [PATCH v8 0/7] speed up index load through parallelization
To:     Ben Peart <peartben@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Ben Peart <benpeart@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 10, 2018 at 5:59 PM Ben Peart <peartben@gmail.com> wrote:
> @@ -3460,14 +3479,18 @@ static struct index_entry_offset_table *read_ieot_extension(const char *mmap, si
>
>         /* validate the version is IEOT_VERSION */
>         ext_version = get_be32(index);
> -       if (ext_version != IEOT_VERSION)
> +       if (ext_version != IEOT_VERSION) {
> +              error("invalid IEOT version %d", ext_version);

Please wrap this string in _() so that it can be translated.

>                return NULL;
> +       }
>         index += sizeof(uint32_t);
>
>         /* extension size - version bytes / bytes per entry */
>         nr = (extsize - sizeof(uint32_t)) / (sizeof(uint32_t) + sizeof(uint32_t));
> -       if (!nr)
> +       if (!nr) {
> +              error("invalid number of IEOT entries %d", nr);

Ditto. And reporting extsize may be more useful than nr, which we know
is zero, but we don't know why it's calculated zero unless we know
extsize.
-- 
Duy
