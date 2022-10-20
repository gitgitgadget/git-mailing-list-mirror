Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF479C433FE
	for <git@archiver.kernel.org>; Thu, 20 Oct 2022 17:01:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbiJTRB0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 13:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbiJTRBU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 13:01:20 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C2F6191896
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 10:01:15 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D98641B57A0;
        Thu, 20 Oct 2022 13:01:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9kUuQCD9G5CxQdNaw0xVOmhmcIKnaNrPJKhqNY
        mn0vY=; b=QFR/G4/pHDf43jys3Z7AUJwQePrk+HCaN3C8EJ3irwPYGlj9Mc0eRU
        vwBzRoZP/IK9m+Qu5JVdCa/F4QYSlhUnZ7H1vVvLwhOsZhnqUpdc5M/k5SCKb86z
        V49Gzt6TmJsRpAKkicXNy0YvakXZjf4Lf50qPDF8k9pS6VbFPbapM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CA6E91B579F;
        Thu, 20 Oct 2022 13:01:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E03B31B579B;
        Thu, 20 Oct 2022 13:01:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Glen Choo <chooglen@google.com>,
        Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJu?= =?utf-8?B?ZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, Eric DeCosta <edecosta@mathworks.com>
Subject: Re: [PATCH v2 00/12] fsmonitor: Implement fsmonitor for Linux
References: <pull.1352.git.git.1665326258.gitgitgadget@gmail.com>
        <pull.1352.v2.git.git.1665783944.gitgitgadget@gmail.com>
        <kl6l7d0yyu6r.fsf@chooglen-macbookpro.roam.corp.google.com>
        <xmqqo7u9wyt7.fsf@gitster.g> <xmqq8rlamq29.fsf@gitster.g>
        <CAPig+cRkQLyy8X7y=1jhrVwYERk5ucagAfJkTAOPNODofiZr1g@mail.gmail.com>
Date:   Thu, 20 Oct 2022 10:01:07 -0700
In-Reply-To: <CAPig+cRkQLyy8X7y=1jhrVwYERk5ucagAfJkTAOPNODofiZr1g@mail.gmail.com>
        (Eric Sunshine's message of "Thu, 20 Oct 2022 12:37:48 -0400")
Message-ID: <xmqq35bitooc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CAFF8438-5098-11ED-948B-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Thu, Oct 20, 2022 at 12:13 PM Junio C Hamano <gitster@pobox.com> wrote:
>> So here is my "panda-see-panda-do" attempt.
>>
>> ----- >8 --------- >8 --------- >8 --------- >8 --------- >8 -----
>> Subject: [PATCH] ci: use DC_SHA1=1 on osx-clang job for CI
>>
>> All other jobs were using the default DC_SHA1 (which is a
>> recommended practice), but the default for macOS jobs being Apple's
>> common crypt, we didn't catch recent breakage soon enough.
>
> "recent breakage" is quite vague and probably won't help future
> readers understand what this is actually fixing. Possible
> improvements: (1) a prose description of the breakage; (2) the actual
> compiler error message; (3) a pointer[1] to the email reporting the
> problem. One or more of the above improvements to the commit message
> would help future readers.

I do not think (2) or (3) would help all that much.  A finger that
points at the exact commit that broke the build (with the condition
under which the build breaks) would probably be the most useful to
those who read "git log" output.

Thanks.

----- >8 --------- >8 --------- >8 --------- >8 --------- >8 -----
Subject: [PATCH] ci: use DC_SHA1=YesPlease on osx-clang job for CI

7b8cfe34 (Merge branch 'ed/fsmonitor-on-networked-macos',
2022-10-17) broke the build on macOS with sha1dc by bypassing our
hash abstraction (git_SHA_CTX etc.), but it wasn't caught before the
problematic topic was merged down to the 'master' branch.  Nobody
was even compile testing with DC_SHA1 set, although it is the
recommended choice in these days for folks when they use SHA-1.

This was because the default for macOS uses Apple Common Crypto, and
both of the two CI jobs did not override the default.  Tweak one of
them to use DC_SHA1 to improve the coverage.

We may want to give similar diversity for Linux jobs so that some of
them build with other implementations of SHA-1; they currently all
build and test with DC_SHA1 as that is the default on everywhere
other than macOS.

But let's start small to fill only the immediate need.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 ci/lib.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/ci/lib.sh b/ci/lib.sh
index 1b0cc2b57d..51e47aa5d6 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -259,6 +259,8 @@ macos-latest)
 		MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=$(which python3)"
 	else
 		MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=$(which python2)"
+		MAKEFLAGS="$MAKEFLAGS NO_APPLE_COMMON_CRYPTO=NoThanks"
+		MAKEFLAGS="$MAKEFLAGS DC_SHA1=YesPlease NO_OPENSSL=NoThanks"
 	fi
 	;;
 esac
-- 
2.38.1-271-ge78cd6c470

