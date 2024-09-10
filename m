Received: from impout001.msg.chrl.nc.charter.net (impout001aa.msg.chrl.nc.charter.net [47.43.20.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A9A1804F
	for <git@vger.kernel.org>; Tue, 10 Sep 2024 04:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.43.20.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725941533; cv=none; b=rA4VSEihzJT48ygJxaxVB9mhyEzVpcWz6NWETPUa7m0pH7ZuDF1qIT+apz4nj7kzVptb8uE187I+mo5uHSlTBmv/bIk39jbv+CG46ekUl5uKpvNE16WFamjv4ONFRZ1zt1xJTJpp3+zj7XixJb4OET93lGIDRM7o9GOcdIojh84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725941533; c=relaxed/simple;
	bh=98pDbBLbVRAZkKWMH7EdwV6v8lGgbB8sHHzHjKEWBas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fILFOn3nX91ZZdJug3xLprxkZociqeIgkGb7bXB9n2zKhw/I9qTYrIIwYxP+85opA/kGfYtf62CjS1DIvrXvKylvjdeIufAXqLr9yXG9sJpuopcKhysk1oGOTWg+n95T7P2X/TM++n2xk/zTqbgVdmHyxqMA2pbzoCEgrUX22u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=charter.net; spf=pass smtp.mailfrom=charter.net; dkim=pass (2048-bit key) header.d=charter.net header.i=@charter.net header.b=BL968A5x; arc=none smtp.client-ip=47.43.20.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=charter.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=charter.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=charter.net header.i=@charter.net header.b="BL968A5x"
Received: from localhost.localdomain ([97.71.114.58])
	by cmsmtp with ESMTPA
	id nsCys18E7ZJqtnsD3sAPjy; Tue, 10 Sep 2024 04:10:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=charter.net;
	s=c20240129; t=1725941434;
	bh=98pDbBLbVRAZkKWMH7EdwV6v8lGgbB8sHHzHjKEWBas=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BL968A5xatS0S5DdM3j8JWoNC7OB0g+bI2ua6xvKXrzZPi/drhMR36FyoLrIgBJLl
	 AGCC3tp0Bf/FZH/2qfHvb5iQYQbfwBhvNkn9RgvB75ZlFVN5Q2La1EC/rBPn7Qjnwe
	 lRRcUAuudXNpimYSE3KG5Tz/Y4Fjd4w1vCMc2nSNWDUNY8mkCuakzZIhQ35w56daih
	 BFV5lotDgwLqcnHG2Bs/gl1JhiaGTeVo9FUwj6G4kKr3lal7qJheM9hlsuz5vAhuMa
	 EsYm3EeUgHkQfIRFmq72lAKHyHqr2PV1awPppnM3jJHtx19G7eC6LmBgrhGepOjO1Q
	 XyrIojzqCLohg==
Authentication-Results: charter.net; auth=pass (LOGIN)
 smtp.auth=ericsunshine@charter.net
X-Authority-Analysis: v=2.4 cv=GtNE+F1C c=1 sm=1 tr=0 ts=66dfc6ba
 a=4h87Vkt5vDwEBqoyvSX4iA==:117 a=4h87Vkt5vDwEBqoyvSX4iA==:17
 a=n9JyWdpkmUyDeySV:21 a=BCjA09oAAAAA:8 a=ZaTx-6xbZQqaopwlVqcA:9
 a=jYKBPJSq9nmHKCndOPe9:22
From: Eric Sunshine <ericsunshine@charter.net>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 1/3] chainlint: don't be fooled by "?!...?!" in test body
Date: Tue, 10 Sep 2024 00:10:11 -0400
Message-ID: <20240910041013.68948-2-ericsunshine@charter.net>
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
X-CMAE-Envelope: MS4xfPW2FhGIvsjxJxEM+pyX7f71if/Ed7x7Sbqn8H90yFJkPZ3cs9ygPEDXySaunURjs4aAvksobEw5y+l9ord2E8qN5g3vmZZp6l+xxL8UH/w6A0Vz2BAY
 XL4DRXGxsyD0AvORWmX3WNm5UqfFulE4P5YnPwlJabd6mDy73IRLLD5UIH9tAvv51NWtDGWI6NLkR8e6Y+r0zhNOloAKCxVxiuhAyRwO8tMHoD1hGm/fkoIK
 9cq4EOg5V4CE8KzDBkfA8Ep3BVm61LPID3WQJlIw2JhCSqa9hMkmY8Ct27rcWTcRRe8mfEXO7S8EdyQZwnJu9A==

From: Eric Sunshine <sunshine@sunshineco.com>

As originally implemented, chainlint did not collect structured
information about detected problems. Instead, it merely emitted raw
parse tokens (not the original test text), along with a "?!...?!"
annotation directly into the output stream each time a problem was
discovered. In order to report statistics (in --stats mode) and to
adjust its exit code to indicate success or failure, it merely counts
the number of times "?!...?!" appears in the output stream. An obvious
shortcoming of this approach is that it can be fooled by a legitimate
"?!...?!" sequence in the body of a test (though, only if an actual
problem is detected in the test).

The situation did not improve when 7c04aa7390 (chainlint: colorize
problem annotations and test delimiters, 2022-09-13) colored the
annotations after-the-fact by searching for "?!...?!" in the output
stream and inserting color codes. As above, a shortcoming is that this
approach can incorrectly color a legitimate "?!...?!" sequence in a test
body as if it is an error.

However, when 73c768dae9 (chainlint: annotate original test definition
rather than token stream, 2022-11-08) taught chainlint to output the
original test text verbatim, it started collecting structured
information about detected problems.

Now that it is available, take advantage of the structured problem
information to deterministically count the number of problems detected
and to color the annotations directly, rather than scanning the output
stream for "?!...?!" and performing these operations after-the-fact.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/chainlint.pl | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/t/chainlint.pl b/t/chainlint.pl
index 5361f23b1d..1a7611ad43 100755
--- a/t/chainlint.pl
+++ b/t/chainlint.pl
@@ -587,6 +587,7 @@ sub new {
 	my $class = shift @_;
 	my $self = $class->SUPER::new(@_);
 	$self->{ntests} = 0;
+	$self->{nerrs} = 0;
 	return $self;
 }
 
@@ -634,6 +635,7 @@ sub check_test {
 	my $parser = TestParser->new(\$body);
 	my @tokens = $parser->parse();
 	my $problems = $parser->{problems};
+	$self->{nerrs} += @$problems;
 	return unless $emit_all || @$problems;
 	my $c = main::fd_colors(1);
 	my $start = 0;
@@ -641,15 +643,16 @@ sub check_test {
 	for (sort {$a->[1]->[2] <=> $b->[1]->[2]} @$problems) {
 		my ($label, $token) = @$_;
 		my $pos = $token->[2];
-		$checked .= substr($body, $start, $pos - $start) . " ?!$label?! ";
+		$checked .= substr($body, $start, $pos - $start);
+		$checked .= ' ' unless $checked =~ /\s$/;
+		$checked .= "$c->{rev}$c->{red}?!$label?!$c->{reset}";
+		$checked .= ' ' unless $pos >= length($body) ||
+		    substr($body, $pos, 1) =~ /^\s/;
 		$start = $pos;
 	}
 	$checked .= substr($body, $start);
 	$checked =~ s/^/$lineno++ . ' '/mge;
 	$checked =~ s/^\d+ \n//;
-	$checked =~ s/(\s) \?!/$1?!/mg;
-	$checked =~ s/\?! (\s)/?!$1/mg;
-	$checked =~ s/(\?![^?]+\?!)/$c->{rev}$c->{red}$1$c->{reset}/mg;
 	$checked =~ s/^\d+/$c->{dim}$&$c->{reset}/mg;
 	$checked .= "\n" unless $checked =~ /\n$/;
 	push(@{$self->{output}}, "$c->{blue}# chainlint: $title$c->{reset}\n$checked");
@@ -791,9 +794,9 @@ sub check_script {
 			my $c = fd_colors(1);
 			my $s = join('', @{$parser->{output}});
 			$emit->("$c->{bold}$c->{blue}# chainlint: $path$c->{reset}\n" . $s);
-			$nerrs += () = $s =~ /\?![^?]+\?!/g;
 		}
 		$ntests += $parser->{ntests};
+		$nerrs += $parser->{nerrs};
 	}
 	return [$id, $nscripts, $ntests, $nerrs];
 }
-- 
2.46.0

