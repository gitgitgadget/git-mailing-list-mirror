Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E43761FC3E
	for <e@80x24.org>; Thu, 27 Apr 2017 06:10:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933097AbdD0GKY (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Apr 2017 02:10:24 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33755 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933091AbdD0GKW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2017 02:10:22 -0400
Received: by mail-pf0-f193.google.com with SMTP id c198so6543983pfc.0
        for <git@vger.kernel.org>; Wed, 26 Apr 2017 23:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=EQ1AejWX4y4YnR2+uH80cKG1pWyJEsKD0n4Dt9FTtRc=;
        b=b5xtWJlh5p2ZMTHFXVFbFI3cgGHjyLC3lOmN0PHKe+sVWEHjXL/sHQ7IEmpsiJSAri
         0ICkBdPCgjw6y1Z76AumZr/+0RbLstDKB80vkikccbyQ3Xoib93CwAnYndFKBUvCSl83
         aNIv6JJfVb457yj3/rSXWq9nTu6HW53HhkHyoYqpv34ntLz5tKnuq273nuDXPCQK2+fo
         2fcJw3myZkl3/hGqhj9mVUN4x7S45QUXVVscZ00Y8/tosP8Q7KHW3+jIcRDDSKj3uuFw
         sq7bOQyxfn90ISTqcxGguOpl5M/8EYDDVRozevLWVlfor8MtL3FDMNd8CCizMi+SzBFZ
         FsTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=EQ1AejWX4y4YnR2+uH80cKG1pWyJEsKD0n4Dt9FTtRc=;
        b=EUmjMsQTQwSPV90zvBlCmHYdjYl9F+1ytckBTGxYKsFqXXF+almFm+QEIsnZit2Ujz
         ESKBourI6dpDicbBypu7MQ76ij51KrPpgIyG9hWCdg0d1eSiZ8rgxwYev+cu3RuXTTf3
         UYGv9i3Zhlo5TyT+RKclw2BeJtUqdgJZYKzYWHOzpU8dkIO15qD9yuJiPKJH9yFR9/cV
         r9bK6+wK2lJp83emoonYw3/njPjGjhol5CuXvApTdfvTE0P9GfWvJmbt8tmLWfPXbpfK
         OVoXOFpKQ75vzsxzsV5NEE6mmm85R7Agf+8g44RMGtw6RXJ29yl3DNa1Wkk/WUxy6jjV
         fhHA==
X-Gm-Message-State: AN3rC/5H0+g20maCukC07GL6QZ/k8M7sPpMCJ6NMorTQIdIuiEEJGtdc
        wMYOb99qTCbcQQ==
X-Received: by 10.98.151.17 with SMTP id n17mr4014811pfe.138.1493273421801;
        Wed, 26 Apr 2017 23:10:21 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:d550:ca2:cfe6:6d97])
        by smtp.gmail.com with ESMTPSA id h85sm1995180pfd.114.2017.04.26.23.10.21
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 26 Apr 2017 23:10:21 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 11/26] cat-file: fix memory leak
References: <cover.1493237937.git.johannes.schindelin@gmx.de>
        <a1381df96c940f1edf5b7fb0c49abfc7b12b72fa.1493237937.git.johannes.schindelin@gmx.de>
Date:   Wed, 26 Apr 2017 23:10:20 -0700
In-Reply-To: <a1381df96c940f1edf5b7fb0c49abfc7b12b72fa.1493237937.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Wed, 26 Apr 2017 22:20:23 +0200
        (CEST)")
Message-ID: <xmqqo9vimldf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Discovered by Coverity.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  builtin/cat-file.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index 1890d7a6390..9af863e7915 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -165,6 +165,7 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
>  		die("git cat-file %s: bad file", obj_name);
>  
>  	write_or_die(1, buf, size);
> +	free(buf);
>  	return 0;
>  }

This is a border-line "Meh".  Just like we do not free resources
immediately before calling die(), we can leave this as-is as the
only thing that happens after this is a return from cmd_cat_file()
back to main() that exits.

The patch is not wrong per-se, so I've applied it anyway, though.

Thanks.
