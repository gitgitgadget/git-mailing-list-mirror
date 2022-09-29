Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ABFDC433FE
	for <git@archiver.kernel.org>; Thu, 29 Sep 2022 21:49:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbiI2Vt4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Sep 2022 17:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbiI2Vty (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2022 17:49:54 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86AF6476FB
        for <git@vger.kernel.org>; Thu, 29 Sep 2022 14:49:53 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id bk15so4086762wrb.13
        for <git@vger.kernel.org>; Thu, 29 Sep 2022 14:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject:from:to:cc
         :subject:date;
        bh=sSqR+IeCFf9O8uu1IghqtNUGsbD8hScZs0b/qTQnouQ=;
        b=jG6G4XFOU8amdWyDDfEgqQbfWR/Q0aXbZ9jH+RGjWzcRr9Vwi84kgH+g9sWStfCHYw
         LBqGrjQWHXkF2FLU8esRzcJuaZh07ta1x3afaikylnUDbQyvw/E6DfoaHHUEvXvkxmSE
         yxcHurFSrkT/DCkasKRXJkYvvSNv0kr33SrPcCcIpNn4FifLmYrc5pWjVAG7eFYT8Jz2
         +g+jh0ntv664811X71D1YzE2y2iyf+GgCmGnJar+dHmkmelCJA/oeNB8hYrrKkQn82pY
         OMORRlLhPbJqdIDAbtq6Pv3CzsfpGx0t+tb+Pb1Or1wmF+014h1sDbiIuxDBUMOAymPY
         OsWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject
         :x-gm-message-state:from:to:cc:subject:date;
        bh=sSqR+IeCFf9O8uu1IghqtNUGsbD8hScZs0b/qTQnouQ=;
        b=cM7g/QNxa2PVadWS/SqW4dfvHUG9h7mxVg/ffomGz/WuH47Mt35WLC/hYn4x8e3nHr
         jjMkjEDMEibMrEMBX7u3aYy7pueofvTOSqnJJSdb2hf6O2abQnNSHsLpxh+fozBruAH6
         WYY4Py3lfS08hQNbclRsHr6hjOUuUwNhZ8PxY2HTdsVhfpllC66nkWIKQe3zFw/g6QNQ
         +fu4W6SnLQ2v0XDZeqD8bQtZzK1wk6iYWAUnXoZGxCBYmSzBkbQJlQmR+nQVDnW52avi
         xIuawHRA4wiVzGgLfvIGxvzRKkwD42MZ4fsf3CQfOW5w0JxF6W8qH/W29A6TZeqlzSoU
         d/pg==
X-Gm-Message-State: ACrzQf0uqbGr6LEbfTGByyFjtSRCzvyiZ0nIbY5RXZFtGYtoJGI2qa1Z
        3RVSxlgV8MBTUMLPVvsVeCMOjXJMKTKa0w==
X-Google-Smtp-Source: AMsMyM7K9lco4R42RMpZNipWavbLQI3YGNK4aAIgOe6X3ogKNz3nazEbYvZrxd0eWDaOi1w8ltVqKg==
X-Received: by 2002:adf:f18c:0:b0:22c:df1c:92cd with SMTP id h12-20020adff18c000000b0022cdf1c92cdmr1136744wro.52.1664488191976;
        Thu, 29 Sep 2022 14:49:51 -0700 (PDT)
Received: from [192.168.2.52] (5.83-213-116.dynamic.clientes.euskaltel.es. [83.213.116.5])
        by smtp.gmail.com with ESMTPSA id t20-20020a05600c199400b003b4fe03c881sm5352815wmq.48.2022.09.29.14.49.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 14:49:51 -0700 (PDT)
Subject: Re: [PATCH] branch: do not fail a no-op --edit-desc
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqczbftina.fsf@gitster.g>
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Message-ID: <ba8a503b-76e2-5de9-1082-3b4c6ecd0cc3@gmail.com>
Date:   Thu, 29 Sep 2022 23:49:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <xmqqczbftina.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Let me try again, I think my review was not good :-)

On 28/9/22 21:15, Junio C Hamano wrote:
> In a repository on a branch without branch description, try running

It is a bit confusing the construction "a repository on a branch
without branch description" as "branch" have "repository" inherent.
So "On a branch without description.." holds the same meaning with less
distracting words.

> The simpler solution of course introduces TOCTOU, but you are

I like that the message introduces an appropriate term that also can
be a trigger for some to learn something without distracting others.
Instead of just using: "BUG"

> fooling yourself in your own repository.  Not overwriting the branch
> description on the same branch you added in another window, while
> you had this other editor open, may even be a feature ;-)

But.. do we want to implement this this way? Maybe we will have to
implement on purpose this feature in some future refactorization?

And.. the message does not make it clear the situation: if there is
a previous description, will clear; if not, will keep.

>  test_expect_success 'use --edit-description' '
> +	EDITOR=: git branch --edit-description &&
> +	test_must_fail git config branch.main.description &&
> +
>  	write_script editor <<-\EOF &&
>  		echo "New contents" >"$1"
>  	EOF
> 

If we want that feature, should we test for it? (do not take
the snippet as tested...):

diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index d5a1fc1375..aa5ee14bae 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -1393,6 +1393,16 @@ test_expect_success 'use --edit-description' '
        EOF
        EDITOR=./editor git branch --edit-description &&
        echo "New contents" >expect &&
+       write_script editor <<-\EOF &&
+               if [ -z "$NA" ]; then
+                       NA=description GIT_EDITOR=./$0 git branch --edit-description
+               fi
+               echo $NA >$1
+       EOF
+       EDITOR=./editor git branch --edit-description &&
+       test_must_fail git config branch.main.description &&
+       EDITOR=./editor git branch --edit-description &&
+       git config branch.main.description &&
        test_cmp expect EDITOR_OUTPUT
