From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 1/2] git-imap-send: Add CRAM-MD5 authenticate method
 support
Date: Mon, 15 Feb 2010 22:34:07 -0800
Message-ID: <7v8watg04g.fsf@alter.siamese.dyndns.org>
References: <1265717345-2118-1-git-send-email-mitake@dcl.info.waseda.ac.jp>
 <1265974572-6282-1-git-send-email-mitake@dcl.info.waseda.ac.jp>
 <7vljeyp1rj.fsf@alter.siamese.dyndns.org>
 <4B764B67.1020402@dcl.info.waseda.ac.jp>
 <7vsk95sht6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Erik Faye-Lund <kusmabite@googlemail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff King <peff@peff.net>
To: Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>
X-From: git-owner@vger.kernel.org Tue Feb 16 07:34:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhH0z-0005rP-Tn
	for gcvg-git-2@lo.gmane.org; Tue, 16 Feb 2010 07:34:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753160Ab0BPGe2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2010 01:34:28 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:50496 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752831Ab0BPGe0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 01:34:26 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7C22B9AFC5;
	Tue, 16 Feb 2010 01:34:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eUKY0c+/8+5n3oIEij1Xe6SjVy8=; b=Qklvan
	Mx61kkcWBA/181M3P1h86xhaoVLTMTKytLkCMt6+AjhsZ6K+NkbygvtqBDO7iTyJ
	ViQwwqCHLlqdceA8NxgHerWbYLHmxeruVigSI+aE8Mjf6g/y9i0ELBqKfsUyNw5S
	ds6aAHjSk9jRD2yF1eQodl7TE7Pdh9md+lmIw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gG42ba/XN7hJ1MC2SN4csJnRXhW99dJW
	ixpzdDYTeSKodVDg7Xl6P5crr2GDFkqk10UPIXOweamzKP8wOePjx7EpULdAxVfo
	6P3Nm5y2/r2kNe0SFDex4s4x7yGDTpZPf+c7zJBgrvMsyFBXi6/KH9n3Z0rKejCQ
	hLUvMNsCzM0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 180CB9AFC4;
	Tue, 16 Feb 2010 01:34:18 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DCDC09AFC3; Tue, 16 Feb
 2010 01:34:09 -0500 (EST)
In-Reply-To: <7vsk95sht6.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri\, 12 Feb 2010 23\:42\:13 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4F0000FE-1AC5-11DF-A915-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140071>

Junio C Hamano <gitster@pobox.com> writes:

> If you know the length of the decoded thing, then you would just know
> how much to hash.  Doesn't the EVP_DecodeBlock() give you that number?
> Why do you need a NUL termination to begin with?
>
> Because you pretend as if you do not have the actual length, you run
> strlen() instead.  I am not that familiar with the API to EVP_* functions,
> but I'd be surprised if it were designed in such a stupid way to force you
> to write into a pre-zeroed buffer.
>
> By the way, if you use strlen() on a pre-cleared and overallocated buffer,
> doesn't your ENCODED_SIZE(n) have to be one byte longer than what you are
> computing?
>
> Looking for EVP_DecodeBlock in http://www.google.com/codesearch seems to
> find usage examples of varying quality.  Your favorite isync-0.5 stores
> the result in "len", but it entirely ignores it and does the same silly
> calloc() and strlen().  Usage example in OpenSSL's own x509spki stores the
> return value in spki_len and uses that as the length of the stuff to call
> another function, which looks much more reasonable.  From this observation
> and a bit of reading of the manual, my understanding is that the function
> gives you the number of bytes written in the buffer.
>
> So does EncodeBlock(), I would think.

So here is a replacement version to see if I remember all the points
raised in the thread.

 * Use of HMAC_Init() is kept, so people with ancient OpenSSL can use it;

 * Lose "overallocate with xcalloc() and use strlen() to see how long the
   result is" pattern; EVP_DecodeBlock() and EVP_EncodeBlock() should be
   returning the length anyway, so use that directly;

 * Comment style fixes;

 * Lose "fprintf() then exit()"; die() instead; and

 * Call HMAC_CTX_cleanup() when done;

I didn't check the validity of the last one at all.  Please see if there
is any funnies.

-- >8 --
Subject: imap-send: support CRAM-MD5 authentication

