Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6428C1F42B
	for <e@80x24.org>; Mon, 13 Nov 2017 21:33:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751367AbdKMVdT (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Nov 2017 16:33:19 -0500
Received: from mail-io0-f178.google.com ([209.85.223.178]:54964 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751234AbdKMVdS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Nov 2017 16:33:18 -0500
Received: by mail-io0-f178.google.com with SMTP id w127so4802679iow.11
        for <git@vger.kernel.org>; Mon, 13 Nov 2017 13:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WTqcy7vyOyqm4ekggc5mLhTCydhVTnPc7MpzHiG97kY=;
        b=s0djFtCEa1iSMNNLHP+MRAXiOpBmQpebyc6/Z1F8clZRIeOFiT1Abwpd6bNQJXL1lG
         HhzO0dF2IvIY5h9VkIB12yW8Jw9haL2xyhGcvw0oBPB0A049iqen8f6YReGa5wmtC9el
         HkeIUY0b3Uv9pb0fwdf7/zRi0MK+v/Uzovk2/ZiObIB8YyvKSL9cMQzMb9TICDAnC8Zg
         CRD9/piHP2Y+xGx+gQK4c1ttNAAgZsMpXaENna27AI2Yn8h95kaQ3K3GthOpzorVu/Ft
         tf4sql1qk5QfxuY2hzxl3CCpFwtguProtfdUViey4Bg4ChcHP0U7FuykWVxBM0vDH96W
         hGpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WTqcy7vyOyqm4ekggc5mLhTCydhVTnPc7MpzHiG97kY=;
        b=RWxaDnksXqObuF6V64bYxW+NBIeF4QY4WDhCcdax3+p8M8TI1V0ecgy+Yg/phQuxm0
         0+o7q+29Y+30v6Mzmkys/qz7SiMHhlr8q5olsVggZCynbLtm0jQhnbBFzm+AESaxz0GQ
         /2vSGohbEZ1f/HwPI3EoM9yANyhz9MckoE9N5LmVjir+OpzpunEeSAGq347JBFHUe/Mf
         uvzQ23teRxLxWHA7gBdVx35eDVkKI6p7VKpPA+7T2Eo8Aqi6MOPRIRRv2YJ6t3OUAk1e
         m3aPzZ4I4+0dlCLR8W5JiGINFf7mSbZSHj3gERNonvKCbS5SzMNWMsOTZhF/D13b5VKj
         eFJA==
X-Gm-Message-State: AJaThX4ZCAac3KWaJ9jv1jv9M2HMPtu5pmcyLBhmmOgSak/QQhppg8cM
        wpE6BX3C7Al/aeFVscyO0MYkN1RO1Dc=
X-Google-Smtp-Source: AGs4zMbJPDB/12eKjoBEJ1JuM4yrWxAyXAz+SA1Wg+AM1xtrKdGshTykki1pA+Q9yk5WJUZw49s8Gg==
X-Received: by 10.107.129.163 with SMTP id l35mr9628551ioi.193.1510608797582;
        Mon, 13 Nov 2017 13:33:17 -0800 (PST)
Received: from twelve3.mtv.corp.google.com ([2620:0:100e:422:b1aa:4028:e6df:d3e])
        by smtp.gmail.com with ESMTPSA id d1sm3056381ioc.61.2017.11.13.13.33.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Nov 2017 13:33:16 -0800 (PST)
Date:   Mon, 13 Nov 2017 13:33:16 -0800
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 2/4] progress: fix progress meters when dealing with
 lots of work
Message-Id: <20171113133316.c10bd360b4af10e572049443@google.com>
In-Reply-To: <20171113201600.24878-3-newren@gmail.com>
References: <20171113201600.24878-1-newren@gmail.com>
        <20171113201600.24878-3-newren@gmail.com>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 13 Nov 2017 12:15:58 -0800
Elijah Newren <newren@gmail.com> wrote:

> -static int display(struct progress *progress, unsigned n, const char *done)
> +static int display(struct progress *progress, uint64_t n, const char *done)
>  {
>  	const char *eol, *tp;
>  
> @@ -106,7 +106,7 @@ static int display(struct progress *progress, unsigned n, const char *done)
>  		if (percent != progress->last_percent || progress_update) {
>  			progress->last_percent = percent;
>  			if (is_foreground_fd(fileno(stderr)) || done) {
> -				fprintf(stderr, "%s: %3u%% (%u/%u)%s%s",
> +				fprintf(stderr, "%s: %3u%% (%"PRIuMAX"/%"PRIuMAX")%s%s",
>  					progress->title, percent, n,
>  					progress->total, tp, eol);

I think it would be better to cast the appropriate arguments to
uintmax_t - searching through the Git code shows that we do that in
several situations. Same for the rest of the diff.
