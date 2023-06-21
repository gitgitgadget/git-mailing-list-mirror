Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 532C3EB64D7
	for <git@archiver.kernel.org>; Wed, 21 Jun 2023 11:49:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjFULtY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jun 2023 07:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbjFULtX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2023 07:49:23 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A093810DB
        for <git@vger.kernel.org>; Wed, 21 Jun 2023 04:49:22 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-56fff21c2ebso62110527b3.3
        for <git@vger.kernel.org>; Wed, 21 Jun 2023 04:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1687348162; x=1689940162;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RDZ1kRlkB8b0HTTeBO7LtwaayE/L7sBcSPTbjsJStHQ=;
        b=fawqnji7fAFgExl1HSBqitx+bTjtG7tWupx7ekyAKKQJRIufoEZn1YRGhB7FIZcpPb
         zVsA0tacry+3gIVbUbB1cvwIRjYuLLTcW9o+joV6de/5VQRxV/RYZWDotaOkUOGCDUcL
         lJB/wGofIUH/LyKdINfeZlP7e+mWuF6XahlotOQECbWgg7dGLzkfl+7D4iGqls52OJew
         qy6RK8mVeOY35nQjy/QnCEYg8EBmuFcvpFfwG7HICm+Z8PKKrk/zw5aKXKJ6uyGWaXbD
         QcD9oBGnwbTfKlxf5GEMFbjtjyL6x911QNr7WQn78WuKxPXYeO3pRDL7oezjyMN8EuPX
         iaXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687348162; x=1689940162;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RDZ1kRlkB8b0HTTeBO7LtwaayE/L7sBcSPTbjsJStHQ=;
        b=VO5xBmX70ybzOtUaymC1wDO3hjxHx+8VZZdqTgc34XaSOmVpsE870VffSGxdfX87Kg
         naRBsD7pRemLGCT6TfvebX8Kkvo3CMsXO+i/mq1VU4rQMWY15XFnpsZ8u6ui+W7Zz8kS
         dyexk0zhws5NSi+CgcRpAeTPrvzuAKvJs6f63F4DNW7Wo5OQMIkMJW/uz1YXxgKZKVfT
         dXnVEoKJj3joVsQkRpIXE2Ec/63YKZ+I8WPMgwurevtIrDjoeMEo6rjvR5RjtUlVYXdh
         9n6zTZAq/Dki5tIgOUQca/bWOv/nXdITp90Eolu7QgVPyYmkgVmcVsvVrGwnTsHw5Kyj
         qAiQ==
X-Gm-Message-State: AC+VfDylg0BjmcMgoRT7+w/tkslKILnT0UMdZJowAPPVzvNyRPWIOeon
        Z4SAs8+IdkWg9z12+W+fvP/Ekal65lG7WjjYebvMgL3c
X-Google-Smtp-Source: ACHHUZ6lcfkR5l2X5zT+KhuIJ4CZUNBJN2xi9V51LwGXQULpSmsQnJbTlEGEN9BROZxbo+YzU/olAA==
X-Received: by 2002:a81:920c:0:b0:56f:ff88:2e43 with SMTP id j12-20020a81920c000000b0056fff882e43mr16164232ywg.27.1687348161810;
        Wed, 21 Jun 2023 04:49:21 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id q204-20020a815cd5000000b0057048db0898sm1060986ywb.138.2023.06.21.04.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 04:49:21 -0700 (PDT)
Date:   Wed, 21 Jun 2023 07:49:18 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 8/9] repack: implement `--filter-to` for storing filtered
 out objects
Message-ID: <ZJLjvhnh0lSRCVzG@nand.local>
References: <20230614192541.1599256-1-christian.couder@gmail.com>
 <20230614192541.1599256-9-christian.couder@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230614192541.1599256-9-christian.couder@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 14, 2023 at 09:25:40PM +0200, Christian Couder wrote:
> diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
> index aa29c7e648..070dd22610 100644
> --- a/Documentation/git-repack.txt
> +++ b/Documentation/git-repack.txt
> @@ -148,6 +148,12 @@ depth is 4095.
>  	resulting packfile and put them into a separate packfile. See
>  	linkgit:git-rev-list[1] for valid `<filter-spec>` forms.
>
> +--filter-to=<dir>::
> +	Write the pack containing filtered out objects to the
> +	directory `<dir>`. This can be used for putting the pack on a
> +	separate object directory that is accessed through the Git
> +	alternates mechanism. Only useful with `--filter`.

Here you say "only useful with --filter", but...

> @@ -1073,8 +1077,11 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
>  		strvec_push(&cmd.args, "--incremental");
>  	}
>
> -	if (po_args.filter)
> -		prepare_pack_filtered_cmd(&pack_filtered_cmd, &po_args, packtmp);
> +	if (po_args.filter) {
> +		if (!filter_to)
> +			filter_to = packtmp;
> +		prepare_pack_filtered_cmd(&pack_filtered_cmd, &po_args, filter_to);
> +	}

Would you want an "} else if (filter_to)" here to die and show the usage
message, since --filter-to needs --filter? Or maybe it should imply
--filter-to.

Thanks,
Taylor
