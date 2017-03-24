Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7735D1FC19
	for <e@80x24.org>; Fri, 24 Mar 2017 22:41:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752801AbdCXWl3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 18:41:29 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35467 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752484AbdCXWl2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 18:41:28 -0400
Received: by mail-pg0-f65.google.com with SMTP id g2so599903pge.2
        for <git@vger.kernel.org>; Fri, 24 Mar 2017 15:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CnLj6f3gcpqG3fQntf1NqZihNMGii+dpBHCaULDR8pk=;
        b=PkQ8L2UmEHC5eWH8QRG7M83D5I11BEplcnHxvvqBfFSdCJ+8d8DPMHXFZHZM7JGus6
         25NVCMxDW4cCjrKforlQO/DKiEtTeNN8ExZQX0HNhmP2tTZlqzxqJPpP5KqZyfK3egBh
         EdTe596h5QRHObVl8eUBLMP6Kmc5Dw3qASZDqRrME2MxPdx4xowbjeHjQwiiTx7+BUK4
         0hUZEFoweadDUhe2/azhyQuHOxvSo7nby0rvGXONG5qMEp9t/i497N5Zywrie54Bs+Ne
         AObXYF6yAe7h+q19OGn2ToTMMgtv2BlX25yLD5SXV22KfDKAZCGkuKFMx22M/8cBe+kG
         EY6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CnLj6f3gcpqG3fQntf1NqZihNMGii+dpBHCaULDR8pk=;
        b=lX391lWToEkWBO6495IdJaGtOy4/e9Ah6rkGdJCaeoplPSYBrLh4tSMrVMfYtRbOxF
         fUMmxDDW3d4haiqw+L/HfS527cPpzPXr7UEIvLiw+0X+RW2CMfwOTo3qDJLBb7hi6XpW
         eT2U9k/2yI9IpcTv4sWeWff+sEiMKXzXDft1joojKCp4LZbigMrVyRqZu6WgdfmGVcir
         VGhshwCK0Sbmf+ZK6OYyX6LI/CaJ3XRaEFhUg1HD83C6XLXgW+PPJ11G4gMJrD+GSBqt
         mO/8npH/LT5ShEnulZRSJ08zYV+6En2/fK7g237HLiT9W4In/FvCzc7Y2L/kAE+NWN/Y
         jGXw==
X-Gm-Message-State: AFeK/H1nfgAsa2RSm88tCxyKkc2OIu9sJeY9lIHZUiCnG95gll/nuLZhESDgsfcmMhI52w==
X-Received: by 10.99.62.4 with SMTP id l4mr11514255pga.172.1490395286598;
        Fri, 24 Mar 2017 15:41:26 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:1000:5b10:8597:ae41:db75:6a97])
        by smtp.gmail.com with ESMTPSA id j188sm6571841pfg.27.2017.03.24.15.41.25
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 24 Mar 2017 15:41:26 -0700 (PDT)
Date:   Fri, 24 Mar 2017 15:41:24 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     gitster@pobox.com, git@vger.kernel.org
Subject: Re: [PATCH 4/7] submodule.c: port is_submodule_modified to use
 porcelain 2
Message-ID: <20170324224124.GI31294@aiede.mtv.corp.google.com>
References: <20170323223338.32274-7-sbeller@google.com>
 <20170324182902.19280-1-sbeller@google.com>
 <20170324182902.19280-5-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170324182902.19280-5-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller wrote:

[...]
> --- a/submodule.c
> +++ b/submodule.c
[...]
> @@ -1070,11 +1070,12 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
[...]
>  	while (strbuf_getwholeline(&buf, fp, '\n') != EOF) {
> -		if ((buf.buf[0] == '?') && (buf.buf[1] == '?'))
> +		/* regular untracked files */
> +		if (buf.buf[0] == '?')
>  			dirty_submodule |= DIRTY_SUBMODULE_UNTRACKED;
>  		else
>  			dirty_submodule |= DIRTY_SUBMODULE_MODIFIED;

At first I didn't believe it could be so simple. :)

Unlike ordinary files that use 1, 2, or u, ignored files use '!'.
You're not passing --ignored so you don't have to worry about them.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Very nice.
