From: Adam Dinwoodie <adam@dinwoodie.org>
Subject: [PATCH] commit: --amend -m '' silently fails to wipe message
Date: Wed, 6 Apr 2016 18:15:03 +0100
Message-ID: <20160406171503.GA2345@dinwoodie.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Chris Webb <chris@arachsys.com>, Jeff King <peff@peff.net>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 06 19:15:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anr3B-0002V4-D5
	for gcvg-git-2@plane.gmane.org; Wed, 06 Apr 2016 19:15:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752403AbcDFRPU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Apr 2016 13:15:20 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:36157 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751358AbcDFRPT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2016 13:15:19 -0400
Received: by mail-wm0-f52.google.com with SMTP id v188so30393799wme.1
        for <git@vger.kernel.org>; Wed, 06 Apr 2016 10:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=8EE/Ncwg8o1OcVHTpj70g27HEhxTEd695JK5DFTtVTg=;
        b=jj7cHQuShr+l/vjEBLT+U3vZsxOc/wfPk+ZdsdL65ZvXYyFqrp15m8p0GuaGe3INWa
         gCBk64Mxri71r/bzVJN4bO3axVBjo6AUjiyuPl8Z2h7zAX0YtmbCpuYuwgcuC3WDuj/L
         5i1pqjE+vQvSZlPWM9+LmQDhOEd+aQ6JiHJOI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=8EE/Ncwg8o1OcVHTpj70g27HEhxTEd695JK5DFTtVTg=;
        b=cSmuxzfBxGT4LmH+AZXhKui7mTOnygsj3oz42FFVgj+vYSSN+JRBpRgxZGlIFeOa7z
         YF8RGHI7EqQogFYMFQ56JL9FbTAKga41tx69nPvPUgcy4+wuiRwR+NyHNnfzGTENlH5q
         L4EezJ+shKs03xk5KcDPq7MLiTfyi+qIAFFjrudySw2eY+wVuA3E5hR//5COEOw5r7ub
         7g8AvOeZYRdEL4mOAyO6Be7kFs7hLjafYj8oen3uRnc4ZXZo/8R1Ody/ERUaJM6as27o
         7ghyDdzikc1VV64jiYJEQ5APKZeMevVlrMDrhwaYTrMDkKkEZvGZZIWD4TjsGTsKY6J9
         FLcQ==
X-Gm-Message-State: AD7BkJKIZhP52ZxkGDFEkFmkjudS10g9rzUUO9eq7IwIsrVgrskQRaqHNzp5PRpIE9j1jA==
X-Received: by 10.194.121.136 with SMTP id lk8mr22696211wjb.92.1459962917467;
        Wed, 06 Apr 2016 10:15:17 -0700 (PDT)
Received: from dinwoodie.org ([2001:ba8:0:1c0::9:1])
        by smtp.gmail.com with ESMTPSA id kq9sm4217612wjc.26.2016.04.06.10.15.16
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 06 Apr 2016 10:15:16 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290855>

`git commit --amend -m ''` seems to be an unambiguous request to blank =
a
commit message, but it actually leaves the commit message as-is.  That'=
s
the case regardless of whether `--allow-empty-message` is specified, an=
d
doesn't so much as drop a non-zero return code.

Add failing tests to show this behaviour.

Signed-off-by: Adam Dinwoodie <adam@dinwoodie.org>
---

I've had to guess at the correct file to add these tests to; t7500
covers the mainline --allow-empty-message cases, while t7501 doesn't
(currently) cover --allow-empty-message but does cover --amend.  I've
made an educated guess about the correct file, but moving the new tests
to the other file should be reasonably trivial.

 t/t7501-commit.sh | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
index 63e0427..a7e9322 100755
--- a/t/t7501-commit.sh
+++ b/t/t7501-commit.sh
@@ -200,6 +200,26 @@ test_expect_success '--amend --edit of empty messa=
ge' '
 	test_cmp expect msg
 '
=20
+test_expect_failure '--amend to set message to empty' '
+	echo bat=E1 >file &&
+	git add file &&
+	git commit -m "unamended" &&
+	git commit --amend --allow-empty-message -m "" &&
+	git diff-tree -s --format=3D%s HEAD >msg &&
+	echo "" >expect &&
+	test_cmp expect msg
+'
+
+test_expect_failure '--amend to set empty message needs --allow-empty-=
message' '
+	echo conga >file &&
+	git add file &&
+	git commit -m "unamended" &&
+	test_must_fail git commit --amend -m "" &&
+	git diff-tree -s --format=3D%s HEAD >msg &&
+	echo "unamended" >expect &&
+	test_cmp expect msg
+'
+
 test_expect_success '-m --edit' '
 	echo amended >expect &&
 	git commit --allow-empty -m buffer &&
--=20
2.7.4
