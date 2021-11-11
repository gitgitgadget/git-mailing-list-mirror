Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6207C433F5
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 00:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CC6F6103C
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 00:18:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbhKKAU6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Nov 2021 19:20:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbhKKAU5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Nov 2021 19:20:57 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5E0C061766
        for <git@vger.kernel.org>; Wed, 10 Nov 2021 16:18:08 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id y5so4073214pfb.4
        for <git@vger.kernel.org>; Wed, 10 Nov 2021 16:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Kn8XLDS2X7FU11QOXWHHwQ8z/NdiTyq80miD1lXkefs=;
        b=Rg0qEnlQaM4J9DFlCq4V2c6hlnq1ujYyIoyqW58q7fippU/D/+YWvV3WT0nsehFLLZ
         y9Q2Hy8osCJlVPN5jQxvTlEKSDVEKqfXKXLMAooBvRV/aWJscnHboGxnUYYuSDraqgfK
         57EBjVocnPJhbrVm7WyDYaoLyu9pcP3z9tk+xJMWZglP2UoKJNHXUwHuNyWLO+8zm2KO
         av7BWG/aWMgW6OUHh80r0m1tlNanNg5rDmvHqaY7Cp5oHlppLsW2QCrgkgY4cD3hHxSI
         otLxpeLxb9hFeJqwEgCnf2P+VYIMlPqWw+WcCe1WDUEuRfTH8FDhu6mdDsP27CCgYktr
         pi5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Kn8XLDS2X7FU11QOXWHHwQ8z/NdiTyq80miD1lXkefs=;
        b=2mcQbsMEbCYdwjJMqMDGgjRep1phi0fj6c0JwiQXGWQSbzsgexcXICT6KzLE8fOVPK
         DGnIf0Lg9D8vHn+Qr0dMYbqJwAEGzW+GSHN6ZB4NwIjMoAecO6ebvn22bXaLV2fbCKHe
         tsAsCvW3V6JVLZKl9opCGTEeoeP4XcdDZHRgsM2T7zIkxPCBc8uULablNB8dMcRaNIeR
         KDRMyUWfrvRsMu7CH78pq/+irv9tzzx1S8cOyapW7xIjEHbZDK1bZ/LTm/iogbaftIbV
         FZyJTMhsslrKfsjX5nso1enwZKqjD6f79aUXIJQRIggLvHJqCHBQL3rG3YAWJ4+8rrnM
         hWBg==
X-Gm-Message-State: AOAM531vAvjqNgIhS/g7tmGiJkNOHyNMpTi59nAIQ34nxkRv055f/NG+
        IWfyjpI7A+WQ/Qh1leBCLWI=
X-Google-Smtp-Source: ABdhPJzVWYKtkN2Ch/J9K5E9j+JMywKkVPVmkK+fV8MJxJZdcH1gphKqzYrhbQYXSvNWJt+V6eJ2BA==
X-Received: by 2002:a05:6a00:1a51:b0:4a0:3c1:4f45 with SMTP id h17-20020a056a001a5100b004a003c14f45mr2885248pfv.86.1636589888282;
        Wed, 10 Nov 2021 16:18:08 -0800 (PST)
Received: from neerajsi-x1.localdomain (c-24-56-226-231.customer.broadstripe.net. [24.56.226.231])
        by smtp.gmail.com with ESMTPSA id e15sm734806pfv.131.2021.11.10.16.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 16:18:07 -0800 (PST)
Date:   Wed, 10 Nov 2021 16:18:03 -0800
From:   Neeraj Singh <nksingh85@gmail.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Subject: Re: [PATCH v2 3/3] refs: add configuration to enable flushing of refs
Message-ID: <20211111001803.GA787@neerajsi-x1.localdomain>
References: <dd65718814011eb93ccc4428f9882e0f025224a6.1636029491.git.ps@pks.im>
 <cover.1636544377.git.ps@pks.im>
 <d9aa96913b1730f1d0c238d7d52e27c20bc55390.1636544377.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d9aa96913b1730f1d0c238d7d52e27c20bc55390.1636544377.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 10, 2021 at 12:41:03PM +0100, Patrick Steinhardt wrote:
>  
> +static int sync_loose_ref(int fd)
> +{
> +	switch (fsync_ref_files) {
> +	case FSYNC_REF_FILES_OFF:
> +		return 0;
> +	case FSYNC_REF_FILES_ON:
> +		return git_fsync(fd, FSYNC_HARDWARE_FLUSH);
> +	case FSYNC_REF_FILES_BATCH:
> +		return git_fsync(fd, FSYNC_WRITEOUT_ONLY);
> +	default:
> +		BUG("invalid fsync mode %d", fsync_ref_files);
> +	}
> +}
> +
> +#define SYNC_LOOSE_REF_GITDIR    (1 << 0)
> +#define SYNC_LOOSE_REF_COMMONDIR (1 << 1)
> +
> +static int sync_loose_refs_flags(const char *refname)
> +{
> +	switch (ref_type(refname)) {
> +	case REF_TYPE_PER_WORKTREE:
> +	case REF_TYPE_PSEUDOREF:
> +		return SYNC_LOOSE_REF_GITDIR;
> +	case REF_TYPE_MAIN_PSEUDOREF:
> +	case REF_TYPE_OTHER_PSEUDOREF:
> +	case REF_TYPE_NORMAL:
> +		return SYNC_LOOSE_REF_COMMONDIR;
> +	default:
> +		BUG("unknown ref type %d of ref %s",
> +		    ref_type(refname), refname);
> +	}
> +}
> +
> +static int sync_loose_refs(struct files_ref_store *refs,
> +			   int flags,
> +			   struct strbuf *err)
> +{
> +	if (fsync_ref_files != FSYNC_REF_FILES_BATCH)
> +		return 0;
> +
> +	if ((flags & SYNC_LOOSE_REF_GITDIR) &&
> +	    git_fsync_dir(refs->base.gitdir) < 0)
> +		return -1;
> +
> +	if ((flags & SYNC_LOOSE_REF_COMMONDIR) &&
> +	    git_fsync_dir(refs->gitcommondir) < 0)
> +		return -1;
> +
> +	return 0;
> +}
> +

Now that I understand it better, I agree with Ævar's feedback. I think
only a single sync is needed to cover everything in .git/. 

I'd also suggest renaming 'sync_loose_refs' to something which makes
it clearer that it's the batch-flush step. Maybe s/do_batch_fsync/do_batch_objects_fsync
and s/sync_loose_refs/do_batch_refs_fsync.

Thanks
Neeraj
