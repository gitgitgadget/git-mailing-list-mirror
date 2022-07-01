Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBCCEC43334
	for <git@archiver.kernel.org>; Fri,  1 Jul 2022 21:32:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbiGAVcy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Jul 2022 17:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbiGAVcx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jul 2022 17:32:53 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77EF153EDA
        for <git@vger.kernel.org>; Fri,  1 Jul 2022 14:32:52 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9EC14198E18;
        Fri,  1 Jul 2022 17:32:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DN4cE75tAeURWDEFvonxCIy0QshleLrJi9ilfg
        AY014=; b=xjIq2G2o50nfP1XMbs09y+vqd7/Ti1JtnXG3NLlLdVAmJ5meNas5t+
        m07HxEwzRwuKpm9537jDlGCipBxp5l6qU0CBz8K7nwNMV3EIyuMF4a4a7NIEslPg
        ul4voSOK2BYTPHgyCnXxDnM63Or178rnQ0KaVYlthJb3J7nNusNjc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 974FA198E17;
        Fri,  1 Jul 2022 17:32:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1C644198E16;
        Fri,  1 Jul 2022 17:32:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] http: support building on RHEL6
References: <pull.1277.git.1656692646303.gitgitgadget@gmail.com>
        <Yr8kfCqKHwO1QqS6@tapette.crustytoothpaste.net>
Date:   Fri, 01 Jul 2022 14:32:45 -0700
In-Reply-To: <Yr8kfCqKHwO1QqS6@tapette.crustytoothpaste.net> (brian
        m. carlson's message of "Fri, 1 Jul 2022 16:44:44 +0000")
Message-ID: <xmqqpmio7c3m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 59A0D4BE-F985-11EC-B0F5-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2022-07-01 at 16:24:06, Johannes Schindelin via GitGitGadget wrote:
>> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>> 
>> There was a bug report attached to the copy of 511cfd3bffa (http: add
>> custom hostname to IP address resolutions, 2022-05-16) in the `git/git`
>> repository on GitHub, claiming that that commit broke the build on
>> RedHat Enterprise Linux 6. The most likely explanation is that the
>> available cURL version does not support the `CURLOPT_RESOLVE` feature.
>> 
>> Let's work around this by warning the user if they configure
>> `http.curloptResolve` if compiled against a too-old cURL version.
>
> I don't think it's a good idea to continue to support RHEL 6.  It lost
> regular security support in 2020 and I think it's fine and even
> preferable to force people to upgrade their OS once every decade.  10
> years is, in my view, well beyond the reasonable life span of an OS.
>
> There's no possible way that any Git developer can be expected to
> support RHEL 6 because it has no publicly available security support[0] and
> we can't expect developers to run or use insecure OSes at all.  It's
> also irresponsible of us to enable people to use such an OS considering
> the likelihood of compromise is substantial and the risk compromised
> systems pose to the Internet, so I think we should drop this patch.

I agree with you that justifying the change to support RHEL6 is a
bad idea, because it is a bad idea to encourage the continued use of
platform that is unsupported by the publisher.

But I do not think the patch text, what the patch does, is that bad.
We advertise in INSTALL that you need 7.19.4 to build without NO_CURL;
IOW, you should be able to build Git with 7.21.3 or later.

> [0] Yes, there is _extended_ security support until 2024, but that's not
> available to people who aren't already RHEL 6 users and it doesn't cover
> dependencies such as libcurl or Perl that are required to effectively
> use Git.

It is a different problem if RHEL6 has cURL 7.19.4 or later.  I do
not know the answer to that question.

Taking all of the above into account, I would say that the patch
text is OK and we should mention that the original complaint came
from a user who tried to build Git with RHEL6, but we should make
this change not because we want to keep Git working on that
platform.  Instead, justify the change because we should follow the
promise we made in INSTALL to support libCURL version 7.19.4 or
later

By the way, I do not see anything to notice an attempt to use
libCURL that is too old.  I wonder if the attached patch is worth
considering.

Thanks.

----- >8 --------- >8 --------- >8 --------- >8 --------- >8 -----
Subject: libcurl: document and enforce the lowest supported version

In INSTALL, we promise that certain version of libCURL is usable to
build git with, but there was nothing that ensures we are not built
with a version that is too old.  We may be lucky and the compiler
may choke on a missing function, global variable, or preprocessor
constant in such a case, but it may be more helpful to the users to
give an explicit error message that says the lowest version we
support.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 INSTALL           |  2 +-
 git-curl-compat.h | 11 ++++++++---
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git c/INSTALL w/INSTALL
index 4140a3f5c8..d9c83f30c5 100644
--- c/INSTALL
+++ w/INSTALL
@@ -146,7 +146,7 @@ Issues of note:
 
 	  Git requires version "7.19.4" or later of "libcurl" to build
 	  without NO_CURL. This version requirement may be bumped in
-	  the future.
+	  the future in the <git-curl-compat.h> file.
 
 	- "expat" library; git-http-push uses it for remote lock
 	  management over DAV.  Similar to "curl" above, this is optional
diff --git c/git-curl-compat.h w/git-curl-compat.h
index 56a83b6bbd..6eda37ea5a 100644
--- c/git-curl-compat.h
+++ w/git-curl-compat.h
@@ -8,9 +8,6 @@
  * inform decisions about removing support for older libcurl in the
  * future.
  *
- * The oldest supported version of curl is documented in the "INSTALL"
- * document.
- *
  * The source of truth for what versions have which symbols is
  * https://github.com/curl/curl/blob/master/docs/libcurl/symbols-in-versions;
  * the release dates are taken from curl.git (at
@@ -28,6 +25,14 @@
  * introduced, oldest first, in the official version of cURL library.
  */
 
+/*
+ * The oldest supported version of curl is documented in the "INSTALL"
+ * document.
+ */
+#if LIBCURL_VERSION_NUM < 0x071304
+#error "libCURL older than 7.19.4 is not supported"
+#endif
+
 /**
  * CURL_SOCKOPT_OK was added in 7.21.5, released in April 2011.
  */
