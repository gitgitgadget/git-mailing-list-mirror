Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78D2A1F406
	for <e@80x24.org>; Sun, 13 May 2018 23:45:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751053AbeEMXpN (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 May 2018 19:45:13 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35735 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750985AbeEMXpM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 May 2018 19:45:12 -0400
Received: by mail-wm0-f67.google.com with SMTP id o78-v6so11931057wmg.0
        for <git@vger.kernel.org>; Sun, 13 May 2018 16:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=JyaxiwF0JFoO4jSOwku84L9XmDzoh6GouJi/uhYl+DU=;
        b=dUR6qdwksjDVHnBL3rfrjiv4pAClfAjUSXCRFkKd7CmiExrfNaHdPtpz5odJQWpx3f
         DC6WTWchnd+f4PAhi792Bmjqx3QgyiLgHLgI6TlEFt4Ok7p5WpXidF06lQmEUIv1P3uv
         HmJc/qPnFb4MuEfSGO8c3EzrDu7zRUgdPxF5NAgndAiLkF4Xvjm2ct8it17VBiCLyMfh
         m7skdiwLrV4K52tklZGf8JF4+h+ctKqD6nP5vBxYa4Aar4kOgaoBeo82JW+S+dS/iE3v
         zbzCvLqV+K3DJTyLfIlxfu0apFjndGaEO2/0F4ZJ7kcv6JYi+8lq9DFlAbee4eeN/tP2
         QBig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=JyaxiwF0JFoO4jSOwku84L9XmDzoh6GouJi/uhYl+DU=;
        b=X6AwA8gKcAXqfF7v/YkkA1KKKVI3JcMWwAjLphLYesDUP5MUicG8OI6RuTATUH/JJ8
         ntPoerpABVoSwT/QbFf9W2EMZaLoVbfjNAgD0yAdJTISkRXnrt2ZcdMnScroper1ok5X
         W/hHwzVV+ahqQh/gLYOqmtiADSNLiWtbsnFLY8ch1UKsCizTJK0ioO/0MqDxVl+OhmzB
         J81VnDZqDam5vaZg/zWT8JIAwtxaW7iVNCl9iTKtKYi74Z98uip6Qe7EPNgF1LCjPae/
         PNrQN9UVgXF7/H/Exxlgq43NwNR7AnUGqsalX4rPFGCAJDjUsJ9zwBhx7qYjXlKK38Bw
         BF4g==
X-Gm-Message-State: ALKqPwdvxgbmXa7dfk7p/4olGaUGdXUWmR+iF/Vw0UytjJGUmDR7hWFL
        YtgMR9S3+HwS1fDZqRmbWIUO2Ivq
X-Google-Smtp-Source: AB8JxZomEZ193ZvMrcr7vJFIggyyJy3RGTwJATdbLkbXF4SCOejFoOkZQ3p5yTZ6OObZIJwDlk4DxQ==
X-Received: by 2002:a1c:8d90:: with SMTP id p138-v6mr3915892wmd.153.1526255110897;
        Sun, 13 May 2018 16:45:10 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id u35-v6sm11948255wrc.29.2018.05.13.16.45.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 13 May 2018 16:45:10 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 04/14] describe: use commit-slab for commit names instead of commit->util
References: <20180512080028.29611-1-pclouds@gmail.com>
        <20180513055208.17952-1-pclouds@gmail.com>
        <20180513055208.17952-5-pclouds@gmail.com>
Date:   Mon, 14 May 2018 08:45:09 +0900
In-Reply-To: <20180513055208.17952-5-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Sun, 13 May 2018 07:51:58 +0200")
Message-ID: <xmqq1sefdssa.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> +		slot = commit_names_peek(&commit_names, c);
> +		n = slot ? *slot : NULL;

Seeing this and the helper in the previous step makes me wonder if
we also want a "peek-and-then-peel" variant that encapsulates this
pattern.  We'll know when we read the series through.

So far looking good.  Thanks.

>  		if (n) {
>  			if (!tags && !all && n->prio < 2) {
>  				unannotated_cnt++;
