Return-Path: <SRS0=iCZD=ZT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC4ADC432C0
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 14:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADCC320674
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 14:22:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JqApOgLB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbfK0OWY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 09:22:24 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33714 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbfK0OWY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Nov 2019 09:22:24 -0500
Received: by mail-qk1-f195.google.com with SMTP id c124so15209532qkg.0
        for <git@vger.kernel.org>; Wed, 27 Nov 2019 06:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pUminfYldzjw/ofJASY/QZLWW2DqFpWzSRcPEFQHDZ4=;
        b=JqApOgLBTmAKBo/kj3eVE17/2Xb00gqNS8TMZryV1yMMoG1EonmhLQ5fDI8XNsE6ir
         TUE/wUWcNa0gNa/IUHv0K4/f56trfmM+imbb7n9tPer4LbL0Q+YKqPSSVUB/63DqX1KN
         WeLE6elzY1jzXeDEwQ+HQ7/zMWSbp5VTzJWwEh4ubY9r3H+Bo293NJPR5ImmgXKAaMuD
         5UHF/atJcn1VLQ7xAjFO3BkGVlNScHQMqOmPo2+c1SqQ+Axhs4ZwhJU7ppB5ozeW0kPS
         RV1Yfq9iR9Ucn7mYucct9qgxTtnW89ovUlRlDPbr5Ao02sN0w9NGTJaTpiJ/T7sBUkwR
         ye6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pUminfYldzjw/ofJASY/QZLWW2DqFpWzSRcPEFQHDZ4=;
        b=U7sJrJSerLqLpqJnQ1kWBBM+RSp/AORUDxOfjiFc2IeuS7qrvcQn0+Wh58PGZaZeWJ
         SS8WCTZB5C/DPZ+76C0qQC+aHqRBHApULbHivKigasMRJIR5Y1SGTIaW7qyz9ISPnqWI
         +Ue/GSaLwcY9lRVDx0rhOUeEIdH5Ui/4gkkl207d+6pWpQP5I+u4tHBn2NbeOLWHNyMI
         Nfa9FidgSjwIJTtjWfYSoEVZOKTNDrizfCcx+Wa3VZ3wMC0nJwBIOnWOwYqBejXeMMX+
         1AX7yB6CMD0wqxVFshbQIsfcHg6jPYT0XrApb8I+yfB6Wp9HtknXnHijJWZm//yQYNoM
         hNAA==
X-Gm-Message-State: APjAAAUMneRm5OwMcBrB+KScGOVl9cXDtDWOdkXUib12gUi7i/p90i10
        rzYrihAd8p5ClDWj0hLs3bkSNaEE
X-Google-Smtp-Source: APXvYqwVLeYNrHVSNJuMrY+AZNk0cWk5YKa8wiTd3jnVFZy18XduglHksnSdwsK6uxPe9AK5jFCzWw==
X-Received: by 2002:a37:5805:: with SMTP id m5mr4664689qkb.32.1574864542850;
        Wed, 27 Nov 2019 06:22:22 -0800 (PST)
Received: from [192.168.1.3] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id e6sm6793872qkg.89.2019.11.27.06.22.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Nov 2019 06:22:21 -0800 (PST)
Subject: Re: [PATCH 1/2] revision: clear the topo-walk flags in
 reset_revision_walk
To:     Mike Hommey <mh@glandium.org>, git@vger.kernel.org
Cc:     gitster@pobox.com
References: <20191122083704.29267-1-mh@glandium.org>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <34a0ae8e-a0f3-e263-e386-2fbbc49f0d07@gmail.com>
Date:   Wed, 27 Nov 2019 09:22:20 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:71.0) Gecko/20100101
 Thunderbird/71.0
MIME-Version: 1.0
In-Reply-To: <20191122083704.29267-1-mh@glandium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/22/2019 3:37 AM, Mike Hommey wrote:
> Not doing so can lead to wrong topo-walks when using the revision walk API
> consecutively.
> 
> Signed-off-by: Mike Hommey <mh@glandium.org>
> ---
>  revision.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> As mentioned in 20191108025007.bphr7ynvskeoe6tb@glandium.org, it feels
> like maybe TOPO_WALK_EXPLORED and TOPO_WALK_INDEGREE should be in
> ALL_REV_FLAGS too?
> 
> diff --git a/revision.c b/revision.c
> index 0e39b2b8a5..765a56ae33 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -3098,7 +3098,7 @@ static void set_children(struct rev_info *revs)
>  
>  void reset_revision_walk(void)
>  {
> -	clear_object_flags(SEEN | ADDED | SHOWN);
> +	clear_object_flags(SEEN | ADDED | SHOWN | TOPO_WALK_EXPLORED | TOPO_WALK_INDEGREE);

Looks good. Thanks for catching and fixing this!

-Stolee
