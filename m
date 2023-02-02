Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C4D0C61DA4
	for <git@archiver.kernel.org>; Thu,  2 Feb 2023 22:36:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232776AbjBBWg1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Feb 2023 17:36:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232658AbjBBWg0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2023 17:36:26 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D436ACAD
        for <git@vger.kernel.org>; Thu,  2 Feb 2023 14:36:23 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id s8so308296pgg.11
        for <git@vger.kernel.org>; Thu, 02 Feb 2023 14:36:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AK+KeySKxPsMiD9pvODe7tVxeQfzxG2E17xP4vwTXJw=;
        b=F+LHP1ZQCiVhJCDgJqlmw8wADwYQcaj7q1HCcYrLhmaeSc4BzCAE6KW1ujoolMv8Zf
         Do0w4hnj4WN4e4YpvcS1nt4Q7SIuD7H5c14lLx8gE3d8ChM9+F+yaUKy97AN9ajMNGYJ
         2kdbdVp+ZnlG1hZZC+h0je5WlZGkGR9Q/K0rp2dU+OtvBW/jtMioBHsA0cC/PY2uXQaE
         2tVjvDt/lOUHrpFMXNXnEiqlJQcKCGWoxuWCsxOvT7NSEpEicmfoHAhElOFOyU0/8roh
         YR/CmgMMO1QogkaCmvNV2dmRk8K4K7Nr8J+JmBKFAIieKHLG01UD06T0XKy03Uvh9DbU
         EaKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AK+KeySKxPsMiD9pvODe7tVxeQfzxG2E17xP4vwTXJw=;
        b=6LslXZgW4FKXkCHiXWdtqPS/T3IgvzDNB1Awz3maI/o5o6iys1WV9gV1PKtQkopPpc
         oeQQA62YS7xu/k4YpFgK29ZVwSExIQQcJOkAFZLzn4TIlur4LzqPXSv7YQPwXPfzIHbz
         8V0qCKlxL4W9mz9kCqNqyiLeSojC8B1Q8EQDvmc9Y1IJHcAu6mP0gTNMED64RpQ5FGEU
         IyHbiYxYpLjTkhVf7fMcCg/jZi7DBfzYIfGLtLuRM9C+/tY0MyJRh8ohDbcM3+YxfaaR
         cLJt8rhrJMvElGnhyQbgRcYlCM4dunM9SR7DNc4j4DUH18upggYr6lTMsG9fFYjINAlE
         p3/w==
X-Gm-Message-State: AO0yUKVZrWuDVckqIbkSG3WObyednlMt9DDfTlc5nb5UWIDrUKZghYhw
        DPAEVTbZZF/hihqWVRPKV9c=
X-Google-Smtp-Source: AK7set+OihcRNjCLOfJkXCC59IUTByzwjBf1ZAqVM94FfLVD45km/WeSYwqAkdXe2AcjKJmfJOuHjQ==
X-Received: by 2002:a05:6a00:18a0:b0:588:a156:6a3d with SMTP id x32-20020a056a0018a000b00588a1566a3dmr10121145pfh.26.1675377382609;
        Thu, 02 Feb 2023 14:36:22 -0800 (PST)
Received: from localhost (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id r3-20020a62e403000000b0058d9710cb18sm216014pfh.2.2023.02.02.14.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 14:36:22 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Kostya Farber <kostya.farber@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [GSoC][PATCH] t/t5000-tar-tree: add helper function
References: <20230202202557.19297-1-kostya.farber@gmail.com>
Date:   Thu, 02 Feb 2023 14:36:21 -0800
In-Reply-To: <20230202202557.19297-1-kostya.farber@gmail.com> (Kostya Farber's
        message of "Thu, 2 Feb 2023 20:25:57 +0000")
Message-ID: <xmqqa61vsniy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kostya Farber <kostya.farber@gmail.com> writes:

> Add the helper function test_file_path_exists to the
> interpret pax header test. This change makes it clearer
> as to what the test is trying to check, in this case whether
> a file path exists.

Really?  

The code with "test -e" is already clear that it is checking if the
path $data exists.  This change does not make it any clearer.  What
it helps is that it gives a message upon failure, when the test is
run with the "-v" option.

> diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
> index d473048138..19d5bd0c04 100755
> --- a/t/t5000-tar-tree.sh
> +++ b/t/t5000-tar-tree.sh
> @@ -73,7 +73,7 @@ check_tar() {
>  			for header in *.paxheader
>  			do
>  				data=${header%.paxheader}.data &&
> -				if test -h $data || test -e $data
> +				if test -h $data || test_file_path_exists $data
>  				then
>  					path=$(get_pax_header $header path) &&
>  					if test -n "$path"

Nothing seems to be adding a new helper whose name is
test_file_path_exists; the patch expects such a helper already
exists and uses it in place for existing "test -e".

Perhaps you meant to say "use test_path_exists" not "add helper" on
the title, and use that function in the patch instead?

Thanks.
