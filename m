Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 150ABC433F5
	for <git@archiver.kernel.org>; Sun, 27 Mar 2022 16:48:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236099AbiC0Qtl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Mar 2022 12:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236096AbiC0Qtj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Mar 2022 12:49:39 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6690B13D47
        for <git@vger.kernel.org>; Sun, 27 Mar 2022 09:48:00 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id a5so10171824qvx.1
        for <git@vger.kernel.org>; Sun, 27 Mar 2022 09:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZnZtxm1rGR+FXIWhIW9zZzKJM1gxZ1Vi16gjKD6NwgA=;
        b=Vm5LAul+N7KhZ25LbnxcAHKZJYHsMWwxO2MkoAcxlPDwl6p7ITfZkixkS3P6ZW4t1b
         lKKjXSW9BNArPNe/h5xVkhUgmr0DSzeVlBn0P0aEbaeILqI0d0EH1N5Eahy6n6JAYzdV
         tgz7kDxhoRb0AZIXS/OAAND3j0euiMWFyDihu/jBuf7R1CK/2oVmyTbszChdsA4+i5g9
         h28DgQaphYMpD9MQ1iGKMMwJl9qYjA9xXAjHuubjtCv01a78PY2yLVl9OmTsYgy9z/YC
         cU3aT9vGLgz3XOVFrGJmJBbHKL0tx2QI0NCQtoksB4jI+zIMrnomIVGIomQRMzBBYT7V
         TC5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZnZtxm1rGR+FXIWhIW9zZzKJM1gxZ1Vi16gjKD6NwgA=;
        b=X94smCfCyPmkjEy7REE0RT4cHUgL/p4OuCsZY9eI7/5IE+SN7pZviKe6RBKGtg8kUU
         MIO+aL2Zm6dbwBI+f3khdJHqF8DQRRiJtFniPZ4NPG3Dph+9EGCrmqSFpQH74V2el545
         LcOENT/N7HNzCfHewiwf2RXI9vdv3qiI+t5dHq7WvcL9XIJJ6gEV9dL10SyLSuFfxhk7
         4nXYT2wu65mRxI/h4dO/GTtM+3hgoro5djcjmyfBZVTSpdMR4HaPuoXnmydmTXSxK3cM
         F/SHiYIltsY2bcTP4Xjw44Xhuhda3HnAv2E342nAFKhVhKxl5aeY41LgT3+sHaT1N2Kb
         JgLA==
X-Gm-Message-State: AOAM5331A4px12K73UIHi3oesx/NWglIx2U1rtbYckjDcE+okeqwR8b0
        N/pc/8qzytPhvs5JH3OR1x8=
X-Google-Smtp-Source: ABdhPJz3+WLQuQMLnsyojK60v0ATj13AwAT8OZIR3VeV0/YP3Rl1v4HcOkFsFJNpT6TEa3eC/imImw==
X-Received: by 2002:ad4:5bc1:0:b0:42d:758c:f694 with SMTP id t1-20020ad45bc1000000b0042d758cf694mr17109131qvt.99.1648399679464;
        Sun, 27 Mar 2022 09:47:59 -0700 (PDT)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id 145-20020a370897000000b0067b30c65415sm6615854qki.75.2022.03.27.09.47.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Mar 2022 09:47:58 -0700 (PDT)
Subject: Re: [PATCH v6 1/3] vimdiff: new implementation with layout support
To:     Fernando Ramos <greenfoo@u92.eu>, git@vger.kernel.org
Cc:     gitster@pobox.com, davvid@gmail.com, sunshine@sunshineco.com,
        seth@eseth.com, rogi@skylittlesystem.org
References: <20220327112307.151044-1-greenfoo@u92.eu>
 <20220327112307.151044-2-greenfoo@u92.eu>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <00463195-5514-bf2b-e733-24e1e24a70cb@gmail.com>
Date:   Sun, 27 Mar 2022 12:47:57 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220327112307.151044-2-greenfoo@u92.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Fernando,

Le 2022-03-27 à 07:23, Fernando Ramos a écrit :

--8<--

> +################################################################################
> +## Internal functions (not meant to be used outside this script)
> +################################################################################
> +
> +debug_print () { 
> +	# Send message to stderr if global variable DEBUG is set to "true"

This should also be GIT_MERGETOOL_VIMDIFF_DEBUG, right?

> +
> +	if test -n "$GIT_MERGETOOL_VIMDIFF_DEBUG"
> +	then
> +		>&2 echo "$@"
> +	fi
> +}
> +

--8<--

> +gen_cmd () {
> +	# This function returns (in global variable FINAL_CMD) the string that
> +	# you can use when invoking "vim" (as shown next) to obtain a given
> +	# layout:
> +	#
> +	#   $ vim -f $FINAL_CMD "$LOCAL" "$BASE" "$REMOTE" "$MERGED"
> +	#
> +	# It takes one single argument: a string containing the desired layout
> +	# definition.
> +	#
> +	# The syntax of the "layout definitions" is explained in ... (TODO)...

Is this still TODO ?

> +	# but you can already intuitively understand how it works by knowing
> +	# that...
> +	#
> +	#   * ";" means "a new vim tab"
> +	#   * "-" means "a new vim horizontal split"
> +	#   * "|" means "a new vim vertical split"
> +	#
> +	# It also returns (in global variable FINAL_TARGET) the name ("LOCAL",
> +	# "BASE", "REMOTE" or "MERGED") of the file that is marked with an "@",
> +	# or "MERGED" if none of them is.
> +	#
> +	# Example:
> +	#
> +	#     gen_cmd "@LOCAL , REMOTE"
> +	#     |
> +	#     `-> FINAL_CMD    == "-c \"echo | vertical split | 1b | wincmd l | 3b | tabdo windo diffthis\" -c \"tabfirst\""
> +	#         FINAL_TARGET == "LOCAL"
