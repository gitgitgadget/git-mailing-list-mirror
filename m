Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22742EB64D9
	for <git@archiver.kernel.org>; Tue,  4 Jul 2023 22:03:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbjGDWDH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jul 2023 18:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbjGDWDE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jul 2023 18:03:04 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B44E8E76
        for <git@vger.kernel.org>; Tue,  4 Jul 2023 15:02:58 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1CBBC19BA0E;
        Tue,  4 Jul 2023 18:02:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OK9mufsl8NShB8Oqcbl3mC3kfyWFbx4JdaVk8D
        gR1jE=; b=AB1mtEDsZPG2V3FhD6TbC62qZ72dbz1T813DSompRCP2A7Sy8iCrtq
        MCHOmiTvvVUZQEA/Y4sZ6CgZCl7mkM3KQlWpr0IZnnRyMRz9g8qk+VyazBq76f6X
        yjwjQ/bONpcAxmbhbJ0lU44Ig+YTAaxk9Wrvs64hzv6Awvx+NG2ws=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 044E519BA0C;
        Tue,  4 Jul 2023 18:02:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.233.135.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 574E119BA0B;
        Tue,  4 Jul 2023 18:02:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Marius Schiffer <marius@mschiffer.de>
Cc:     git@vger.kernel.org
Subject: Re: Bug report: AM 3-way patching fails with partial cloning
References: <1e79047e-944c-0112-ffd0-ca52e31226c3@mschiffer.de>
Date:   Tue, 04 Jul 2023 15:02:56 -0700
In-Reply-To: <1e79047e-944c-0112-ffd0-ca52e31226c3@mschiffer.de> (Marius
        Schiffer's message of "Mon, 3 Jul 2023 18:46:45 +0200")
Message-ID: <xmqqedln49nz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 88A1C798-1AB6-11EE-8BBD-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Marius Schiffer <marius@mschiffer.de> writes:

> When applying patches with git am on a repository cloned with
> filter=blob:none, the patching sometimes fails when it can't find the
> required SHA1 information.
> Applying the same thing on a normal clone works.

This is very much expected, especially if your patches are not
generated with --full-index option, because partial clones cannot
on-demand request objects without knowing their full object names to
the promissor remote.  I do not offhand know if "am -3" codepath, if
the full object name is available, is arranged to trigger lazy
fetching of the objects, but nobody sane are sending patches with
the --full-index option to begin with, so that is academic, I would
say.
