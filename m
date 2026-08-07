Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9491642D758
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 16:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786119608; cv=none; b=g55dvTN/G/BnzZ9rcijRwLTIwcf9tJjcXlJYa9fbyeTS3zpFvfwvGj5gShhYKUg8D9hQ1vfnUYeJc+eoLysiJC1PeGP7tCkjH4zJ4ewdzlyY352bUVPOmoCs/DDNeinJGPrPI0qxst9WR743hhC9olw8+vTNCsl29VvfwFJ3xoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786119608; c=relaxed/simple;
	bh=0ULmFWmNeXO1CanlCNaeTT1CxexY9iCRaLAoi4OpkSA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e+F9DoLUP5gpe5rSY5TYpj6kjV9BS4xDOcRU6pytI/5UyEAg0l7ZfSEqgh3ov5x6kFwgvQaiHdYvrptoRsdztgda377iIP8aOaH3+OQZtsBxPbiIqYqyQrKg9XnXx3al0bAhoKDdSnUt+UoCCcRmaKpGMlsb2BnQmjWA+1sTD+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PNeN/Tjc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cK+OS55f; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PNeN/Tjc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cK+OS55f"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 161C0EC010C;
	Fri,  7 Aug 2026 12:20:05 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Fri, 07 Aug 2026 12:20:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1786119605; x=
	1786206005; bh=Jil1HWj5ydy7ID9l4IWhJ6tOFW4s+IBygP6iLl69Tpo=; b=P
	NeN/TjcYrqfM4WPj5b90PWmLIs+zkw/1gEb+VQbbMEQbIaYrty9gTEB7gGtBn7nA
	sALuaWSAZDLyPb8DAIDY1zhnpIxrwxcCJq+YherRaTJU4mW6t6X1l96bc0bfOTOH
	yfnWelkO+J0s0zUWiZDh+zSWvbjQ7zvCn1Bgkkv4FVc/tFVvIpn4/+Xx1DP/llLl
	9pNCj9pty3L6xeroJg6ajR4n6WEv5AjVLUZU9gzS1SoBnAF9AMFwCS9z79QxgRQa
	EtW/YwrrPXEbsGnVOJv828kRdCDvFSfAam8pKlGQIht0//3AHegPkGJgJ82JpAOX
	7uRaU2rUMSfgqPhLyhNRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1786119605; x=1786206005; bh=J
	il1HWj5ydy7ID9l4IWhJ6tOFW4s+IBygP6iLl69Tpo=; b=cK+OS55fgDDUYF/AS
	s1F82u+9rqHps6U/2Dkg700uJAvzSkAIOHrvJzpBftcrgFCbVgVDKim2Xm5me+3W
	CaOLm9rPF6sBBbqZgY3da8M81ACo7kEVAzX5Yx05Ji55IxJhoQq/ITM+UE57J9Ho
	HbGbAuXVsD41AjXRb/+8XiJALG9iSxWhjY+RibiNjWtKBoQvM1/xaOTJrFCvoRVU
	3INpfuCgWaVo4eF22au4aM9/0IVwJfId+QqS9ysQNSLAPkJqIQADKMgueSKkkcJg
	wNCBqXhSrpcxdPVlYB5xTziyJ+5C9BbWKGl0VI0RPcgPh0QxZLM4H5Oy8R2Z4nhi
	ZVXVQ==
X-ME-Sender: <xms:swV2akafVDkPibAAOPMfY-XcQWcRth6cqoOXHQceXkwbSQvSiMjH2Q>
    <xme:swV2asSJxn9L6kWTPdlJheDPcyPLAzUinAtUFpFx7IxHHlliYSVUZcnCC8qNRu8Zv
    WBEiWZ-RxU_ffTq_jqC2WBrz9PnDmfShMMlpFA_rrkrZAKXy662cYM>
X-ME-Received: <xmr:swV2aut1i829GSQzhoKzN_erDCmrcLomEhIIa9OMx1oNNyPx0hPwPNvbVeT7pZ32dsk3gtV4GuUsTPicly7-G6ybOFfOp06s8Q>
X-ME-Proxy-Cause: dmFkZTENauiR608JuG8esu9tomFDJ7+Tmj+r+sHdv1HEFNz54od37QBkUoNs4FrxIFyBTw
    r74r+N8uRIRjUlLxyG0Yu6tnaToGUMdkT0Kf0UoOKaFNOqTm/PtnbVgtwali1nRjX0QpKD
    cEPlHwIyvYp6NzhCR3Xbpj1wqHO6cwpvtHehG6TwaWZl2SCLpzmj+5/k/slCtO5W1RN4J9
    jbZJya+F+kCpH8ULBt39i9fjKZ2KumXL3ZDpGFSJIr/9R6gZYqe5s1BWyGuGHXXZndS8X8
    kEJO+wagsIoxaKJ+Z3RnoJHNpznfLqwEuOWGAQaq7dfFtQnkKNpJ920XyMJQQUUfDuYhM8
    OShFftHzgCl2lM7l0dtkUKIbPLQorYbWM4iWIuOiDsmiTxEIOFJbRYbJH6z06CosN8c8wH
    pbysnJw9G0QCqas3JAG6FMBPf0sbHzUfyitYCwVroUQkUie1McdpyLDBmonInawr1vG52z
    4JTP7QMOm0lLT5yZByveOX2MaJtGfyGVb9mZ8RToWnLeuIFMHNUTibcbKYYIkjJbXI1Wu3
    2b81+eEJxWF2sRUYSeelDAz4DXUmxLzvK2+UoXwbQm+20LC3coxVpdbTIiHhiF5E/3bgPh
    BCXEWxZQZ3TIxM4Gyk2u4WMV5gcTZIzTaz0nqodZjgxk1w4MotmrgiasWodg
