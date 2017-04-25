Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 546701FE90
	for <e@80x24.org>; Tue, 25 Apr 2017 13:52:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1431334AbdDYNwD (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 09:52:03 -0400
Received: from mout.gmx.net ([212.227.17.22]:58381 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1431325AbdDYNwB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 09:52:01 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M9KR0-1cqP9W3qpS-00Cjdz; Tue, 25
 Apr 2017 15:51:57 +0200
Date:   Tue, 25 Apr 2017 15:51:56 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v2 3/9] rebase -i: do not invent onelines when expanding/collapsing
 SHA-1s
In-Reply-To: <cover.1493128210.git.johannes.schindelin@gmx.de>
Message-ID: <8f08b5d385a2d35526ff9faf92e3c96ea89f134b.1493128210.git.johannes.schindelin@gmx.de>
References: <cover.1472833365.git.johannes.schindelin@gmx.de> <cover.1493128210.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:evpcLr4JzxMElGTTwLH5SCrok82RrxHjqXjFkuDaoWgaiWub5L6
 qH3Z+zTzvJUIsHByEZFH2owG1frDsx+REUxvbd7Na6CllyOlU6YBsI9XM/DLESI5F4YsCmt
 LGeDiCVPgItGvaHSfBpIdm6WlTEWeLdZ0XU9ElAiooTF/yLBJG6j5FX1Y7zc+Gvpe4n/GfJ
 hmGW0d3uCuUmIRRaScaLQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:yavL0M27Vtw=:l6VG9cg0fFxd2rWjJAusT9
 +eAMB/I5c+FoG2VnsYXIO0fYuqEIFBN6ohWJ/lFj2Rne2XKtvT4HMLOmXTbF0Ygy3ScmvRkTr
 GmHC+MlC8LtZBImh5+i3Hp95z71fnquMu2nou6+huNOXMrtsioxcizVO856M86eWoCCHgw2Un
 wvVsgaR4XEucQumyFsBeM3M4YsY2KWUuQl3rLutVUviHy5X4+nH+MartA+tl+9O0vo41DGkyN
 tJw/yepU4ONUqYTplMZ4vt9Du2G9JkqrGw7YrbuXxuHok/33NC2kLx144bReHjU8oj2wh9CY7
 H0eEnhm/TN/qVeF9oCM7HadiVZUT6i8iep9WGafkRbWFUpdIIc5SFQFbDqJ89nufII8Me2hrU
 XgCc2PP9R3BUWJ3+vP+TWSd8Csu1nrdCXE8dUlZ+GYjIzuMiIezTXgAKD7D7COFzMNkuUPxMS
 dAL/10iFx/pdVtqzs+Qpgx4AJ5ZoihH0hpxCpo7mNErqwHI+PQPkRZBPeszuup8qx4WBGD5QZ
 viPAgdMwIUZN53fLA+tOZf1c5FnfYasGw+QvNf4BizbI89iYXq66JQI0NTf8NThhmgkLR0/F+
 M7z09Rp6XXPHdmSTb5NBEJxh8MM5ru+cZtj1/EHFqoSKK/l5IG4QevLDtcvEYm9Zp5blArlJi
 DMeaWIoSaVurb5/7KP1PV4h9QO3lLfdLb0mr+A9KbHsDXbJ+Iz/6cOoqoq5FPxgI4dIdo7mnH
 dDu+sl1J4GNH6NX1E/YYS50e3dsj54uUDMPUa+GYxwZe9Q1sd+AttVHHv34JS7twdqtvI+5u2
 XRQ2FLz
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To avoid problems with short SHA-1s that become non-unique during the
rebase, we rewrite the todo script with short/long SHA-1s before and
after letting the user edit the script. Since SHA-1s are not intuitive
for humans, rebase -i also provides the onelines (commit message
subjects) in the script, purely for the user's convenience.

It is very possible to generate a todo script via different means than
rebase -i and then to let rebase -i run with it; In this case, these
onelines are not required.

And this is where the expand/collapse machinery has a bug: it *expects*
that oneline, and failing to find one reuses the previous SHA-1 as
"oneline".

It was most likely an oversight, and made implementation in the (quite
limiting) shell script language less convoluted. However, we are about
to reimplement performance-critical parts in C (and due to spawning a
git.exe process for every single line of the todo script, the
expansion/collapsing of the SHA-1s *is* performance-hampering on
Windows), therefore let's fix this bug to make cross-validation with the
C version of that functionality possible.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-rebase--interactive.sh | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index c40b1fd1d2e..214af0372ba 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -760,7 +760,12 @@ transform_todo_ids () {
 			;;
 		*)
 			sha1=$(git rev-parse --verify --quiet "$@" ${rest%%[	 ]*}) &&
-			rest="$sha1 ${rest#*[	 ]}"
+			if test "a$rest" = "a${rest#*[	 ]}"
+			then
+				rest=$sha1
+			else
+				rest="$sha1 ${rest#*[	 ]}"
+			fi
 			;;
 		esac
 		printf '%s\n' "$command${rest:+ }$rest"
-- 
2.12.2.windows.2.406.gd14a8f8640f


