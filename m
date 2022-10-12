Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BCEFC4332F
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 07:47:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiJLHrr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 03:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiJLHrn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 03:47:43 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6783AAD9A0
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 00:47:41 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id qw20so35638578ejc.8
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 00:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JXWnDwrOG1EenvRiJhgJ1adJkm9ov2rT+VoXdATci4s=;
        b=jljdwKHIQQh1IQQ4c63VOxzwZbtLhm0bf6D/wH7xvTqus9GidLPHB6jDSAcMSvQjwg
         RPa6ao76aw1yIiJk0Ww/DpGOw+Ugt0DFr0VlETMKMIU42AZfYQksb/uqRdAM6CM1TRs9
         zUPFM0glUAL1R4QFvf0R4t89C0I+xTWPhQ4wF3sdhGYMHuzjsZcMHfThLbWIoHv7ILjl
         QQ8jraYFbucmysiCBozXSfOaZJ0jWB3YZ1iXixmEkg6gFnOgqWl6Ttvz7ZQEfnvbByh+
         LG7HFpe+Zy/RUtZVkj0oeLMmLGrLt13kxfzjNLQ5YnDkoHKABm1pStwZ3nlzbzwroAWZ
         j2Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JXWnDwrOG1EenvRiJhgJ1adJkm9ov2rT+VoXdATci4s=;
        b=n3YvMSvs+xQEIrqRtcmoduHSxATZwnW57z9PyiTJcHwjNq97jodZK4Wtv6jnJwU6Kd
         gt80/9O6eA/b6kPQQiu/HVDZTRBsW96YSQLJ/fI53zsuMOx9IsSsIvW2KAIebkwVsJFF
         HJ+4vq7+h1su17DyO6Pil7vpoj86M3JGZbgYoKaLdxtLoqm6/go+w0gYr1vHkezhUEZy
         wz4GI0f4FYod4vQFUX3xJjsNxoyDTGDMDwN+r6ygmyBKQH23JcEAs/DTE5964nEgKRG2
         pph1VatTSydDumlRJ9JEs6B9mmE81jg13Z7P4Pf3WZhs5+6SPhQzin8CzRhcsHM+Lq1k
         4ihQ==
X-Gm-Message-State: ACrzQf1GfJsNFubIuL+Cctch5pe7oZ3ArrZsGg/7lg9Zf5fDmKU9P9Ik
        ZE9Tj35IeJzVhPAe94iXc5nIBtkC42Ki1w==
X-Google-Smtp-Source: AMsMyM6Xm5vxv2VBRX0feyZkj4o9WvwBGCVqQqimjpJ5E9nKbtztdwiVnbRUxxyKOMGFFGr2Jv2aNA==
X-Received: by 2002:a17:907:2722:b0:77e:d84d:9e09 with SMTP id d2-20020a170907272200b0077ed84d9e09mr21881887ejl.679.1665560859309;
        Wed, 12 Oct 2022 00:47:39 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id s12-20020a170906354c00b007806c1474e1sm765072eja.127.2022.10.12.00.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 00:47:38 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oiWSo-004DO9-0c;
        Wed, 12 Oct 2022 09:47:38 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, emilyshaffer@google.com,
        phillip.wood123@gmail.com
Subject: Re: [PATCH v2 2/4] submodule: move status parsing into function
Date:   Wed, 12 Oct 2022 09:41:21 +0200
References: <https://lore.kernel.org/git/20220922232947.631309-1-calvinwan@google.com/>
 <20221011232604.839941-3-calvinwan@google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <20221011232604.839941-3-calvinwan@google.com>
Message-ID: <221012.868rllo545.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Oct 11 2022, Calvin Wan wrote:

