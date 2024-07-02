Received: from impout008.msg.chrl.nc.charter.net (impout008aa.msg.chrl.nc.charter.net [47.43.20.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1702D15B10B
	for <git@vger.kernel.org>; Tue,  2 Jul 2024 23:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.43.20.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719964364; cv=none; b=mnOFOGWNdD1lXwzs89uF5aoX4AS5AzrVR2+dzt7WFZvBLYEN8JMiegTcvGy2BqZ9jorWMUK4GVjP50kUi1JwBfjPeGfabluJM7MkOXE8uGeiU8b72zu3XRRINtW3Ni0NORtE7Pt2NX/SdB8banDmCBF5NFwDsOFebeBRiOQtMyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719964364; c=relaxed/simple;
	bh=B5fBxzZuO/0xbgk+2/HGwd1r1WXAwcU47ktgH5AggZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j44E/ICd3upkiM92OaS6wmy2lbz02nq4PWKHBGGdQ1/cOh6qRM1lH5L66OEF1tXnqNNiNPp9rHXNEwXQjTD49czEvHLe5dp1k4W2IV66yUT9Q7e8npXSCAayEzM2cuWy8IEwHVRtvUbFbNZ8UmF+gs2J6Y53yANugAVWA/TjjY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=charter.net; spf=pass smtp.mailfrom=charter.net; dkim=pass (2048-bit key) header.d=charter.net header.i=@charter.net header.b=W27ftf/q; arc=none smtp.client-ip=47.43.20.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=charter.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=charter.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=charter.net header.i=@charter.net header.b="W27ftf/q"
Received: from localhost.localdomain ([97.71.114.58])
	by cmsmtp with ESMTPA
	id OnGys2KAA6kyQOnH7sNSM3; Tue, 02 Jul 2024 23:51:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=charter.net;
	s=c20240129; t=1719964266;
	bh=B5fBxzZuO/0xbgk+2/HGwd1r1WXAwcU47ktgH5AggZ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=W27ftf/qlQ7cEwhWWOm39zteCvwOFS9GpgN73G0ibesoO/62BF8tJgDdskN7FJvvt
	 s+PjNF0MAuMEePiCg5XsCsQb8AaCHpBxKzmHzcIT9CC6niUkDnqJu5ilRTXOxVqW5I
	 CSs+whNlvG/naWajdvLA7ZLZNGsz952FYdXyum+vlgyajcOuOiuWEBr51lwRCK6k0D
	 +gCyOhq09enRhrkEuNBjxrwZfvvED87BRSJ38fe4Pf15/p8mzz/y/KVNap3h5ZJ/6m
	 +maZ1QMoOgPthha2/YcnIGuNn/UUO5qR1riKFKC2JOtem1jbDYasE7z12kl7vzvVhS
	 5stipCTpt5q2Q==
Authentication-Results: charter.net; auth=pass (LOGIN)
 smtp.auth=ericsunshine@charter.net
X-Authority-Analysis: v=2.4 cv=bKkQIu+Z c=1 sm=1 tr=0 ts=6684926a
 a=4h87Vkt5vDwEBqoyvSX4iA==:117 a=4h87Vkt5vDwEBqoyvSX4iA==:17 a=BCjA09oAAAAA:8
 a=VwQbUJbxAAAA:8 a=PKzvZo6CAAAA:8 a=EOXPgkXvZlImvmqjUjYA:9
 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19 a=jYKBPJSq9nmHKCndOPe9:22
 a=AjGcO6oz07-iQ99wixmX:22 a=q92HNjYiIAC_jH7JDaYf:22
From: Eric Sunshine <ericsunshine@charter.net>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH] chainlint.pl: recognize test bodies defined via heredoc
Date: Tue,  2 Jul 2024 19:50:34 -0400
Message-ID: <20240702235034.88219-1-ericsunshine@charter.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240701220815.GA20293@coredump.intra.peff.net>
References: <20240701220815.GA20293@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfOUHoFBqsqG9+Bn1JyA61cudzGQODumGUuDu2UBEUXGhyNn0ddsu1lm51GrbvOjV/v76Q7b9cT0rxMztmw2ep6BWCIuehIk/sc+JXiZtSei8YHB3+gKo
 7kYS3Icpx67jJK3yG/eGFDy4H7CfyHFvwoLcYsg6fPQm18GCH+m80f6sz9aM3S5sUNbYAGr/Fn26tKAkMi5u0IV35rfXulRjEaL5PERJDuneHZZ+RRQWCGZT
 EbuFug2jaBWufz/cCthxAyae10pYQA8KzvkZKKTpuu9N9Faq1VD/wATtediDwEer+saO+WyEYoqtVOrq+8/z8Q==

From: Eric Sunshine <sunshine@sunshineco.com>

In order to check tests for semantic problems, chainlint.pl scans test
scripts, looking for tests defined as:

    test_expect_success [prereq] title '
        body
    '

where `body` is a single string which is then treated as a standalone
chunk of code and "linted" to detect semantic issues. (The same happens
for `test_expect_failure` definitions.)

The introduction of test definitions in which the test body is instead
presented via a heredoc rather than as a single string creates a blind
spot in the linting process since such invocations are not recognized by
chainlint.pl.

Address this shortcoming by also recognizing tests defined as:

    test_expect_success [prereq] title - <<\EOT
        body
    EOT

A minor complication is that chainlint.pl has never considered heredoc
bodies significant since it doesn't scan them for semantic problems,
thus it has always simply thrown them away. However, with the new
`test_expect_success` calling sequence, heredoc bodies become
meaningful, thus need to be captured.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

This is a clean-room implementation which serves the same purpose as a
change proposed[1] by Peff; it was created before I looked at Peff's
proposal. The two independent implementations turned out quite similar,
but the one implemented by this patch takes a more formal and paranoid
stance. In particular, unlike Peff's patch, it doesn't trust that the
most-recently-seen heredoc body is one associated with the
`test_expect_success` invocation.

This patch can sit either at the top or bottom of Peff's series[2].

There was also related discussion of improving the chainlint self-test
infrastructure[3], however, such proposed changes needn't hold up Peff's
series[2]; such improvements can be applied after the dust settles. On
the other hand, Peff, if you plan to reroll for some reason, feel free
to incorporate this patch into your series.

[1]: https://lore.kernel.org/git/20240702005144.GA27170@coredump.intra.peff.net/
[2]: https://lore.kernel.org/git/20240701220815.GA20293@coredump.intra.peff.net/
[3]: https://lore.kernel.org/git/20240702211913.GB120950@coredump.intra.peff.net/

 t/chainlint.pl | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/t/chainlint.pl b/t/chainlint.pl
index 1bbd985b78..eba509b8e1 100755
--- a/t/chainlint.pl
+++ b/t/chainlint.pl
@@ -174,6 +174,8 @@ sub swallow_heredocs {
 		$$b =~ /(?:\G|\n)$indent\Q$$tag[0]\E(?:\n|\z)/gc;
 		if (pos($$b) > $start) {
 			my $body = substr($$b, $start, pos($$b) - $start);
+			$self->{parser}->{heredocs}->{$$tag[0]} =
+			    substr($body, 0, length($body) - length($&));
 			$self->{lineno} += () = $body =~ /\n/sg;
 			next;
 		}
@@ -232,7 +234,8 @@ sub new {
 	my $self = bless {
 		buff => [],
 		stop => [],
-		output => []
+		output => [],
+		heredocs => {},
 	} => $class;
 	$self->{lexer} = Lexer->new($self, $s);
 	return $self;
@@ -616,7 +619,9 @@ sub unwrap {
 
 sub check_test {
 	my $self = shift @_;
-	my ($title, $body) = map(unwrap, @_);
+	my $title = unwrap(shift @_);
+	my $body = unwrap(shift @_);
+	$body = shift @_ if $body eq '-';
 	$self->{ntests}++;
 	my $parser = TestParser->new(\$body);
 	my @tokens = $parser->parse();
@@ -649,8 +654,13 @@ sub parse_cmd {
 	return @tokens unless @tokens && $tokens[0]->[0] =~ /^test_expect_(?:success|failure)$/;
 	my $n = $#tokens;
 	$n-- while $n >= 0 && $tokens[$n]->[0] =~ /^(?:[;&\n|]|&&|\|\|)$/;
-	$self->check_test($tokens[1], $tokens[2]) if $n == 2; # title body
-	$self->check_test($tokens[2], $tokens[3]) if $n > 2;  # prereq title body
+	my $herebody;
+	if ($n >= 2 && $tokens[$n-1]->[0] eq '-' && $tokens[$n]->[0] =~ /^<<-?(.+)$/) {
+		$herebody = $self->{heredocs}->{$1};
+		$n--;
+	}
+	$self->check_test($tokens[1], $tokens[2], $herebody) if $n == 2; # title body
+	$self->check_test($tokens[2], $tokens[3], $herebody) if $n > 2;  # prereq title body
 	return @tokens;
 }
 
-- 
2.45.2

