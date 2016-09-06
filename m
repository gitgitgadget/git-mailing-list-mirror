Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9978A1F859
	for <e@80x24.org>; Tue,  6 Sep 2016 09:36:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933751AbcIFJgr (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Sep 2016 05:36:47 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35493 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933143AbcIFJgq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Sep 2016 05:36:46 -0400
Received: by mail-wm0-f66.google.com with SMTP id a6so6266688wmc.2
        for <git@vger.kernel.org>; Tue, 06 Sep 2016 02:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=BCvfkKXETmEZJgehKL0RVOEfq6YknGBGkGV1RsU+7bE=;
        b=t8+QtVBLzRngu2jSDfeqzQXxG8Kd9d65akIu2i4JmD7FrZ7kwBZPwI+WexDdAPO5c7
         IzE/yHf4Io00cn7vjbrSlicQyCrzRIcdjbsvlMqmSwOIbc19qVi/ueB3BeYYaNMJrh2U
         7MDjWrshqKrUFMwe3wfhLmtdunQpd8Xv38+WGSogHv6Np9g5kFAryWC9ZTQHyjb7UrhP
         pJU9anTrW5VOj4Jec0W7eChzvjnZ7KTp4g3pblQxROrioJPIBhd6R4rKSG1HCFKSqoud
         wd7bpa14VBR29xNnGhTlRAp01/Vap91PSlrk/cmPQYkbi9XUoMziIPAHYw5QFMKNp1Ji
         sQxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=BCvfkKXETmEZJgehKL0RVOEfq6YknGBGkGV1RsU+7bE=;
        b=MEbGrj17hZyECBcA22e9U98l/JeWc9m3zpA4c46OTn80XECCd0KY2ZTE0psm1fhKe2
         bBWg88Xv8lKqtd4GR/dIK9qYgTjzxuCp/kvZ5vy5XSbUBEEjJoQoU+NaHlwEswNBAHOk
         G8CTQl2I4/BNuXz0N9/UDN6TUgJB/kKwOcR5Jgk3bcv+ch+hME9wql0zT31I3whnP3Ks
         K5U14AV9QsX9a76PUmdlgot3fCeTRDaw2K6whxCAwYayJuH5yKXUluvPprz9wWyOiB2Q
         GNQCvo1jfnuQ7hW++4CkRd1jSqb2o3B9qO5zIZvf4KsMMWTZml+rv1JCh/potRf9+dSO
         rk2Q==
X-Gm-Message-State: AE9vXwOlRp+AUWHszjoc2xhh/J/Q8ik2tTvy7uHvbmfMBHJWqCxKuY0x8wljzfdSjGW/zg==
X-Received: by 10.194.90.239 with SMTP id bz15mr23075033wjb.146.1473154604890;
        Tue, 06 Sep 2016 02:36:44 -0700 (PDT)
Received: from [192.168.1.26] (epw136.neoplus.adsl.tpnet.pl. [83.20.64.136])
        by smtp.googlemail.com with ESMTPSA id a194sm25510876wmd.24.2016.09.06.02.36.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Sep 2016 02:36:44 -0700 (PDT)
Subject: Re: [PATCH v1 1/2] sha1_file: open window into packfiles with CLOEXEC
To:     Eric Wong <e@80x24.org>, larsxschneider@gmail.com
References: <20160905211111.72956-1-larsxschneider@gmail.com>
 <20160905211111.72956-2-larsxschneider@gmail.com>
 <20160905222715.GA30031@starla>
Cc:     git@vger.kernel.org, gitster@pobox.com, tboegi@web.de,
        Johannes.Schindelin@gmx.de
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <bd9fc74b-b9b0-7c09-9c22-02b6f0f3cec9@gmail.com>
Date:   Tue, 6 Sep 2016 11:36:33 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20160905222715.GA30031@starla>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 06.09.2016 o 00:27, Eric Wong pisze:
> larsxschneider@gmail.com wrote:

>> -int git_open_noatime(const char *name)
>> +int git_open_noatime_cloexec(const char *name)
[...]
> 
> I question the need for the "_cloexec" suffixing in the
> function name since the old function is going away entirely.

On the other hand the new name is descriptive...

> 
> I prefer all FD-creating functions set cloexec by default
> for FD > 2 to avoid inadvertantly leaking FDs.  So we
> ought to use pipe2, accept4, socket(..., SOCK_CLOEXEC), etc...
> and fallback to the racy+slower F_SETFD when not available.
> 
> 
> Fwiw, Perl has been setting cloexec on FDs above $^F
> (2, $SYSTEM_FD_MAX) for decades, and Ruby started
> doing it a few years ago, too.
 

