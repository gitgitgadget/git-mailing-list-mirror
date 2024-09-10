Received: from impout001.msg.chrl.nc.charter.net (impout001aa.msg.chrl.nc.charter.net [47.43.20.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250CF15C156
	for <git@vger.kernel.org>; Tue, 10 Sep 2024 04:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.43.20.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725941534; cv=none; b=GJ5o/ZmhPk6idfsIaY734FdA9yF/7p7qBuiiQacn0UhrR0Rq6ZYL6hJU0dbUKWU5p1RGd/1j4vhVfMNVbzRd6vVgEN3moBOIWVydj196zy2NWaSMkpwH48crxVpFLGJ3Ri1UziFtBUfG/dIznl/78+4Dt3wcb/x76erK95gfW3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725941534; c=relaxed/simple;
	bh=8HWUxLDiG5efToWdx+yAU1LN0lZ33k1XatBWWSgocD8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SBzmcFOddHha42VSs6LNPBsGvgUOLBWnu6dPBYDZYX+kL/1UmITuq+Bn6o/H5dCrLneVQahMZD8YFXXkE2vZapOehRjnOWouiddL9+GbO8Sv3AWs2eFm4OjhAIc4Y0Jog3ZgXtd1AO5eQ6Ca7cXDZl7Wgweu9R5+UM81+GGEv1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=charter.net; spf=pass smtp.mailfrom=charter.net; dkim=pass (2048-bit key) header.d=charter.net header.i=@charter.net header.b=H6ZIM9+5; arc=none smtp.client-ip=47.43.20.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=charter.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=charter.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=charter.net header.i=@charter.net header.b="H6ZIM9+5"
Received: from localhost.localdomain ([97.71.114.58])
	by cmsmtp with ESMTPA
	id nsCys18E7ZJqtnsD4sAPk8; Tue, 10 Sep 2024 04:10:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=charter.net;
	s=c20240129; t=1725941435;
	bh=8HWUxLDiG5efToWdx+yAU1LN0lZ33k1XatBWWSgocD8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=H6ZIM9+5FeGErRhjKuBBVInrl1llEplKs5YAtFpviLSRGuFk74W3VmsLhRMxW3Mls
	 fMxNucB6db2+YNUN/PidjGEPkPlLHwqlhWGwVxmuSE0Zumhw93Lis6+cG1OJrErfy9
	 poeRGLDgPG/Vfkotcl33dg7VufoEqNAms93KGdH1bxPReFLP86wp+uHvpOMdpnuMbQ
	 EsZK/18kc/02/Ws2WZQjt/gSBig688ZVbKPZiv78IrQB/tl/xBWY5OPYKjgwTcCjn7
	 doBW4IXfz/trE2U/+Z8b11ZzkXRcRqIpbTSdesLN/X4IhsmXhNh97Ds1RjEZO64Y5N
	 D1LwVuo7YRg8g==
Authentication-Results: charter.net; auth=pass (LOGIN)
 smtp.auth=ericsunshine@charter.net
X-Authority-Analysis: v=2.4 cv=GtNE+F1C c=1 sm=1 tr=0 ts=66dfc6bb
 a=4h87Vkt5vDwEBqoyvSX4iA==:117 a=4h87Vkt5vDwEBqoyvSX4iA==:17 a=BCjA09oAAAAA:8
 a=CiDZ7TDfkiE2MZKSJG4A:9 a=jYKBPJSq9nmHKCndOPe9:22
From: Eric Sunshine <ericsunshine@charter.net>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 3/3] chainlint: reduce annotation noise-factor
Date: Tue, 10 Sep 2024 00:10:13 -0400
Message-ID: <20240910041013.68948-4-ericsunshine@charter.net>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910041013.68948-1-ericsunshine@charter.net>
References: <20240829091625.41297-1-ericsunshine@charter.net>
 <20240910041013.68948-1-ericsunshine@charter.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfKou+fqMIKVEAU0++x3digitUxtLjTjEWNGKe2BFRSRbiiYl7EKfYTWX+/+7IujAU9e6nMJjYJr/nF7uSPkf8i54QAW1IHO5r2qg6QJBzY2KzCMNnrel
 jEpu/YCCKQp9mx+rsl37uonzBTI4S9k2JvcnGL0K0qkcJA2Knv+v5u+i3tNhUuofdm0kQV/+J0G5J3PHkFaVgcRELfE/U9lcIrqvS3vItIwSF1Y1cHvmYxAh
 68OsdlFmgWs0q9mj/PtihMNQbDevm7RMFhvmheOniNudjsoCdVkVtWwoL2TGM7rI2EVMj6cQVlvwn6EJamKhTA==

From: Eric Sunshine <sunshine@sunshineco.com>

When chainlint detects a problem in a test definition, it highlights the
offending code with a "?!...?!" annotation. The rather curious "?!"
decoration was chosen to draw the reader's attention to the problem area
and to act as a good "needle" when using the terminal's search feature
to "jump" to the next problem.

Later, chainlint learned to color its output when sent to a terminal.
Problem annotations are colored with a red background which stands out
well from surrounding text, thus easily draws the reader's attention.
Together with the preceding change which gave all problem annotations a
uniform "LINT:" prefix, the noisy "?!" decoration has become superfluous
as a search "needle" so omit it when output is colored.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/chainlint.pl | 3 ++-
 t/test-lib.sh  | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/chainlint.pl b/t/chainlint.pl
index ad26499478..f0598e3934 100755
--- a/t/chainlint.pl
+++ b/t/chainlint.pl
@@ -651,6 +651,7 @@ sub check_test {
 	$self->{nerrs} += @$problems;
 	return unless $emit_all || @$problems;
 	my $c = main::fd_colors(1);
+	my ($erropen, $errclose) = -t 1 ? ("$c->{rev}$c->{red}", $c->{reset}) : ('?!', '?!');
 	my $start = 0;
 	my $checked = '';
 	for (sort {$a->[1]->[2] <=> $b->[1]->[2]} @$problems) {
@@ -659,7 +660,7 @@ sub check_test {
 		my $err = format_problem($label);
 		$checked .= substr($body, $start, $pos - $start);
 		$checked .= ' ' unless $checked =~ /\s$/;
-		$checked .= "$c->{rev}$c->{red}?!LINT: $err?!$c->{reset}";
+		$checked .= "${erropen}LINT: $err$errclose";
 		$checked .= ' ' unless $pos >= length($body) ||
 		    substr($body, $pos, 1) =~ /^\s/;
 		$start = $pos;
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 54247604cb..278d1215f1 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1606,7 +1606,7 @@ if test "${GIT_TEST_CHAIN_LINT:-1}" != 0 &&
    test "${GIT_TEST_EXT_CHAIN_LINT:-1}" != 0
 then
 	"$PERL_PATH" "$TEST_DIRECTORY/chainlint.pl" "$0" ||
-		BUG "lint error (see '?!...!? annotations above)"
+		BUG "lint error (see 'LINT' annotations above)"
 fi
 
 # Last-minute variable setup
-- 
2.46.0

