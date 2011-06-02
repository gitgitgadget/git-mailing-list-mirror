From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git status --ignored
Date: Thu, 02 Jun 2011 09:08:18 -0700
Message-ID: <7vk4d4dxn1.fsf@alter.siamese.dyndns.org>
References: <4DE712CE.20509@vpac.org>
 <7vr57cerxo.fsf@alter.siamese.dyndns.org>
 <20110602055449.GA28292@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andrew Spiers <aspiers@vpac.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 02 18:09:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QSASB-0005lL-6z
	for gcvg-git-2@lo.gmane.org; Thu, 02 Jun 2011 18:08:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752960Ab1FBQIa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2011 12:08:30 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:50862 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752625Ab1FBQI3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2011 12:08:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 01A4352EC;
	Thu,  2 Jun 2011 12:10:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9/t9mfU6Kv2chQ3Be0GYcrBg3O0=; b=FQC6BS
	Wc/ub7pwVvska4PR0fYpPk0MJKS90IpOCWqa2s/f2CpoqFkBIB5nMglio/TG1Oad
	N82inNS04zhkZVSqkOWdiIk5HN51WoWVLspZhW0AlNuLDeaBH5Koyht+UTIQt10y
	Xpc+6kH3rZTloeotGfZMtlfk5lidp94jTFKt0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NnGetWF242jvZdUBuIA6Ndbt3QZC+IaX
	yRIbvVU0NtdfrylKgrKRxizEmF/CfntIbmvhGNJMWxHAx8pRK+WTK+aSBGhtDmV8
	ZKSr1z4E3e2rZlaxwHcaJsxFKGzazU83mPhwC0DnKA53IoIwdW0TnE7lltTQqKUr
	aTOE7qMq2i4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C163452EB;
	Thu,  2 Jun 2011 12:10:33 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 54F6652EA; Thu,  2 Jun 2011
 12:10:29 -0400 (EDT)
In-Reply-To: <20110602055449.GA28292@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 2 Jun 2011 01:54:49 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D8408FF6-8D32-11E0-AB77-EA23C7C1A288-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174958>

Jeff King <peff@peff.net> writes:

> I can reproduce here. The faulty logic means the bug only shows when you
> actually have no real untracked files. You should keep your git
> directory cleaner. ;)

Ok.

-- >8 --
Subject: [PATCH] git status --ignored: tests and docs

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-status.txt |    6 ++++
 t/t7508-status.sh            |   64 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 70 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index 1cab91b..b663e51 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -49,6 +49,9 @@ See linkgit:git-config[1] for configuration variable
 used to change the default for when the option is not
 specified.
 
+--ignored::
+	Show ignored files as well.
+
 -z::
 	Terminate entries with NUL, instead of LF.  This implies
 	the `--porcelain` output format if no other format is given.
@@ -80,6 +83,8 @@ shows the status of stage #3 (i.e. theirs).
 For entries that do not have conflicts, `X` shows the status of the index,
 and `Y` shows the status of the work tree.  For untracked paths, `XY` are
 `??`.
+For ignored paths, `XY` are `!!`; they are shown only when the `--ignored`
+option is in effect.
 
     X          Y     Meaning
     -------------------------------------------------
@@ -102,6 +107,7 @@ and `Y` shows the status of the work tree.  For untracked paths, `XY` are
     U           U    unmerged, both modified
     -------------------------------------------------
     ?           ?    untracked
+    !           !    ignored
     -------------------------------------------------
 
 
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index 556d0fa..b47aad8 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -86,6 +86,70 @@ test_expect_success 'status -s (2)' '
 
 '
 
+test_expect_success 'status with gitignore' '
+	{
+		echo ".gitignore" &&
+		echo "expect" &&
+		echo "output" &&
+		echo "untracked"
+	} >.gitignore &&
+
+	cat >expect <<-\EOF &&
+	 M dir1/modified
+	A  dir2/added
+	?? dir2/modified
+	EOF
+	git status -s >output &&
+	test_cmp expect output &&
+
+	cat >expect <<-\EOF &&
+	 M dir1/modified
+	A  dir2/added
+	?? dir2/modified
+	!! .gitignore
+	!! dir1/untracked
+	!! dir2/untracked
+	!! expect
+	!! output
+	!! untracked
+	EOF
+	git status -s --ignored >output &&
+	test_cmp expect output
+'
+
+test_expect_success 'status with gitignore' '
+	{
+		echo ".gitignore" &&
+		echo "expect" &&
+		echo "dir2/modified" &&
+		echo "output" &&
+		echo "untracked"
+	} >.gitignore &&
+
+	cat >expect <<-\EOF &&
+	 M dir1/modified
+	A  dir2/added
+	EOF
+	git status -s >output &&
+	test_cmp expect output &&
+
+	cat >expect <<-\EOF &&
+	 M dir1/modified
+	A  dir2/added
+	!! .gitignore
+	!! dir1/untracked
+	!! dir2/modified
+	!! dir2/untracked
+	!! expect
+	!! output
+	!! untracked
+	EOF
+	git status -s --ignored >output &&
+	test_cmp expect output
+'
+
+rm -f .gitignore
+
 cat >expect <<EOF
 # On branch master
 # Changes to be committed:
-- 
1.7.6.rc0.98.gc12085
