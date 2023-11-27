Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fM16dNjP"
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66EF710CA
	for <git@vger.kernel.org>; Mon, 27 Nov 2023 11:45:02 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1cfc34b6890so13503745ad.1
        for <git@vger.kernel.org>; Mon, 27 Nov 2023 11:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701114302; x=1701719102; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dIPbi1SAcoLyhsO9h2GkVMa7NxNVTvPU3WlcXbdv41c=;
        b=fM16dNjPsQq3YAkzJV8/ysCx1GWXptVfjVnvqAZj0aA0EnBDONcoxwXa/vVTa1OEFa
         MhODCjpjjz/i3VWcXbeWcB8QYSfirBDXJ64blV3a4D9tN1YjhZRoJuOVz5ZPdyX+1SAL
         zIqYuyaEY17Bzczde1IWbxTlkybhr+nzoT0Gj126b4dJiJBmVKQm5r3mJ9eqhLsvI6Sa
         yaMucI4FjlOhu4b2J5QJAD/zYFgQ3upO/IJDQcuEIvLqAawJa/+Dl5aaTptSdvAH1hA2
         jXVj6xtWx7wIsYUw1cuhW5yC3JExb2gcQnccG3a/En2fP1NslCD1jrS8mI+i76PtREE6
         LCJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701114302; x=1701719102;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dIPbi1SAcoLyhsO9h2GkVMa7NxNVTvPU3WlcXbdv41c=;
        b=iZm722zUrf5nmFs+vu2ld979COAOadv72RtGctx1g8m/HjdclnLBO+Pf74zCBTeYZJ
         54fyOppIXCDsjamgVu7RmjL8xSBrS1N3nodBwXHfZ3ZukDb1D/JplGQ79oAmHO7zjr19
         boGGhs1pK1cwQNFjXs8HCKLsGWSXugcGD/PXwYna+cwz4yYv4EoPAMstMKvrX7r7V/Nj
         8IAlVts3VRuw4TQbJ4nFoMXMvVT7e5NhzgqX3bj5zTpBgxKzyXj+Z3sSYSbdH4UGx+Ih
         5k5ZsZOzlr2HSk2GA/7dXDm3Hy2hxebWVoe+ec/Z2dHfuLKOBK8sfCQ6VSRdA+n+96qR
         flMw==
X-Gm-Message-State: AOJu0YyEOMTtj4RtYCLR5bWD9XkkK2hLwbgcSm1KrK+DDvR1Kam2MrrE
	0+5mAirndl00SqukUA9ltfOzJA==
X-Google-Smtp-Source: AGHT+IGAg2XIRu7gr+Q7yaiEt3Hy5WjVMfr//VKL9yTAbujFADjQekmRLw92/lwnUSJrLKqqc8qzvA==
X-Received: by 2002:a17:902:d4cf:b0:1cf:c67e:8f43 with SMTP id o15-20020a170902d4cf00b001cfc67e8f43mr7602327plg.7.1701114301549;
        Mon, 27 Nov 2023 11:45:01 -0800 (PST)
Received: from google.com ([2620:15c:2d3:204:d2e9:e3fe:4455:513f])
        by smtp.gmail.com with ESMTPSA id j18-20020a170902da9200b001bb0eebd90asm8646216plx.245.2023.11.27.11.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 11:45:01 -0800 (PST)
Date: Mon, 27 Nov 2023 11:44:56 -0800
From: Josh Steadmon <steadmon@google.com>
To: Adam Majer <adamm@zombino.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] setup: recognize bare repositories with packed-refs
Message-ID: <ZWTxuBV1DGieo6n2@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
	Adam Majer <adamm@zombino.com>, git@vger.kernel.org
References: <20231117202513.20604-1-adamm@zombino.com>
 <20231117203253.21143-1-adamm@zombino.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117203253.21143-1-adamm@zombino.com>

On 2023.11.17 21:32, Adam Majer wrote:
> In a garbage collected bare git repository, the refs/ subdirectory is
> empty.  In use-cases when such a repository is directly added into
> another repository, it no longer is detected as valid. Git doesn't
> preserve empty paths so refs/ subdirectory is not present. Simply
> creating an empty refs/ subdirectory fixes this problem.
> 
> Looking more carefully, there are two backends to handle various refs in
> git -- the files backend that uses refs/ subdirectory and the
> packed-refs backend that uses packed-refs file. If references are not
> found in refs/ subdirectory (or directory doesn't exist), the
> packed-refs directory will be consulted. Garbage collected repository
> will have all its references in packed-refs file.
> 
> To allow the use-case when packed-refs is the only source of refs and
> refs/ subdirectory is simply not present, augment 'is_git_directory()'
> setup function to look for packed-refs file as an alternative to refs/
> subdirectory.
> 
> Signed-off-by: Adam Majer <adamm@zombino.com>
> ---
>  setup.c       | 10 +++++++---
>  t/t6500-gc.sh |  8 ++++++++
>  2 files changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/setup.c b/setup.c
> index fc592dc6dd..2a6dda6ae9 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -348,7 +348,7 @@ int get_common_dir_noenv(struct strbuf *sb, const char *gitdir)
>   *
>   *  - either an objects/ directory _or_ the proper
>   *    GIT_OBJECT_DIRECTORY environment variable
> - *  - a refs/ directory
> + *  - a refs/ directory or packed-refs file
>   *  - either a HEAD symlink or a HEAD file that is formatted as
>   *    a proper "ref:", or a regular file HEAD that has a properly
>   *    formatted sha1 object name.
> @@ -384,8 +384,12 @@ int is_git_directory(const char *suspect)
>  
>  	strbuf_setlen(&path, len);
>  	strbuf_addstr(&path, "/refs");
> -	if (access(path.buf, X_OK))
> -		goto done;
> +	if (access(path.buf, X_OK)) {
> +		strbuf_setlen(&path, len);
> +		strbuf_addstr(&path, "/packed-refs");
> +		if (access(path.buf, R_OK))
> +			goto done;
> +	}
>  
>  	ret = 1;
>  done:
> diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
> index 18fe1c25e6..e81eb7d2ab 100755
> --- a/t/t6500-gc.sh
> +++ b/t/t6500-gc.sh
> @@ -214,6 +214,14 @@ test_expect_success 'gc.repackFilter launches repack with a filter' '
>  	grep -E "^trace: (built-in|exec|run_command): git repack .* --filter=blob:none ?.*" trace.out
>  '
>  
> +test_expect_success 'remove empty refs/ subdirectory' '
> +	git -C bare.git cat-file -e 60dd8ad7d8ed49005c18b7ce9f5b7a45c28df814 &&
> +	test_dir_is_empty bare.git/refs/heads &&
> +	test_dir_is_empty bare.git/refs/tags &&
> +	rm -r bare.git/refs &&
> +	GIT_DIR="$PWD"/bare.git git -C bare.git cat-file -e 60dd8ad7d8ed49005c18b7ce9f5b7a45c28df814
> +'
> +

Two suggestions for the test here:
1) Can you give the test a more descriptive name, such as "GCed bare
repos still recognized"?
2) Can you add a check that bare.git/packed-refs exists?

Other than that, looks good to me.

Reviewed-by: Josh Steadmon <steadmon@google.com>