CRAM-MD5 authentication ought to be independent from SSL, but NO_OPENSSL
build will not support this because the base64 and md5 code are used from
the OpenSSL library in this implementation.

Signed-off-by: Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>
Signed-off-by: Junio C Hamano <gitster@pobox.com>

---
 Documentation/git-imap-send.txt |    4 +
 imap-send.c                     |  146 +++++++++++++++++++++++++++++++++++----
 2 files changed, 135 insertions(+), 15 deletions(-)

diff --git a/Documentation/git-imap-send.txt b/Documentation/git-imap-send.txt
index 57db955..6cafbe2 100644
--- a/Documentation/git-imap-send.txt
+++ b/Documentation/git-imap-send.txt
@@ -71,6 +71,10 @@ imap.preformattedHTML::
 	option causes Thunderbird to send the patch as a plain/text,
 	format=fixed email.  Default is `false`.
 
+imap.authMethod::
+	Specify authenticate method for authentication with IMAP server.
+	Current supported method is 'CRAM-MD5' only.
+
 Examples
 ~~~~~~~~
 
diff --git a/imap-send.c b/imap-send.c
index ba72fa4..bf1cd73 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -27,6 +27,9 @@
 #include "run-command.h"
 #ifdef NO_OPENSSL
 typedef void *SSL;
