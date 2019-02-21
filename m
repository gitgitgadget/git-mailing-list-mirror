Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52C4D1F453
	for <e@80x24.org>; Thu, 21 Feb 2019 21:26:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726241AbfBUV0p (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Feb 2019 16:26:45 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52081 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbfBUV0o (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Feb 2019 16:26:44 -0500
Received: by mail-wm1-f66.google.com with SMTP id n19so80988wmi.1
        for <git@vger.kernel.org>; Thu, 21 Feb 2019 13:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=l5Udr/5wLssxIWLBkGckGt+ggBBupkMjaC5bW0/eV1c=;
        b=jKvt/iRR7DrD/OSZsSpWJlzZ552MiMUuOLHIKGeX7HRG0YFDXdtousRCC75ZTcO0jp
         z+FCeKzd9pK8aqwCOXsSXrJUb9NThVL+SWQ+II67GOm3SICD2AzSKF/1B/eCD8U9DzMR
         Yj0B0nF6H0TO3cy9BDdmc4Y3BIi0bpBkvkEoHDz+QRjuzgS9x5VBQSGE+ZmYGSp3C0nY
         bfo4NSm/ILp+j9J7r9CSOXguaHCURSsDBAB2fJrIaLP6kr3qr5e5ak1l+EhhBCeshKbJ
         vnEZqLW9eIQEEt/gArOGvv0zZWi9YROA8aeHfMgJf9JBeytTlQ8yLAHhpOodwgpDjZ0M
         6BHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=l5Udr/5wLssxIWLBkGckGt+ggBBupkMjaC5bW0/eV1c=;
        b=jN4CS4+B7Zqqs+LFwijdLvqEm0WJiKIyr7N6TzKifmnU4WsZpGXiQATiDAMUYrRQjh
         K+n0FIppwLeKZCtBtdyfhfUwv9ldWayYnOadgEV1owytVUyhJyLsKXTYPh76ZmtJBvb5
         AR5Vmev05QkrR8fytU/6tXX6bsnW/koV62ztkm/aJCaSPI2AUFdGRMv3/eEFAF80G/58
         cCDGE0HqqTze+HetT939RMOnfcCdmA29HWrDvDK1wvmG/yiLxDKprcROL52sp4e2U0hG
         n+6ePxEJCvx2+2E5G0R/R9ZnxAHAUo4JE1kXrkAr3ysJfjLaE5/+iYkXkWvhe/Y7Lhp7
         4xAw==
X-Gm-Message-State: AHQUAuYh0quPKDKLpVagpxdKTvMcHqdzYxpkhY4AP1maOC+hutjT7HwD
        Ird+Nytt/IiokmaLoqJPd4E=
X-Google-Smtp-Source: AHgI3IYskiDAnR1K/RXfWUPvoUhgWA9JYz2dnILici7oo80waCqFrYmyUbytelH+H0qg7w49rziEfA==
X-Received: by 2002:a1c:c205:: with SMTP id s5mr305240wmf.116.1550784401817;
        Thu, 21 Feb 2019 13:26:41 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id n189sm7304735wmb.28.2019.02.21.13.26.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Feb 2019 13:26:40 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH] http: use --stdin and --keep when downloading pack
References: <20190221001447.124088-1-jonathantanmy@google.com>
Date:   Thu, 21 Feb 2019 13:26:40 -0800
In-Reply-To: <20190221001447.124088-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Wed, 20 Feb 2019 16:14:47 -0800")
Message-ID: <xmqq5ztcu92n.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> When Git fetches a pack using dumb HTTP, it does at least 2 things
> differently from when it fetches using fetch-pack or receive-pack: (1)
> it reuses the server's name for the packfile (which incorporates a hash)
> for the packfile, and (2) it does not create a .keep file to avoid race
> conditions with repack.
>
> A subsequent patch will allow downloading packs over HTTP(S) as part of
> a fetch. These downloads will not necessarily be from a Git repository,
> and thus may not have a hash as part of its name. Also, generating a
> .keep file will be necessary to avoid race conditions with repack (until
> the fetch has successfully written the new refs).
>
> Thus, teach http to pass --stdin and --keep to index-pack, the former so
> that we have no reliance on the server's name for the packfile, and the
> latter so that we have the .keep file.

Makes sense.  Can a malicious dumb server mount a passive attack
that serves misnamed packfiles and wait for victims to come?

> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
> This is part of the work of CDN offloading of fetch responses.
>
> I have plans to use the http_pack_request suite of functions to
> implement the part where we download from CDN over HTTP(S), but need
> this change to be able to do so. I think it's better from the code
> quality perspective to reuse these functions, but this necessitates a
> behavior change in that we no longer use the filename as declared by the
> server, so I'm sending this as RFC to see what the community thinks.
> ---
>  http-push.c   |  7 ++++++-
>  http-walker.c |  5 ++++-
>  http.c        | 42 ++++++++++++++++++++----------------------
>  http.h        |  2 +-
>  4 files changed, 31 insertions(+), 25 deletions(-)
>
> diff --git a/http-push.c b/http-push.c
> index b22c7caea0..409b266b0c 100644
> --- a/http-push.c
> +++ b/http-push.c
> @@ -586,11 +586,16 @@ static void finish_request(struct transfer_request *request)
>  			fprintf(stderr, "Unable to get pack file %s\n%s",
>  				request->url, curl_errorstr);
>  		} else {
> +			char *lockfile;
> +
>  			preq = (struct http_pack_request *)request->userData;
>  
>  			if (preq) {
> -				if (finish_http_pack_request(preq) == 0)
> +				if (finish_http_pack_request(preq,
> +							     &lockfile) == 0) {
> +					unlink(lockfile);
>  					fail = 0;
> +				}
>  				release_http_pack_request(preq);
>  			}
>  		}
> diff --git a/http-walker.c b/http-walker.c
> index 8ae5d76c6a..804dc82304 100644
> --- a/http-walker.c
> +++ b/http-walker.c
> @@ -425,6 +425,7 @@ static int http_fetch_pack(struct walker *walker, struct alt_base *repo, unsigne
>  	int ret;
>  	struct slot_results results;
>  	struct http_pack_request *preq;
> +	char *lockfile;
>  
>  	if (fetch_indices(walker, repo))
>  		return -1;
> @@ -457,7 +458,9 @@ static int http_fetch_pack(struct walker *walker, struct alt_base *repo, unsigne
>  		goto abort;
>  	}
>  
> -	ret = finish_http_pack_request(preq);
> +	ret = finish_http_pack_request(preq, &lockfile);
> +	if (!ret)
> +		unlink(lockfile);
>  	release_http_pack_request(preq);
>  	if (ret)
>  		return ret;
> diff --git a/http.c b/http.c
> index a32ad36ddf..5f8e602cd2 100644
> --- a/http.c
> +++ b/http.c
> @@ -2200,13 +2200,13 @@ void release_http_pack_request(struct http_pack_request *preq)
>  	free(preq);
>  }
>  
> -int finish_http_pack_request(struct http_pack_request *preq)
> +int finish_http_pack_request(struct http_pack_request *preq, char **lockfile)
>  {
>  	struct packed_git **lst;
>  	struct packed_git *p = preq->target;
> -	char *tmp_idx;
> -	size_t len;
>  	struct child_process ip = CHILD_PROCESS_INIT;
> +	int tmpfile_fd;
> +	int ret = 0;
>  
>  	close_pack_index(p);
>  
> @@ -2218,35 +2218,33 @@ int finish_http_pack_request(struct http_pack_request *preq)
>  		lst = &((*lst)->next);
>  	*lst = (*lst)->next;
>  
> -	if (!strip_suffix(preq->tmpfile.buf, ".pack.temp", &len))
> -		BUG("pack tmpfile does not end in .pack.temp?");
> -	tmp_idx = xstrfmt("%.*s.idx.temp", (int)len, preq->tmpfile.buf);
> +	tmpfile_fd = xopen(preq->tmpfile.buf, O_RDONLY);
>  
>  	argv_array_push(&ip.args, "index-pack");
> -	argv_array_pushl(&ip.args, "-o", tmp_idx, NULL);
> -	argv_array_push(&ip.args, preq->tmpfile.buf);
> +	argv_array_push(&ip.args, "--stdin");
> +	argv_array_pushf(&ip.args, "--keep=git %"PRIuMAX, (uintmax_t)getpid());
>  	ip.git_cmd = 1;
> -	ip.no_stdin = 1;
> -	ip.no_stdout = 1;
> +	ip.in = tmpfile_fd;
> +	ip.out = -1;
>  
> -	if (run_command(&ip)) {
> -		unlink(preq->tmpfile.buf);
> -		unlink(tmp_idx);
> -		free(tmp_idx);
> -		return -1;
> +	if (start_command(&ip)) {
> +		ret = -1;
> +		goto cleanup;
>  	}
>  
> -	unlink(sha1_pack_index_name(p->sha1));
> +	*lockfile = index_pack_lockfile(ip.out);
> +	close(ip.out);
>  
> -	if (finalize_object_file(preq->tmpfile.buf, sha1_pack_name(p->sha1))
> -	 || finalize_object_file(tmp_idx, sha1_pack_index_name(p->sha1))) {
> -		free(tmp_idx);
> -		return -1;
> +	if (finish_command(&ip)) {
> +		ret = -1;
> +		goto cleanup;
>  	}
>  
>  	install_packed_git(the_repository, p);
> -	free(tmp_idx);
> -	return 0;
> +cleanup:
> +	close(tmpfile_fd);
> +	unlink(preq->tmpfile.buf);
> +	return ret;
>  }

Nicely done.

>  
>  struct http_pack_request *new_http_pack_request(
> diff --git a/http.h b/http.h
> index 4eb4e808e5..20d1c85d0b 100644
> --- a/http.h
> +++ b/http.h
> @@ -212,7 +212,7 @@ struct http_pack_request {
>  
>  extern struct http_pack_request *new_http_pack_request(
>  	struct packed_git *target, const char *base_url);
> -extern int finish_http_pack_request(struct http_pack_request *preq);
> +int finish_http_pack_request(struct http_pack_request *preq, char **lockfile);
>  extern void release_http_pack_request(struct http_pack_request *preq);
>  
>  /* Helpers for fetching object */
