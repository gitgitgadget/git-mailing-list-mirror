Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1376C77B7C
	for <git@archiver.kernel.org>; Thu, 11 May 2023 03:42:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjEKDmB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 May 2023 23:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbjEKDl4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2023 23:41:56 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 630F430FF
        for <git@vger.kernel.org>; Wed, 10 May 2023 20:41:55 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6434e65d808so8557758b3a.3
        for <git@vger.kernel.org>; Wed, 10 May 2023 20:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1683776515; x=1686368515;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cZXsxBKyeQCnO7BOlLV9UuAxnrDChRnEjUfGvAXmBOY=;
        b=a21F6F99GcQ7oqNWbw0a3mTkuWru4if37yfWcTruaJO1C8GG4HJL/XiWbxTuiI8CqQ
         4gzNeYVqQqesKomSInEvRPlso3q9fJ3MfPDY2KpA2Zv9bQB8c3XDaKP3iSeJEH64VzaC
         cIJeGuo7t79hBuP8eLhZhxBsSBEP6f9lUzjHH1iyVLmKqQCNc6LJO0Oo4zFzdbswzxhO
         h0OwqN0GnPRxLI1fLNIBISh96enf6sT9/5IVKlnfkCo6I5Qlt7lMk932dGMSWX7LFvrp
         1XmVwQLnTuODOE0qusCvDvOJuiXmGUVkEMRPWEz71C4cwg4DZwd065OoZBm7vqti7iYX
         +73g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683776515; x=1686368515;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cZXsxBKyeQCnO7BOlLV9UuAxnrDChRnEjUfGvAXmBOY=;
        b=BgH5pS1O/j4dYW/41P15yCI5fpupjnDeu/OkLxtACEhw/YmRL4lyu4uBvomrSphDAA
         akMcEtmzuVoorgRWUTLLN/bPMGMtBEHFF7TOfVObxH1J6IQowktphsvrfDYVtE5AUZef
         1M0L/qUrXMrQKH+y4s7c4khAfaQJRl095kCw3r0a9N3+vZnH9OSTt5vDQjEYnmomopx+
         OYZWrhUxgLT4LNPLSQonBuhZo8JxZeyLSolauEjy/2h9xBnp7jWRekjaaqiY/LtKbhWz
         GUXVN+E0mLCz21BkRA9AMAvfzQ0EDu62uNHNeyW7zZhwA5PwPc0bzCQySH7NU1sMJKSL
         mO6A==
X-Gm-Message-State: AC+VfDwA48hhbt/k2X6E/2vhBUt2FMN4bTizgYRtn70F5k8J4pkRBCMb
        8uw1ldI9JP5s640igbXzf6D+AZKbKjZpkrII9A==
X-Google-Smtp-Source: ACHHUZ5yQrS3iw/Fw0xWldImPp1vEu+QFPQ4h2FWZp0VIwcvX0YvbovM0SNoHrW4YaB40I+Yilk5Sg==
X-Received: by 2002:a05:6a00:2392:b0:645:ac97:52a4 with SMTP id f18-20020a056a00239200b00645ac9752a4mr17906418pfc.8.1683776514779;
        Wed, 10 May 2023 20:41:54 -0700 (PDT)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id r19-20020a62e413000000b0063799398eb9sm4268844pfh.58.2023.05.10.20.41.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 May 2023 20:41:54 -0700 (PDT)
Message-ID: <f51a8d77-c480-f021-38c4-78a9d75cdd11@github.com>
Date:   Wed, 10 May 2023 20:41:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: [PATCH v12 0/2] diff-files: integrate with sparse index
Content-Language: en-US
To:     Shuqi Liang <cheskaqiqi@gmail.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, derrickstolee@github.com
References: <20230508184652.4283-1-cheskaqiqi@gmail.com>
 <20230509194241.469477-1-cheskaqiqi@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <20230509194241.469477-1-cheskaqiqi@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shuqi Liang wrote:
> * Add the '--' in all test to remain consistent.
> 
> * Change 'may not' to 'will not'.
> 
> 
> Shuqi Liang (2):
>   t1092: add tests for `git diff-files`
>   diff-files: integrate with sparse index
> 
>  builtin/diff-files.c                     |  4 ++
>  t/perf/p2000-sparse-operations.sh        |  2 +
>  t/t1092-sparse-checkout-compatibility.sh | 66 +++++++++++++++++++++++-
>  3 files changed, 70 insertions(+), 2 deletions(-)
> 

This iteration looks good to me. Thanks for keeping up with the reviews and
getting this to a polished state!