+#else
+#include <openssl/evp.h>
+#include <openssl/hmac.h>
 #endif
 
 struct store_conf {
@@ -140,6 +143,20 @@ struct imap_server_conf {
 	int use_ssl;
 	int ssl_verify;
 	int use_html;
+	char *auth_method;
+};
+
+static struct imap_server_conf server = {
+	NULL,	/* name */
+	NULL,	/* tunnel */
+	NULL,	/* host */
+	0,	/* port */
+	NULL,	/* user */
+	NULL,	/* pass */
+	0,   	/* use_ssl */
+	1,   	/* ssl_verify */
+	0,   	/* use_html */
+	NULL,	/* auth_method */
 };
 
 struct imap_store_conf {
@@ -214,6 +231,7 @@ enum CAPABILITY {
 	LITERALPLUS,
 	NAMESPACE,
 	STARTTLS,
+	AUTH_CRAM_MD5,
 };
 
 static const char *cap_list[] = {
@@ -222,6 +240,7 @@ static const char *cap_list[] = {
 	"LITERAL+",
 	"NAMESPACE",
 	"STARTTLS",
+	"AUTH=CRAM-MD5",
 };
 
 #define RESP_OK    0
@@ -949,6 +968,87 @@ static void imap_close_store(struct store *ctx)
 	free(ctx);
 }
 
+#ifndef NO_OPENSSL
+
+/*
+ * hexchar() and cram() functions are based on the code from the isync
+ * project (http://isync.sf.net/).
+ */
+static char hexchar(unsigned int b)
+{
+	return b < 10 ? '0' + b : 'a' + (b - 10);
+}
+
+#define ENCODED_SIZE(n) (4*((n+2)/3))
+static char *cram(const char *challenge_64, const char *user, const char *pass)
+{
+	int i, resp_len, encoded_len, decoded_len;
+	HMAC_CTX hmac;
+	unsigned char hash[16];
+	char hex[33];
+	char *response, *response_64, *challenge;
+
+	/*
+	 * length of challenge_64 (i.e. base-64 encoded string) is a good
+	 * enough upper bound for challenge (decoded result).
+	 */
+	encoded_len = strlen(challenge_64);
+	challenge = xmalloc(encoded_len);
+	decoded_len = EVP_DecodeBlock((unsigned char *)challenge,
+				      (unsigned char *)challenge_64, encoded_len);
+	if (decoded_len < 0)
+		die("invalid challenge %s", challenge_64);
+	HMAC_Init(&hmac, (unsigned char *)pass, strlen(pass), EVP_md5());
+	HMAC_Update(&hmac, (unsigned char *)challenge, decoded_len);
+	HMAC_Final(&hmac, hash, NULL);
+	HMAC_CTX_cleanup(&hmac);
+
+	hex[32] = 0;
+	for (i = 0; i < 16; i++) {
+		hex[2 * i] = hexchar((hash[i] >> 4) & 0xf);
+		hex[2 * i + 1] = hexchar(hash[i] & 0xf);
+	}
+
+	/* response: "<user> <digest in hex>" */
+	resp_len = strlen(user) + 1 + strlen(hex) + 1;
+	response = xmalloc(resp_len);
+	sprintf(response, "%s %s", user, hex);
+
+	response_64 = xmalloc(ENCODED_SIZE(resp_len));
+	encoded_len = EVP_EncodeBlock((unsigned char *)response_64,
+				      (unsigned char *)response, resp_len);
+	if (encoded_len < 0)
+		die("EVP_EncodeBlock error");
+	response_64[encoded_len] = '\0';
+	return (char *)response_64;
+}
+
+#else
+
+static char *cram(const char *challenge_64, const char *user, const char *pass)
+{
+	die("If you want to use CRAM-MD5 authenticate method, "
+	    "you have to build git-imap-send with OpenSSL library.");
+}
+
+#endif
+
+static int auth_cram_md5(struct imap_store *ctx, struct imap_cmd *cmd, const char *prompt)
+{
+	int ret;
+	char *response;
+
+	response = cram(prompt, server.user, server.pass);
+
+	ret = socket_write(&ctx->imap->buf.sock, response, strlen(response));
+	if (ret != strlen(response))
+		return error("IMAP error: sending response failed\n");
+
+	free(response);
+
+	return 0;
+}
+
 static struct store *imap_open_store(struct imap_server_conf *srvc)
 {
 	struct imap_store *ctx;
@@ -1130,9 +1230,34 @@ static struct store *imap_open_store(struct imap_server_conf *srvc)
 		if (!imap->buf.sock.ssl)
 			imap_warn("*** IMAP Warning *** Password is being "
 				  "sent in the clear\n");
-		if (imap_exec(ctx, NULL, "LOGIN \"%s\" \"%s\"", srvc->user, srvc->pass) != RESP_OK) {
-			fprintf(stderr, "IMAP error: LOGIN failed\n");
-			goto bail;
+
+		if (srvc->auth_method) {
+			struct imap_cmd_cb cb;
+
+			if (!strcmp(srvc->auth_method, "CRAM-MD5")) {
+				if (!CAP(AUTH_CRAM_MD5)) {
+					fprintf(stderr, "You specified"
+						"CRAM-MD5 as authentication method, "
+						"but %s doesn't support it.\n", srvc->host);
+					goto bail;
+				}
+				/* CRAM-MD5 */
+
+				memset(&cb, 0, sizeof(cb));
+				cb.cont = auth_cram_md5;
+				if (imap_exec(ctx, &cb, "AUTHENTICATE CRAM-MD5") != RESP_OK) {
+					fprintf(stderr, "IMAP error: AUTHENTICATE CRAM-MD5 failed\n");
+					goto bail;
+				}
+			} else {
+				fprintf(stderr, "Unknown authentication method:%s\n", srvc->host);
+				goto bail;
+			}
+		} else {
+			if (imap_exec(ctx, NULL, "LOGIN \"%s\" \"%s\"", srvc->user, srvc->pass) != RESP_OK) {
+				fprintf(stderr, "IMAP error: LOGIN failed\n");
+				goto bail;
+			}
 		}
 	} /* !preauth */
 
@@ -1310,18 +1435,6 @@ static int split_msg(struct msg_data *all_msgs, struct msg_data *msg, int *ofs)
 	return 1;
 }
 
-static struct imap_server_conf server = {
-	NULL,	/* name */
-	NULL,	/* tunnel */
-	NULL,	/* host */
-	0,	/* port */
-	NULL,	/* user */
-	NULL,	/* pass */
-	0,   	/* use_ssl */
-	1,   	/* ssl_verify */
-	0,   	/* use_html */
-};
-
 static char *imap_folder;
 
 static int git_imap_config(const char *key, const char *val, void *cb)
@@ -1361,6 +1474,9 @@ static int git_imap_config(const char *key, const char *val, void *cb)
 		server.port = git_config_int(key, val);
 	else if (!strcmp("tunnel", key))
 		server.tunnel = xstrdup(val);
+	else if (!strcmp("authmethod", key))
+		server.auth_method = xstrdup(val);
+
 	return 0;
 }
 
