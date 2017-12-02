Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A93F20C13
	for <e@80x24.org>; Sat,  2 Dec 2017 17:02:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751937AbdLBRCw (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Dec 2017 12:02:52 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:39063 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751848AbdLBRCv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Dec 2017 12:02:51 -0500
Received: by mail-wm0-f65.google.com with SMTP id i11so7936358wmf.4
        for <git@vger.kernel.org>; Sat, 02 Dec 2017 09:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=WLi3COHk43WHqirpudzlsS3GB97TaocSiYvbhtZfGew=;
        b=uqCQf4tz9aJJV4dS7V4q04FTH5gB4wykx5e9Q5/okLZQAlTWexs4psDEMuuyKsCb6H
         ZoV62Nc6a+XpmPrDtzSgmZYXLdhwy4bkgnNNGahOg9k6EzSZ/dlNhgXT1H8jh3N/C2pc
         iHLBz9pfpFuWaoQJlIgDEeIJcR53obwlgLmGgxsl99oOvHQSY9Yf+YKHaXoq8stVEwSc
         Z2yGVQ067yUqP3BnHmHjPtEIMnAK9yPqzbiMDPP7J8i6BTYoUEf/XDOPYH5pgCoFq+pK
         scM6Yp8gM1HNKLHmzDPOuIpeJ8x8k8rBkUR4OcghLwMa1WpE96ZxJrBO1Vmt6vcOkd7N
         +7cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WLi3COHk43WHqirpudzlsS3GB97TaocSiYvbhtZfGew=;
        b=HKakLOz/y5bieQleYRkGCfldPGOq3QfjQ2EuM8w+nS04gNEz1ENUsxhNoDPON9xqD7
         YcgeoW9eQPJIjlbbQJPYJCJZM1DpH00+Ibul4shSOcKfLYWtMoNSjZfn/+Li9WXs1bva
         kARfIlET8opzGKqs/NN7z8eoXWMtC0lRhvUtgqgWfZ+KfekDfVEMO59wuU72EE2NEgVJ
         eNMq+ADm08BApmKbvSeSXpSxY4HxbZ8TerQtbBoKzip8oBOf4jqBvSWogEqKbkky/6T3
         MrxBBtq2WNzNhI5Niw2rgk8u37ObgaDCGk22GwcUORhdpToZCHw8NKhczmdWBcODGw/I
         mgYw==
X-Gm-Message-State: AJaThX7utZPw4E5yEURb3jEy5vZ/7E1iTIfWQ00sKV+N2rzdNk3Bct0J
        kvtaGlkqOEDSfumm68rlT9Ia+w==
X-Google-Smtp-Source: AGs4zMa7uixxIG0UYLd0qfx+945dZ9Pc2Y8bqx257eRPjGfsso/C09PgJLBLMvHA84Kct8UyKReUOQ==
X-Received: by 10.28.137.5 with SMTP id l5mr3986128wmd.123.1512234169483;
        Sat, 02 Dec 2017 09:02:49 -0800 (PST)
Received: from Laptops-nathan.numericable.fr (145.50.86.79.rev.sfr.net. [79.86.50.145])
        by smtp.gmail.com with ESMTPSA id v192sm249670wme.1.2017.12.02.09.02.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 02 Dec 2017 09:02:48 -0800 (PST)
From:   Payre Nathan <second.payre@gmail.com>
To:     git@vger.kernel.org
Cc:     ryan@michonline.com, e@80x24.org, gitster@pobox.com,
        Nathan Payre <second.payre@gmail.com>,
        Nathan Payre <nathan.payre@etu.univ-lyon1.fr>,
        Matthieu Moy <matthieu.moy@univ-lyon1.fr>,
        Timothee Albertin <timothee.albertin@etu.univ-lyon1.fr>,
        Daniel Bensoussan <daniel.bensoussan--bohm@etu.univ-lyon1.fr>
Subject: [PATCH] send-email: extract email-parsing code into a subroutine
Date:   Sat,  2 Dec 2017 18:02:20 +0100
Message-Id: <20171202170220.10073-1-second.payre@gmail.com>
X-Mailer: git-send-email 2.15.0.318.g5ec122d43
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Nathan Payre <second.payre@gmail.com>

The existing code mixes parsing of email header with regular
expression and actual code. Extract the parsing code into a new
subroutine 'parse_header_line()'. This improves the code readability
and make parse_header_line reusable in other place.

Signed-off-by: Nathan Payre <nathan.payre@etu.univ-lyon1.fr>
Signed-off-by: Matthieu Moy <matthieu.moy@univ-lyon1.fr>
Signed-off-by: Timothee Albertin <timothee.albertin@etu.univ-lyon1.fr>
Signed-off-by: Daniel Bensoussan <daniel.bensoussan--bohm@etu.univ-lyon1.fr>
---

This patch is a first step to implement a new feature.
See new feature discussion here: https://public-inbox.org/git/20171030223444.5052-1-nathan.payre@etu.univ-lyon1.fr/

 git-send-email.perl | 106 +++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 80 insertions(+), 26 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 2208dcc21..98c2e461c 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -715,41 +715,64 @@ EOT3
 	if (!defined $compose_encoding) {
 		$compose_encoding = "UTF-8";
 	}
-	while(<$c>) {
+
+	my %parsed_email;
+	while (<$c>) {
 		next if m/^GIT:/;
-		if ($in_body) {
-			$summary_empty = 0 unless (/^\n$/);
-		} elsif (/^\n$/) {
-			$in_body = 1;
-			if ($need_8bit_cte) {
+		parse_header_line($_, \%parsed_email);
+		if (/^\n$/i) {
+			while (my $row = <$c>) {
+				if (!($row =~ m/^GIT:/)) {
+					$parsed_email{'body'} = $parsed_email{'body'} . $row;
+				}
+			}
+		}
+	}
+	if ($parsed_email{'from'}) {
+		$sender = $parsed_email{'from'};
+	}
+	if ($parsed_email{'in_reply_to'}) {
+		$initial_reply_to = $parsed_email{'in_reply_to'};
+	}
+	if ($parsed_email{'subject'}) {
+		$initial_subject = $parsed_email{'subject'};
+		print $c2 "Subject: " .
+			quote_subject($parsed_email{'subject'}, $compose_encoding) .
+			"\n";
+	}
+	if ($parsed_email{'mime-version'}) {
+		$need_8bit_cte = 0;
+	}
+	if ($need_8bit_cte) {
+		if ($parsed_email{'content-type'}) {
+				print $c2 "MIME-Version: 1.0\n",
+					 "Content-Type: $parsed_email{'content-type'};",
+					 "Content-Transfer-Encoding: 8bit\n";
+			} else {
 				print $c2 "MIME-Version: 1.0\n",
 					 "Content-Type: text/plain; ",
-					   "charset=$compose_encoding\n",
+					 "charset=$compose_encoding\n",
 					 "Content-Transfer-Encoding: 8bit\n";
 			}
-		} elsif (/^MIME-Version:/i) {
-			$need_8bit_cte = 0;
-		} elsif (/^Subject:\s*(.+)\s*$/i) {
-			$initial_subject = $1;
-			my $subject = $initial_subject;
-			$_ = "Subject: " .
-				quote_subject($subject, $compose_encoding) .
-				"\n";
-		} elsif (/^In-Reply-To:\s*(.+)\s*$/i) {
-			$initial_reply_to = $1;
-			next;
-		} elsif (/^From:\s*(.+)\s*$/i) {
-			$sender = $1;
-			next;
-		} elsif (/^(?:To|Cc|Bcc):/i) {
-			print __("To/Cc/Bcc fields are not interpreted yet, they have been ignored\n");
-			next;
-		}
-		print $c2 $_;
 	}
+	if ($parsed_email{'body'}) {
+		$summary_empty = 0;
+		print $c2 "\n$parsed_email{'body'}\n";
+	}
+
 	close $c;
 	close $c2;
 
+	open $c2, "<", $compose_filename . ".final"
+		or die sprintf(__("Failed to open %s.final: %s"), $compose_filename, $!);
+
+	print "affichage : \n";
+	while (<$c2>) {
+		print $_;
+	}
+
+	close $c2;
+
 	if ($summary_empty) {
 		print __("Summary email is empty, skipping it\n");
 		$compose = -1;
@@ -792,6 +815,37 @@ sub ask {
 	return;
 }
 
+sub parse_header_line {
+	my $lines = shift;
+	my $parsed_line = shift;
+
+	foreach (split(/\n/, $lines)) {
+		if (/^From:\s*(.+)$/i) {
+			$parsed_line->{'from'} = $1;
+		} elsif (/^To:\s*(.+)$/i) {
+			$parsed_line->{'to'} = [ parse_address_line($1) ];
+		} elsif (/^Cc:\s*(.+)$/i) {
+			$parsed_line->{'cc'} = [ parse_address_line($1) ];
+		} elsif (/^Bcc:\s*(.+)$/i) {
+			$parsed_line->{'bcc'} = [ parse_address_line($1) ];
+		} elsif (/^Subject:\s*(.+)\s*$/i) {
+			$parsed_line->{'subject'} = $1;
+		} elsif (/^Date: (.*)/i) {
+			$parsed_line->{'date'} = $1;
+		} elsif (/^In-Reply-To:\s*(.+)\s*$/i) {
+			$parsed_line->{'in_reply_to'} = $1;
+		} elsif (/^Message-ID: (.*)$/i) {
+			$parsed_line->{'message_id'} = $1;
+		} elsif (/^MIME-Version:$/i) {
+			$parsed_line->{'mime-version'} = $1;
+		} elsif (/^Content-Type:\s+(.*)\s*$/i) {
+			$parsed_line->{'content-type'} = $1;
+		} elsif (/^References:\s+(.*)/i) {
+			$parsed_line->{'references'} = $1;
+		}
+	}
+}
+
 my %broken_encoding;
 
 sub file_declares_8bit_cte {
-- 
2.15.1

