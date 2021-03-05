Return-Path: <SRS0=rdad=ID=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A54C433DB
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 22:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B454065079
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 22:21:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbhCEWVB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Mar 2021 17:21:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbhCEWU6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Mar 2021 17:20:58 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4031BC06175F
        for <git@vger.kernel.org>; Fri,  5 Mar 2021 14:20:58 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id a7so3603704iok.12
        for <git@vger.kernel.org>; Fri, 05 Mar 2021 14:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=discourse.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=B5n7LwfxxxtY5XMRgTyIQvC1pQOwaXtfkrwwuPMIgag=;
        b=sGh3dBDFhyXvMlzKFyaKq5RgjWpWVGTV8z7VoB3x27d2jkJ/gXdCLyQqiCiujkXRNF
         d+sHJ4jZRniwGvqsD6YzXrLHz8WPmU0kv7iI3/LoOLqAY6S+n4BvjyWJMZ1TQa1VsHrO
         8UYmnYAoNYofHNiNVj79sVg3kWT7UfPpN/z1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=B5n7LwfxxxtY5XMRgTyIQvC1pQOwaXtfkrwwuPMIgag=;
        b=rjGaO7eibWbegoG1phk/HQWCh7VfNhe2lEmGQXYUaBXfZTlPV4njzNWc/qKn5BmF18
         QR67PHgCuvkWqhbmbUn1fXMXxFJz4/66H0Vwccws7DDC6fOXAgZQyEcu42KpTnSwIvdk
         ZlpLOVe7CdwpcyEuxsJbPKZ9DPIJxuTCNcurd9Bswg6wGZGgtnJcpf/W/wbORwstkBzY
         +nB9fIxyashzv/rq0T8A63e/tCegBHJm+agWYlMHvsyRs7ErdLR2r4zS8ykhiHVFZNJu
         ZEAyrUqfnY+gBj6vFY1yfMwEzw7QCPO6MZCX2BQdUqxYPMhh3MS3tVy9DBU5Lb2YFIxt
         aE8g==
X-Gm-Message-State: AOAM531FmCXU+u2eqgHVpM8+KFVEWb81K2f7vvsDu22raQEHKO5c2Wqy
        7LneTMFJMzGjFKBHD7O2/knhS1BFUnPn92SE
X-Google-Smtp-Source: ABdhPJy+n10qv1AtRtUA+u2Hivgn9aseULHx+aC5UwMXPXmBseJ5pLBRkrl/LFOyEkZnHaWUGTeU9w==
X-Received: by 2002:a5d:8887:: with SMTP id d7mr9714180ioo.151.1614982857484;
        Fri, 05 Mar 2021 14:20:57 -0800 (PST)
Received: from [192.168.1.216] (dhcp-24-53-242-66.cable.user.start.ca. [24.53.242.66])
        by smtp.gmail.com with ESMTPSA id b20sm1866258iod.22.2021.03.05.14.20.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Mar 2021 14:20:57 -0800 (PST)
Subject: Re: "git diff-files" command reports differences that don't exist
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <4210f5f1-dd7e-f425-6ab2-e220a33e82bf@discourse.org>
 <xmqqa6rh9sph.fsf@gitster.c.googlers.com>
From:   Michael Brown <michael.brown@discourse.org>
X-Clacks-Overhead:  GNU Terry Pratchett
Message-ID: <b3774f98-d2aa-3ae2-2aa5-c80339684c50@discourse.org>
Date:   Fri, 5 Mar 2021 17:20:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqa6rh9sph.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-03-05 4:49 p.m., Junio C Hamano wrote:
> This is totally expected behaviour.  In general when you are working
> with plumbing commands like diff-files and diff-index, you are
> expected to do "update-index --refresh" upfront.
Thanks. I wondered if since it was a plumbing command there might have
been something I was missing but didn't know where to look.

Cheers.

-- 
Michael Brown
Civilized Discourse Construction Kit, Inc.
https://www.discourse.org/
