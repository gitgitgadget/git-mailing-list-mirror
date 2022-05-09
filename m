Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F2BDC433F5
	for <git@archiver.kernel.org>; Mon,  9 May 2022 22:27:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231607AbiEIWbh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 May 2022 18:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbiEIWbd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 May 2022 18:31:33 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0913221E332
        for <git@vger.kernel.org>; Mon,  9 May 2022 15:27:20 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id h3so12332312qtn.4
        for <git@vger.kernel.org>; Mon, 09 May 2022 15:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=xS3DCtGeeVSk29XC6rkUh6ayKG7n80jcrAXk9P+mMxw=;
        b=nhuGIUr/lxUD6OIMNYt2Qgjjwuhy6+CP7ohau/A0AzeEcyrsao3G+qOPXtzPWr5HRR
         1Z3FKmFFFPuPRD8jq5C1Pf5KiAmi01VzQsYadfqHgfTT/W2BDEvQlXIgvVg2iatF+qyv
         AGDxFSN7t0Huet8hpf74VqrWNnBvjjIGIF908biS613TdH7O6iDNGkEi9CBtUBM7V2XI
         heW0hiT/Dx8o3cUxP9Egl60NCWvmC6flZbVb8xOf1n0lBYpa+Id7NeXHr6ZGTVMFUOOa
         6G8PE2as+R7UdscaMa5ZH+nluhuA0FqMnXFAsd+1dy5DrMiaGXuFqwmBsYys5C9HQGtI
         iDlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=xS3DCtGeeVSk29XC6rkUh6ayKG7n80jcrAXk9P+mMxw=;
        b=XnkmjOmh1HGMEwjl6J3aJm7pGINGoS2dhomoEVYK5pw0MW6QKCL9Art2TTXkSC6dZ6
         qCFOixqzoNnH4hbar6V/YBdUTVgMRAJFOfIdqBQiQsLB6SqiT9GIyWV7K5E6MBGivK+o
         TZ/eqFNAmDSACzm8M3ZseZ0piOmWP3cYrkmRsFMEjC35F3ODWCSCF4lCcvEQqijW57bJ
         7IkAF4NSNhmENzlzKE2O5WbI+3qKljsGKAaZEYSTXTQXC+923brd9YK7KgA1WfqdDFF1
         Wq4wSsvSd7cPOB4rqp+D6gIT3miSq9IIkXKqBeWSOUTGQtRIvMqvuzefZDoyEv6jqUCh
         l2zA==
X-Gm-Message-State: AOAM532EeIepOhtpaqBibh9RjdaG/GXTWmW5ucZRxk0SKcUXCRy8nash
        PVpXDyEyMBXxWMS8R613te4UDg==
X-Google-Smtp-Source: ABdhPJz+xFSVZS11ICqMQsZvHe9biQBQQNxGcoh33CVQJpTMEwZ3otsnz8Xfjtl2nyk/CunOxqTK8g==
X-Received: by 2002:a05:622a:3c8:b0:2f3:7231:913e with SMTP id k8-20020a05622a03c800b002f37231913emr17396721qtx.212.1652135239103;
        Mon, 09 May 2022 15:27:19 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id x4-20020ac81204000000b002f3ce9c0601sm5139017qti.3.2022.05.09.15.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 15:27:18 -0700 (PDT)
Date:   Mon, 9 May 2022 18:27:18 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] t0033-safe-directory: check the error message
 without matching the trash dir
Message-ID: <YnmVRoOpfvON6lwW@nand.local>
References: <pull.1215.git.1649863951.gitgitgadget@gmail.com>
 <20220427170649.4949-1-szeder.dev@gmail.com>
 <20220427170649.4949-2-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220427170649.4949-2-szeder.dev@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 27, 2022 at 07:06:47PM +0200, SZEDER Gábor wrote:
>   - it is interpreted as a regexp by 'grep', so, because of the dot,
>     it matches the name of the test script and the path of the trash
>     directory as well.  Consequently, these tests could be fooled by
>     any error message that would happen to include the path of the
>     test repository.

Nice catch. I wouldn't have even thought about "could match the test
directory" as a potential way for this test to generate a false
positive. So I'm happy to see us tightening this down.

Thanks.

Taylor
