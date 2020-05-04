Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 700FEC4724C
	for <git@archiver.kernel.org>; Mon,  4 May 2020 19:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52531206C0
	for <git@archiver.kernel.org>; Mon,  4 May 2020 19:02:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XQ7GhorD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbgEDTC6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 15:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725981AbgEDTC5 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 4 May 2020 15:02:57 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9805DC061A0E
        for <git@vger.kernel.org>; Mon,  4 May 2020 12:02:57 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id s30so475967qth.2
        for <git@vger.kernel.org>; Mon, 04 May 2020 12:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:user-agent:mime-version:content-transfer-encoding;
        bh=13772MH02HBiJSPNNdzOYdoFwODAJ29IwEkMpJEFyvE=;
        b=XQ7GhorDkZujAFPv5lCwue6ptU+r1kAK4JCzoTUTLhJ/mI6XRj6XBYAKy2tYCKrMQI
         9EIqs6gxDchulqFJHIfe6mREur9gS9ea3DB8rWX58GrSM9Q3tnOD10YENAESHXzn+0ij
         8BRiFkvyAoFbWVViAbA4qYp95xOU7bYkWWQl94sFcY6RD6B9yvPMeJG40kucwf7I9WCz
         ajypU5DWGCARu9vCnRxVz+6TniuBHydp3BuVDKcKku0PiFGsJ3R9WogCX/FEsbV6z2G/
         mLYSlzTLj6prtEkwzJSEop//DB7ZHl+CHdF3Mlv707YTfyWUs3wS/iTB6+HgDo5nd2AS
         Bzvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=13772MH02HBiJSPNNdzOYdoFwODAJ29IwEkMpJEFyvE=;
        b=CIQws6kt6XY6GyEksXG/bUn0qM3PJCeFzqSp5h3LE3eZ+hWkUhTLJtnpqh0ulBNDQQ
         CushkmGUIRj3wGqyNe1gLUhg4xe3l4LY6Rda9uizgeCbTruDaB9TYhh/qalYB1rp/Vsm
         +oIdrP6qytX9U9Am/25SPkG6NZHNboKDw75CXlDBJbSMhGInB3FpwC+DwMlIHG4SsH+a
         ozTc8pwPiwf8KW0ohQt58NdvnLtt5ZjWMC9xBthkjCw4TRbWFQGsZokYnTQTkeXjxx55
         rV/n16y11WZa9Ds/dq18URf/g2MO1OPfrQla8HQn3o3ZQJloxaZR4lh6olCrizOgbw+A
         K9IQ==
X-Gm-Message-State: AGi0PuaRXIhWNZLTAv/BXzNzC7IGESCAo9GXfB+1zYFEAbN4oI1rR9Yr
        SevR0bOs9wGMT9yQS2vEIbd5G7mg
X-Google-Smtp-Source: APiQypLrbOK7PB+981SigMHPYHEZxrlypnKxbHoJOuDt4UDBFt3csvMA3D4qQzaaeqq6bF6ya7AwBQ==
X-Received: by 2002:aed:233d:: with SMTP id h58mr677776qtc.4.1588618976784;
        Mon, 04 May 2020 12:02:56 -0700 (PDT)
Received: from LeoBras (179-125-207-129.dynamic.desktop.com.br. [179.125.207.129])
        by smtp.gmail.com with ESMTPSA id s74sm4218570qka.54.2020.05.04.12.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 12:02:55 -0700 (PDT)
Message-ID: <6abf695198e969898c56669bd884f2679aebd35a.camel@gmail.com>
Subject: Re: [PATCH] send-email: Defines smtpPassCmd config option
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Carlo Marcelo Arenas =?ISO-8859-1?Q?Bel=F3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, Jan Viktorin <viktorin@rehivetech.com>,
        Michal Nazarewicz <mina86@mina86.com>
Date:   Mon, 04 May 2020 16:02:45 -0300
In-Reply-To: <20200501125308.GE33264@Carlos-MBP>
References: <20200501105131.297457-1-leobras.c@gmail.com>
         <20200501125308.GE33264@Carlos-MBP>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 2020-05-01 at 05:53 -0700, Carlo Marcelo Arenas Belón wrote:
> having said that, this looks like a good alternative, but might need to
> make sure if die makes sense below or would be better to see if you can
> still get a password through git credential even if that fails.

Thank you.

