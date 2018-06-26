Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D4991F516
	for <e@80x24.org>; Tue, 26 Jun 2018 20:11:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932221AbeFZULo (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 16:11:44 -0400
Received: from mail-wr0-f178.google.com ([209.85.128.178]:38392 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932159AbeFZULn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 16:11:43 -0400
Received: by mail-wr0-f178.google.com with SMTP id e18-v6so18463761wrs.5
        for <git@vger.kernel.org>; Tue, 26 Jun 2018 13:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=rRllhFHxwMjUgh5N+5CDJMxpRAS02mi5udy2r1s7dvA=;
        b=O4Ne1aychjg7ZGXf2aiRlBJdD8zB2TpwlxLpfcYZScX64Tp32rV/bRADsM5TJf+K/6
         q/QLrbK2J0ykH0V1OzN4f4YJ2hDQy0V5LP33uR0rPu5OgXapla/TFEyiu2Ut4dCplXyH
         000lXmTlbYUJLVDMAPQxuj23P/8JsL+U486R9JvdYN+FTHgXlC/8bntEmpj3Kd7i16G/
         jWXdh37qblu1+y1bfDU/YvcnpvaUMecVRTmVZmOFkMqoPDBUnfszFYmEdxuMTB9x8pwP
         xisX6ax5alioY3MeiEt+CXAofQDnV/kCWhNSWCFo14STHu9USccOs8nqvsu+1zJ0qaKy
         3x2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=rRllhFHxwMjUgh5N+5CDJMxpRAS02mi5udy2r1s7dvA=;
        b=ct+admP1cpRWQY49w8wewp8xyFFEdNxQLlg1cpMbNOHJ7JngoGU9k/LnuxioNJBAwM
         F3SO1PQ1K5jLNLHnmVg1wDbWXCe98z/5gZJ33avJqwSf8ws3AeAJ2Rg36uMDOJOPlBBU
         ypuN8jLezvOk6u6BPVszXg5XmzWkUrex62WX4dj4wrtLFWmkPShkBnuwf9bhADtYO63F
         gkk+gtx+1udtIGVtbGV+vyO0WFbYa1oOQz+m9mYwp4HSpXXSiijWZwP1uQUUrFFzuNxP
         RvRbc+qLkfXurxUn09UWoSJItx8Va7V+9BS95kl6ras5FKOAA9JTaTU2V2kq53/3zJra
         Zh4w==
X-Gm-Message-State: APt69E2fYC79JMNc9G0/cjuvGQFeURX1gdvaxkJIWnvCp61yZfX+1INW
        RmNvnkKvxFXQa75RRBVSN+7ZK1VG
X-Google-Smtp-Source: AAOMgpcJzRMtTVbJZCCY4m/yg7lH6tVPa/lN8og/VMYP+r4MJjrcg+E8ATUoZqxepCgMsM+PJRqmRQ==
X-Received: by 2002:adf:9ac5:: with SMTP id a63-v6mr2567121wrc.110.1530043901958;
        Tue, 26 Jun 2018 13:11:41 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id l6-v6sm1782381wmh.41.2018.06.26.13.11.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Jun 2018 13:11:41 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Antonio Ospite <ao2@ao2.it>
Cc:     git@vger.kernel.org, Brandon Williams <bmwill@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/6] submodule-config: add helper function to get 'fetch' config from .gitmodules
References: <20180626104710.9859-1-ao2@ao2.it>
        <20180626104710.9859-3-ao2@ao2.it>
Date:   Tue, 26 Jun 2018 13:11:40 -0700
In-Reply-To: <20180626104710.9859-3-ao2@ao2.it> (Antonio Ospite's message of
        "Tue, 26 Jun 2018 12:47:06 +0200")
Message-ID: <xmqqfu19jojn.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Antonio Ospite <ao2@ao2.it> writes:

> Add a helper function to make it clearer that retrieving 'fetch'
> configuration from the .gitmodules file is a special case supported
> solely for backward compatibility purposes.
> ...

Then perhaps the new public function deserves a comment stating
that?

> +struct fetch_config {
> +	int *max_children;
> +	int *recurse_submodules;
> +};
> +
> +static int gitmodules_fetch_config(const char *var, const char *value, void *cb)
> +{
> +	struct fetch_config *config = cb;
> +	if (!strcmp(var, "submodule.fetchjobs")) {
> +		*(config->max_children) = parse_submodule_fetchjobs(var, value);
> +		return 0;
> +	} else if (!strcmp(var, "fetch.recursesubmodules")) {
> +		*(config->recurse_submodules) = parse_fetch_recurse_submodules_arg(var, value);
> +		return 0;
> +	}
> +
> +	return 0;
> +}
> +
> +void fetch_config_from_gitmodules(int *max_children, int *recurse_submodules)
> +{
> +	struct fetch_config config = {
> +		.max_children = max_children,
> +		.recurse_submodules = recurse_submodules
> +	};

We started using designated initializers some time ago, and use of
it improves readability of something like this ;-)

> +	config_from_gitmodules(gitmodules_fetch_config, &config);
> +}
> diff --git a/submodule-config.h b/submodule-config.h
> index 5148801f4..cff297a75 100644
> --- a/submodule-config.h
> +++ b/submodule-config.h
> @@ -66,4 +66,6 @@ int check_submodule_name(const char *name);
>   */
>  extern void config_from_gitmodules(config_fn_t fn, void *data);
>  
> +extern void fetch_config_from_gitmodules(int *max_children, int *recurse_submodules);
> +
>  #endif /* SUBMODULE_CONFIG_H */
