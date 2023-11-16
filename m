Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Z6VE2Ipk"
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1117D19D
	for <git@vger.kernel.org>; Thu, 16 Nov 2023 00:08:59 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5BE551AC70F;
	Thu, 16 Nov 2023 03:08:58 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Io7n6/CtPW3BEYDEveYxYgySjFXFH+ZeF1Cf3u
	+X+JA=; b=Z6VE2IpkYBUNhPneOgmiw14zIs0ax4m87rk4ZHLaOUx3kJJAF5klQr
	SXdFU7pSu+WpIhH0RO08SNKHPBJFMalPkBeBVuSLDPLocddB0snFGiCXpwuKcdfp
	ar/7AzlCnTgaBugW5jwhuzKcPtDSHG7ZAIjU42oRq8TBAtoDvKfWU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 53F801AC70C;
	Thu, 16 Nov 2023 03:08:58 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BA6E81AC70B;
	Thu, 16 Nov 2023 03:08:57 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Joanna Wang <jojwang@google.com>
Cc: git@vger.kernel.org,  sunshine@sunshineco.com,  tboegi@web.de
Subject: Re: [PATCH 1/1] attr: add builtin objectmode values support
In-Reply-To: <xmqqsf56ql14.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	16 Nov 2023 15:17:43 +0900")
References: <xmqqttpmtnn5.fsf@gitster.g>
	<20231116054437.2343549-1-jojwang@google.com>
	<xmqqsf56ql14.fsf@gitster.g>
Date: Thu, 16 Nov 2023 17:08:56 +0900
Message-ID: <xmqqil62qfvr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 6479CD9C-8457-11EE-9D02-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> Other than the removal of that file, I locally applied the following
> fix-up while checking the difference relative to the previous
> iteration.

Cumulatively, aside from the removal of the t/#t* file, here is what
I ended up with so far.

Subject: [PATCH] SQUASH???

---
 Documentation/gitattributes.txt |  2 +-
 neue                            |  0
 t/t0003-attributes.sh           |  5 +++--
 t/t6135-pathspec-with-attrs.sh  | 10 ++++++----
 4 files changed, 10 insertions(+), 7 deletions(-)
 create mode 100644 neue

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 784aa9d4de..201bdf5edb 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -108,7 +108,7 @@ user defined attributes under this namespace will be ignored and
 trigger a warning.
 
 `builtin_objectmode`
-^^^^^^^^^^^^^^^^^^^^
+~~~~~~~~~~~~~~~~~~~~
 This attribute is for filtering files by their file bit modes (40000,
 120000, 160000, 100755, 100644). e.g. ':(attr:builtin_objectmode=160000)'.
 You may also check these values with `git check-attr builtin_objectmode -- <file>`.
diff --git a/neue b/neue
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index 86f8681570..774b52c298 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -580,12 +580,13 @@ test_expect_success 'builtin object mode attributes work (dir and regular paths)
 '
 
 test_expect_success POSIXPERM 'builtin object mode attributes work (executable)' '
-	>exec && chmod +x exec &&
+	>exec &&
+	chmod +x exec &&
 	attr_check_object_mode exec 100755
 '
 
 test_expect_success SYMLINKS 'builtin object mode attributes work (symlinks)' '
-	>to_sym ln -s to_sym sym &&
+	ln -s to_sym sym &&
 	attr_check_object_mode sym 120000
 '
 
diff --git a/t/t6135-pathspec-with-attrs.sh b/t/t6135-pathspec-with-attrs.sh
index b08a32ea68..f6403ebbda 100755
--- a/t/t6135-pathspec-with-attrs.sh
+++ b/t/t6135-pathspec-with-attrs.sh
@@ -295,22 +295,24 @@ test_expect_success 'reading from .gitattributes in a subdirectory (3)' '
 	test_cmp expect actual
 '
 
-test_expect_success 'pathspec with builtin_objectmode attr can be used' '
+test_expect_success POSIXPERM 'pathspec with builtin_objectmode attr can be used' '
 	>mode_exec_file_1 &&
 
 	git status -s ":(attr:builtin_objectmode=100644)mode_exec_*" >actual &&
 	echo ?? mode_exec_file_1 >expect &&
 	test_cmp expect actual &&
 
-	git add mode_exec_file_1 && chmod +x mode_exec_file_1 &&
+	git add mode_exec_file_1 &&
+	chmod +x mode_exec_file_1 &&
 	git status -s ":(attr:builtin_objectmode=100755)mode_exec_*" >actual &&
 	echo AM mode_exec_file_1 >expect &&
 	test_cmp expect actual
 '
 
-test_expect_success 'builtin_objectmode attr can be excluded' '
+test_expect_success POSIXPERM 'builtin_objectmode attr can be excluded' '
 	>mode_1_regular &&
-	>mode_1_exec  && chmod +x mode_1_exec &&
+	>mode_1_exec  &&
+	chmod +x mode_1_exec &&
 	git status -s ":(exclude,attr:builtin_objectmode=100644)" "mode_1_*" >actual &&
 	echo ?? mode_1_exec >expect &&
 	test_cmp expect actual &&
-- 
2.43.0-rc2

