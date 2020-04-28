Return-Path: <SRS0=fhRL=6M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47375C83000
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 21:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BEAA20730
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 21:14:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TYkerahk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbgD1VOM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Apr 2020 17:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726279AbgD1VOL (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 28 Apr 2020 17:14:11 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF591C03C1AC
        for <git@vger.kernel.org>; Tue, 28 Apr 2020 14:14:11 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id t16so9006953plo.7
        for <git@vger.kernel.org>; Tue, 28 Apr 2020 14:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=AtIiIq8SNINxiBgXpPWs75fffOz+bkuf5ofDnhtYcmg=;
        b=TYkerahkxGAdfb6gWt7fsS0k4BaS9yHjaBGeKW+QqFaD6VF2uBLnzgHRQ90zrhKE3s
         up/qppXvdcDiaUEWzwfGwMzmS61q/qjfo9RP2CGUfnD1uOLd+0aYqur6Becg4ffxHmks
         N17aISLnIOQXkucfbQAD6b0aqO/2Q5XYDwI6MDUugL5zjvNYVP8xjrB/hemLDuggJ9si
         RC361Pm2ZkYVXPXDWVFOAA7XKrgkXwNz5fWAR3QSkHknrb6hkywg/ZyXDHNjHvxi419L
         UZpwolfbXPMP5QmfV+Zp/aZSTf+wwNcAjpAWi9v8n3mK7jruA9AJMsSq3txZb/UnxC9n
         TT0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=AtIiIq8SNINxiBgXpPWs75fffOz+bkuf5ofDnhtYcmg=;
        b=X0BRY8r6PUMJJTNhF0BqLaA6H8cLeZTCk0vsUzo1Sona3q5g8NcWD2e5AS9HuPyox6
         oqwRKg6ChBzviw5ZUPw8q33901JsmRJffHinNeunh8c3YG5Q/lxrKtSf7YqZPZ8ZEZq8
         8uf1XZ+oc0p5rhjiZ7UHxzHyF1awExGgTHlyvkNib2hHrB0ywfp/83G+ALpxECLQMniV
         c+U53rXMoOTLHzvwzNqGqr/H9cpzdqxN50Dp3LLLil1k4PWStvAKRXpkCPT+lU+fNqBF
         ph7urQOC+85sbVS7STdW2ziZx5cg8RZ7Pas3LWZgnyYUtLPJFnATugHgh4ND9aNBYUWL
         pAnw==
X-Gm-Message-State: AGi0PuYFYThXEFpGb9IauvLV8u+GQuITbkQUkQ7g/aR/EoM8nxBBIDFt
        ui1REJDs0qUrWQVmNR+wMO0=
X-Google-Smtp-Source: APiQypLtyi/ggpsiA4fdCxnK76E7dikQWmRTmhsIHvzeWCUNsa8q6lA/+PnoaEviXzUVOaH6Xb8J1g==
X-Received: by 2002:a17:902:7c06:: with SMTP id x6mr16511393pll.203.1588108450822;
        Tue, 28 Apr 2020 14:14:10 -0700 (PDT)
Received: from Carlos-MBP (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id x26sm15535924pfo.218.2020.04.28.14.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 14:14:09 -0700 (PDT)
Date:   Tue, 28 Apr 2020 14:14:07 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>,
        git@vger.kernel.org, dirk@ed4u.de, sunshine@sunshineco.com,
        Stefan Tauner <stefan.tauner@gmx.at>
Subject: Re: [PATCH v3] git-credential-store: skip empty lines and comments
 from store
Message-ID: <20200428211407.GC56126@Carlos-MBP>
References: <20200427084235.60798-1-carenas@gmail.com>
 <20200427125915.88667-1-carenas@gmail.com>
 <xmqqftco94wx.fsf@gitster.c.googlers.com>
 <20200427191858.GB1728884@coredump.intra.peff.net>
 <xmqqv9lk7j7p.fsf@gitster.c.googlers.com>
 <20200428052510.GA201501@google.com>
 <xmqqsggn4mxz.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqsggn4mxz.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 28, 2020 at 09:03:36AM -0700, Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
> 
> > I wonder if in addition to the above documentation change we may want
> > something guaranteed to catch all cases where people would have
> > experienced a regression, like
> >
> > diff --git i/credential-store.c w/credential-store.c
> > index c010497cb21..294e7716815 100644
> > --- i/credential-store.c
> > +++ w/credential-store.c
> > @@ -24,8 +24,8 @@ static int parse_credential_file(const char *fn,
> >  	}
> >  
> >  	while (strbuf_getline_lf(&line, fh) != EOF) {
> > -		credential_from_url(&entry, line.buf);
> > -		if (entry.username && entry.password &&
> > +		if (!credential_from_url_gently(&entry, line.buf, 1) &&
> > +		    entry.username && entry.password &&
> >  		    credential_match(c, &entry)) {
> >  			found_credential = 1;
> >  			if (match_cb) {
> 
> Hmph, so the idea is, instead of ignoring the potential error
> detected by credential_from_url() and using credential when it is
> available, we loudly attempt to parse and give warning on malformed
> entries when we discard a line?

the idea was to silently ignore the line (notice quiet = 1), which
is the "original behaviour" as Peff pointed out in his reply in
20200428054155.GB2376380@coredump.intra.peff.net[1]

> I think that is an excellent idea.
> 
> It would be nicer if we can somehow add where we found the offending
> line, e.g.
> 
>     /home/me/.gitcredential:396: url has no scheme: ://u:p@host/path
> 
> Do we feel it a bit disturbing that u:p is shown in the error
> message, without redacting, by the way?

we could do so with the following on top as a 5/4.

most of the test changes would go away in a reroll, and are similar
to what would have been needed for my original suggested patch[2] with
the exception that in this series we won't support silently fixing
credentials which is something you mentioned a preference on.

Carlo

[1] https://lore.kernel.org/git/20200428054155.GB2376380@coredump.intra.peff.net/ 
[2] https://lore.kernel.org/git/20200428013726.GD61348@Carlos-MBP/
-- >8 --
Subject: [RFC PATCH] credential-store: SQUASH!!

add warnings

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 credential-store.c          | 55 +++++++++++++++++++++++++++++++------
 t/t0302-credential-store.sh | 42 ++++++++++++++++------------
 2 files changed, 70 insertions(+), 27 deletions(-)

diff --git a/credential-store.c b/credential-store.c
index 294e771681..f76292df20 100644
--- a/credential-store.c
+++ b/credential-store.c
@@ -6,6 +6,32 @@
 
 static struct lock_file credential_lock;
 
+static char *redact_credential(const struct strbuf *line)
+{
+	struct strbuf redacted_line = STRBUF_INIT;
+	char *at = strchr(line->buf, '@');
+	char *colon;
+	int redacted = 0;
+
+	if (at) {
+		strbuf_addf(&redacted_line, "%.*s",
+			(int)(at - line->buf), line->buf);
+		colon = strrchr(redacted_line.buf, ':');
+		if (colon && *(colon + 1) != '/' && colon > redacted_line.buf) {
+			redacted_line.len = colon - redacted_line.buf + 1;
+			strbuf_addstr(&redacted_line, "<redacted>");
+			strbuf_addstr(&redacted_line, at);
+			redacted = 1;
+		}
+		else
+			strbuf_reset(&redacted_line);
+	}
+	if (!redacted)
+		strbuf_addbuf(&redacted_line, line);
+
+	return redacted_line.buf;
+}
+
 static int parse_credential_file(const char *fn,
 				  struct credential *c,
 				  void (*match_cb)(struct credential *),
@@ -15,6 +41,7 @@ static int parse_credential_file(const char *fn,
 	struct strbuf line = STRBUF_INIT;
 	struct credential entry = CREDENTIAL_INIT;
 	int found_credential = 0;
+	int lineno = 0;
 
 	fh = fopen(fn, "r");
 	if (!fh) {
@@ -24,17 +51,27 @@ static int parse_credential_file(const char *fn,
 	}
 
 	while (strbuf_getline_lf(&line, fh) != EOF) {
-		if (!credential_from_url_gently(&entry, line.buf, 1) &&
-		    entry.username && entry.password &&
-		    credential_match(c, &entry)) {
-			found_credential = 1;
-			if (match_cb) {
-				match_cb(&entry);
-				break;
+		lineno++;
+		if (!credential_from_url_gently(&entry, line.buf, 1)) {
+			if (entry.username && entry.password &&
+				credential_match(c, &entry)) {
+				found_credential = 1;
+				if (match_cb) {
+					match_cb(&entry);
+					break;
+				}
 			}
+			else if (other_cb)
+				other_cb(&line);
+		}
+		else {
+			if (other_cb)
+				other_cb(&line);
+			char *redacted = redact_credential(&line);
+			warning("%s:%d ignoring invalid credential: %s",
+				fn, lineno, redacted);
+			free(redacted);
 		}
-		else if (other_cb)
-			other_cb(&line);
 	}
 
 	credential_clear(&entry);
diff --git a/t/t0302-credential-store.sh b/t/t0302-credential-store.sh
index 7c7a48303f..597a75903a 100755
--- a/t/t0302-credential-store.sh
+++ b/t/t0302-credential-store.sh
@@ -120,36 +120,42 @@ test_expect_success 'erase: erase matching credentials from both xdg and home fi
 	test_must_be_empty "$HOME/.config/git/credentials"
 '
 
-test_expect_success 'get: store file can contain empty/bogus lines' '
-	test_write_lines "#comment" " " "" \
-		 https://user:pass@example.com >"$HOME/.git-credentials" &&
-	check fill store <<-\EOF
+test_expect_success 'get: credentials without scheme are invalid' '
+	echo "://user:pass@example.com" >"$HOME/.git-credentials" &&
+	cat >expect-stdout <<-\STDOUT &&
 	protocol=https
 	host=example.com
-	--
+	username=askpass-username
+	password=askpass-password
+	STDOUT
+	test_config credential.helper store &&
+	git credential fill <<-\EOF >stdout 2>stderr &&
 	protocol=https
 	host=example.com
-	username=user
-	password=pass
-	--
 	EOF
+	test_cmp expect-stdout stdout &&
+	grep "askpass: Username for '\''https://example.com'\'':" stderr &&
+	grep "askpass: Password for '\''https://askpass-username@example.com'\'':" stderr &&
+	test_i18ngrep "ignoring invalid credential" stderr
 '
 
-test_expect_success 'get: ignore credentials without scheme' '
-	echo "://user:pass@example.com" >"$HOME/.git-credentials" &&
-	check fill store <<-\EOF
+test_expect_success 'get: store file can contain empty/bogus lines' '
+	test_write_lines "#comment" " " "" \
+		 https://user:pass@example.com >"$HOME/.git-credentials" &&
+	cat >expect-stdout <<-\STDOUT &&
 	protocol=https
 	host=example.com
-	--
+	username=user
+	password=pass
+	STDOUT
+	test_config credential.helper store &&
+	git credential fill <<-\EOF >stdout 2>stderr &&
 	protocol=https
 	host=example.com
-	username=askpass-username
-	password=askpass-password
-	--
-	askpass: Username for '\''https://example.com'\'':
-	askpass: Password for '\''https://askpass-username@example.com'\'':
-	--
 	EOF
+	test_cmp expect-stdout stdout &&
+	test_i18ngrep "ignoring invalid credential" stderr &&
+	test_line_count = 3 stderr
 '
 
 test_done
-- 
2.26.2.569.g1d74ac4d14

