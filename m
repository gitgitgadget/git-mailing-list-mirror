Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B242C433C1
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 00:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0FF761929
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 00:02:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbhC3AB5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 20:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbhC3ABX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 20:01:23 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213A3C061762
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 17:01:23 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id lr1-20020a17090b4b81b02900ea0a3f38c1so379858pjb.0
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 17:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=GpJd1TpaSoTuituiM3fi+MUywKYpdUcvrWgM3tgJt/g=;
        b=uqgtL6Jbz6h8VsPQZNabif/+8GjEA3ZRw5E8MNzTsz6jpCidVRooU/ay0XOv7mh2JN
         4/96SwujVN4ySCnjtxNQv298M5Nu6JzgDq9uegZY+w1e66UtkIWc2l/3gzzqFHzOYCY9
         Th2v7Ux3C6HLVx8r/pjy/QtCkf6vPCK3nsKZZ1iqWTfbsO/K6RMJy84uuBN+vCLbgTVi
         ZEbhXI5tQdk3KlnP5aIJBkS3BnPlAg7pwEyK8jpkqG6It322gzW6ETSrjZYzobjo2hek
         0dLSRywj4Gg1G9WEXkWMKi1R+PmBHhT1aPuy3YzEzY40JiHJAUWbzxmUaJU5fPj51nox
         bLpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=GpJd1TpaSoTuituiM3fi+MUywKYpdUcvrWgM3tgJt/g=;
        b=QD/qL6kJ8rcEdOo3JffcvEEPCbWBYyJ59M2tSTk7pPCKEUcBhJigFLRvrpQxaUD15t
         UzOK+RbyJ+Ry7mP6RYYAUMArcH+ocQAgJlCV3d36v4PrC+TA7M3onXu547iM5HzbYNKF
         TAaqlq2iPUtwHf/5L+KsupH5DG/AhPWb6j4Pba5ZMMQRWExh8sRai5mrt61sH2FUBm9S
         nWnZUu+Tln+76GPNEyIq14TtHkRfabzGv76G1t2lhA3NqXyb0vMUndUv1ZDetKBeVB40
         8AcSow6ErOrTxFK8ZBZD0fkeotrRUZlVlUuhZyD+1kLZpFdL89DeGTV5kBT/1pGepAay
         ixvQ==
X-Gm-Message-State: AOAM533Ro3+uE+vaI/2XJNMZadiJjKEATXCN7e6TjWs+aKr1ZDJbmXET
        y3V6Tm/G1NeiZdIIo6XAgThU+Q==
X-Google-Smtp-Source: ABdhPJw+fyyPVegMxvk9iPgHLXnv8+Na/MG4YNxo0CBqvHZqJ/AaqrgP4KVKlG2/IjNCRiDjPRhJkQ==
X-Received: by 2002:a17:90a:bb02:: with SMTP id u2mr1535018pjr.175.1617062482568;
        Mon, 29 Mar 2021 17:01:22 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:282c:288a:2054:f194])
        by smtp.gmail.com with ESMTPSA id a21sm18225684pfk.83.2021.03.29.17.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 17:01:21 -0700 (PDT)
Date:   Mon, 29 Mar 2021 17:01:16 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v8 32/37] post-update: use hook.h library
Message-ID: <YGJqTIjxm3e4GXcQ@google.com>
References: <20210311021037.3001235-1-emilyshaffer@google.com>
 <20210311021037.3001235-33-emilyshaffer@google.com>
 <871rckhgy0.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <871rckhgy0.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 12, 2021 at 10:14:31AM +0100, Ævar Arnfjörð Bjarmason wrote:
> 
> 
> On Thu, Mar 11 2021, Emily Shaffer wrote:
> 
> > By using run_hooks() instead of run_hook_le(), 'post-update' hooks can
> > be specified in the config as well as the hookdir.
> 
> Looking ahead in the series no tests for this, seems like a good thing
> to have some at least trivial tests for each hook and their config
> invocation.

I'll look through the series and make sure the hooks being converted
have at least some test to make sure they worked; I think I checked that
for some of the early ones but got lazy :) I'll try and add some
config-specified tests too. Thanks, it's on my todo list.

 - Emily
