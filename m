Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF4F11F597
	for <e@80x24.org>; Sat,  4 Aug 2018 06:34:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbeHDIeI (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Aug 2018 04:34:08 -0400
Received: from mail-it0-f46.google.com ([209.85.214.46]:35591 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbeHDIeH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Aug 2018 04:34:07 -0400
Received: by mail-it0-f46.google.com with SMTP id 139-v6so4674195itf.0
        for <git@vger.kernel.org>; Fri, 03 Aug 2018 23:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yacCLiF/GviQmAg2Ew6jwiqDCLicjkoJvGc0pzCcgxo=;
        b=BEnroTk2EYwKiorenF8LWXlZsc+zkugiQ4PmO2XYi70Nint/dk1+JDWMGDyOHvOruQ
         w5cLShGFGIibzJAl4a925HEHlok6PZ8cnoY5ZLkHj86vmllsGalgq4BlLvmxWR+FxLNB
         OoXoPU1h0RN2QVtefULglnumx75+G5Cz/tIZWDCo2NnB6wPZffz1XwtZMtqCD0FP6sW4
         0AijijbAvxfBIkxDVe4yFpL07eM0/7dfyV3Ok6qp1bv4uaZQvjIkvR2mr89espOgNBcH
         +OOEiaCPZiXpB+LDqyCftluThXMQDbchDbN+zvg7ZNLzgv6++gzDkQ6alh7RB/HKs2hD
         j4QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yacCLiF/GviQmAg2Ew6jwiqDCLicjkoJvGc0pzCcgxo=;
        b=mXa1dxQQ9fyviVIZDWn/QkCr9gaERUhyAKJzcgv20tIOzjrPe+LaUev6Q4x6lOG+ES
         2JDrWO8Fv3XHZiNdp/XJk0XydX8fbPxgTzQSctlmi2t7+2AXCBYDo+6ME7rmo1dcKQW/
         Ggs+/B4d4UEgi0wXKvNprvnTFyZ+A4OgDbPEF4VhUYc3jxTC1/uYmeJbofFGNXCZBBhZ
         uvihQdhehOJj9TgUFM8wMRecwUzPcGcXAYWOuM8aWN8UvqFIZQA1MXVOJvlU8jQyKx43
         H0pTXAtK2x/NY964X6sIrK6G2drFyxPRaXWa9zaIBxIAR0b99NqGFJikkIhPZ0SCBNwe
         65TA==
X-Gm-Message-State: AOUpUlH8Iq+qwuMZD+FifY1Xnmu3qbLZeRByBfT+WsP/VYqwr24PYN37
        DUNdw7lLjr6Ys5xhrKWez19Qsw5V8L8evYLt0rQ=
X-Google-Smtp-Source: AAOMgpd8LnVNDq3WOFWNiSW3zKLPFC9tXbh+CcNiu2n2qBJHi8dPxHO0QZN+MbDiZokp+5J9skTkC8BpBn75a+lf5yw=
X-Received: by 2002:a02:c50b:: with SMTP id s11-v6mr6051437jam.61.1533364474727;
 Fri, 03 Aug 2018 23:34:34 -0700 (PDT)
MIME-Version: 1.0
References: <20180727034859.15769-1-max@max630.net> <20180727034859.15769-3-max@max630.net>
In-Reply-To: <20180727034859.15769-3-max@max630.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 4 Aug 2018 08:34:08 +0200
Message-ID: <CACsJy8DRNHVgYYH0AjdcU68PGg1anp5g+d7Up3cXp0bmDuC0Mg@mail.gmail.com>
Subject: Re: [PATCH v9 2/3] http-backend: respect CONTENT_LENGTH as specified
 by rfc3875
To:     Max Kirillov <max@max630.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>, manschwetus@cs-software-gmbh.de,
        Chris Packham <judge.packham@gmail.com>,
        Konstantin Khomoutov <kostix+git@007spb.ru>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 27, 2018 at 5:50 AM Max Kirillov <max@max630.net> wrote:
> -static void inflate_request(const char *prog_name, int out, int buffer_input)
> +static ssize_t read_request_fixed_len(int fd, ssize_t req_len, unsigned char **out)
> +{
> +       unsigned char *buf = NULL;
> +       ssize_t cnt = 0;
> +
> +       if (max_request_buffer < req_len) {
> +               die("request was larger than our maximum size (%lu): "
> +                   "%" PRIuMAX "; try setting GIT_HTTP_MAX_REQUEST_BUFFER",
> +                   max_request_buffer, (uintmax_t)req_len);

Please mark these strings for translation with _().
-- 
Duy
