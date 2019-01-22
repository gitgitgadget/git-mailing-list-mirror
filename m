Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B361E1F453
	for <e@80x24.org>; Tue, 22 Jan 2019 23:05:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbfAVXFg (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Jan 2019 18:05:36 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38583 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbfAVXFf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jan 2019 18:05:35 -0500
Received: by mail-wr1-f67.google.com with SMTP id v13so260814wrw.5
        for <git@vger.kernel.org>; Tue, 22 Jan 2019 15:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=5aKPmAn2f2e84LCZA9Be7AopWaOavYo2h9jrmCc7iqE=;
        b=MxOssR/LEh1q3MCyfhm9346DYN77uho8UKXsl1OGPwNhQ9LO89nvDbO/97fh7hwp+v
         637zFiPcNQSAG8m7CaxmlpMv8BIOGwkxL5Je2NhkJ8SZJH3ycsw5qUpElsb/ACCCmwW5
         21i/Fd2YuALLL/N37SGIfnIO9/b8Q3Kekhu62ZFpds+NkWAaWEntfSjlJT17eMdmMZE7
         wk4jMmKy4oXD0Fu7LGZ/sy/PviFi70Drt4HwdEQ+wVfokWULFWkrpRtovqnnxNsB2LQf
         FeHRJdbBaX92VtIdUlXEndnUFcEhUp1YOFAfw3DdpJDph1SbIZ1rpQ4Bg6ADgixDLmaG
         yMjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=5aKPmAn2f2e84LCZA9Be7AopWaOavYo2h9jrmCc7iqE=;
        b=khTBmAqcaRd8VDFwiXeSrxM97Trm8HS1jELTsIJX22OkI4zx9BHwewEF2i5j3kPYVX
         pfI95g57/H9uWJR8wLdFAMGIS/e4ZIts1f+6Qr6oXrMb2nIxFniFTkkHdvMldusCH2nU
         9JOkjX82Qi6gjN2Pb+w7QGjVb/HNO+9ON1bSLy9/UkJvSIkRhI8J/YlsBTBJEAHY32Vk
         DMZNKcfOEHY4/+5eWicaka7+bk854rCdD5JF8TDBd10jjqYIPEiOgbeopxDZTpTdcoQz
         +bjMJR9CN80fG6E1movSYceCGdOY3tyKap8OzFTPsHi/tzNZ4tBkiBCwA96+21b8mtQL
         QSjA==
X-Gm-Message-State: AJcUukeb7iXgtb27sR6jwLFj53GmgtLT0lbuaM1UTk+R7gBqF/FYJrv3
        yx1YeNdYsMgxXxW1WsN0yG0=
X-Google-Smtp-Source: ALg8bN7Q28PFBaTuAdbALv4zzZoX7cAXqHk2a/DhxNsWH/xW9LwSgkojSngwTR2EbkzGUA2HJoKYZA==
X-Received: by 2002:adf:9b11:: with SMTP id b17mr35263143wrc.168.1548198333275;
        Tue, 22 Jan 2019 15:05:33 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id f187sm39716381wma.4.2019.01.22.15.05.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Jan 2019 15:05:31 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Hogg <phogg@novamoon.net>
Cc:     git@vger.kernel.org, pclouds@gmail.com
Subject: Re: [PATCH] pack-objects.c: Initialize read mutex in cmd_pack_objects
References: <20190118022736.36832-1-phogg@novamoon.net>
Date:   Tue, 22 Jan 2019 15:05:30 -0800
In-Reply-To: <20190118022736.36832-1-phogg@novamoon.net> (Patrick Hogg's
        message of "Thu, 17 Jan 2019 21:27:36 -0500")
Message-ID: <xmqqwomwcmyt.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Hogg <phogg@novamoon.net> writes:

> @@ -3319,6 +3327,8 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
>  		OPT_END(),
>  	};
>  
> +	init_read_mutex();
> +
>  	if (DFS_NUM_STATES > (1 << OE_DFS_STATE_BITS))
>  		BUG("too many dfs states, increase OE_DFS_STATE_BITS");
>  
> @@ -3495,5 +3505,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
>  			   _("Total %"PRIu32" (delta %"PRIu32"),"
>  			     " reused %"PRIu32" (delta %"PRIu32")"),
>  			   written, written_delta, reused, reused_delta);
> +
> +	cleanup_read_mutex();

This is insufficient, isn't it?  There is "return 0" just above the
pre-context of this hunk which should probably be made to "goto
clean_exit" or something, with a new label "clean_exit:" just in
front of this new call to cleaup.

>  	return 0;
>  }