> A future patch requires the ability to parse the output of git
> status --porcelain=2. Move parsing code from is_submodule_modified to
> parse_status_porcelain.
>
> Signed-off-by: Calvin Wan <calvinwan@google.com>
> ---
>  submodule.c | 71 +++++++++++++++++++++++++++++------------------------
>  1 file changed, 39 insertions(+), 32 deletions(-)
>
> diff --git a/submodule.c b/submodule.c
> index 72b295b87b..a3410ed8f0 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -1864,6 +1864,43 @@ int fetch_submodules(struct repository *r,
>  	return spf.result;
>  }
>  
> +static int parse_status_porcelain(char *buf, unsigned *dirty_submodule, int ignore_untracked)
> +{
> +	/* regular untracked files */
> +	if (buf[0] == '?')
> +		*dirty_submodule |= DIRTY_SUBMODULE_UNTRACKED;
> +
> +	if (buf[0] == 'u' ||
> +		buf[0] == '1' ||
> +		buf[0] == '2') {
> +		/* T = line type, XY = status, SSSS = submodule state */
> +		if (strlen(buf) < strlen("T XY SSSS"))
> +			BUG("invalid status --porcelain=2 line %s",
> +				buf);
> +
> +		if (buf[5] == 'S' && buf[8] == 'U')
> +			/* nested untracked file */
> +			*dirty_submodule |= DIRTY_SUBMODULE_UNTRACKED;
> +
> +		if (buf[0] == 'u' ||
> +			buf[0] == '2' ||
> +			memcmp(buf + 5, "S..U", 4))
> +			/* other change */
> +			*dirty_submodule |= DIRTY_SUBMODULE_MODIFIED;
> +	}
> +
> +	if ((*dirty_submodule & DIRTY_SUBMODULE_MODIFIED) &&
> +		((*dirty_submodule & DIRTY_SUBMODULE_UNTRACKED) ||
> +		ignore_untracked)) {
> +		/*
> +		* We're not interested in any further information from
> +		* the child any more, neither output nor its exit code.
> +		*/
> +		return 1;
> +	}
> +	return 0;
> +}
> +
>  unsigned is_submodule_modified(const char *path, int ignore_untracked)
>  {
>  	struct child_process cp = CHILD_PROCESS_INIT;
> @@ -1900,39 +1937,9 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
>  
>  	fp = xfdopen(cp.out, "r");
>  	while (strbuf_getwholeline(&buf, fp, '\n') != EOF) {
> -		/* regular untracked files */
> -		if (buf.buf[0] == '?')
> -			dirty_submodule |= DIRTY_SUBMODULE_UNTRACKED;
> -
> -		if (buf.buf[0] == 'u' ||
> -		    buf.buf[0] == '1' ||
> -		    buf.buf[0] == '2') {
> -			/* T = line type, XY = status, SSSS = submodule state */
> -			if (buf.len < strlen("T XY SSSS"))
> -				BUG("invalid status --porcelain=2 line %s",
> -				    buf.buf);
> -
> -			if (buf.buf[5] == 'S' && buf.buf[8] == 'U')
> -				/* nested untracked file */
> -				dirty_submodule |= DIRTY_SUBMODULE_UNTRACKED;
> -
> -			if (buf.buf[0] == 'u' ||
> -			    buf.buf[0] == '2' ||
> -			    memcmp(buf.buf + 5, "S..U", 4))
> -				/* other change */
> -				dirty_submodule |= DIRTY_SUBMODULE_MODIFIED;
> -		}
> -
> -		if ((dirty_submodule & DIRTY_SUBMODULE_MODIFIED) &&
> -		    ((dirty_submodule & DIRTY_SUBMODULE_UNTRACKED) ||
> -		     ignore_untracked)) {
> -			/*
> -			 * We're not interested in any further information from
> -			 * the child any more, neither output nor its exit code.
> -			 */
> -			ignore_cp_exit_code = 1;
> +		ignore_cp_exit_code = parse_status_porcelain(buf.buf, &dirty_submodule, ignore_untracked);
> +		if (ignore_cp_exit_code)
>  			break;
> -		}
>  	}
>  	fclose(fp);

This isn't just a code move, but a rewrite of much of the code to accept
a "char *buf" rather than a "struct strbuf buf".

I can see in a later commit that you'd like to change this to accept a
.string from a string_list.


Without changing anything else, if you lead with a commit that does (in
the initial loop):

	char *str = buf.buf;
        const size_t len = buf.len;

And then make it use "buf" and "len" instead you could follow with the
move commit, which at that ponit would benefit from the rename detection
more more than it does now.

Also: If we have a strbuf in this caller let's pass a "len", and not
here make it need to do a strlen() on every line when we've computed it
already, the other caller could just pass another strlen([...].string).

