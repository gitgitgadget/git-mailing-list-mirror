Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E1DC05027
	for <git@archiver.kernel.org>; Mon, 23 Jan 2023 23:13:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbjAWXNs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Jan 2023 18:13:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231510AbjAWXNr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2023 18:13:47 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D59322796
        for <git@vger.kernel.org>; Mon, 23 Jan 2023 15:13:46 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id dw9so13116187pjb.5
        for <git@vger.kernel.org>; Mon, 23 Jan 2023 15:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0n4mjLkjU83bCYhbVTmVANBrPEbYw3w1DX5fPdtaI1c=;
        b=kF55MPmxRNos8ePhOWd3TUxQo5Z8/cdInVbdO0iwRdKA4jbfUgv2dKTRB2d0EByi+V
         spQRwT9PipjPk3eVKNTc1pqp27wzxsGmq1Ixq6IZr2e6W/ZYAjAyJHSLyE61ls4QPVwx
         V9KO+pgC4NMqd3V7AA8PZkjUmf2Y00b1Waz1rbQusj9Pb0PXJMbVAZCZSxgW3Z+oxNB9
         sAZqa74fpVvg3BYDuPFSiED08P5LE0fhc3pXrQer6MIiJML3nq9kvFzaKFTpJnEm4jkC
         61Up7jEOz72X51kmWuRSCfDYqShOPcXwstpW6Ke0IeNxApJjWgKeB7EUVb/DK1U9+jxA
         Ct/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0n4mjLkjU83bCYhbVTmVANBrPEbYw3w1DX5fPdtaI1c=;
        b=cuU4TIXY8lW2WotB1IJKMsZqDyK4EoKxlbYBB6WVegJUGnKEdbwmGaAvM6ngS2ZZTp
         n6p1yyCjID+kdoTb2QiNN3d16Tl/eJXf1uT/D9SIcx77Zmga1sel2KHecCg/O6QkBLa0
         Z4qYag7YpBFi4aC6MUJIXsvDeyXa29bGkrAqHy9i5PEfMSc48ENelXpe4Tm4ooTjLbGz
         Kq4Cg1nJNBXMPNDkiK1C/rczbSzRrQOz2htkhLkwa9FhgKKggqUBja85aXkdNSxTmgDK
         Nj7ulKe6HpCu4kY4JZp8juj1Wi7e4Ur1aOjrNBIsnv6UPwc+nanDJVCu6S1/zBwxW6c4
         vaPA==
X-Gm-Message-State: AFqh2kourcryZWdE49SGVpGS6DvCl5qy7yLkhoC1KC/2GZXDzdTXdZwN
        SKxsvXwmDEDXIweq+t8AZR0=
X-Google-Smtp-Source: AMrXdXtSCKlvmOzD7xa1Xvk6MZg6o1+yNeaRsmQ+Ytalxnhq6XtFrDC5hU7LSuXCisoMTH2aL9WyUg==
X-Received: by 2002:a17:902:eccd:b0:194:dec8:9824 with SMTP id a13-20020a170902eccd00b00194dec89824mr20374003plh.26.1674515625804;
        Mon, 23 Jan 2023 15:13:45 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id ja5-20020a170902efc500b001947c22185bsm228407plb.184.2023.01.23.15.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 15:13:45 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Michael Strawbridge <michael.strawbridge@amd.com>
Subject: Re: [PATCH 3/5] hook API: support passing stdin to hooks, convert
 am's 'post-rewrite'
References: <cover-0.5-00000000000-20230123T170550Z-avarab@gmail.com>
        <patch-3.5-c6b9b69c516-20230123T170551Z-avarab@gmail.com>
Date:   Mon, 23 Jan 2023 15:13:45 -0800
In-Reply-To: <patch-3.5-c6b9b69c516-20230123T170551Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 23 Jan
 2023 18:15:07 +0100")
Message-ID: <xmqqy1pskfo6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> @@ -53,8 +53,14 @@ static int pick_next_hook(struct child_process *cp,
>  	if (!hook_path)
>  		return 0;
>  
> -	cp->no_stdin = 1;
>  	strvec_pushv(&cp->env, hook_cb->options->env.v);
> +	/* reopen the file for stdin; run_command closes it. */
> +	if (hook_cb->options->path_to_stdin) {
> +		cp->no_stdin = 0;
> +		cp->in = xopen(hook_cb->options->path_to_stdin, O_RDONLY);
> +	} else {
> +		cp->no_stdin = 1;
> +	}

By the way, using the path_to_stdin as the customization machinery
for the API users, and keeping it to the API implementation to
actually open the file and stuff .in member with it, is a good way
to make sure that multiple processes do not compete for the same
standard input stream.  IOW, what I was worried about in my review
of [2/5] is addressed by this mechanism.

Thanks.
