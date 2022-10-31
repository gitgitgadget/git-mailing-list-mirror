Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E22ECAAA1
	for <git@archiver.kernel.org>; Mon, 31 Oct 2022 21:56:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbiJaV4l (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Oct 2022 17:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiJaV4j (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2022 17:56:39 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11057140CA
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 14:56:39 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id q142so4863068iod.5
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 14:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kw4rQpTrDaKefmtyfoADlL0AL9nRFsObWs3FX3VCbPo=;
        b=WZMxE7ARsn4Q9ONCQVNa4xkYPA4pVoVaTdQAZtnmY9fcDP9IUrv17R3aJirFGkxLiS
         FlagWKbX56MuxfHwU8/QHOLcXr2dVN16BCTamHwNH5OxqmkI+HCPMZ+2KoPhdEje14Tz
         tRJRmyg+f2xue9ZZzJiZ8YnUs+DwOgWaM7PUehks7vtk7FpG3dNAN6vR6yMMkIIclX7+
         4VBzDHZK5YxVy4YtXRwo366nmjfKcO3Ejmd+UJSAGAFtVwRcbZLoH42QWCjVvS+lEn4w
         fyMJkI0xbDHVgnB8PWz35tw317Wp9pToaRC61NtIXOc5kjIFrMe2GqzI80bru0AKyQ+z
         N1MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kw4rQpTrDaKefmtyfoADlL0AL9nRFsObWs3FX3VCbPo=;
        b=A4X0+gOm7eVEyJLxzjRu6VNf/M8PsS/5jXIjKzQbuavt8vghKVDh69cnLunLen5m9k
         K0l8bXEN43JXNT61c36dA4VEFOtp5LNMgCb9KFgQuE4J3uhOuMnGtGfzxfR8JSm+bh4R
         tSyspToj2uw3kPERXrJacPI9fGy9BmgmqF9q+yBLdkKVZtFHvGIjiIcZW/GYTnSMngYk
         bj5Ai8fs/JR/mWEQ4tiUQodJJDuMsBrm37BbGHlIhDnKQEjMjnZjuouDn2vSdTtn/WiF
         xrmtqCyOFml5RHBfixuoR8vOFpr9ei261wXijOdpsug96fgKYA40XLwcyDJDb0XoLPwP
         WG3w==
X-Gm-Message-State: ACrzQf1nUh3Rm8+2Tk3toOZHY7N8ql/bzp1qUein43i7UfbVDeux9gw8
        r+R7n6Q+zwrfz2NwH/+ehqNtukv8LQxbrCp9
X-Google-Smtp-Source: AMsMyM5295Z7IrkLRfWIcDAxe9KAkWLVs5Ag0rYgO1vgOSnM+86yVw6acc9/YAGzeuI2aavfBOtwkA==
X-Received: by 2002:a02:a04f:0:b0:375:444e:3dc0 with SMTP id f15-20020a02a04f000000b00375444e3dc0mr8120840jah.142.1667253398402;
        Mon, 31 Oct 2022 14:56:38 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id p8-20020a92d488000000b002ff9ea02044sm1943068ilg.61.2022.10.31.14.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 14:56:38 -0700 (PDT)
Date:   Mon, 31 Oct 2022 17:56:36 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     man dog <dogman888888@gmail.com>, git@vger.kernel.org
Subject: Re: Bug report: git -L requires excessive memory.
Message-ID: <Y2BElOFGJ8JinYxC@nand.local>
References: <CAFOPqVXz2XwzX8vGU7wLuqb2ZuwTuOFAzBLRM_QPk+NJa=eC-g@mail.gmail.com>
 <20221031214554.GA1714@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221031214554.GA1714@szeder.dev>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 31, 2022 at 10:45:54PM +0100, SZEDER Gábor wrote:
> 'line-log.c' contains two "NEEDSWORK leaking like a sieve" comments,
> but you managed to stumble upon yet another case (those two are in the
> code path handling merge commits, but your history is linear).

;-).

> The patch below plugs this leak.
>
>   ---  >8  ---
>
> diff --git a/line-log.c b/line-log.c
> index 51d93310a4..b6ea82ac6b 100644
> --- a/line-log.c
> +++ b/line-log.c
> @@ -1195,6 +1195,9 @@ static int process_ranges_ordinary_commit(struct rev_info *rev, struct commit *c
>  	if (parent)
>  		add_line_range(rev, parent, parent_range);
>  	free_line_log_data(parent_range);
> +	for (int i = 0; i < queue.nr; i++)
> +		diff_free_filepair(queue.queue[i]);
> +	free(queue.queue);
>  	return changed;
>  }
>
>   ---  8<  ---

Very nice. I wouldn't be surprised if there are other leaks, in the
line-log code, but fixing one is good regardless. If you resend with
your S-o-b, I'd be happy to queue it.

Thanks,
Taylor
