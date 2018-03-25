Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5AE531F404
	for <e@80x24.org>; Sun, 25 Mar 2018 18:21:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753881AbeCYSVD (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Mar 2018 14:21:03 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:42357 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753700AbeCYSVC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Mar 2018 14:21:02 -0400
Received: by mail-qk0-f194.google.com with SMTP id b198so17920065qkg.9
        for <git@vger.kernel.org>; Sun, 25 Mar 2018 11:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=MJAPMebFeobY8BQ9ChsZuW4nTYZKpTKnJKb4UfP+VBk=;
        b=VajGZc5R/6754G2hAuWWA6nrwpbn2CEgWXjDZketd4YLiwvUFGqkOiRS0TsFQbyv9d
         2o/9kGzoenPNUQz8SwumyOVAJAJds2hgcZ/EmwPHkSNZAtQU/x5xNHzBveh0aAd7KFEH
         OGXlqbcsgy15927Sm8LDxjc/p06bcHhV/7VgPDNPuglWL/h8e0PHnOx7wGaeAw3WoeRV
         gXjzQjQsk7qEXYoxncMqTRmNoDJe7uUdo7DhfZD9I8HCVryT99go0IAQCXGs+tjT53vV
         pOa1kLSi6d83ZKQMvS4Uum4czemINvxVlo9+9KzeQPA6CpEPcCyo8Vh3ZMooyX0maLot
         geUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=MJAPMebFeobY8BQ9ChsZuW4nTYZKpTKnJKb4UfP+VBk=;
        b=LsZKYQM98hu/cq0CkvWyc0E9bwBh4IQxQnvgXhHEM70CtVIaBPdwCrQmNJe5jhLIg5
         MQtZSJqy497HQt0H9labiM6WpehCDDLiDaut8b79HSaOe1YJ0FPaD5ziwA/I187ddUl7
         aeyVoCBfi2mrOtIiQu7VAdEi1g+rKZwBb2DQutuTzvHIGvY8M5uBO6Z4hOsq09qMeztd
         0hHph+sm4W8SA/2S2ZmQn3Ba3W4JTuyfyh9PVocadtFE5fUNqC7XsxBkKVvnO6EQ6vD+
         7cS7kJLid3pWEeFpoIF/T5Z0Ul7V7mdwtymPASfoYVEx8CwP0D5N4SvVrKw9Uv9RSxSh
         xZpQ==
X-Gm-Message-State: AElRT7F8skygBksp3Wnb/LeSvVBpIzbSFJl4VXuMtfgmM5yQMetHrGZE
        3ZBepN8546xqhHigteoLtUo=
X-Google-Smtp-Source: AG47ELsyrMhd1B+E7TuwgT8QX92A/dzlt0Wpdhk54szSZmhWowhCeoVfzOdzY+CBfJXdagPE3WZVhQ==
X-Received: by 10.55.209.216 with SMTP id o85mr51437993qkl.217.1522002062138;
        Sun, 25 Mar 2018 11:21:02 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id f13sm5054272qtj.6.2018.03.25.11.21.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Mar 2018 11:21:01 -0700 (PDT)
Subject: Re: [PATCH 4/3] sha1_name: use bsearch_pack() in unique_in_pack()
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org
Cc:     jonathantanmy@google.com, sandals@crustytoothpaste.net
References: <20180321224226.GA74743@genre.crustytoothpaste.net>
 <20180322174010.120117-1-dstolee@microsoft.com>
 <71b5cef0-abad-001f-6a23-3f2d874b9709@web.de>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <63f7e580-add1-2e5c-8720-c7982d993e00@gmail.com>
Date:   Sun, 25 Mar 2018 14:21:00 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <71b5cef0-abad-001f-6a23-3f2d874b9709@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/24/2018 12:41 PM, René Scharfe wrote:
> Replace the custom binary search in unique_in_pack() with a call to
> bsearch_pack().  This reduces code duplication and makes use of the
> fan-out table of packs.
>
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
> This is basically the same replacement as done by patch 3.  Speed is
> less of a concern here -- at least I don't know a commonly used
> command that needs to resolve lots of short hashes.

Thanks, René! Good teamwork on this patch series.

Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
