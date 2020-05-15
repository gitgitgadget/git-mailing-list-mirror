Return-Path: <SRS0=YoUm=65=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F5FCC433E0
	for <git@archiver.kernel.org>; Fri, 15 May 2020 17:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FBA020727
	for <git@archiver.kernel.org>; Fri, 15 May 2020 17:21:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rpBEPqTO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbgEORVZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 May 2020 13:21:25 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62686 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbgEORVY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 May 2020 13:21:24 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5ACDE4DCDD;
        Fri, 15 May 2020 13:21:22 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=zjRuNjd0Ps88AQ1wqrXyJQODT
        dA=; b=rpBEPqTOZWouM012ySPdr2/ZAomYlQWNbmI9S+pokAn+iZfyIzZNpJ23c
        xu0TXlreE/axIElGo9X9WlER4/fllBAWT4ZU2J5VxgtLhiOwQVFXJjOTYb59eoVW
        nLitbnaR7eTGVFVJsd2e4oJeYh5d45gWsdeybs6bj6JykQUjc0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; q=dns; s=sasl; b=TcXkRblf7lNc9/teHMm
        AydIHjvNgOge+wAeWY5/FMzhYg70Sz4gIQQzsy9W6AqutCt17EeZ2YnIW/atXsGX
        wAxUF/Vr7fKcsTsnlWPx1/ayF6wt1bsSBfIA7mD/QEgJdji/K4V2WIIWHCsOsFfl
        /h9LN6RXJOjX5LycJxeUUtFA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4CAE64DCDB;
        Fri, 15 May 2020 13:21:22 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C7A3F4DCD9;
        Fri, 15 May 2020 13:21:21 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>, Alban Gruin <alban.gruin@gmail.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 1/2] Revert "t/test_lib: avoid naked bash arrays in file_lineno"
Date:   Fri, 15 May 2020 10:21:16 -0700
Message-Id: <20200515172117.155238-2-gitster@pobox.com>
X-Mailer: git-send-email 2.27.0-rc0
In-Reply-To: <20200515172117.155238-1-gitster@pobox.com>
References: <xmqqlfltm9b5.fsf@gitster.c.googlers.com>
 <20200515172117.155238-1-gitster@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: 7F1F19C2-96D0-11EA-BAC9-C28CBED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This reverts commit 303775a25f0b4ac5d6ad2e96eb4404c24209cad8;
instead of trying to salvage the tap-breaking change, let's
revert the whole thing for now for the upcoming release.

The enhancement can be re-attempted in the next cycle.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/test-lib.sh | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index baf94546da..1b221951a8 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -677,16 +677,14 @@ die () {
=20
 file_lineno () {
 	test -z "$GIT_TEST_FRAMEWORK_SELFTEST" && test -n "$BASH" || return 0
-	eval '
-		local i
-		for i in ${!BASH_SOURCE[*]}
-		do
-			case $i,"${BASH_SOURCE[$i]##*/}" in
-			0,t[0-9]*.sh) echo "t/${BASH_SOURCE[$i]}:$LINENO: ${1+$1: }"; return;=
;
-			*,t[0-9]*.sh) echo "t/${BASH_SOURCE[$i]}:${BASH_LINENO[$(($i-1))]}: $=
{1+$1: }"; return;;
-			esac
-		done
-	'
+	local i
+	for i in ${!BASH_SOURCE[*]}
+	do
+		case $i,"${BASH_SOURCE[$i]##*/}" in
+		0,t[0-9]*.sh) echo "t/${BASH_SOURCE[$i]}:$LINENO: ${1+$1: }"; return;;
+		*,t[0-9]*.sh) echo "t/${BASH_SOURCE[$i]}:${BASH_LINENO[$(($i-1))]}: ${=
1+$1: }"; return;;
+		esac
+	done
 }
=20
 GIT_EXIT_OK=3D
--=20
2.27.0-rc0

