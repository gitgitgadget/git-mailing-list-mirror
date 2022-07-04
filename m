Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7508C433EF
	for <git@archiver.kernel.org>; Mon,  4 Jul 2022 20:51:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbiGDUvI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Jul 2022 16:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiGDUvH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jul 2022 16:51:07 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 327CF1B3
        for <git@vger.kernel.org>; Mon,  4 Jul 2022 13:51:04 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id l24so9481205ion.13
        for <git@vger.kernel.org>; Mon, 04 Jul 2022 13:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=y2HoS9OnPIV8l/fYVxP2fcTLaE8in7TwyKso5tmXVFg=;
        b=XJDgvCKRZIOm5dp1csyCAWs9D+Ex5jjJFIgqrlQ+xhMlWeq713BE6NhETqwtOx3j1M
         8zPnTUY5s/NrYmUH1sfng/0bHyx/GZ7U1T4QnHJaAO6XgYOWMy/tOgKrG01oE3q3GZxq
         Slwb9YOEpWIjY9GOKfFay0Md87eLo1b21WOKh2be9tscb9J4jW8kR6DSkmIpasGB0qK9
         4WSKJzmUcDbD3KQgigPWqt0laMXaGUceaDrkGtQX4b7P2TADgy6Nrqx5ypdRpOUIB4Of
         IgSPyJKkgYQb40UmbdEJmJgbCPQlEupWH874G8js0ScCiWPyDMLnmreeyJ80fwMDEFf7
         vscQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=y2HoS9OnPIV8l/fYVxP2fcTLaE8in7TwyKso5tmXVFg=;
        b=zdUWK+DVe6jB4j5Z3AKKRdXNFMbGzCXoT/B5hsj49F8QswcY8W6wsZAGATrzt0HnZe
         9T39RqK8xHyrGfznaTIs75ynY8L8B031yfBfB0TQfvz8qCA8G1hqVNTZg11mzVesT2Vl
         0MJ9T2TC8AeiI6s+pCXgW7x+GS0IRtSZb8Qxg+48nWAUHCePmEwxjTVX8BskPpVSk9jd
         nYbU62BpLItxuapwRgFcn9PgCc6PtXYYVGfaHs8UfoKhhdcW/owk11/JopVC1IMBIJZ/
         MqiUHz1Ft2JPaghY7iQAqBuvkmcn4We/SfkgKacfIacUlVGsl8Sal4X5gryOjjcz23a1
         Ug8w==
X-Gm-Message-State: AJIora+Nohl70UFmR8+Ofvm+HAejEmyyiLZFsDHs/BwfKE3nWWnRhYO2
        18HlqYPXe3bWSPk6KVFpACto/zGxVNKP
X-Google-Smtp-Source: AGRyM1vslbXUYLlAjVe2/q3IrtWRuSw8CvO7cugLrrMf31FQ7oCnV6XAA5AdRU+kIMZC0T8ZxZAHyA==
X-Received: by 2002:a05:6638:34a0:b0:33c:aa2d:a88b with SMTP id t32-20020a05663834a000b0033caa2da88bmr19685150jal.296.1656967863309;
        Mon, 04 Jul 2022 13:51:03 -0700 (PDT)
Received: from [192.168.103.232] ([4.1.157.141])
        by smtp.gmail.com with ESMTPSA id f9-20020a056e0204c900b002dc0d2f7c7bsm1875474ils.4.2022.07.04.13.51.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jul 2022 13:51:03 -0700 (PDT)
Message-ID: <a154e109-3f4c-c500-3365-d47879abf30d@github.com>
Date:   Mon, 4 Jul 2022 14:50:57 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: commit-graph overflow generation chicken and egg
Content-Language: en-US
To:     Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
References: <YqD5dgalb9EPnz85@coredump.intra.peff.net>
 <581c7ef2-3de4-eb8a-bfbb-d4bca3522a2d@github.com>
 <YqEuE2iAmMVLlUSu@coredump.intra.peff.net> <Yr7jY6GjUkOzHNh6@ncase>
 <YsLE+DVa5Hd/NqdD@ncase>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <YsLE+DVa5Hd/NqdD@ncase>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/4/22 4:46 AM, Patrick Steinhardt wrote:
> On Fri, Jul 01, 2022 at 02:07:03PM +0200, Patrick Steinhardt wrote:

> While I still haven't been able to reproduce the error, I did find a
> different error. Here's the reproducer, which works with Git v2.37.0 and
> older:


Hi Patrick. Thanks for taking a close look. There is
an issue here, and it's due to using a negative
timestamp:

> + GIT_COMMITTER_DATE='1970-01-01T00:00:00 +0100'

Because of the "+0100" in the time zone, this date
becomes a negative value. The commit-graph does not
store dates with more than 34 bits (and Git does
not handle negative timestamps very well? Peff can
clarify here).

The commit-graph could certainly warn better here to
say we do not have enough date bits to store this
timestamp (the same would happen with a date beyond
2138 or something like that).

However, this is a failure since the commit-graph first
started parsing dates in 177722b3442 (commit: integrate
commit graph with commit parsing, 2018-04-10).

Thanks,
-Stolee
