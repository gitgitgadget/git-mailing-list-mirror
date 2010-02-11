From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/2] git-imap-send: Add CRAM-MD5 authenticate method
 support
Date: Thu, 11 Feb 2010 12:30:15 -0800
Message-ID: <7vaavf4iso.fsf@alter.siamese.dyndns.org>
References: <40aa078e1002110655n120b14b9y242a57d0e1bd3e96@mail.gmail.com>
 <1265900785-12044-1-git-send-email-mitake@dcl.info.waseda.ac.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org,
	Erik Faye-Lund <kusmabite@googlemail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff King <peff@peff.net>
To: Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>
X-From: git-owner@vger.kernel.org Thu Feb 11 21:30:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NffgQ-0002T2-91
	for gcvg-git-2@lo.gmane.org; Thu, 11 Feb 2010 21:30:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756699Ab0BKUag (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2010 15:30:36 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:57182 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755734Ab0BKUaf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2010 15:30:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DA5399859F;
	Thu, 11 Feb 2010 15:30:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yXO87gmrWJKt31/F4NfWsJRmUZQ=; b=etfKfg
	dW2Igk1bpYXO0ApuchtmvAclOmf4ntxFJq9m1Gxeenz8sVnqUet8unbIVH6ZGE5j
	hyDMDkfRaG/ThyLrH+65hsq7lK+GXKkmNRkyxaLzOjYoqYqTOOZsaiw0dk+oYAlK
	Gk5Q6R8AqwOlRlxWaF1wcJ9EgRc+qHbqPfdsk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fnY21PEbt9FqLaqdoi/xynZlII19kB+2
	j1SaGe+NMZky9VCzVF309IVTF/51Ym+AiWPfSNQ+57vEZz7qk9883srVWKtaFZdQ
	0pwfu5Z/cKj1LXO0LF6GpdwAufOfSr71sCINXm45VXmtBo9guYRs6GSM+dIHDAT9
	kcSqS1eQSyw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 722AB98596;
	Thu, 11 Feb 2010 15:30:26 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B0E3A98595; Thu, 11 Feb
 2010 15:30:16 -0500 (EST)
In-Reply-To: <1265900785-12044-1-git-send-email-mitake@dcl.info.waseda.ac.jp>
 (Hitoshi Mitake's message of "Fri\, 12 Feb 2010 00\:06\:25 +0900")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 499C0184-174C-11DF-8613-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139620>

Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp> writes:

> This patch makes git-imap-send CRAM-MD5 authenticate method ready.
> In theory, CRAM-MD5 authenticate method doesn't depend on SSL,
> but for easy of maintainance, this patch uses base64 and md5 stuffs of OpenSSL.
> So if you want to use CRAM-MD5 authenticate method,
> you have to build git-imap-send with OpenSSL library.

Except for some grammer and length of the third line this description
looks good.  It concisely explains the design decision.

> v3: Erik's noticed that there were some garbage lines in this patch.
> I removed these. And 2/2 wasn't changed, I'm sending 1/2 only.

Please put these two lines below three-dash lines.  People reading "git
log" output 6 months from now won't know nor care what v2 looked like.

> diff --git a/imap-send.c b/imap-send.c
> index ba72fa4..caa4e1b 100644
> --- a/imap-send.c
> +++ b/imap-send.c
> @@ -25,10 +25,16 @@
>  #include "cache.h"
>  #include "exec_cmd.h"
>  #include "run-command.h"
> +
>  #ifdef NO_OPENSSL
>  typedef void *SSL;
> +#else
> +#include <openssl/evp.h>
> +#include <openssl/hmac.h>
>  #endif
>  
> +static int login;
> +

Does this variable have a meaning?  login what?

 - "login attempted--if we have failed, the authenticator is wrong---no
   point retrying"?

 - "login attempt succeeded and we are now authenticated"?  "logged_in"
   would be a better name if this is the case.

Something else?

> @@ -526,8 +548,9 @@ static struct imap_cmd *v_issue_imap_cmd(struct imap_store *ctx,
>  		get_cmd_result(ctx, NULL);
>  
>  	bufl = nfsnprintf(buf, sizeof(buf), cmd->cb.data ? CAP(LITERALPLUS) ?
> -			   "%d %s{%d+}\r\n" : "%d %s{%d}\r\n" : "%d %s\r\n",
> -			   cmd->tag, cmd->cmd, cmd->cb.dlen);
> +			  "%d %s{%d+}\r\n" : "%d %s{%d}\r\n" : "%d %s\r\n",
> +			  cmd->tag, cmd->cmd, cmd->cb.dlen);
> +

What did you change here?  Indentation?

> @@ -949,6 +972,72 @@ static void imap_close_store(struct store *ctx)
>  	free(ctx);
>  }
>  
> +/*
> + * hexchar() and cram() functions are
> + * based on ones of isync project ... http://isync.sf.net/
> + * Thanks!
> + */
> +static char hexchar(unsigned int b)
> +{
> +	return b < 10 ? '0' + b : 'a' + (b - 10);
> +}
> +

Do you need the above helper function outside "#ifndef NO_OPENSSL" block?

> +#ifndef NO_OPENSSL
> +
> +static char *cram(const char *challenge_64, const char *user, const char *pass)
> +{
> +	int i;
> +	HMAC_CTX hmac;
> +	char hash[16], hex[33], challenge[256], response[256];
> +	char *response_64;
> +
> +	memset(challenge, 0, 256);
> +	EVP_DecodeBlock((unsigned char *)challenge, (unsigned char *)challenge_64, strlen(challenge_64));

In this codepath, is there anything that guarantees that the decoded
result is short enough to fit in challenge[256]?

> +	HMAC_Init(&hmac, (unsigned char *)pass, strlen(pass), EVP_md5());
> +	HMAC_Update(&hmac, (unsigned char *)challenge, strlen(challenge));
> +	HMAC_Final(&hmac, (unsigned char *)hash, NULL);

Hmph, if challenge needs to be always casted to (unsigned char*), perhaps
is it better declared as such?  (not rhetorical---doing so might need cast
in other calls but I am too lazy to check myself so instead I am asking).

> +	hex[32] = 0;
> +	for (i = 0; i < 16; i++) {
> +		hex[2 * i] = hexchar((hash[i] >> 4) & 0xf);
> +		hex[2 * i + 1] = hexchar(hash[i] & 0xf);
> +	}
> +
> +	memset(response, 0, 256);
> +	snprintf(response, 256, "%s %s", user, hex);

"hex" would be of a limited and known length, but username could be overly
long, no?  Is it Ok to truncate that silently using snprintf while
creating response (not rhetorical---your caller may be barfing on overlong
user name, but I am too lazy to check, so instead I am asking)?

> +	response_64 = calloc(256 , sizeof(char));

Do you need to allocate this, or just have the caller supply a pointer
into an array on its stack as an argument to this function?

> +	EVP_EncodeBlock((unsigned char *)response_64, (unsigned char *)response, strlen(response));

Again, is there anything that guarantees response would fit after encoding
in respose_64 in this codepath?

> +	return response_64;

> +#else
> +
> +static char *cram(const char *challenge_64 __used, const char *user __used, const char *pass __used)

Does everybody understand __used annotation these days, or just gcc?

> +{
> +	fprintf(stderr, "If you want to use CRAM-MD5 authenticate method,"
> +		"you have to build git-imap-send with OpenSSL library\n");
> +	exit(0);

Should this exit with "success"?

> +static int auth_cram_md5(struct imap_store *ctx, struct imap_cmd *cmd, const char *prompt)
> +{
> +	int ret;
> +	char *response;
> +
> +	response = cram(prompt, server.user, server.pass);
> +	ret = socket_write(&ctx->imap->buf.sock, response, strlen(response));
> +	if (ret != strlen(response)) {
> +		fprintf(stderr, "IMAP error: sending response failed\n");
> +		return -1;

Perhaps 'return error("message fmt without LF at the end", args...);'?
