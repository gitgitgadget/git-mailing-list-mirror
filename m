Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 328F2C43334
	for <git@archiver.kernel.org>; Fri, 10 Jun 2022 21:01:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346779AbiFJVBR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jun 2022 17:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244872AbiFJVBQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jun 2022 17:01:16 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25DA5184918
        for <git@vger.kernel.org>; Fri, 10 Jun 2022 14:01:14 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 289E813F5F1;
        Fri, 10 Jun 2022 17:01:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dFl8sf89zpfx8MzrDGu3QgcTVJ5ReK4PRFndNb
        wTGow=; b=EJ9yTbWoGUwXGNbs6GCBAbUIOHjzlmDxCJCDX7GzW45ziS+630RVov
        vGiqRweKPMb+2p0nG5Np1eCCbahZMX4Ey701+aIc3G0Pe1zzB/FwfkcRlwhUSmdz
        839IGWdLKh+0eqFjH+IAVkhUPoxYcNVXJGgqkGTMxkURiqsixTE54=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1E01113F5F0;
        Fri, 10 Jun 2022 17:01:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7D00F13F5EF;
        Fri, 10 Jun 2022 17:01:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han Xin <chiyutianyi@gmail.com>
Cc:     avarab@gmail.com, git@vger.kernel.org, l.s.r@web.de,
        neerajsi@microsoft.com, newren@gmail.com, philipoakley@iee.email,
        stolee@gmail.com, worldhello.net@gmail.com,
        Neeraj Singh <nksingh85@gmail.com>
Subject: Re: [PATCH v14 6/7] core doc: modernize core.bigFileThreshold
 documentation
References: <cover-v13-0.7-00000000000-20220604T095113Z-avarab@gmail.com>
        <cover.1654871915.git.chiyutianyi@gmail.com>
        <dea5c4172b3908104d703dd09b644796ae52d873.1654871916.git.chiyutianyi@gmail.com>
Date:   Fri, 10 Jun 2022 14:01:10 -0700
In-Reply-To: <dea5c4172b3908104d703dd09b644796ae52d873.1654871916.git.chiyutianyi@gmail.com>
        (Han Xin's message of "Fri, 10 Jun 2022 22:46:06 +0800")
Message-ID: <xmqqh74scjxl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 751619A6-E900-11EC-B6F9-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han Xin <chiyutianyi@gmail.com> writes:

>  core.bigFileThreshold::

> +	The size of files considered "big", which as discussed below
> +	changes the behavior of numerous git commands, as well as how
> +	such files are stored within the repository. The default is
> +	512 MiB. Common unit suffixes of 'k', 'm', or 'g' are
> +	supported.
>  +
> +Files above the configured limit will be:
>  +
> +* Stored deflated in packfiles, without attempting delta compression.
> ++
> +The default limit is primarily set with this use-case in mind. With it

"With it" -> "With it,"

> +most projects will have their source code and other text files delta
> +compressed, but not larger binary media files.
> +
> +Storing large files without delta compression avoids excessive memory
> +usage, at the slight expense of increased disk usage.

Makes sense.

> +* Will be treated as if though they were labeled "binary" (see

"as if though" -> "as if"

> +  linkgit:gitattributes[5]). e.g. linkgit:git-log[1] and
> +  linkgit:git-diff[1] will not diffs for files above this limit.

"will not diffs" -ECANNOTPARSE.  "will not compute diffs", probably?

> ++
> +* Will be generally be streamed when written, which avoids excessive

"be generally be" -> "generally be"

> +memory usage, at the cost of some fixed overhead. Commands that make
> +use of this include linkgit:git-archive[1],
> +linkgit:git-fast-import[1], linkgit:git-index-pack[1] and
> +linkgit:git-fsck[1].
>  
>  core.excludesFile::
>  	Specifies the pathname to the file that contains patterns to
