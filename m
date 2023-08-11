Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 079EBC001DE
	for <git@archiver.kernel.org>; Fri, 11 Aug 2023 01:41:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbjHKBlv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Aug 2023 21:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbjHKBlu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2023 21:41:50 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 548F3196
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 18:41:50 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9EF1119E801;
        Thu, 10 Aug 2023 21:41:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=6MU6zAc9BB7GVJVnzoCd7gx9yemIEbhhxJdpPGn4b00=; b=SwEK
        GvbXmYtheu6SlitbOoMug6tYMKeMxhPgu0g/Q92On5gTxTyqjuPkUQUzBnf1YRAl
        6cFddXcDPcuuidlFQ8pJhKccEvec62zxi194okdB7Rirk3grcTJvcur9goG3obQE
        W2f0amerbw1QdStY0JmJCQNEe42rw3BmgmLNwGg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 950D419E800;
        Thu, 10 Aug 2023 21:41:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0B20719E7FF;
        Thu, 10 Aug 2023 21:41:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
        Linus Arver <linusa@google.com>
Subject: Re: [PATCH v2 00/13] Fixes to trailer test script, help text, and
 documentation
References: <pull.1564.git.1691210737.gitgitgadget@gmail.com>
        <pull.1564.v2.git.1691702283.gitgitgadget@gmail.com>
Date:   Thu, 10 Aug 2023 18:41:47 -0700
Message-ID: <xmqq7cq2pd7o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3D02C3F6-37E8-11EE-A8F0-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

t0450 dies like the attached, probably because the documentation was
updated to say "<key> or <keyAlias>" but a matching update to the
output of "interpret-trailers -h" command help is missing?

A possible trivial fix to 13/13 will be queued on top as "SQUASH???"
patch for now.

 builtin/interpret-trailers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git c/builtin/interpret-trailers.c w/builtin/interpret-trailers.c
index 832f86a770..d2d78fd961 100644
--- c/builtin/interpret-trailers.c
+++ w/builtin/interpret-trailers.c
@@ -14,7 +14,7 @@
 
 static const char * const git_interpret_trailers_usage[] = {
 	N_("git interpret-trailers [--in-place] [--trim-empty]\n"
-	   "                       [(--trailer <token>[(=|:)<value>])...]\n"
+	   "                       [(--trailer (<key>|<keyAlias>)[(=|:)<value>])...]\n"
 	   "                       [--parse] [<file>...]"),
 	NULL
 };





--- txt 2023-08-10 22:31:54.328609532 +0000
+++ help        2023-08-10 22:31:54.332609929 +0000
@@ -1,3 +1,3 @@
 git interpret-trailers [--in-place] [--trim-empty]
-                       [(--trailer (<key>|<keyAlias>)[(=|:)<value>])...]
+                       [(--trailer <token>[(=|:)<value>])...]
                        [--parse] [<file>...]
not ok 302 - interpret-trailers -h output and SYNOPSIS agree
#
#                       t2s="$(txt_to_synopsis "$builtin")" &&
#                       if test "$builtin" = "merge-tree"
#                       then
#                               test_when_finished "rm -f t2s.new" &&
#                               sed -e 's/ (deprecated)$//g' <"$t2s" >t2s.new
#                               t2s=t2s.new
#                       fi &&
#                       h2s="$(help_to_synopsis "$builtin")" &&
#
#                       # The *.txt and -h use different spacing for the
#                       # alignment of continued usage output, normalize it.
#                       align_after_nl "$builtin" <"$t2s" >txt &&
#                       align_after_nl "$builtin" <"$h2s" >help &&
#                       test_cmp txt help
#
1
