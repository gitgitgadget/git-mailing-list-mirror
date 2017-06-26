Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B75AB207D2
	for <e@80x24.org>; Mon, 26 Jun 2017 17:56:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751393AbdFZR4k (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Jun 2017 13:56:40 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33804 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751335AbdFZR4i (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2017 13:56:38 -0400
Received: by mail-pf0-f195.google.com with SMTP id d5so1127795pfe.1
        for <git@vger.kernel.org>; Mon, 26 Jun 2017 10:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=wpdRSRugdmrf4Jwu81q9wo39Yc6AAfyw4Ye+AJqtFLs=;
        b=rcyP53zsDn/XEqiYaLy8NfxzTAgPQXxOX4Wtc9MG7eUgwrDIx7Y1Tx3Vxv/LxK+I8P
         cKSzs7pdz+R7gib/rnzxp8gu/Rhhm/AxJUxh7+TA3wFg4Vu+Juc2ha1MaFl03U3dRFTk
         u8jIg8zYo1GzxFFizvSbE1RgDYU4qm5UvQpCUNjc+U4tdLwGbK9g5iVHESGyqStRs5cz
         BJtx/5qy7pzy2NjcMaP+8lse5udYc9vTt5bgfF0pRReFJKD3XFqHHRB4nMGpnkjp2tx+
         OVzWK2DUn6LgfrLcFrF/ersmLfkmJDepxcFHV8UjzzYKeXN1Qgw3EBA37GtbOaU8FGz2
         LtUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=wpdRSRugdmrf4Jwu81q9wo39Yc6AAfyw4Ye+AJqtFLs=;
        b=UL2rlRhz4eeHvnR95yFsb1oXZ8/0aJ+LBVNVky+UorqCLxVey/NLqwtfWl9Io4Bp8R
         3q4GXWQDJ4HN+b0o7onXTYr/7/F1NR/pKaOfkGDDE4Ri7gs7QBpC5jYdJlVDsAyvXlrC
         GLFfP9sKYLppMYrARxguETETqXNblZR7f80NsnmBd+QBrhEEQsA6Ah9bJEni37K3F64i
         OQZ8muwfb/PDbbwdxKA5/I0cMIcMN1+SM0bNq70NgKJj2bNG8+q/0+Vjdn9nrXHQ2t8W
         C6MU6nScQcR9MQ+aLLdVzHljiHjgwdjlFQBKZbtdg+Lp1/WWqDpFitR7e7uc4LQYnjOC
         xaoQ==
X-Gm-Message-State: AKS2vOxcPappz8guEJm630UqqhTOtYzEU227QZ2Om+BKA4oUV8XB/VDZ
        9gv1kSKI5vHG2A==
X-Received: by 10.84.198.67 with SMTP id o61mr1430557pld.98.1498499797775;
        Mon, 26 Jun 2017 10:56:37 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b537:cc1a:8e81:b9ca])
        by smtp.gmail.com with ESMTPSA id 188sm974265pgc.49.2017.06.26.10.56.37
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 26 Jun 2017 10:56:37 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, peff@peff.net,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v6 5/6] convert: move multiple file filter error handling to separate function
References: <20170625182125.6741-1-larsxschneider@gmail.com>
        <20170625182125.6741-6-larsxschneider@gmail.com>
Date:   Mon, 26 Jun 2017 10:56:36 -0700
In-Reply-To: <20170625182125.6741-6-larsxschneider@gmail.com> (Lars
        Schneider's message of "Sun, 25 Jun 2017 20:21:24 +0200")
Message-ID: <xmqqmv8u63aj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Not about this patch, but viewing this with

	git show -w --color-moved=zebra

gives an interesting result.  The bulk of the part moved are
re-indented, and the comment string gets zebra stripes, as if the
line movement detection code does not realize that these came from
the same place.

