Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A19C433EF
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 21:48:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237462AbiGSVse (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 17:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237195AbiGSVsd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 17:48:33 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E87120A0
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 14:48:33 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8850B19D3D7;
        Tue, 19 Jul 2022 17:48:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kowJHppwOePIO3XOLTakutAafL62u9cz0xQFYu
        bGznA=; b=Od/g0MuCJJQ/dIPn1KKpkeJ4eNfxzSvTL6E+UvNWWlN2sH3bY3YVGT
        c0iHQpgFbiowtnCA+WNkU7GMqkoZuosQQYcApd3uA2udDrlP4gEA/IZrpeab97QR
        Vz7yftkkhs5IHPy5uNEgU+MUBEmlrwX+eO2CHruZVxvBnjjZP7XhM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8144519D3D6;
        Tue, 19 Jul 2022 17:48:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 60DE419D3D5;
        Tue, 19 Jul 2022 17:48:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: [PATCH] repack: document there is no need to avoid delta-base-offset
References: <patch-1.1-363f84a3fa7-20220715T075114Z-avarab@gmail.com>
        <xmqqsfn21fmt.fsf@gitster.g>
        <220716.8635f1zdg3.gmgdl@evledraar.gmail.com>
        <xmqq1qujt334.fsf@gitster.g>
        <220718.86tu7eyhvz.gmgdl@evledraar.gmail.com>
        <xmqqk089ewbx.fsf@gitster.g>
        <220719.8635exwje8.gmgdl@evledraar.gmail.com>
Date:   Tue, 19 Jul 2022 14:48:26 -0700
In-Reply-To: <220719.8635exwje8.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 19 Jul 2022 11:07:29 +0200")
Message-ID: <xmqqbktk93kl.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8583757A-07AC-11ED-AA2A-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As continued use of 1.4.4 by people stopped being an issue long time
ago, we can safely remove the warning about interoperability that we
added in 1.6.0 when the use of delta-base-offset has become default.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Instead of outright removing, it probably is a good idea to hint
   the reason why the now seemingly useless configuration variable
   is there, perhaps.

 Documentation/git-repack.txt | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git c/Documentation/git-repack.txt w/Documentation/git-repack.txt
index 0bf13893d8..882904fc7b 100644
--- c/Documentation/git-repack.txt
+++ w/Documentation/git-repack.txt
@@ -218,15 +218,11 @@ CONFIGURATION
 Various configuration variables affect packing, see
 linkgit:git-config[1] (search for "pack" and "delta").
 
-By default, the command passes `--delta-base-offset` option to
-'git pack-objects'; this typically results in slightly smaller packs,
-but the generated packs are incompatible with versions of Git older than
-version 1.4.4. If you need to share your repository with such ancient Git
-versions, either directly or via the dumb http protocol, then you
-need to set the configuration variable `repack.UseDeltaBaseOffset` to
-"false" and repack. Access from old Git versions over the native protocol
-is unaffected by this option as the conversion is performed on the fly
-as needed in that case.
+By default, the command passes `--delta-base-offset` option to 'git
+pack-objects', which results in packs smaller by a few per-cent.
+The configuration variable `repack.UseDeltaBaseOffset` can be set to
+`false` to disable it, but these days there hardly is any reason to
+do so.
 
 Delta compression is not used on objects larger than the
 `core.bigFileThreshold` configuration variable and on files with the
