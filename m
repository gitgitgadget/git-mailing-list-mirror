Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1121C6FD1C
	for <git@archiver.kernel.org>; Thu, 23 Mar 2023 16:03:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbjCWQD3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Mar 2023 12:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbjCWQD2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2023 12:03:28 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A631815D
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 09:03:21 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id q206so3097144pgq.9
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 09:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679587401;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OiuDFjv0JNacSbse4MxUEyoUq2ZzzWZUP3autHTya0g=;
        b=i+QPa+C6560HVw1kCRhPCzQuCUCCvfIH1hsme7vOVhF/WilDWXwzP8wfZMdhp9VWMZ
         J4BJkbwcQvOUJ78X8otc+MDSBvX0F10uGIPrftBROlGwXLN4qdAImRC4M/nj7kwVoZgp
         mtXbr48R1EhS2HaOkDU7OHuJyupGmQMs27esdbFuLawtY6ZYEGfZMnJqpNL1Y/rsWXbJ
         7u9ZluSGIflCEgYEnLOXUrSSiDvSnLeRcAZsDcoE54JYLCH2FkuNvKv73N/TSWJjdIIr
         0yM3TLuJxXpi6mtzl3DvRjiAZvWU2B5CMlgrBe6/Aj85bQzQAPRCo1hNmv8SqWTmmxPO
         ubuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679587401;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OiuDFjv0JNacSbse4MxUEyoUq2ZzzWZUP3autHTya0g=;
        b=mTe5mSearcLS/5yXMhEZRXu2rfWfHvN+jESAeyEvjSabRHEk4xOm60RnPpRm91li8n
         342YwNYxckj++cwilLOXUHUmsAPe8K8h3f8abb1ha+2WPqATPWqXbmmL8DVxdVuQT5Is
         Dbh+/ezmoomZpFENtVAmY0bwvKF8aoReH682V9bE2N/RpHa/ws+4BwnBz6jyRujREN5U
         WN+LhH2hPQmwDXMsiCFnYewkZO9LQMSxJ8CnBzAhlwGeVFSWnf+3ORtzh3k8V+7btvpi
         yoe5bA04ojmTyyAUAzfg1haLH9UXNvcN0N1zquEN4fObFgfT3GJmejRnDKuE7dFR5AB5
         5QYA==
X-Gm-Message-State: AO0yUKV2rR6Sq5Q53QTvBdfLvnAkLZwPrDjskRULwCZwhvd5i5boyrkT
        xqJQj27Nl/712IjCyVJIkFiqf9qLkLM=
X-Google-Smtp-Source: AK7set/2fxGZYti8siiF7EYMAJxljbCjXMUDrw9kPuMqFDUIXdc7WNfFkgnUQFjyeOG9nyVHwnIi/Q==
X-Received: by 2002:a62:4d83:0:b0:623:e4d2:d13e with SMTP id a125-20020a624d83000000b00623e4d2d13emr6602770pfb.34.1679587400872;
        Thu, 23 Mar 2023 09:03:20 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id n12-20020aa78a4c000000b005a8db4e3ecesm12213364pfa.69.2023.03.23.09.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 09:03:20 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Shuqi Liang <cheskaqiqi@gmail.com>
Cc:     git@vger.kernel.org, Victoria Dye <vdye@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v7 0/2] diff-files: integrate with sparse index
References: <20230320205241.105476-1-cheskaqiqi@gmail.com>
        <20230322161820.3609-1-cheskaqiqi@gmail.com>
        <xmqqilesbbph.fsf@gitster.g>
        <CAMO4yUFshQ_bP3gXeZhfHQ3OevC+_3qKwa-iy2nNGScvRouu6Q@mail.gmail.com>
Date:   Thu, 23 Mar 2023 09:03:20 -0700
In-Reply-To: <CAMO4yUFshQ_bP3gXeZhfHQ3OevC+_3qKwa-iy2nNGScvRouu6Q@mail.gmail.com>
        (Shuqi Liang's message of "Thu, 23 Mar 2023 03:42:21 -0400")
Message-ID: <xmqqlejna20n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shuqi Liang <cheskaqiqi@gmail.com> writes:

> When the index file is not up-to-date, git diff-files may show differences
> between the working directory and the index that are caused by file creation
> time differences, rather than actual changes to the file contents. By using git
> diff-files --stat, which ignores file creation time differences.

Use of "diff-files --stat" would mean that the contents of the blob
registered in the index will be inspected, which can be used to hide
the "stat dirty" condition.

But doesn't it cut both ways?  Starting from a clean index that has
up-to-date stat information for paths, we may want to test what
"stat dirty" changes diff-files reports when we touch paths in the
working tree, both inside and outside the spase cones.  A test with
"--stat" will not achieve that, exactly because it does not pay
attention to and hides the stat dirtiness.

On the other hand, if "update-index --refresh" is used in the test,
we may discover breakages caused by "update-index" not handling
the sparse index correctly.  It would be outside the topic of this
series, so avoiding it would be simpler, but (1) if it is not broken,
then as you said, it would be a more direct way to test diff-files,
and (2) if it is broken, it would need to be fixed anyway, before or
after this series.  So, I dunno...

Thanks.
