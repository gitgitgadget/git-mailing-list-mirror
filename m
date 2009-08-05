From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH 0/5] Revamping "git status"
Date: Wed, 5 Aug 2009 19:40:46 +0200
Message-ID: <200908051940.48110.trast@student.ethz.ch>
References: <1249463746-21538-1-git-send-email-gitster@pobox.com> <7vbpmub3la.fsf@alter.siamese.dyndns.org> <200908051937.36255.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 05 19:41:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYkU8-0001hl-Sl
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 19:41:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750799AbZHERlB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 13:41:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750771AbZHERlA
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 13:41:00 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:50165 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750706AbZHERlA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 13:41:00 -0400
Received: from CAS02.d.ethz.ch (129.132.178.236) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.1.375.2; Wed, 5 Aug
 2009 19:41:00 +0200
Received: from thomas.localnet (84.74.103.245) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.1.375.2; Wed, 5 Aug
 2009 19:41:00 +0200
User-Agent: KMail/1.12.0 (Linux/2.6.27.25-0.1-default; KDE/4.2.98; x86_64; ; )
In-Reply-To: <200908051937.36255.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124930>

Thomas Rast wrote:
> +test_expect_failure 'M/D conflict does not segfault' '
> +	mkdir mdconflict &&
> +	cd mdconflict &&
> +	git init &&
> +	test_commit initial foo '' &&
> +	test_commit modify foo foo &&
> +	git checkout -b side HEAD^ &&
> +	git rm foo &&
> +	git commit -m delete &&
> +	git merge master &&
> +	git status
> +'
> +

Meh, this stops before the git-status because merge signals a
conflict.  However, the following really crashes.  Promise.

-- 8< --
diff --git i/t/t7060-wtstatus.sh w/t/t7060-wtstatus.sh
index 5ad2cd1..a152a26 100755
--- i/t/t7060-wtstatus.sh
+++ w/t/t7060-wtstatus.sh
@@ -28,4 +28,17 @@ test_expect_success 'Report new path with conflict' '
 	test_cmp expect actual
 '
 
+test_expect_failure 'M/D conflict does not segfault' '
+	mkdir mdconflict &&
+	cd mdconflict &&
+	git init &&
+	test_commit initial foo '' &&
+	test_commit modify foo foo &&
+	git checkout -b side HEAD^ &&
+	git rm foo &&
+	git commit -m delete &&
+	test_must_fail git merge master &&
+	git status
+'
+
 test_done
-- >8 --

Sorry for all the confusion.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
