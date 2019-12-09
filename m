Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EBEDC43603
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 22:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1037120637
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 22:27:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="JweiX/CI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbfLIW1q (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 17:27:46 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62375 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbfLIW1q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 17:27:46 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 13A7FAA8A6;
        Mon,  9 Dec 2019 17:27:41 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kqZK1TrUhv+qNsq3S7v1V/r6fwo=; b=JweiX/
        CI9IJdki0vDAmsR7TcJyWPM2pTVKaVRdjhQ/KDx8zVRGuaDnhU4dgi5d6LRM7xOR
        kzf61WsKroLrR8fYAK1oTJ15Ycak4feWIsHN1bnQuuqwdiEfvtybSPmYEex1zEPc
        t9SXz4vxUmlLOiGCPvvfNQBVEADQngH+F3ntc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xaV0Opl4WalTFf/TJ1YIcp9sqLvSGR82
        bFDPgeGLMwxwPdPmoLuup7DeRh7cTFk/Pj1QIqo3jPOLo/XvESC1DhF4+siLhYV2
        ggCxIX5vNlsCGC2jwTStrAjL4pbhaw1tSFe1QeVeZS0BuwWTTtmzODPCSLM+YRaO
        niII99Au5U8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0B62DAA8A4;
        Mon,  9 Dec 2019 17:27:41 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 27784AA8A2;
        Mon,  9 Dec 2019 17:27:38 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "panzercheg via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, panzercheg <panzercheg@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 1/1] "git lfs" allows users to specify the custom storage location by configuration variable lfs.storage, but when "git p4" interacts with GitLFS pointers, it always used the hardcoded default that is the .git/lfs/ directory, without paying attention to the configuration.
References: <pull.483.git.1575466209.gitgitgadget@gmail.com>
        <pull.483.v2.git.1575901722.gitgitgadget@gmail.com>
        <e65375c528bdcdcc928dce8159edfccddcf77070.1575901722.git.gitgitgadget@gmail.com>
Date:   Mon, 09 Dec 2019 14:27:35 -0800
In-Reply-To: <e65375c528bdcdcc928dce8159edfccddcf77070.1575901722.git.gitgitgadget@gmail.com>
        (panzercheg via GitGitGadget's message of "Mon, 09 Dec 2019 14:28:42
        +0000")
Message-ID: <xmqq1rtdt9rc.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1B023AE2-1AD3-11EA-AF7B-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"panzercheg via GitGitGadget" <gitgitgadget@gmail.com> writes:

>Subject: Re: [PATCH v2 1/1] "git lfs" allows users to specify the custom storage location by configuration variable lfs.storage, but when "git p4" interacts with GitLFS pointers, it always used the hardcoded default that is the .git/lfs/ directory, without paying attention to the configuration.

Oops, what happened here?

I wonder/I wish if GGG can be a bit more helpful when seeing a
commit that looks "strange".

> From: panzercheg <panzercheg@gmail.com>
>
> Use the value configured in lfs.storage, if exists, as all the
> "git" operations do, for consistency.
>
> Signed-off-by: r.burenkov <panzercheg@gmail.com>

Please make sure that the name/email as the author matches whom you
sign-off the patch as.



> ---
>  git-p4.py | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/git-p4.py b/git-p4.py
> index 60c73b6a37..0b3a07cb31 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -1257,9 +1257,15 @@ def generatePointer(self, contentFile):
>              pointerFile = re.sub(r'Git LFS pointer for.*\n\n', '', pointerFile)
>  
>          oid = re.search(r'^oid \w+:(\w+)', pointerFile, re.MULTILINE).group(1)
> +        # if someone use external lfs.storage ( not in local repo git )
> +        lfs_path = gitConfig('lfs.storage')
> +        if not lfs_path:
> +            lfs_path = 'lfs'
> +        if not os.path.isabs(lfs_path):
> +            lfs_path = os.path.join(os.getcwd(), '.git', lfs_path)
>          localLargeFile = os.path.join(
> -            os.getcwd(),
> -            '.git', 'lfs', 'objects', oid[:2], oid[2:4],
> +            lfs_path,
> +            'objects', oid[:2], oid[2:4],
>              oid,
>          )
>          # LFS Spec states that pointer files should not have the executable bit set.
