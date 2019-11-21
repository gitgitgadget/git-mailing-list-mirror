Return-Path: <SRS0=oq1W=ZN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30147C432C0
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 11:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05000208CC
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 11:49:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h0Pdrvnb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbfKULtp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Nov 2019 06:49:45 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46444 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727123AbfKULtl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Nov 2019 06:49:41 -0500
Received: by mail-wr1-f65.google.com with SMTP id z7so604720wrl.13
        for <git@vger.kernel.org>; Thu, 21 Nov 2019 03:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uPijQdoNv8fk3ugb+ljbh77ESM5I+sKVMByC7NejsI0=;
        b=h0PdrvnbzkwAs9qjjlUCY63v+bIO6+iiVQ5sD08gdbbv+XABeus+1xO142nb40L4sx
         L4c9ZGE1U72/doZnuOe/vh+EkB+sCEHbVdx/tQE0ur5PaBIvjaigl0w9jBNvJnkAtOzT
         0/Spn3sOON146DHgYL9uYSYtdyPxlAe/UFvd5QgsYyeN9tixsxE5BLaRVH0bjKAPEOrY
         myNtxIARD/Fy3KFIGMoJ3LfdnoL430Nfh3LTfJlJINllNV5fklvRG715ppFEPMOqTwQL
         +8iNkWBsj14qx9yWfmtqFz3h/hJDDpcBBbXWFqhCXR7cloICA00F3VcFjIofHgOmyTyE
         z+Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uPijQdoNv8fk3ugb+ljbh77ESM5I+sKVMByC7NejsI0=;
        b=K9xqAkfdythQq+o/1Wjsvg0dvo/MB96H7bya7ItLLoicsRfBCeoX2JgNjpnITz/nyj
         r6ZAZRlVbGtlCIDcx30t3HNGIiYHVXlqUBxnnoXw7wXC4kn0tqenektGkN6xSUiNZugL
         jgOKU04yovHdRrWh7c23CRoH64hgZNkpQXQ1bMoRovxAa+rNz1ahmyM3r/PdeSqiQxQC
         FB7bjy2hi0eSpccQZGNYOuz357LouR5wvMKFyrFXLo2kITwTPkXjWoAVUUBamwquoDBv
         VV7IFZPqwo6H0/fJ/vib/QYbExlnid1T36YO1nSXAHxvvqh2/oICGllk5i/PfIoTKsjd
         tFsA==
X-Gm-Message-State: APjAAAVfkFTcwo7daLUH9gCbIe/Rki+6Nme4vqb8MqEmDT0dmS3rQ4fd
        OxA5SMk4AhRHelJrI4v8iBsjSiD8
X-Google-Smtp-Source: APXvYqy4awOC7jCa82qKfV7fKk4cMGWHYIxhaT/wHpavk1dcP8YdwXOAoZkZSi6fD4xniPLDwZwpCQ==
X-Received: by 2002:adf:de0a:: with SMTP id b10mr10261516wrm.268.1574336979658;
        Thu, 21 Nov 2019 03:49:39 -0800 (PST)
Received: from szeder.dev (x4db6680d.dyn.telefonica.de. [77.182.104.13])
        by smtp.gmail.com with ESMTPSA id b8sm2994205wrt.39.2019.11.21.03.49.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Nov 2019 03:49:38 -0800 (PST)
Date:   Thu, 21 Nov 2019 12:49:36 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com, jon@jonsimons.org,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 02/17] sparse-checkout: create 'init' subcommand
Message-ID: <20191121114936.GR23183@szeder.dev>
References: <pull.316.v4.git.1571147764.gitgitgadget@gmail.com>
 <pull.316.v5.git.1571666186.gitgitgadget@gmail.com>
 <a161cee0dfec76e7a08253083f488e2e6d26299e.1571666186.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a161cee0dfec76e7a08253083f488e2e6d26299e.1571666186.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 21, 2019 at 01:56:11PM +0000, Derrick Stolee via GitGitGadget wrote:
> Getting started with a sparse-checkout file can be daunting. Help
> users start their sparse enlistment using 'git sparse-checkout init'.
> This will set 'core.sparseCheckout=true' in their config, write
> an initial set of patterns to the sparse-checkout file, and update
> their working directory.

Enabling sparse-checkout can remove modified files:

  $ mkdir dir
  $ touch foo dir/bar
  $ git add .
  $ git commit -m Initial
  [master (root-commit) ecc81bd] Initial
   2 files changed, 0 insertions(+), 0 deletions(-)
   create mode 100644 dir/bar
   create mode 100644 foo
  $ echo changes >dir/bar
  $ ~/src/git/git sparse-checkout init
  error: Entry 'dir/bar' not uptodate. Cannot update sparse checkout.
  error: failed to update index with new sparse-checkout paths
  $ cat dir/bar 
  changes

So far so good, my changes are still there.  Unfortunately, however:

  $ git add -u
  $ ~/src/git/git sparse-checkout init
  $ echo $?
  0
  $ ls
  foo

Uh-oh, my changes are gone.

