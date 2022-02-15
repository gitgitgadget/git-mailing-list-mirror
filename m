Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C77F5C433F5
	for <git@archiver.kernel.org>; Tue, 15 Feb 2022 21:34:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243496AbiBOVea (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 16:34:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241795AbiBOVe2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 16:34:28 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 773F5FBA41
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 13:34:17 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id a8so37684ejc.8
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 13:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=idk7EYzpdieVhuSrgyzmZhb5hBLmlyLByg9p5ADZKJ0=;
        b=dRfIUCs44MNRjUzWkd53UAREuRHVrlk70jGdq6Tm7uDsW3VSHdFcICSYkCZY2K7VrL
         p4n7iF/Xv6P7/EKqRPB8CXa59iNWbyV4z5Mwhromrmmg+6rzn4Jrg9O5O9onbpIbbijJ
         fXaOBmZ/T5fkMQuJud0G9VEtQ0t2ngK1juuh9Ze1R8agUaWD0nNousRGHoAQR1zUC2H5
         L8Ky8kdEQ1Xsv9KPXJNOPjZywXEDc0T4bFpSW9lsaX6jMBxx3lENLcWoGa3yoRfskGa1
         JZFkedO7UXsjsv7Czu5Ww7WRaYTeByxIUhN/zRdRzYkmnzLu+znkOruVDCCfJrIfzEwg
         W2lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=idk7EYzpdieVhuSrgyzmZhb5hBLmlyLByg9p5ADZKJ0=;
        b=mXRs1xwP1dHR2WLASy2bNH21OGmwK0n/Z1rhecUwzqT7P2b1wMxWyNUNB4OUr4T1oW
         4jRQ5qxQ2TxMFXd/pKeRKBWWpANkjzod4TqRT+xiG7O6EBiyPf7rbIueP/NipURB302W
         7f/gc0lt5fR6c+hSv5BADuHD+O+AMN8bDL3bEt4MiunhONM2a1iSeQKK0yMPAP37/0p8
         MQx8ZZiUBi8SPFylcBgt7Z8tAFClIf+Fy3SWwrGOYOc68y/WnZGst38ZAEt7xAPi6rA2
         rxWPw7PQXr8/QdsVF68Kg5uUavDC6YlDZ/XgSKNoO/MvU0anrgXttIFn9D0aNwcGIzjD
         DaFA==
X-Gm-Message-State: AOAM533fcUMcEMqufPJYH2mCp/zldbaIDtM69fCFM8eA72ch9Z7z5FuB
        I91y3OcpZrzx45rVrSI30fyNmy9sYxI=
X-Google-Smtp-Source: ABdhPJzjquGv6iZ8YYwh3aiRSYWbfk4jaK6mos8DFlZe3YqiJyYtzxKkOsiPmepe3BcgGRmnqOQBHQ==
X-Received: by 2002:a17:907:1c26:: with SMTP id nc38mr812004ejc.557.1644960856015;
        Tue, 15 Feb 2022 13:34:16 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id r17sm547021edd.64.2022.02.15.13.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 13:34:15 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nK5Sg-002rqs-QK;
        Tue, 15 Feb 2022 22:34:14 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 5/9] submodule: store new submodule commits oid_array
 in a struct
Date:   Tue, 15 Feb 2022 22:33:07 +0100
References: <20220210044152.78352-1-chooglen@google.com>
 <20220215172318.73533-1-chooglen@google.com>
 <20220215172318.73533-6-chooglen@google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <20220215172318.73533-6-chooglen@google.com>
Message-ID: <220215.86zgmrx19l.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Feb 16 2022, Glen Choo wrote:

>  	struct string_list_item *item;
> -	for_each_string_list_item(item, submodules)
> -		oid_array_clear((struct oid_array *) item->util);
> +	for_each_string_list_item(item, submodules) {
> +		changed_submodule_data_clear(item->util);
> +	}

Nit: These {} additions aren't needed here or in the end state of this
series.