X-ME-Proxy: <xmx:swV2auGGdtA3wSouU8cfYBM2HWo60Ofycc4BdLAZUV8UgMUE0w-rHg>
    <xmx:swV2avxJs8aoN16DY9ZF--HuHGj16P6l11XtxUZJeHX-6tPcxiQKXQ>
    <xmx:swV2ao3kJTQ1MYEYytRBkgcuIt1XTXTu3GHivt791WQXZk0FvCPf6Q>
    <xmx:swV2avrkQK92xiC6lC2YMgvsXRtQXKyeWRL3ohiREJrymUv8HScTvg>
    <xmx:tQV2ahaakIZREAwEIfYfO_UG_TibR7JD2CAlFX1fBa3Y3vHa_VM8zECd>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Aug 2026 12:20:03 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Philippe Blain <levraiphilippeblain@gmail.com>,
	Britton Leo Kerin <britton.kerin@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	=?UTF-8?q?Rub=C3=A9n=20Justo?= <rjusto@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	"D. Ben Knoble" <ben.knoble@gmail.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v5 2/3] completion: complete tracked paths for 'git diff'
Date: Fri,  7 Aug 2026 09:19:55 -0700
Message-ID: <20260807161956.1004889-3-gitster@pobox.com>
X-Mailer: git-send-email 2.55.0-655-g8b87133eb9
In-Reply-To: <20260807161956.1004889-1-gitster@pobox.com>
References: <xmqqcxw010me.fsf@gitster.g>
 <20260807161956.1004889-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When completing arguments for 'git diff', _git_diff() delegates to
__git_complete_revlist_file(), which only completes revision
references.  This is good [*], as mixing both revisions and paths in a
single list for the user to pick from is simply too confusing.

If no reference matches, or if '--' is given, however, _git_diff()
leaves COMPREPLY empty.  Bash then falls back to default filename
completion in $PWD.  This fails when 'git -C <path>' is used because
$PWD is not the target repository.

Update _git_diff() to use __git_complete_index_file() when '--' is
present, or when revision reference completion yields no matching
candidates, so that tracked paths are offered as candidates.

This changes behavior even in the case where '-C <there>' is not
used.  The new behavior omits untracked paths from suggestions when
no revs match the prefix but matching tracked paths exist, which is
more useful in the context of 'git diff'.

When run outside the working tree of a repository, or when nothing
matches from revisions or tracked paths, Bash still falls back to
default filename completion in $PWD, so such a use case would be
just like completing paths for any 'diff' command, rather than for
'git diff'.

[Footnote]
 * In https://lore.kernel.org/git/al%2Fw2qgBfhe9qMg6@szeder.dev/
   SZEDER made the same argument for "git send-email 0<TAB>".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 contrib/completion/git-completion.bash |  4 +++
 t/t9902-completion.sh                  | 39 ++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index a61b6ed59a..76181e8714 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1981,6 +1981,10 @@ _git_diff ()
 		esac
 		__git_complete_revlist_file
 	fi
+
+	if [ ${#COMPREPLY[@]} -eq 0 ]; then
+		__git_complete_index_file ""
+	fi
 }
 
 __git_mergetools_common="diffuse diffmerge ecmerge emerge kdiff3 meld opendiff
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 9ae3c48ebd..55361a89e1 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -2712,6 +2712,45 @@ test_expect_success 'git -C <path> checkout uses the right repo' '
 	EOF
 '
 
+test_expect_success 'git diff completes tracked paths when no refs match' '
+	# file1 and file2 are tracked but file3 is not
+	test_completion "git diff f" <<-\EOF
+	file1
+	file2
+	EOF
+'
+
+test_expect_success 'git diff -- completes tracked paths' '
+	# file1 and file2 are tracked but file3 is not
+	test_completion "git diff -- f" <<-\EOF
+	file1
+	file2
+	EOF
+'
+
+test_expect_success 'git -C <path> diff completes tracked paths in specified repo' '
+	test_when_finished "rm -rf repo-for-diff" &&
+	git init repo-for-diff &&
+	echo content >repo-for-diff/otherfile &&
+	git -C repo-for-diff add otherfile &&
+	echo untracked >repo-for-diff/oops &&
+	git -C repo-for-diff commit -m otherfile &&
+	test_completion "git -C repo-for-diff diff o" <<-\EOF
+	otherfile
+	EOF
+'
+
+test_expect_success 'git -C <path> diff -- completes pathspecs in specified repo' '
+	test_when_finished "rm -rf repo-for-diff" &&
+	git init repo-for-diff &&
+	echo content >repo-for-diff/otherfile &&
+	git -C repo-for-diff add otherfile &&
+	git -C repo-for-diff commit -m otherfile &&
+	test_completion "git -C repo-for-diff diff -- o" <<-\EOF
+	otherfile
+	EOF
+'
+
 test_expect_success 'show completes all refs' '
 	test_completion "git show m" <<-\EOF
 	main Z
-- 
2.55.0-655-g8b87133eb9

