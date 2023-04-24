Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BA98C7618E
	for <git@archiver.kernel.org>; Mon, 24 Apr 2023 16:09:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbjDXQJh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Apr 2023 12:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231983AbjDXQJg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2023 12:09:36 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408096A6A
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 09:09:35 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-63b4960b015so3773214b3a.3
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 09:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682352575; x=1684944575;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=77jx7BmdSWSx2VPdNBcHgN1hcRKlLQ1mnsxyuKfQ7Sg=;
        b=dVhCtpn2iJwiogr96Q+l2mu/oHI7gGEIH4PDabzhi5rc6CeMnUqHmiq3TvVF8NHfrm
         Lo8WeaxlPZdJ2B1bQQBiN9WmOdik4d1p+lFSPiDFAtw2XJnfzHF6AT3Lz3BSuYZIKb0V
         31RZKTPXD0/xPy6GybW6q3lD7+oFzatZyCO/9NGhILI0g9ZTX4Bj6Dk4wGsfS0w21BZu
         obDKCOSkWyQjF/fjoX83uJ/Q4zDfmSDLJpgTPtmUC2S3sjAZx0J3M8J3gNUFsZhQekSL
         oHakngKjtRyaXqZJmHYGHVkAkejTAkWWYSRxCEtTSMG6j7ALPqUV6MOxGvaU8f6GVtmu
         8LhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682352575; x=1684944575;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=77jx7BmdSWSx2VPdNBcHgN1hcRKlLQ1mnsxyuKfQ7Sg=;
        b=O3oGj6PCQfe+/4jNkhwzzGDl5wecr4qD7rLpnFgXAhqhYuUYn/smsVX4V55QAgzm9l
         b+6r31fPbDeTAhPcMaeWAEAbxpdC2E4zf6CWXegcr/M80rfvekRXpRGfEro8hgDFFwnC
         cKat9bVO6exsDnCprrRXJaSQ1RZwPV3lDBilGplS2jX/ZUS0bv3bxS5w0dAIpJBc7dGo
         Jx77R5yOcNTdlVIpWgKyqxfe9paQ2W75VIuzNFIl3fPIbvmH96OWPfBZq9rdQ05r8uAO
         epfklXkffcmT3nP+pV1Ut8kRxnAaojaDRNQT5FLkyhi9heQhZTay+p9zUh8ntA5PihlB
         +yCA==
X-Gm-Message-State: AAQBX9fHg7NqknAK3ih05gswGD/zfzPClgeJvYO0I5lTXwjWGRSxMhpT
        OGeHyAM5lJK5cg8T49KWcMXGWs4bFk0=
X-Google-Smtp-Source: AKy350ap3PGp2lH+GsLusUnkYsbinXoJh+A5fVzUWc/R/Lom2dnidPNwuAANOOWUqRVMQXHI+fDdsg==
X-Received: by 2002:a05:6a00:2396:b0:63f:1adb:bf61 with SMTP id f22-20020a056a00239600b0063f1adbbf61mr15198610pfc.18.1682352574652;
        Mon, 24 Apr 2023 09:09:34 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id n11-20020a056a00212b00b0063f167b41bdsm6096299pfj.38.2023.04.24.09.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 09:09:34 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Mike Hommey <mh@glandium.org>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH] Fix memory leak in get_reachable_subset
References: <20230421234409.1925489-1-mh@glandium.org>
Date:   Mon, 24 Apr 2023 09:09:33 -0700
In-Reply-To: <20230421234409.1925489-1-mh@glandium.org> (Mike Hommey's message
        of "Sat, 22 Apr 2023 08:44:09 +0900")
Message-ID: <xmqqbkjdgt36.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mike Hommey <mh@glandium.org> writes:

> ---
>  commit-reach.c | 2 ++
>  1 file changed, 2 insertions(+)

Missing sign-off?

[jc: adding the author of fcb2c076 (commit-reach: implement
get_reachable_subset, 2018-11-02) to the CC list]

> diff --git a/commit-reach.c b/commit-reach.c
> index 70bde8af05..f15d84566b 100644
> --- a/commit-reach.c
> +++ b/commit-reach.c
> @@ -944,6 +944,8 @@ struct commit_list *get_reachable_subset(struct commit **from, int nr_from,
>  		}
>  	}
>  
> +	clear_prio_queue(&queue);
> +
>  	clear_commit_marks_many(nr_to, to, PARENT1);
>  	clear_commit_marks_many(nr_from, from, PARENT2);

Looking good.
