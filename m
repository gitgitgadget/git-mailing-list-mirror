Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C89681F404
	for <e@80x24.org>; Thu, 15 Mar 2018 18:58:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752484AbeCOS6P (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Mar 2018 14:58:15 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37278 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752294AbeCOS6O (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Mar 2018 14:58:14 -0400
Received: by mail-wm0-f67.google.com with SMTP id 139so12550720wmn.2
        for <git@vger.kernel.org>; Thu, 15 Mar 2018 11:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=aIF9rpFuMEoNl93lyZZxaQgBCGJxCvh8zfEKkoNWoAI=;
        b=lJ59h6IQRM32qnqWL/oxvRInUeq63IutF28itVpWe1XBI+oYX24hdTikrvMzdBCo3U
         FIM57J0pOaWmrsvoOdpn7a2c9Sy6FqIc/VzwHD0vd34KPMBYKEYDN6ZgX71HU41lY0m/
         BROZkHZYmybeU7RaVVnz+LxAogwuIDxGLzYM0utIXtPBwYfpU3GNI6co52rJxojw+aJZ
         7Bo5rx7VEKgxwsLLdtiGCvykExnLQZdKF/0E1G2mvNJ8LP1+sRX+uAmBoH1BrxfYQR8M
         x7p8dNlgsy/U65KnzFvhPcgG2PZt7QfLnxKgG5v3+NMUu1DjGLdvtJOskPnJfQgJ0Fr9
         OinA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=aIF9rpFuMEoNl93lyZZxaQgBCGJxCvh8zfEKkoNWoAI=;
        b=NzkO+IdKoaAiLomDtZvMhC9VwqP2Bw79OGaU9jubMi2ddVYT9IoxdqQWIO/KQghMHo
         Nttc+6beucJM1BrtpmeZoc8cFi67REcrAUF7sXm83a7xFolSgo++GUNSSLyK8uHsORTf
         6yDl8D2es5EPy45nibNlhmiVQn/PbKMIJhf/FxyJxFDSDGZG/m/8K0+Hajedvqrw0eKx
         wyX/xEFswdNHLGXUjyZIcqdbguHEmw1YngomsXhNrzM6WKw7jiLRB2py38Z9dx0dfxbo
         qGL2JnozcSIMdmfHxriGmUaCRDENbjfoEfP4mKn6zHvc4Jp+DB1RHVV2Oe0jY1BKB15e
         A8bA==
X-Gm-Message-State: AElRT7EaKlY7m6jTGFTFmAGPxVV1ONJIryZQ3AF8kxWmH4HoWeFMVBWd
        PpI1OWDBFNBcGbLcyIrN+FQ=
X-Google-Smtp-Source: AG47ELu3CEfO7SkbyHUjB/bX5qvn0byHBpXHThTd5wU0P0xuATSR3HnThKxOzRyX8yt/dV3QfMdrxg==
X-Received: by 10.28.149.71 with SMTP id x68mr2370589wmd.78.1521140292911;
        Thu, 15 Mar 2018 11:58:12 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 41sm6992787wrt.82.2018.03.15.11.58.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Mar 2018 11:58:12 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     Ben Peart <benpeart@microsoft.com>, git@vger.kernel.org,
        pclouds@gmail.com, blees@dcon.de
Subject: Re: [PATCH v1] Fix bugs preventing adding updated cache entries to the name hash
References: <20180315152520.23264-1-benpeart@microsoft.com>
        <xmqqfu515ihj.fsf@gitster-ct.c.googlers.com>
        <339cd7f7-9ca0-62cf-ea46-588be119eedd@gmail.com>
Date:   Thu, 15 Mar 2018 11:58:11 -0700
In-Reply-To: <339cd7f7-9ca0-62cf-ea46-588be119eedd@gmail.com> (Ben Peart's
        message of "Thu, 15 Mar 2018 14:44:06 -0400")
Message-ID: <xmqqy3it414s.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <peartben@gmail.com> writes:

> This 2nd part of the patch was more for code cleanliness.

Thanks.
