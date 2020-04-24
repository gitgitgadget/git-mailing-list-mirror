Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0107C54FD0
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 17:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B560A2071E
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 17:13:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="opi/wutz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728816AbgDXRND (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 13:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbgDXRND (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Apr 2020 13:13:03 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C291C09B047
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 10:13:03 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id e6so4121346pjt.4
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 10:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=I4geT3lgaNpq6+7glMMGjgOvHU8fH82bW1cJrYoMFA0=;
        b=opi/wutzr2BpIQNwIxm2ttijwIki7xPRDsPyLkEcehUzS4+M6WhI60/wjC5GERdz6x
         F8BXEBf1QPQqvkO/NYqBm0N2Mhxmc09aHzdNtKmu1MMFbyIuHaaWoD94G2pSJKjwspaa
         aLqKa7oaNVq7cCkpJx4PCJzl9cXAdx5T5kQLMwvhqItySgdnPN2HypOUTMSODuoZAGtg
         MRQ5ECXH6VbxVWt8r3JfAtZnhDjKLiTglvD2wtjgN5G2f5BUeyEoIIn23jOSMInTFAEI
         ZmvMftskrctHZGV7oF50c1g76xXx55sLhehH4BGzYQ0MvrtcLUTohamLBHmSTzxWxFAr
         Dr0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=I4geT3lgaNpq6+7glMMGjgOvHU8fH82bW1cJrYoMFA0=;
        b=J1vl+PuhrwbYshBnBalvPRMfli+CGmxTG11tvaIPnhYiu44tRQB0gwP+uuAxIgPVxP
         Dx8wYo5m3arK0gVCXUYKIV25iZ4BZsIjr3SZYBY1xAVHiisOXLHMueUjkcYIJouoQyqS
         3aoJoVkGkvOVmDele+C1aQ1RBakRpo0OQ1BxnxPChnI3TgbPtbXv7LdhAbgQ44Z62l0o
         oURPPcg+/fdMXzuer4u/+6JMrRVKeCbsS9isWQqirNr5cJY/ex8+QchYIKFleKvlY7HN
         AC3OSigbhHvXI7qjNe8iLrANmnZ15cTNpVMq1vMAgVXaB8t8BcmdGMUkxVW642KpNDuJ
         k1/Q==
X-Gm-Message-State: AGi0PuaRGY0YeDJ0Xcz4fb8XiifyFIvMsna40HRa85AB/hUll6Rllj4e
        E31izQdF03uLEoWHHwhm/994CA==
X-Google-Smtp-Source: APiQypKTEDBHpiFirs9orbxouFDTkbOwtYMbIe03Zz8Ln492Pi48qfqcO3JYbtuWCwAuVSVH9jmx9Q==
X-Received: by 2002:a17:90a:fc8a:: with SMTP id ci10mr7161716pjb.152.1587748382949;
        Fri, 24 Apr 2020 10:13:02 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id g22sm5051447pju.21.2020.04.24.10.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 10:13:02 -0700 (PDT)
Date:   Fri, 24 Apr 2020 11:13:01 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, me@ttaylorr.com,
        git@vger.kernel.org, newren@gmail.com
Subject: Re: [PATCH v2 2/2] shallow.c: use '{commit,rollback}_shallow_file'
Message-ID: <20200424171301.GB61470@syl.local>
References: <296e70790d7a391d471554b0bc5a58e2a091ce88.1587601501.git.me@ttaylorr.com>
 <20200423180905.195407-1-jonathantanmy@google.com>
 <xmqqr1weey0g.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr1weey0g.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 23, 2020 at 01:40:47PM -0700, Junio C Hamano wrote:
> Jonathan Tan <jonathantanmy@google.com> writes:
>
> >> Replace each instance of 'commit_lock_file' and 'rollback_lock_file'
> >> with 'commit_shallow_file' and 'rollback_shallow_file' when the lock
> >> being held is over the '.git/shallow' file.
> >
> > I think Jonathan Nieder already covered 1/2 so I'll just close the loop
> > on this patch. There was one potential issue in that a previous version
> > of this patch also called reset_repository_shallow() in
> > setup_alternate_shallow(), but this version does not. But after looking
> > into it, this looks fine - setup_alternate_shallow() deals with a
> > passed-in alternate_shallow_file variable, which is different from the
> > r->parsed_objects->alternate_shallow_file that is_repository_shallow()
> > uses to set the global variables. (I might have confused the two during
> > earlier reviews.) Also, setup_alternate_shallow() is called either
> > before any shallow processing (empirically demonstrating that no
> > resetting is needed in this case, because it has been working), or right
> > before a commit or rollback of the lock file (so the global variables
> > are being reset anyway, so we do not need to call
> > reset_repository_shallow()).
> >
> > So,
> > Reviewed-by: Jonathan Tan <jonathantanmy@google.com>
>
> Thanks for a review.
>
> And of course, thanks Taylor.  Will queue.

Thanks, both. I'll send some more patches on top to introduce a
'shallow_lock' type.

Thanks,
Taylor
