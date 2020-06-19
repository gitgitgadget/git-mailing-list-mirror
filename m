Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4971FC433DF
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 14:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 208C5208C7
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 14:24:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HfTeySg2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733132AbgFSOYe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 10:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbgFSOYc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jun 2020 10:24:32 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DDA9C06174E
        for <git@vger.kernel.org>; Fri, 19 Jun 2020 07:24:32 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id o11so2169260wrv.9
        for <git@vger.kernel.org>; Fri, 19 Jun 2020 07:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hGPkYGcJm3yXpCBLPc/hFItc1ZVEOGY5kgIlsHVFyaw=;
        b=HfTeySg20rbly0IIHOE+i+b0PqMMj3UXXqYN+pgCbo47XFcGB2cxodZGR0Z6vL216U
         JSPxNiMN4J2nt5YqxR5wecewPHhnk8p6AQtKdimYw/HSKKyeb0B8Q4XY8GDkLtfsS+2U
         5lnjkDKRkafkd9Y+cFz3FdEW/AXlCdIDNsGCc8myPq/j7RaYR0yNkTob1wt159FeXvFf
         NIVq8sHfLqVjIoX+y+nd3DeDODum+xMVPAkx+vtC0ehGtH0vyfCjwNl76U7iu4ez+15j
         FaLcotzXY7E7mRas9Fm2DpuGJ+m3P0J5nB+q6o/FLELHFGOD0kD36VyvCDMe+GT2xO6L
         0TDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hGPkYGcJm3yXpCBLPc/hFItc1ZVEOGY5kgIlsHVFyaw=;
        b=Xk13xpgH99uT3UH8ykaCvyw2UOan/jVaNdHKsqi+jFNgDvMrUXXIOQ8kf9tQVT7Q+y
         Xal4XQtDbBZdfA7O0uRjN5tWHxEvMX88I3Lrut09+0wRghnmmaU2S+sNWmtQ4fg9ja/i
         A6HPVkhOEJqh610lpxkL1lSW21actjy0pxpZ4UkiW51WWYL23GJ4qvPum3ohG4x6K67q
         PUPjq5DMBV2+cbJ7rFyXq1QbzzCxDJIVc7jzYbCo4RKirGQrd+tFhHTEDDert4PfXoLZ
         DBJzEox0Apn3wujBVVA3QXuIEEfXhWl3rr+sksrbohmXgJbl4hnKXTkxCNUuVDS65xQN
         xIAw==
X-Gm-Message-State: AOAM530s/6ZFW12QrazZ02xiiiOwAMfoWN970dbq+bW+Nhp9E05d87mx
        Pi+tr+RyVe8h9uDvxrT6gBI=
X-Google-Smtp-Source: ABdhPJzth1mWLipu8ZjWTKvcytfykCCLFNa8pTHbAWfsU9TDZ+3SwBBjfK4Vdl4yzWoK3UlqrCOskg==
X-Received: by 2002:a5d:468d:: with SMTP id u13mr4648346wrq.73.1592576671251;
        Fri, 19 Jun 2020 07:24:31 -0700 (PDT)
Received: from szeder.dev (62-165-236-97.pool.digikabel.hu. [62.165.236.97])
        by smtp.gmail.com with ESMTPSA id g82sm7148320wmf.1.2020.06.19.07.24.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Jun 2020 07:24:30 -0700 (PDT)
Date:   Fri, 19 Jun 2020 16:24:28 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v17 12/17] Reftable support for git-core
Message-ID: <20200619142428.GG2898@szeder.dev>
References: <pull.539.v16.git.1591380199.gitgitgadget@gmail.com>
 <pull.539.v17.git.1592335242.gitgitgadget@gmail.com>
 <e1b019274545f36949d73436e23e6f292433b922.1592335243.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e1b019274545f36949d73436e23e6f292433b922.1592335243.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 16, 2020 at 07:20:37PM +0000, Han-Wen Nienhuys via GitGitGadget wrote:
> +static int reftable_init_db(struct ref_store *ref_store, struct strbuf *err)
> +{
> +	struct git_reftable_ref_store *refs =
> +		(struct git_reftable_ref_store *)ref_store;
> +	struct strbuf sb = STRBUF_INIT;
> +
> +	safe_create_dir(refs->reftable_dir, 1);
> +
> +	strbuf_addf(&sb, "%s/HEAD", refs->repo_dir);
> +	write_file(sb.buf, "ref: refs/.invalid");

The "Backward compatibility" section of the specs says:

  * `.git/HEAD`, a regular file containing `ref: refs/heads/.invalid`.

not "refs/.invalid".

> +	strbuf_reset(&sb);
> +
> +	strbuf_addf(&sb, "%s/refs", refs->repo_dir);
> +	safe_create_dir(sb.buf, 1);
> +	strbuf_reset(&sb);
> +
> +	strbuf_addf(&sb, "%s/refs/heads", refs->repo_dir);
> +	write_file(sb.buf, "this repository uses the reftable format");
> +
> +	return 0;
> +}
