Return-Path: <SRS0=YoUm=65=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FECEC433DF
	for <git@archiver.kernel.org>; Fri, 15 May 2020 17:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44F6120727
	for <git@archiver.kernel.org>; Fri, 15 May 2020 17:21:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="oUgmEBJC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgEORV2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 May 2020 13:21:28 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53375 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbgEORV1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 May 2020 13:21:27 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 91563CD53E;
        Fri, 15 May 2020 13:21:26 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=3C+zAwX3eMoNJEuwu8HqDS1oy
        /Y=; b=oUgmEBJC5tdgaN4HLBBqjYcochyVQAZihlSAJIGmxIDx2Cz2ryToy+hlQ
        YwdECB74MPAAmOLCZt7B2OHqy8j0+fY315XzZ0tigb1kFSEep68kTcyXKdRvm7D8
        EJekkRwHZy6DDTRDxOYzT/pweaJ6MaLzCSyGeDDsoFpgoAw9T8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; q=dns; s=sasl; b=Z1jieiYAO+d+goHYhZb
        ibr4XoVkcmgw9kh8i22nQWA9o4MPQKwbi1nvFvQ2bp+oPDZQdMnNpzq04yx5EF8V
        j5+ZR1HsxStfAZgI2Gd2rjfkS0xLFhLNBZo/Sa4LDy3fdyHQihzBqVG47EMzSAJX
        Xc7KTvGEAt3TPBS03HGcoc1k=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 881C1CD53D;
        Fri, 15 May 2020 13:21:26 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B3D39CD539;
        Fri, 15 May 2020 13:21:23 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>, Alban Gruin <alban.gruin@gmail.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 2/2] Revert "tests: when run in Bash, annotate test failures with file name/line number"
Date:   Fri, 15 May 2020 10:21:17 -0700
Message-Id: <20200515172117.155238-3-gitster@pobox.com>
X-Mailer: git-send-email 2.27.0-rc0
In-Reply-To: <20200515172117.155238-1-gitster@pobox.com>
References: <xmqqlfltm9b5.fsf@gitster.c.googlers.com>
 <20200515172117.155238-1-gitster@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: 80438A86-96D0-11EA-8C19-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This reverts commit 662f9cf1548cf069cb819e9e95f224657015fcf9,
which broke TAP output under bash.

It can be re-attempted in a way that does not break TAP in the next
cycle, but we do not want to worry about it at this late in the
current cycle.

Reported-by: Alban Gruin <alban.gruin@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/test-lib.sh | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 1b221951a8..d36b6ddc62 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -675,18 +675,6 @@ die () {
 	fi
 }
=20
-file_lineno () {
-	test -z "$GIT_TEST_FRAMEWORK_SELFTEST" && test -n "$BASH" || return 0
-	local i
-	for i in ${!BASH_SOURCE[*]}
-	do
-		case $i,"${BASH_SOURCE[$i]##*/}" in
-		0,t[0-9]*.sh) echo "t/${BASH_SOURCE[$i]}:$LINENO: ${1+$1: }"; return;;
-		*,t[0-9]*.sh) echo "t/${BASH_SOURCE[$i]}:${BASH_LINENO[$(($i-1))]}: ${=
1+$1: }"; return;;
-		esac
-	done
-}
-
 GIT_EXIT_OK=3D
 trap 'die' EXIT
 # Disable '-x' tracing, because with some shells, notably dash, it
@@ -732,7 +720,7 @@ test_failure_ () {
 		write_junit_xml_testcase "$1" "      $junit_insert"
 	fi
 	test_failure=3D$(($test_failure + 1))
-	say_color error "$(file_lineno error)not ok $test_count - $1"
+	say_color error "not ok $test_count - $1"
 	shift
 	printf '%s\n' "$*" | sed -e 's/^/#	/'
 	test "$immediate" =3D "" || { finalize_junit_xml; GIT_EXIT_OK=3Dt; exit=
 1; }
--=20
2.27.0-rc0

