Return-Path: <SRS0=27Fn=A3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2BABC433E0
	for <git@archiver.kernel.org>; Thu, 16 Jul 2020 16:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88F7A2065E
	for <git@archiver.kernel.org>; Thu, 16 Jul 2020 16:49:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hCtFtOF2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728993AbgGPQtU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jul 2020 12:49:20 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52459 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbgGPQtT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jul 2020 12:49:19 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8A32E60451;
        Thu, 16 Jul 2020 12:49:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XGUKQCEP7qboY3F6m3127PO+wcs=; b=hCtFtO
        F2djpd3bBd/4B/SKkyLk3LYKng4xWl2Qhuphwrmg33IkTJgjQ+bFZ4oAtQNJ/9Q7
        DhOCCoaYi6BBuVk3itClMK/tALoq8dUZqjorkizzLMY6vIxPLyKxMyzo+HL6cV0q
        jAQESx9VaRzEEpF/fGV2wDeTz5wyAVLvUg5L0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qJCzeio98+1dF8VmLSkcnNBE63+wBhkk
        Kg8zuBA+yrg7b6MY1yVyf1sUBuiynZ5rWby/3vPN2zIR+yeGcLcj69hl3i66sIYz
        tGYfDC+2PY01q5qUT6AnrXC63MVai1+EeAurNBvagm1xBkmZvep4SGlhP740PBfv
        9wfl/Dn9wXw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 80E4660450;
        Thu, 16 Jul 2020 12:49:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0C3176044F;
        Thu, 16 Jul 2020 12:49:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, delphij@google.com,
        Huan Huan Chen <huanhuanchen@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 2/2] repository: allow repository format upgrade with extensions
References: <pull.675.git.1594677321039.gitgitgadget@gmail.com>
        <0bede821-139a-d805-934a-142004abaa4c@gmail.com>
        <nycvar.QRO.7.76.6.2007141420300.52@tvgsbejvaqbjf.bet>
        <xmqqzh82ktgm.fsf@gitster.c.googlers.com>
        <xmqqpn8wkben.fsf@gitster.c.googlers.com>
        <20200716062054.GA3242764@google.com>
        <20200716062818.GC3242764@google.com>
        <xmqqh7u8hrka.fsf@gitster.c.googlers.com>
        <20200716110007.GD376357@coredump.intra.peff.net>
        <20200716122513.GA1050962@coredump.intra.peff.net>
Date:   Thu, 16 Jul 2020 09:49:14 -0700
In-Reply-To: <20200716122513.GA1050962@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 16 Jul 2020 08:25:13 -0400")
Message-ID: <xmqqv9inh0c5.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 48E319E6-C784-11EA-8410-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Subject: verify_repository_format(): complain about new extensions in v0 repo
>
> We made the mistake in the past of respecting extensions.* even when the
> repository format version was set to 0. This is bad because forgetting
> to bump the repository version means that older versions of Git (which
> do not know about our extensions) won't complain. I.e., it's not a
> problem in itself, but it means your repository is in a state which does
> not give you the protection you think you're getting from older
> versions.
>
> For compatibility reasons, we are stuck with that decision for existing
> extensions. However, we'd prefer not to extend the damage further. We
> can do that by catching any newly-added extensions and complaining about
> the repository format.

Looking good overall, but I needed this to build from the source.

Thanks.

 setup.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/setup.c b/setup.c
index e29659b7b9..e69bd28ed6 100644
--- a/setup.c
+++ b/setup.c
@@ -457,10 +457,10 @@ enum extension_result {
  * Do not add new extensions to this function. It handles extensions which are
  * respected even in v0-format repositories for historical compatibility.
  */
-enum extension_result handle_extension_v0(const char *var,
-					  const char *value,
-					  const char *ext,
-					  struct repository_format *data)
+static enum extension_result handle_extension_v0(const char *var,
+						 const char *value,
+						 const char *ext,
+						 struct repository_format *data)
 {
 		if (!strcmp(ext, "noop")) {
 			return EXTENSION_OK;
@@ -483,10 +483,10 @@ enum extension_result handle_extension_v0(const char *var,
 /*
  * Record any new extensions in this function.
  */
-enum extension_result handle_extension(const char *var,
-				       const char *value,
-				       const char *ext,
-				       struct repository_format *data)
+static enum extension_result handle_extension(const char *var,
+					      const char *value,
+					      const char *ext,
+					      struct repository_format *data)
 {
 	if (!strcmp(ext, "noop-v1")) {
 		return EXTENSION_OK;
