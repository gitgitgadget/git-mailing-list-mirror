From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] buitin_config: return postitive status in get_value
Date: Sun, 29 Jul 2012 13:43:21 -0700
Message-ID: <7v4noqwb6e.fsf@alter.siamese.dyndns.org>
References: <1343475730-18743-1-git-send-email-nikolay@vladimiroff.com>
 <CACsJy8BUU13H1tRfTtUme_7u0Jf0upca31U-VNhXva_0R2MLoQ@mail.gmail.com>
 <CAJg5NvdAq_zEx2phVGS4EiUfqMtFJA2Bo=y1d3FJyWXtzMwCTw@mail.gmail.com>
 <20120728132923.GA31388@do> <7vipd7vzql.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nikolay Vladimirov <nikolay@vladimiroff.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 29 22:43:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SvaKn-0008KB-SU
	for gcvg-git-2@plane.gmane.org; Sun, 29 Jul 2012 22:43:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753541Ab2G2UnZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jul 2012 16:43:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59000 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753469Ab2G2UnY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jul 2012 16:43:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2635780A5;
	Sun, 29 Jul 2012 16:43:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2kFmXcrsnFW1Q5XL4/e7c5YIxjw=; b=mjMWLm
	vwekCYrUZ4MjYsKOHGnvp9Qd5scxSX4nxB8LR774cPxtTSX/pX7BDLaWu7UpyEk0
	h/iavO4pE4AjqJlWo8fkskqAEczUjgXgSJBV40YfK/9p9GhFsJPsrDluAJNri41p
	h8XziFHLAgp3BGkeZAZd6jnRDLZcA2PnHDmLI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fAva6b68Uof9r35592iDtvpsxUqu1PUc
	M5a3tiV6ZOm4VWjp9t1QQDFHjCXibmI0sgqj5zpnX106yArNZTtdPoyi+fmyhWOD
	QEpDFO45LN4m8KxxbPCPTXF/9NSi81QgT2jJIfTif3NJHVM0mk8ax8ftFmHaaOtB
	d4i7B7zN+UY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 133DB80A4;
	Sun, 29 Jul 2012 16:43:24 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3E3DD80A2; Sun, 29 Jul 2012
 16:43:23 -0400 (EDT)
In-Reply-To: <7vipd7vzql.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sat, 28 Jul 2012 23:38:10 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0A003716-D9BE-11E1-8C9B-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202494>

Junio C Hamano <gitster@pobox.com> writes:

> I personally think that the documentation unnecessarily exposes the
> useless value assignment of the exit codes (the use of different
> exit codes was done merely to aid debugging the git-config command
> itself) by describing the then-current set of conditions, and should
> be reduced to say "0 for success, non-zero for any error".
>
> But if we really want to follow that "documented" subset of possible
> conditions, I agree that your version to return "1" in this case,
> together with a change to initialize "ret" to "7" and document it as
> "all other errors (ret=7), would make more sense.  Other conditions
> that have been added since that partial enumeration of the exit code
> was done are regexp errors, which I think will get -1 from the same
> function.

IOW, something like this.

 Documentation/git-config.txt | 18 ++++++++++--------
 builtin/config.c             |  8 ++++++--
 2 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 2d6ef32..b071d65 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -54,19 +54,21 @@ configuration file by default, and options '--system', '--global',
 '--file <filename>' can be used to tell the command to write to
 that location (you can say '--local' but that is the default).
 
-This command will fail (with exit code ret) if:
+This command will fail with non-zero status if:
 
+. The section name or key name is invalid (ret=1),
+. No section name or key name was provided (ret=2),
 . The config file is invalid (ret=3),
-. can not write to the config file (ret=4),
-. no section or name was provided (ret=2),
-. the section or key is invalid (ret=1),
-. you try to unset an option which does not exist (ret=5),
-. you try to unset/set an option for which multiple lines match (ret=5),
-. you try to use an invalid regexp (ret=6), or
-. you use '--global' option without $HOME being properly set (ret=128).
+. The config file cannot be written (ret=4),
+. You try to unset an option which does not exist (ret=5),
+. You try to unset/set an option for which multiple lines match (ret=5),
+. You try to use an invalid regexp (ret=6),
+. You use '--global' option without $HOME being properly set (ret=128),
+. Any other errors (ret=7).
 
 On success, the command returns the exit code 0.
 
+
 OPTIONS
 -------
 
diff --git a/builtin/config.c b/builtin/config.c
index 8cd08da..2318308 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -160,7 +160,7 @@ static int show_config(const char *key_, const char *value_, void *cb)
 
 static int get_value(const char *key_, const char *regex_)
 {
-	int ret = -1;
+	int ret = 7;
 	char *global = NULL, *xdg = NULL, *repo_config = NULL;
 	const char *system_wide = NULL, *local;
 	struct config_include_data inc = CONFIG_INCLUDE_INIT;
@@ -196,11 +196,14 @@ static int get_value(const char *key_, const char *regex_)
 		if (regcomp(key_regexp, key, REG_EXTENDED)) {
 			fprintf(stderr, "Invalid key pattern: %s\n", key_);
 			free(key);
+			ret = 6;
 			goto free_strings;
 		}
 	} else {
-		if (git_config_parse_key(key_, &key, NULL))
+		if (git_config_parse_key(key_, &key, NULL)) {
+			ret = 1;
 			goto free_strings;
+		}
 	}
 
 	if (regex_) {
@@ -212,6 +215,7 @@ static int get_value(const char *key_, const char *regex_)
 		regexp = (regex_t*)xmalloc(sizeof(regex_t));
 		if (regcomp(regexp, regex_, REG_EXTENDED)) {
 			fprintf(stderr, "Invalid pattern: %s\n", regex_);
+			ret = 6;
 			goto free_strings;
 		}
 	}
