Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F44C433EF
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 06:00:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbiGUGAx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 02:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbiGUGAv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 02:00:51 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE2D52716
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 23:00:48 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id b11so1275590eju.10
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 23:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=aIh6kzAk1/ob4fsZ9gQIqqBseQ3u5tgXNr9t+zJ3vSs=;
        b=p9FXBRqjGXCZGv4SyDTV11b/zqU1OdMAnfMmgk8InUi8ufBCV2bSO5JZcpKaSli9me
         AZavLRgJYUNLEdL/DiyNp/HGkdgP4DXDFBt59tOet2/T5nkvLv7xgZUoTc/40cDLPi9Q
         Nw9repbpYYT2u/ISNCKHpoed3p5Kxdrh2tVHfdYU59vMHeO7p88dkhpQyXJiY0/md/er
         dvs4DaY2H9tDo8zU31sojzliwIfQfWBWFUreTaDL89krAhgD8fiHcvr18b9H+H3Gg5Yu
         Uua6I9K0LN8u8+UI6TOha9gJKWDT00/t9dngfoxQTvWeS5fZWe2QPy8RUbDBcZtdXwvn
         wlFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=aIh6kzAk1/ob4fsZ9gQIqqBseQ3u5tgXNr9t+zJ3vSs=;
        b=535rKXCZiRQtD4oy6sj41kOT/YYZnrvncEvhvGvo56qcQN6fl2UwayBlGm5fP579cj
         pu6vjj2VWctCRV+Ey22gOeTh86DkAeQGAKttsnEFypy0efMiUoosgKb7RIYa//doFNvG
         XRDT4nJfvlvYXxAbezYCMo5u1U+KX4jlMOeZVMR91VnWzN7gWEWzKY/lAPzs2uDyVqCR
         3VJbC1lGD+6Bnz1IBPiAtSAKOshXVdf5VHX6raq+w/Dks7N4mYpwsce5hUb2U0w+LFpk
         IfXj+eJ45LbQt4m8wPzaSSDEwnSlTdnCFjuTxedgMMVQWRQ//ePGOlXcSj/dmy4+KRWq
         1KUg==
X-Gm-Message-State: AJIora8WGLd87sTxTB4i0AJuS8gW2sUadCrL68KNSUwPcaZIFFAUMTpC
        R93CIPL0yOJ8KKtxoYB7TSQhp+hTyl6yNA==
X-Google-Smtp-Source: AGRyM1vynXj+BDPU2rLPfI/KRIw3/WTb3804dMS1QVk4KX2XYjYxYYT9bsTj2PzeYafS/b0SyA/K6w==
X-Received: by 2002:a17:906:c10:b0:6f4:6c70:b00f with SMTP id s16-20020a1709060c1000b006f46c70b00fmr39150855ejf.660.1658383246982;
        Wed, 20 Jul 2022 23:00:46 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id lb5-20020a170907784500b0072f2e409575sm439016ejc.98.2022.07.20.23.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 23:00:46 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oEPEr-004Q7W-Co;
        Thu, 21 Jul 2022 08:00:45 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] string_list: use the right kind of STRING_LIST_INIT
Date:   Thu, 21 Jul 2022 07:55:49 +0200
References: <xmqq7d471dns.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqq7d471dns.fsf@gitster.g>
Message-ID: <220721.868ronuhrm.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jul 20 2022, Junio C Hamano wrote:

> Since 4a4b4cda (builtin-remote: Make "remote -v" display push urls,
> 2009-06-13), the string_list that was initialized with 0 in its
> strdup_string member is immediately made to strdup its key strings
> by flipping the strdup_string member to true.  When 183113a5
> (string_list: Add STRING_LIST_INIT macro and make use of it.,
> 2010-07-04) has introduced STRING_LIST_INIT macros, it mechanically
> replaced the initialization to STRING_LIST_INIT_NODUP.
>
> Instead, just use the other initialization macro to make it strdup
> the key from the beginning.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  builtin/remote.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git c/builtin/remote.c w/builtin/remote.c
> index d9b8746cb3..c713463d89 100644
> --- c/builtin/remote.c
> +++ w/builtin/remote.c
> @@ -1229,10 +1229,9 @@ static int get_one_entry(struct remote *remote, void *priv)
>  
>  static int show_all(void)
>  {
> -	struct string_list list = STRING_LIST_INIT_NODUP;
> +	struct string_list list = STRING_LIST_INIT_DUP;
>  	int result;
>  
> -	list.strdup_strings = 1;
>  	result = for_each_remote(get_one_entry, &list);
>  
>  	if (!result) {

Heh :) I think it's safe to give this my Reviewed-By, since I've been
running with this patch for almost a year now:
https://github.com/avar/git/commit/bdf4466eb92

It's on a branch of some WIP string_list API fixes that I haven't sent
in, but the fix looks good to me...
