Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D8421F597
	for <e@80x24.org>; Thu,  2 Aug 2018 17:19:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732129AbeHBTLQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 15:11:16 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:37217 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726938AbeHBTLP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 15:11:15 -0400
Received: by mail-yb0-f195.google.com with SMTP id r3-v6so1463848ybo.4
        for <git@vger.kernel.org>; Thu, 02 Aug 2018 10:19:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1l2awbi69+BDXtgCJlbPHsQMhw3dKTA5EVVlWpKbLJI=;
        b=aenANsoP9QfmcoHE6HsOa2lUl4pF1kDNr+ciqquPCvCsmo/JFAxEMKowa4NQIZG2iq
         s3WLvYsKWpyAUXBurYioeSjEZp1Nq+15hr1JsiVq26k8cpy0hd9bDjOfqIKTenoeMgrr
         cKOYtqmTv8XqiaAtppM0i3kY082v1wsI8uzZBiHUbtBV0NI2yd89x3O+in+GUtWZZjU7
         I4tttgiW8EW5c0MeTtYPCsAp5W1SH9Sl/D5sLYzIQn5oP1xXFe17VGrpL9L8ecKykIYl
         M+leaMwmbq2QvpLc+bGCqHPit6l2pPopOh52uvvqcU+cEclPhHdLbZrB2lCVyO1AxufQ
         uq6Q==
X-Gm-Message-State: AOUpUlGilgj6Gv6y+Y6LkVwFsOjw1SnA+0okdtf2VPWQERHzKcAfWTj7
        CcFqB2LVag8dZH6Zhy0tn44UJ1cX8ukrlJJDX3w=
X-Google-Smtp-Source: AAOMgpcP901dWTHySOLrz4Mx26pC7OauGOct41EM3CxOk5TJpYiFFpiyXV/CFJxUVXrbk/eYpOCd6YBAtYn0XdTCRXY=
X-Received: by 2002:a81:110e:: with SMTP id 14-v6mr269502ywr.16.1533230352328;
 Thu, 02 Aug 2018 10:19:12 -0700 (PDT)
MIME-Version: 1.0
References: <20180802121308.17371-1-hanwen@google.com> <20180802121308.17371-2-hanwen@google.com>
In-Reply-To: <20180802121308.17371-2-hanwen@google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 2 Aug 2018 13:19:00 -0400
Message-ID: <CAPig+cTFmNsxa4bSdUN199Q8YcJz74jn4Ytc3=JezaE-J595Og@mail.gmail.com>
Subject: Re: [PATCH 1/2] config: document git config getter return value.
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 2, 2018 at 8:13 AM Han-Wen Nienhuys <hanwen@google.com> wrote:
> diff --git a/config.h b/config.h
> @@ -178,10 +178,16 @@ struct config_set {
>  extern void git_configset_init(struct config_set *cs);
> -extern int git_configset_add_file(struct config_set *cs, const char *filename);
> -extern int git_configset_get_value(struct config_set *cs, const char *key, const char **value);
> +/*
> + * These functions return 1 if not found, and 0 if found, leaving the found
> + * value in the 'dest' pointer.
> + */
> +extern int git_configset_add_file(struct config_set *cs, const char *filename);
> +extern int git_configset_get_value(struct config_set *cs, const char *key, const char **dest);
>  extern int git_configset_get_string_const(struct config_set *cs, const char *key, const char **dest);
>  extern int git_configset_get_string(struct config_set *cs, const char *key, char **dest);
>  extern int git_configset_get_int(struct config_set *cs, const char *key, int *dest);

It doesn't seem like git_configset_add_file() fits in this group. It's
neither searching for something (thus won't return "found" / "not
found"), nor is it returning 0 or 1. (It returns 0 on success and -1
on failure.)
