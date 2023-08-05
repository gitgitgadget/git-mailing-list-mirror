Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D055AC0015E
	for <git@archiver.kernel.org>; Sat,  5 Aug 2023 14:44:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjHEOoy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Aug 2023 10:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjHEOox (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Aug 2023 10:44:53 -0400
Received: from mout.web.de (mout.web.de [212.227.15.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BDF44224
        for <git@vger.kernel.org>; Sat,  5 Aug 2023 07:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1691246686; x=1691851486; i=l.s.r@web.de;
 bh=TmGA97pfbD2hJZUknzp/3HbJ6R/YrUyR9NzX7uqW/JM=;
 h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
 b=EhpE5k7seHv9sZLAlP4mhXW0loHU+39/sHhI/rXzxKL+ZebME+U5ZiyKA/kb+dTYLVZ3HZt
 pgTd7Dch6oYbA9zF9T9bMmhFSQell5XFyZiYzQWtJ4q8OFWu4e6S3fDp70AtOe4Eorbh8WosT
 8ggQ+ZgtApc4ss8mMSTHi5klRATYM5p6KtftuX7bGZQtxj8/xD+RwMpFA4WNICSzSzOJBIOu6
 MesEQnaYz0kpGw7jY/KT0kLhYtWCdMDZ26evkpSO1LeEDz2QSlJrFl62/8ZUUZ2OnoHiLifE8
 GgFsTzByICrusnRN01JoIc0b+2PmXelY8WeHuRLoKHyvt5dUPeLQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.150.179]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MIc7N-1qeezb0C4D-00EPQR; Sat, 05
 Aug 2023 16:44:46 +0200
Message-ID: <21b40894-1f1b-9e3e-8fe9-754ca9fe685c@web.de>
Date:   Sat, 5 Aug 2023 16:44:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: [PATCH v3 7/8] parse-options: no --[no-]no-...
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
References: <d392a005-4eba-7cc7-9554-cdb8dc53975e@web.de>
 <xmqqo7k9fa5x.fsf@gitster.g> <a6326aaa-4f05-4d00-8906-2f50ea8e1e7a@web.de>
 <xmqq351hz5xp.fsf@gitster.g> <43ca3f01-ba11-6c29-a8e8-4e6c262a68cc@web.de>
 <xmqq4jlxuiuu.fsf@gitster.g> <e4d46d97-1cd4-7fea-afd1-7de5023b1b09@web.de>
In-Reply-To: <e4d46d97-1cd4-7fea-afd1-7de5023b1b09@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:whSkK0cosqizpZlrkv5r7EYCPd0Lg6wXMQbL8huXsQLxYKUp5gR
 rSLKvyT1Juw7KZZKJDvQTVxCxfZAy+YoZu5kYw1pr9a3Z4kjit/bsSXW0485FT93F1TSYd5
 N57/DuFicvdHi7H7kUM8O54kC4ZTKMmQwUMuzVz5u1UrCqBgSDrve0pZy6YWhr3rwR2bR80
 VLL2M4wq05N8eWxQ8HHzg==
UI-OutboundReport: notjunk:1;M01:P0:Q8OIDU8IOAc=;KSDIP4Rit7HRAvYVjcJ3YKFRWc7
 T5okrQtrUvt7bHUeXHnqet4HPfQjbFLAFl6kYcpoX/lYHHCW1P35iwIi+ephI6DrcE7tTnnkF
 6PP8pp+/8MKuDy7/ZPusbHTRfyCc2qOTG0mAsptxqcsOGcAhAIE1S3H0uhnpZ6HtNUEBr3fFL
 r9/hhW42nmdBwm9ldbizYuINQ/gBqD6WG/8VyjQ1RLA0nGtwJAkWNukzHtz2Oi8pxqVBhPjm9
 09q2egXbZwJL6O/MaboU2aJroKOn99JdXhKWBqqmvuKzugwzOHSJWbp4w7eGEy4ImD47rt0YQ
 PHT3EK5/D7zKGeq4oay4rPu0G7BPxohk3mvzcLqXRlwuXOa9k1q1v3K9ed6rN6+qXyNVG3WJY
 ak1UbtTz9ng2GrrHdhOppGyqGrBwFflbh+u9a9+afl9BbhKpkhRScv9mGxP9btaKH74OKy3Le
 L+adHr2aCCPyPnD5Lmw/hrulRVmD5yO9/7gRILEyNvhwARgUgpJC93ef94ysD79y4TKNwQY9H
 Wzy+wSeU8wEcP5Zo7VPDI7GMw9GiH+QGfTYFI/WplR8wW+MyHUpAh93uumlHBZG5KSNJS1QHP
 vRHWbpFpmKK3BUQ0b6tUQ+WnUvgh42wd5TJR/7sKOvoh4E+T2GyhHSz+SD1vnyN24lbISXnoK
 ERQVqY8rGH9h/IjwJ7MD0SBnuaRCr4ZXJFbW/+Qjp+AU/QLIe9I/Fuec2jJpw18QnWAd4O5ox
 +mDrNbb24XThoaw/BnGMNIxWN/2un/wYZ1j7Dyu4UfWemD8JOarnAP7KoaodbgDR2LQFfgFVh
 ZrMgAHCpQeyiUxKS2Jg4a67ofwCg/UOLda8eO7rynUdX4gFOHQCP866Pu+J+fGowq//b4QDwg
 hk7QsjXHdppTAVQPhbWNb4sjsh+RnHzOeBmPr7s2CAQfSgQRPhl3u4FAm89Zezu2mY+oa290C
 YZlCy7faNP1sOa/YSwaSGAEt/ic=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Avoid showing an optional "no-" for options that already start with a
"no-" in the short help, as that double negation is confusing.  Document
the opposite variant on its own line with a generated help text instead,
unless it's defined and documented explicitly already.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 parse-options.c             | 25 ++++++++++++++++++++++++-
 t/t0040-parse-options.sh    |  3 ++-
 t/t1502/optionspec-neg.help |  3 ++-
 3 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 4b76fc81e9..4a8d380ceb 100644
=2D-- a/parse-options.c
+++ b/parse-options.c
@@ -1042,11 +1042,22 @@ static void usage_padding(FILE *outfile, size_t po=
s)
 	fprintf(outfile, "%*s", pad + USAGE_GAP, "");
 }

+static const struct option *find_option_by_long_name(const struct option =
*opts,
+						     const char *long_name)
+{
+	for (; opts->type !=3D OPTION_END; opts++) {
+		if (opts->long_name && !strcmp(opts->long_name, long_name))
+			return opts;
+	}
+	return NULL;
+}
+
 static enum parse_opt_result usage_with_options_internal(struct parse_opt=
_ctx_t *ctx,
 							 const char * const *usagestr,
 							 const struct option *opts,
 							 int full, int err)
 {
+	const struct option *all_opts =3D opts;
 	FILE *outfile =3D err ? stderr : stdout;
 	int need_newline;

@@ -1128,6 +1139,7 @@ static enum parse_opt_result usage_with_options_inte=
rnal(struct parse_opt_ctx_t
 	for (; opts->type !=3D OPTION_END; opts++) {
 		size_t pos;
 		const char *cp, *np;
+		const char *positive_name =3D NULL;

 		if (opts->type =3D=3D OPTION_SUBCOMMAND)
 			continue;
@@ -1157,7 +1169,8 @@ static enum parse_opt_result usage_with_options_inte=
rnal(struct parse_opt_ctx_t
 			pos +=3D fprintf(outfile, ", ");
 		if (opts->long_name) {
 			const char *long_name =3D opts->long_name;
-			if (opts->flags & PARSE_OPT_NONEG)
+			if ((opts->flags & PARSE_OPT_NONEG) ||
+			    skip_prefix(long_name, "no-", &positive_name))
 				pos +=3D fprintf(outfile, "--%s", long_name);
 			else
 				pos +=3D fprintf(outfile, "--[no-]%s", long_name);
@@ -1185,6 +1198,16 @@ static enum parse_opt_result usage_with_options_int=
ernal(struct parse_opt_ctx_t
 				np++;
 			pos =3D 0;
 		}
+
+		if (positive_name) {
+			if (find_option_by_long_name(all_opts, positive_name))
+				continue;
+			pos =3D usage_indent(outfile);
+			pos +=3D fprintf(outfile, "--%s", positive_name);
+			usage_padding(outfile, pos);
+			fprintf_ln(outfile, _("opposite of --no-%s"),
+				   positive_name);
+		}
 	}
 	fputc('\n', outfile);

diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index 1dfc431d52..a0ad6192d6 100755
=2D-- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -14,7 +14,8 @@ usage: test-tool parse-options <options>
     A helper function for the parse-options API.

     --[no-]yes            get a boolean
-    -D, --[no-]no-doubt   begins with 'no-'
+    -D, --no-doubt        begins with 'no-'
+    --doubt               opposite of --no-doubt
     -B, --no-fear         be brave
     -b, --[no-]boolean    increment by one
     -4, --[no-]or4        bitwise-or boolean with ...0100
diff --git a/t/t1502/optionspec-neg.help b/t/t1502/optionspec-neg.help
index 156e5f0ed9..4cd3c83e55 100644
=2D-- a/t/t1502/optionspec-neg.help
+++ b/t/t1502/optionspec-neg.help
@@ -4,7 +4,8 @@ usage: some-command [options] <args>...
     some-command does foo and bar!

     --[no-]foo            can be negated
-    --[no-]no-bar         can be positivated
+    --no-bar              can be positivated
+    --bar                 opposite of --no-bar
     --positive-only       cannot be negated
     --no-negative         cannot be positivated

=2D-
2.41.0
