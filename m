Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7536D20958
	for <e@80x24.org>; Wed, 29 Mar 2017 23:13:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933005AbdC2XNP (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Mar 2017 19:13:15 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33109 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932963AbdC2XNN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2017 19:13:13 -0400
Received: by mail-pg0-f65.google.com with SMTP id 79so5405684pgf.0
        for <git@vger.kernel.org>; Wed, 29 Mar 2017 16:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=craYCVi2BTYSG//ZfvGfYRhlqVpUpjc5Rf1JH0LfWk0=;
        b=jp9kPg5OK3surYCjptgvtsCYDgXdiUn+6boEQaFuoNuYVu4eiAqZItGjUQjlsMnOpx
         TslXXB/LmFgT94OhdIrRjdLtPtMMVve/91ZbwVgG3LkTvREX8lS4yjQR02UTpUDfH7VS
         5moLKW0FY59IUNsB1QvV0Im6FRxB5h78YZLP8Xq1+mtXRgQpf23fLbfXQsFKk4wmNO0S
         d1GKLpIU35DrSlqLTKNFj/92lMyYcJ1Xn4KkNeLPHo80RwHupr15fu3Etyw7vvoHn1DA
         fbKVpaeaGfIEonyFxn0IvlbboUFRwc+Rqyrs/TsnzKdxBSoadQ9q8wAFXRIV95DZ6rV8
         vAiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=craYCVi2BTYSG//ZfvGfYRhlqVpUpjc5Rf1JH0LfWk0=;
        b=Jf4nRP2LJ9t8K/LfnCWN5PcbnbcKTZb5AVh2XAawXTk3B1Vu6gZuFvL5fmXb36oUWm
         eFOFLyCg4t7CZqP8Q+WEqjSoOtgiO5LLg/Q5wnpCbylnxsEAxi7TOYUApPgKjBc0YYIs
         c8lnecoU7S4t6FcmsW6HxToxymcjDtMmlXMkH95KhX58A5V5LxePu+VWeqBANGRsNZ4L
         znoHBmq6T8FsnRbYmjLUfpNoV3osQz7orp0/gj4tZQf4BcDbwXBowLbjDxhp5i+oT5JU
         OSiFvhQPVRMZvbO/djfmnlaBxC3GobrzMYruXgtF2dRL7unwR9oF0R/L46OlR0fjus7N
         EpQQ==
X-Gm-Message-State: AFeK/H2ImMzQi2Nr6QyqFDFrsnUraApc8jCsVU5UUQZ0hNOenEiLSAy8z2KBVQsaFBY+Zg==
X-Received: by 10.98.36.151 with SMTP id k23mr2898495pfk.53.1490829191523;
        Wed, 29 Mar 2017 16:13:11 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:1000:5b10:1cae:64a4:6d7e:ad6f])
        by smtp.gmail.com with ESMTPSA id t5sm281686pgb.58.2017.03.29.16.13.10
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 29 Mar 2017 16:13:10 -0700 (PDT)
Date:   Wed, 29 Mar 2017 16:13:09 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     gitster@pobox.com, git@vger.kernel.org
Subject: Re: [PATCH 2/2] submodule.c: correctly handle nested submodules in
 is_submodule_modified
Message-ID: <20170329231308.GZ31294@aiede.mtv.corp.google.com>
References: <20170328230938.9887-1-sbeller@google.com>
 <20170329222616.11077-1-sbeller@google.com>
 <20170329222616.11077-3-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170329222616.11077-3-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller wrote:

> This bug fix also affects the default output (non-short, non-porcelain)
> of git-status, which is not tested here.

Do you have an example?  (In just the commit message would be fine, in
tests would be even better.)

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  Documentation/git-status.txt |  2 ++
>  submodule.c                  | 21 +++++++++++++++++++--
>  t/t3600-rm.sh                |  2 +-
>  t/t7506-status-submodule.sh  |  4 ++--
>  4 files changed, 24 insertions(+), 5 deletions(-)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

but I would be a lot more comfortable after looking at the change to
"git status" output.  (E.g. a test demonstrating it can happen in a
followup change if that's simpler.)

Thanks for your patient work on this.
