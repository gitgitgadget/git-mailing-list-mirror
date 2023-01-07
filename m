Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AED6C54EBC
	for <git@archiver.kernel.org>; Sat,  7 Jan 2023 19:50:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232609AbjAGTuu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Jan 2023 14:50:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232493AbjAGTus (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Jan 2023 14:50:48 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F42A485A6
        for <git@vger.kernel.org>; Sat,  7 Jan 2023 11:50:48 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id j16so4905302qtv.4
        for <git@vger.kernel.org>; Sat, 07 Jan 2023 11:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=psjU15GA+pAReHul0hHkb8DcegGEa5JjipaWWLxh/wI=;
        b=J4UV8CYxxI+pnajY2BxvUA+q5stECiZm81xYrGAoIXKah8//MZwJ0GJrDPeqBTIyvi
         FMElMUAAsJyfdYz9kJnqacKzWuSbq8PRxpSg8w7WDDu8fdI4/CiYAIWsLjwS2ilzdory
         zKAt45NI8V76alQuGv2twM+bO1XgUFMqBiFiVG+rM+T9gxbq99mxZsyUvzn4bP8tLSNL
         gdcYuq+Jr+KMQGK0s382DGXJMUtmJ/4qiqwOgBlCrzefNaGKbMng80uByvxPQS0UGus2
         f5HB8XbLDXLYiwR0AvtFph6AcXwsqIDJCxoLIvEct4sh3rIv+IvboMPbbSu93gFrmRvv
         z79Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=psjU15GA+pAReHul0hHkb8DcegGEa5JjipaWWLxh/wI=;
        b=h8P42Hd6yWQMwQ9f5bX/jD9aMzG2JaUI8B7jmIPwO15FkwWHyxmy4J3pq8/wve8u8b
         OEQM7GiZ4MZa3K6nDhyVZQCU9pjFJcX9JpCoVR7ZA+GE+phkgpylCewUYNHVBcj4INTa
         Y409oxUBCRgN84dmRrCf2ccYTIzX+qgQJfWr/L5UtnuJWA5+zgoGxxor5ExY6hsnGTOA
         MSesVQhN9jjvlY5FuHCaksYwN5nzGwR2weZqtUDlu9pm9eDMXMSBeajEOljOsNPrxfwr
         u4rEDekKohrsX6QumYCkAEFNTPcTUf/gmXyVWwDCXHYf9jksh8wDTU2TDahb1gZnfDhD
         bnUw==
X-Gm-Message-State: AFqh2kofOL5F8hY0GPuPmH5BDRn3Y33HoGRQp42qDVafIlb5WgYfxtdM
        GnNV8KkGE1zMGl/UECq6rnCRVR7fFEo=
X-Google-Smtp-Source: AMrXdXun+n73qVunapjiNXrnuN7TddYNKVyEqQI/lJ71xlFmsG4KSosdZj75iertVl5hCuLrwrw0Hg==
X-Received: by 2002:ac8:6e87:0:b0:3a8:11f3:b81c with SMTP id c7-20020ac86e87000000b003a811f3b81cmr81783902qtv.53.1673121047142;
        Sat, 07 Jan 2023 11:50:47 -0800 (PST)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id t7-20020a05620a034700b007054a238bf2sm2585941qkm.126.2023.01.07.11.50.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Jan 2023 11:50:46 -0800 (PST)
Subject: Re: bug?: ORIG_HEAD incorrect after reset during git-rebase -i
From:   Philippe Blain <levraiphilippeblain@gmail.com>
To:     phillip.wood@dunelm.org.uk, Erik Cervin Edin <erik@cervined.in>
Cc:     git@vger.kernel.org
References: <CA+JQ7M-ynq1cLN-3ZodXae=x-H5k7Ab6uPBwUFhG+kgtOvCgtA@mail.gmail.com>
 <e6adaad6-f6ee-57d3-dc8f-d14a760c57c2@talktalk.net>
 <CA+JQ7M9G8HqqieRAK3C6csMM93PHOmaMd8GMPrDEfogWG0bteA@mail.gmail.com>
 <ef389a14-8513-4650-21e4-89421a24df2d@gmail.com>
 <81218256-5354-4b0a-6f74-7e9605131968@dunelm.org.uk>
 <1b2b8e98-5506-a1e6-6059-a967757b3bb8@gmail.com>
Message-ID: <28ebf03b-e8bb-3769-556b-c9db17e43dbb@gmail.com>
Date:   Sat, 7 Jan 2023 14:50:45 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <1b2b8e98-5506-a1e6-6059-a967757b3bb8@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Le 2023-01-07 à 12:06, Philippe Blain a écrit :
> 
> Hi Phillip,
> 
> I'll try to send a few updates to the doc to make this hopefully clearer.

See https://lore.kernel.org/git/pull.1456.git.1673120359.gitgitgadget@gmail.com/T/#t
