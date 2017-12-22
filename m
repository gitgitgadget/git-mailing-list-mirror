Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A4B81F406
	for <e@80x24.org>; Fri, 22 Dec 2017 23:55:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756923AbdLVXzp (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Dec 2017 18:55:45 -0500
Received: from mout.gmx.net ([212.227.17.22]:55075 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756902AbdLVXzo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Dec 2017 18:55:44 -0500
Received: from [192.168.0.129] ([37.201.193.73]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MJGFi-1eQsCX2Azi-002qae; Sat, 23
 Dec 2017 00:55:39 +0100
Date:   Sat, 23 Dec 2017 00:55:38 +0100 (STD)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Liam Beguin <liambeguin@gmail.com>
Subject: [PATCH 1/5] rebase: do not continue when the todo list generation
 failed
In-Reply-To: <cover.1513986836.git.johannes.schindelin@gmx.de>
Message-ID: <834ea65b997a052dc47f1bcda5d95865d79a20c9.1513986836.git.johannes.schindelin@gmx.de>
References: <cover.1513986836.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:E09h8uvNv/nPXSYeoEjX3N1FgKNG9syFyNcX0FUN193+P0HjdPh
 adUvwqqrb8zPFXENpr2a8TKOOPUTIz8dLp5qBcuYQamfPduxbbZM9zrnF0l2ISfqrhEeqKo
 o/rFL37K8PNK52u3YxCBPSB8yRZq7Kq1FnvOjvePRZCDgziXoJ/oic9XwIJO7qmLcBRfgAo
 sx2vbXynlQ3NaJTeJq4GA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:4LZ/0bHWdwE=:U/giGQkkuoCfw4han5Rgrp
 dndxiRUR/R7j8Tf97Pbws1NmaF+ybtOMvbVOikmMGZK7Rv23Gnt+EWEdzasphb6ir1uJtv3iD
 0bOM05n4pCxsfoJT8YPwmhfQtbfi2OwhBjU2HbHAx3p3xm8jvw/7kiWTrv1Z/3vbfNkh2p+3M
 VVdiKu4hB7QhtYWnZ2WTo00TS6M1C0RIxJegGMtgT0bjG7r7BAecIWSztnGHdgUX9n1cHRX1y
 JIo09UpS05+nZFsH/2UHvmQsdF8fj5Fr4ItON3UyKnvRIgjurXPtFcIt5B0kzrP1QW+JJPJN1
 SFZpfTb4b5sWD190XtbtGq4CNP1ytZORZpW5N/gqBgzW096/L2FeYFAeVKA31LJb0flMBp8Si
 504xiK1zYjSvhhtyhuBukwxGm60L8VcniU+xet2MWzRQ2j5p/VVVmkFOQmtUL15bjGCOE+eaE
 X6yQRExJ/UEHTOgpEsto5QUVcOEz6iH+QGC5un1TWQ+uA8d8MyRhI9RKsk4jJxqwiYs9qOtbO
 /jK6PY1aSxOC6ZhVid8C9hGrH+GghvBHxEIeYpwe7m7IJbBX0NSCZvzhSD6bNRxFAqV4IRXPZ
 JfhOQFX42wf1fdBErcHYxPHG+Ey9DguKaMyGUkj33hzPIc95Zn1/CjexanxwQLgAuPYQOf0HZ
 dDu4nc2AZM1RWuxe1frpZwL3uC7abPMQqFBKjhtsIjXF8fonoUgnEpWC76YV7VfPah0pIdX0i
 lOd4BUu9YvjVMwAe/q4xxbqk6i7sa3S16o4xA9m+FA0azQeZDg/oih1Sg84W0BuqP6nvr3nKz
 EATxwBy9a4jTyYuQQipIuBvVibdV4b+WnxUyvBnWEKgQ7IY1Pc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a *really* long-standing bug. As a matter of fact, this bug has
been with us from the very beginning of `rebase -i`: 1b1dce4bae7 (Teach
rebase an interactive mode, 2007-06-25), where the output of `rev-list`
was piped to `sed` (and any failure of the `rev-list` process would go
completely undetected).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-rebase--interactive.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index e3f5a0abf3c..b7f95672bd9 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -893,7 +893,8 @@ fi
 if test t != "$preserve_merges"
 then
 	git rebase--helper --make-script ${keep_empty:+--keep-empty} \
-		$revisions ${restrict_revision+^$restrict_revision} >"$todo"
+		$revisions ${restrict_revision+^$restrict_revision} >"$todo" ||
+	die "$(gettext "Could not generate todo list")"
 else
 	format=$(git config --get rebase.instructionFormat)
 	# the 'rev-list .. | sed' requires %m to parse; the instruction requires %H to parse
-- 
2.15.1.windows.2


