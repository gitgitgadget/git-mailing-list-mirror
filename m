Return-Path: <SRS0=vH5l=CZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 074A8C35257
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 20:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADD30206BE
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 20:47:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NQJxPxeS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728520AbgIPUrB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Sep 2020 16:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbgIPRBX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Sep 2020 13:01:23 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A19A7C0073F2
        for <git@vger.kernel.org>; Wed, 16 Sep 2020 07:04:10 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id z18so1501116pfg.0
        for <git@vger.kernel.org>; Wed, 16 Sep 2020 07:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Ue3/Ibk7EXHjW+9w4j0DgFsER9TmHC5GA0fZ632QJrw=;
        b=NQJxPxeSaO5jIL/La/doAAqFCuvZt7ILeW6VHIEunvBTuqGPdFGGlfw+cX5UkbTOp7
         3/W+CXONDFBLuiE2SoXaLKrLwqTftS5Cl+Mqb7RVFyEaK+gb4tnzYK0FPtP/3Y5tw/xv
         bxKWYNem3ja0DEUhhPg2BjWejIRFNR84NuTibdY9tI1lhn6EIITx/yUh+cZf1XnBTlUM
         tDTWHybMVGlj3+fg7x+e7ckI5pXdCqpicm7ZHW7EDUAYEahTU2OdT0OThTKnWfo7T8Ue
         pxm1rHeCpTJpmddRcXwkV+UcaxwxeCoYEPOV+LJwbOYVOqVmxxLkZgIkyEHp1khgkL1I
         mcGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Ue3/Ibk7EXHjW+9w4j0DgFsER9TmHC5GA0fZ632QJrw=;
        b=fqvsWy+5FSevhUaU2ICutCcX6lYEhG3Ywgkl6shl87FQaQLfmKIfblLSMEsm7b8uXm
         yeWGcWXu9pJMZu6mq+h8QRWcwZsoaWPTjFpURhqhFAQYdB5kEPlQp16ZPa9IK7PSMKeO
         RFaTu6u7Lja2KIYN2XDc0NZRDGlit3/1tjT2cshIi9Ne/v5ig85SQLWPNptcVcZ0I9Np
         9mpI3GwxqidLpTlbPCTTuH6UHFpLW+CCnuy9cVLa5+37m4ji6YRv8xwtrmtc0p3ar1tG
         sS/F4tcyayiY06JIQNeSvhwPamdkXyZOMYld3OwuCapOPN/lYqb+r+PeqMyV0QAXnF9l
         4M9Q==
X-Gm-Message-State: AOAM532x6+FtKLAJRObWPYWZoePSbNYyEHptYLF79tVX2aobgEA5iNo0
        VL/vjkhXVqjXk2lvm/QL/t4=
X-Google-Smtp-Source: ABdhPJzTaIae/BO+FbKyli8dkf1yBMaeA97YFrUs/9FpSCwUYmA5SN72BFY9F+JO8XEH+4/Ui9TK5Q==
X-Received: by 2002:a63:f53:: with SMTP id 19mr18791780pgp.26.1600265050210;
        Wed, 16 Sep 2020 07:04:10 -0700 (PDT)
Received: from localhost ([2402:800:63a8:edfa:1ca8:8e9c:e6de:6bb2])
        by smtp.gmail.com with ESMTPSA id y24sm17603405pfn.161.2020.09.16.07.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 07:04:09 -0700 (PDT)
Date:   Wed, 16 Sep 2020 21:04:07 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Antoine =?utf-8?Q?Beaupr=C3=A9?= <anarcat@debian.org>,
        Simon Legner <Simon.Legner@gmail.com>
Subject: Re: [PATCH 07/15] remote-mediawiki tests: guard test_cmp with
 test_path_is_file
Message-ID: <20200916140407.GB10150@danh.dev>
References: <20200916102918.29805-1-avarab@gmail.com>
 <20200916102918.29805-8-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200916102918.29805-8-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-09-16 12:29:10+0200, Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> Change a test that used a plain test_cmp to first check the file(s)
> using test_path_is_file. If some of these file(s) don't exist (as
> happened to me during debugging), test_cmp will emit a way less useful
> message about the failure.

IIRC, <20200809174209.15466-1-sunshine@sunshineco.com> was meant to
solve this problem.

The version you're using (v2.28.0-297-g1956fa8f8d) should have it
integrated already. The test should barf with:

	error: bug in the test script: test_cmp '<file-name>' missing

Am I missed anything?

-- 
Danh

> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  contrib/mw-to-git/t/t9363-mw-to-git-export-import.sh | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/contrib/mw-to-git/t/t9363-mw-to-git-export-import.sh b/contrib/mw-to-git/t/t9363-mw-to-git-export-import.sh
> index 43580af3cf..d3de6c204a 100755
> --- a/contrib/mw-to-git/t/t9363-mw-to-git-export-import.sh
> +++ b/contrib/mw-to-git/t/t9363-mw-to-git-export-import.sh
> @@ -52,9 +52,13 @@ test_expect_success 'git clone works on previously created wiki with media files
>  	test_when_finished "rm -rf mw_dir mw_dir_clone" &&
>  	git clone -c remote.origin.mediaimport=true \
>  		mediawiki::'"$WIKI_URL"' mw_dir_clone &&
> +	test_path_is_file mw_dir_clone/Foo.txt &&
> +	test_path_is_file mw_dir/Foo.txt &&
>  	test_cmp mw_dir_clone/Foo.txt mw_dir/Foo.txt &&
>  	(cd mw_dir_clone && git checkout HEAD^) &&
>  	(cd mw_dir && git checkout HEAD^) &&
> +	test_path_is_file mw_dir_clone/Foo.txt &&
> +	test_path_is_file mw_dir/Foo.txt &&
>  	test_cmp mw_dir_clone/Foo.txt mw_dir/Foo.txt
>  '
>  
> @@ -74,6 +78,8 @@ test_expect_success 'git clone works on previously created wiki with media files
>  	test_when_finished "rm -rf mw_dir mw_dir_clone" &&
>  	git clone -c remote.origin.mediaimport=true \
>  		mediawiki::'"$WIKI_URL"' mw_dir_clone &&
> +	test_path_is_file mw_dir_clone/Bar.txt &&
> +	test_path_is_file mw_dir/Bar.txt &&
>  	test_cmp mw_dir_clone/Bar.txt mw_dir/Bar.txt
>  '
>  
> @@ -90,6 +96,7 @@ test_expect_success 'git push & pull work with locally renamed media files' '
>  		git commit -m "Rename a file" &&
>  		test_git_reimport &&
>  		echo "A File" >expect &&
> +		test_path_is_file Bar.txt &&
>  		test_cmp expect Bar.txt &&
>  		test_path_is_missing Foo.txt
>  	)
> -- 
> 2.28.0.297.g1956fa8f8d
> 

-- 
Danh
