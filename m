Received: from impout006.msg.chrl.nc.charter.net (impout006aa.msg.chrl.nc.charter.net [47.43.20.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389C32260C
	for <git@vger.kernel.org>; Fri, 12 Jan 2024 17:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=charter.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=charter.net
Received: from localhost.localdomain ([97.71.114.58])
	by cmsmtp with ESMTPA
	id OLBYrJO8946f3OLCBrXnuR; Fri, 12 Jan 2024 17:19:52 +0000
Authentication-Results: charter.net; auth=pass (LOGIN)
 smtp.auth=ericsunshine@charter.net
X-Authority-Analysis: v=2.4 cv=RNOgoqu+ c=1 sm=1 tr=0 ts=65a174b8
 a=4h87Vkt5vDwEBqoyvSX4iA==:117 a=4h87Vkt5vDwEBqoyvSX4iA==:17 a=ybZZDoGAAAAA:8
 a=BCjA09oAAAAA:8 a=VwQbUJbxAAAA:8 a=WzvBV3xypB2YBKiNti4A:9
 a=0RhZnL1DYvcuLYC8JZ5M:22 a=jYKBPJSq9nmHKCndOPe9:22 a=AjGcO6oz07-iQ99wixmX:22
From: Eric Sunshine <ericsunshine@charter.net>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Benji Kay <okaybenji@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH] messages: mark some strings with "up-to-date" not to touch
Date: Fri, 12 Jan 2024 12:19:10 -0500
Message-ID: <20240112171910.11131-1-ericsunshine@charter.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <xmqqjzofec0e.fsf@gitster.g>
References: <xmqqjzofec0e.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfEN94/j7eePoDRHeL1VwkAMywCub2TlGz9Z4zerkarSbDn1jtNjTi164DIWDN0PbB9Y6QEfi1f/KhNOnMNuT2/U8UvuAQgSy8ERu+xVqVUWlqQd2tE8F
 Du6U4wvC0CF+AreUzhOpo30lprcXzPh0jAP2whbzjsOBEIfe6ZpSWwm8O6xB/wW9eehfJW6JpVJlqEgFEI4ob/N9SZS02vv9HlqJcnSBkte7ARmRmGRiAKpX
 tOBAdoXU23VIPQJ7vPOpePoOU/Z+fVpT2dGXNjGNRS46jvyZ78Sw2Z47TMeGUvYX

From: Junio C Hamano <gitster@pobox.com>

The treewide clean-up of "up-to-date" strings done in 7560f547
(treewide: correct several "up-to-date" to "up to date", 2017-08-23)
deliberately left some out, but unlike the lines that were changed
by the commit, the lines that were deliberately left untouched by
the commit is impossible to ask "git blame" to link back to the
commit that did not touch them.

Let's do the second best thing, leave a short comment near them
explaining why those strings should not be modified or localized.

[es: make in-code comment more developer-friendly]

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

This is a reroll of Junio's[1] v1 which adds an in-code comment
explaining that "up-to-date" messages in plumbing commands should not be
changed, but doesn't explain _why_, which forces readers to dig through
project history or the mailing list to understand the motivation. v2
changes the comment to be more developer-friendly by adding the
explanation directly to the comment.

[1]: https://lore.kernel.org/git/xmqqjzofec0e.fsf@gitster.g/

Range-diff:
1:  36596051c9 ! 1:  782169e0b1 messages: mark some strings with "up-to-date" not to touch
    @@ Commit message
         the commit is impossible to ask "git blame" to link back to the
         commit that did not touch them.
     
    -    Let's do the second best thing, leave a short comment near them, to
    -    make it possible for those who are motivated enough to find out why
    -    we decided to tell them "do not modify".
    +    Let's do the second best thing, leave a short comment near them
    +    explaining why those strings should not be modified or localized.
    +
    +    [es: make in-code comment more developer-friendly]
     
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
    +    Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
     
      ## builtin/send-pack.c ##
     @@ builtin/send-pack.c: int cmd_send_pack(int argc, const char **argv, const char *prefix)
      	}
      
      	if (!ret && !transport_refs_pushed(remote_refs))
    -+		/* do not modify this string */
    ++		/* stable plumbing output; do not modify or localize */
      		fprintf(stderr, "Everything up-to-date\n");
      
      	return ret;
    @@ http-push.c: int cmd_main(int argc, const char **argv)
      
      		if (oideq(&ref->old_oid, &ref->peer_ref->new_oid)) {
      			if (push_verbosely)
    -+				/* do not modify this string */
    ++				/* stable plumbing output; do not modify or localize */
      				fprintf(stderr, "'%s': up-to-date\n", ref->name);
      			if (helper_status)
      				printf("ok %s up to date\n", ref->name);
    @@ http-push.c: int cmd_main(int argc, const char **argv)
      				 * commits at the remote end and likely
      				 * we were not up to date to begin with.
      				 */
    -+				/* do not modify this string */
    ++				/* stable plumbing output; do not modify or localize */
      				error("remote '%s' is not an ancestor of\n"
      				      "local '%s'.\n"
      				      "Maybe you are not up-to-date and "
    @@ transport.c: int transport_push(struct repository *r,
      	if (porcelain && !push_ret)
      		puts("Done");
      	else if (!quiet && !ret && !transport_refs_pushed(remote_refs))
    -+		/* do not modify this string */
    ++		/* stable plumbing output; do not modify or localize */
      		fprintf(stderr, "Everything up-to-date\n");
      
      done:

 builtin/send-pack.c | 1 +
 http-push.c         | 2 ++
 transport.c         | 1 +
 3 files changed, 4 insertions(+)

diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index b7183be970..3df9eaad09 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -333,6 +333,7 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 	}
 
 	if (!ret && !transport_refs_pushed(remote_refs))
+		/* stable plumbing output; do not modify or localize */
 		fprintf(stderr, "Everything up-to-date\n");
 
 	return ret;
diff --git a/http-push.c b/http-push.c
index b4d0b2a6aa..12d1113741 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1851,6 +1851,7 @@ int cmd_main(int argc, const char **argv)
 
 		if (oideq(&ref->old_oid, &ref->peer_ref->new_oid)) {
 			if (push_verbosely)
+				/* stable plumbing output; do not modify or localize */
 				fprintf(stderr, "'%s': up-to-date\n", ref->name);
 			if (helper_status)
 				printf("ok %s up to date\n", ref->name);
@@ -1871,6 +1872,7 @@ int cmd_main(int argc, const char **argv)
 				 * commits at the remote end and likely
 				 * we were not up to date to begin with.
 				 */
+				/* stable plumbing output; do not modify or localize */
 				error("remote '%s' is not an ancestor of\n"
 				      "local '%s'.\n"
 				      "Maybe you are not up-to-date and "
diff --git a/transport.c b/transport.c
index bd7899e9bf..df518ead70 100644
--- a/transport.c
+++ b/transport.c
@@ -1467,6 +1467,7 @@ int transport_push(struct repository *r,
 	if (porcelain && !push_ret)
 		puts("Done");
 	else if (!quiet && !ret && !transport_refs_pushed(remote_refs))
+		/* stable plumbing output; do not modify or localize */
 		fprintf(stderr, "Everything up-to-date\n");
 
 done:
-- 
2.43.0

