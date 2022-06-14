Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD9A0C43334
	for <git@archiver.kernel.org>; Tue, 14 Jun 2022 01:03:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243854AbiFNBDx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jun 2022 21:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238764AbiFNBDv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jun 2022 21:03:51 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B31615A39
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 18:03:50 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id 43so5528319qvb.3
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 18:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zE2z9ZmoSow3TeMIqIBigCU2Me0fYD6QSgdCFPJ3aJ8=;
        b=iLaMwyfanbbPZ26KN6VQbjqYVG775ATMIerossIZysnS0LHspB0lnfGIXGfRcbJ+pE
         wU8GZaQe4rPlSkW77wLh96Z7dLRrwwHVPCUniz2mULvjy6gJQGU+QLTirb0sQlS+Mukz
         d3PT52liy2DZn2pZ2Wclxck9ANhkNSWvkKrHmRDU/Hh8NjST9EhPn/Pa9cfT3p1v4/Fc
         F3/bNYdGae64af0CgpAzgRWXJIkdFk3/2a+3q3smYUGIi2EVOZ0lmlne8NIHjFegHrpr
         /7KjuclHUJ6dCqDcKRG6HhZNSTFmzd/exXPEQqcBwNBn83/9T6TmpkvvDl/rz4Iaa47t
         FFXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zE2z9ZmoSow3TeMIqIBigCU2Me0fYD6QSgdCFPJ3aJ8=;
        b=PP0VMTIfBhLUKpaRG0rhrjYIoJNhau/FL84ammtbsxJQD3myoIFgSTDXfA/Z8HkLNk
         Kzjgn3IUcahP/ZYCo35/cqh78UpMzwFWVoaOtODMf12l3Ot88gajxj/eza3MM+5OKnYF
         +nQxQVATBIgm4wuefU355tlFD1RdlF9kIiCLIPsAJQq+8FtRlrC9n6PuSQulJzyW1oUx
         yLDryAUahigHgxWXA6aVunhQ4RI1X4Mu+0eoOvQiR+rA+1uGkGdze6VzyHKfPk8oxgrt
         4ev7myBeX8VCPUJgLpFXp+CBS+h78Tp5Ue2nGUVlzKdl9IrBIWJsyMQQzck/qFam+DIQ
         A0OA==
X-Gm-Message-State: AJIora/+X9NHCykX+jlgpMHYWiveAmblsrUyQnFqMzt+lWANVJbKBsyl
        KQRn/mQRiNRcrPmPUY2zwyk61w==
X-Google-Smtp-Source: AGRyM1sxYCJ0OpJM+rYctfIjl5IVWDpUV0f1KzgaqznNwWgblc+rG/t8GuV8sEnybowbkCRRufivqQ==
X-Received: by 2002:a05:6214:f62:b0:46a:471a:dc8c with SMTP id iy2-20020a0562140f6200b0046a471adc8cmr1479665qvb.124.1655168629734;
        Mon, 13 Jun 2022 18:03:49 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id t67-20020a379146000000b006a71c420460sm7541965qkd.22.2022.06.13.18.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 18:03:49 -0700 (PDT)
Date:   Mon, 13 Jun 2022 21:03:47 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     git@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>,
        Pavel Rappo <pavel.rappo@gmail.com>
Subject: Re: [PATCH] remote: handle negative refspecs in git remote show
Message-ID: <Yqfec9yvT3LKomNK@nand.local>
References: <20220614003251.16765-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220614003251.16765-1-jacob.e.keller@intel.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 13, 2022 at 05:32:51PM -0700, Jacob Keller wrote:
> Fix this by checking negative refspecs inside of get_ref_states. For
> each ref which matches a negative refspec, copy it into a "skipped" list
> and remove it from the fetch map. This allows us to show the following
> output instead:

Seems sensible.

> +	/* handle negative refspecs first */
> +	for (tail = &fetch_map; *tail; ) {
> +		ref = *tail;
> +
> +		if (omit_name_by_refspec(ref->name, &states->remote->fetch)) {
> +			string_list_append(&states->skipped, abbrev_branch(ref->name));
> +
> +			/* Matched a negative refspec, so remove this ref from
> +			 * consideration for being a new or tracked ref.
> +			 */
> +			*tail = ref->next;
> +			free(ref->peer_ref);
> +			free(ref);
> +		} else {
> +			tail = &ref->next;
> +		}
> +	}
> +

Not being overly familiar with the "git remote show" code, this
implementation looks very reasonable to me. If we see a negative
refspec, we remove it from the fetch_map list and append it to the
skipped list. Otherwise, we increment our pointer, and continue along
until we reach the end of the list.

> diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
> index fff14e13ed43..e19b8d666c73 100755
> --- a/t/t5505-remote.sh
> +++ b/t/t5505-remote.sh
> @@ -302,6 +302,33 @@ test_expect_success 'show' '
>  	)
>  '
>
> +cat >test/expect <<EOF
> +* remote origin
> +  Fetch URL: $(pwd)/one
> +  Push  URL: $(pwd)/one
> +  HEAD branch: main
> +  Remote branches:
> +    main     skipped
> +    side     tracked
> +    upstream stale (use 'git remote prune' to remove)
> +  Local branches configured for 'git pull':
> +    ahead merges with remote main
> +    main  merges with remote main
> +  Local refs configured for 'git push':
> +    main pushes to main     (local out of date)
> +    main pushes to upstream (create)
> +EOF
> +
> +test_expect_success 'show with negative refspecs' '
> +	test_when_finished "git -C test config --fixed-value --unset remote.origin.fetch ^refs/heads/main" &&
> +	(
> +		cd test &&
> +		git config --add remote.origin.fetch ^refs/heads/main &&

Doing "git config --unset" outside of the subshell could be avoided by
ditching the subshell altogether, perhaps with something like:

    test_config -C test remote.origin.fetch ^refs/heads/main &&
    git -C test remote show origin >actual &&
    test_cmp test/expect actual

Thanks,
Taylor
