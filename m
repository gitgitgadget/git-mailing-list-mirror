Return-Path: <SRS0=05is=6N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC4CC83004
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 18:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9700A20661
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 18:49:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="wwi+9Rof"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgD2StO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 14:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726456AbgD2StO (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Apr 2020 14:49:14 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A597C03C1AE
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 11:49:13 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id n24so1150632plp.13
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 11:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qlRUR9igMrOCZWXjSOr29Tr92I9EDgR6SjxrCrxIjlg=;
        b=wwi+9RofWMVgL3Pz6fuL/oGZfHxUY1qlcmJ//qjJzZou7hr1YzH7GFdJJj12baPtMA
         I29wqQgLg2FzRr+qMcSmmvUGp7wR8EjE9SxZsvRNVTjx6jO2HEoZgsnEilXIp2zKj2vZ
         DIO4z6UhOn4Yns5lOeW+cwiQ20mXm7UiK2x4HBlO5g668eCIQEtnDgx1m4es63gxmlxD
         dqsm2HMMk4vvoMgPIlPBjQiwc7wxf1+PIMbzg2rlSYx4XXPXbIe6Hi0DLcrIvaHDgCkr
         JFkJGYenWhyVY/oKG4hiy5ouQVWoO21etvEAGPJ9j/fFxR5+tnu0SR+6QpqRxt/jBSRX
         acxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qlRUR9igMrOCZWXjSOr29Tr92I9EDgR6SjxrCrxIjlg=;
        b=U1txERM3/2UMPDrY9/wbv/RLsx6YX19nl0xNwh7RcawC6WFuuxHPoGC0xIRlW7x22I
         XT2kGPY+lT299Do5vbrl/zfph0BaIqD+d1+nzytrLJKmQsDd9T3mmctQPmfyz9KNGuZd
         C/NPJAEXAjhHVX+FMg/5X+THpsXXZLQ11LfVRycfWe7Ga7Ik845Ee6Qhr4apvBTZCK0T
         Nq47uFmsHHw8kUD2w62DnHbKL90g57zwB44v1RtlCALrFKYSmNqIsEg+EnetqGojgISx
         hL6R1VWWOLDgSQZwQZ/b5OB2WmAP3T7MnWrOd5envK97nLcG/OQ+RBX/7PGJdwwqg186
         CY5w==
X-Gm-Message-State: AGi0PubGVYJQMgbvF/aUi4SzXvGMOMcoot7LasfNIUNjMRVGF2+TeH+g
        Hin96Z0LJlK0ZohsAQonwTzoow==
X-Google-Smtp-Source: APiQypIow8YE7fdE/ZpcqNZ9MD39amzoCSGi3DHBSTMAQ8eGJu2Yi5mLUh2eRMH/ZZatFA3qsfqHpg==
X-Received: by 2002:a17:902:8a88:: with SMTP id p8mr34999157plo.134.1588186152368;
        Wed, 29 Apr 2020 11:49:12 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id 67sm1656571pfx.108.2020.04.29.11.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 11:49:11 -0700 (PDT)
Date:   Wed, 29 Apr 2020 12:49:09 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Doug Glidden <41mortimer@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git fast-export not preserving executable permissions?
Message-ID: <20200429184909.GE83442@syl.local>
References: <CAHTRwmjXXYAU_LTBF_9sX1CXFnGyHsu5_KHuCp1rB76-4zn=Gg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHTRwmjXXYAU_LTBF_9sX1CXFnGyHsu5_KHuCp1rB76-4zn=Gg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Doug,

On Wed, Apr 29, 2020 at 09:36:31AM -0400, Doug Glidden wrote:
> Hello Git world!
>
> I have run into an issue that I cannot seem to resolve with git
> fast-export. When running a fast-export on a repo that contains
> scripts with executable permissions (e.g. a gradlew script), the
> resulting export does not properly reflect the executable permissions
> on the script files.

Interesting. fast-import and fast-export both understand executable
modes (although Git only understands the modes 644 and 755 for blobs),
so this should be working.

I can not reproduce the issue as-is. Round-tripping a fast-import and
fast-export preserves executable bits for me:

  #!/bin/bash

  set -e

  rm -rf repo client

  git init -q repo
  git init -q client

  (
    cd repo
    printf "x" >x
    printf "y" >y
    chmod +x x
    git add x y
    git commit -q -m "initial commit"
  )

  git -C repo fast-export HEAD | git -C client fast-import

  diff -u <(git -C repo ls-tree HEAD) <(git -C client ls-tree HEAD)

> To illustrate this issue, I created a small sample repo, with one
> executable file and one non-executable file. From the output below,
> you can see that the mode in the output from fast-export is the same
> for both files; according to the documentation for fast-import, the
> mode for the executable file should be 100755 instead of 100644.
>
>     $ ls -gG
>     total 2
>     -rwxr-xr-x 1 106 Apr 29 09:13 executable_script.sh*
>     -rw-r--r-- 1  63 Apr 29 09:12 non_executable_file.txt
>
>     $ git fast-export --all
>     blob
>     mark :1
>     data 106
>     #!/bin/bash
>
>     # This is a shell script that should be executable.
>     echo 'The script executed successfully!'
>
>     blob
>     mark :2
>     data 63
>     This file is a simple text file that should not be executable.
>
>     reset refs/heads/dev
>     commit refs/heads/dev
>     mark :3
>     author Doug <41mortimer@gmail.com> 1588167102 -0400
>     committer Doug <41mortimer@gmail.com> 1588167102 -0400
>     data 25
>     Adding some sample files
>     M 100644 :1 executable_script.sh
>     M 100644 :2 non_executable_file.txt
>
> Please let me know if there is any further information I can provide
> about this issue.

Does Git think that the file is executable? Please run 'git ls-tree
HEAD' to find out.

> Thank you,
> Doug

Thanks,
Taylor
