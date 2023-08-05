Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE456C0015E
	for <git@archiver.kernel.org>; Sat,  5 Aug 2023 14:41:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjHEOlK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Aug 2023 10:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjHEOlG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Aug 2023 10:41:06 -0400
Received: from mout.web.de (mout.web.de [212.227.15.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F321720
        for <git@vger.kernel.org>; Sat,  5 Aug 2023 07:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1691246460; x=1691851260; i=l.s.r@web.de;
 bh=o4Oj29J56ZIReu1bNUCkc/4fZHa9kzrqxDyun95PFRk=;
 h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
 b=fr33DKvPPpK6KCC3ltIMjdfVL3whWdhPDo00C7QnGM85BYb7luux+NHH9Jl7W8w9CVU/U8h
 aa50a+pzzWvzCGz9lF4jQou5/RDv8A6ByKoSiUUMG3FLteX3CiLuOXQI8mVaVLi9ZydJyf+IP
 vCo4CNEQUE9P1zgpdiOLJaBtrm600l2bEMAhSC/ZjATI7PNbs9rC2CFawi4gO3nEct61Fnkfo
 UEC2yi7MpgoUPlvhvB6RcaBPuRFyKhq38nmHQ0w3pZac/aOT6A6wXIHSKTMLW4NebEr1gQUaR
 633nvPJFEshsK3NC6zT0syQhVoib5Nmtph4cilA3kXddKEW9P5sg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.150.179]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MJFhX-1q88sZ1yMF-00KNJE; Sat, 05
 Aug 2023 16:41:00 +0200
Message-ID: <025bb465-635d-33ed-c847-924ead2635c5@web.de>
Date:   Sat, 5 Aug 2023 16:40:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: [PATCH v3 5/8] parse-options: show negatability of options in short
 help
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
X-Provags-ID: V03:K1:mtgZrHDFxbHU3dCSjO1mMdH2GSf7gLGQsAw+3bsUTi5ujNUx7St
 yqZ9lXlMJDw/TgdK66jJqmqVp/AagK5nvKUlCXaHH02Q6uh3qq7fYfoFL4TMnNZKvZpD2nU
 RUs1i7BE28J1g2/CdrC4dVMcwC1kjDLPmDiUaV5JCqN2z/yb0JBfLSE/QRtiWyG6BWfwQ0g
 5jJClCrhDPwUNknoJ0i7g==
UI-OutboundReport: notjunk:1;M01:P0:io9e/pfeeas=;0+5fQgKuxJI2pVvFLe/AKJBPivW
 yxyMhS51OFnWZ2KHsZnZGafIRUPAEDvsS+JECX7IZ3/+Fh2aefGfVKoWF3Fx6CYWYLVghvVN7
 Bn1AfFk1ol+I/fP6IaMcyzTYL/DYHNt8MCoFJC+udqKX8uNLsqCxaV9n+sAI7T7kaWBfgg2+b
 LHRbND3HPiIDXPjUPeOIluFjh9L41xxmUfihz7ql5dLevzqbuk31kqV8QK4jRfb7WxhrMu7zX
 FKktAwvRK1ix3WtlxiYKg4/gHH3OuX54pkeul0r2X2PFatnDhllj6edp5L1PpgF3hKhXgys0g
 1dZwmkDnJVIqqJW4bZINnGUDcOEgxS0+UWAw7Xy0Ka9PZOFo2JHuWWvEY+KWPE9qdNPpnA1Da
 +gvHGWuLreS2WHaZmY4c29wCKVLbxijdY2dgV/tULyvFx9s+YBROaTUuhlfMUuXuobW51z5Er
 UmurnZZltmHU24FbAABd5vBs1bOHKud3KoBy4PkMnyNnSSv2pMyP2yhG9WI9uIYAxX8ZDvv/r
 DMCJXcRUCz/4rmyIRDCyBSlcw1xC1MN0Zm3esPT9sdY4PTcbsUP8cRNbMPQu5kOQGIf9LhBfP
 5IEILveMxfXsBhUK+QP+yu8BEFC661KB2Qx5yeiA3PAzgeGdUUh6tvp7N/Uepqo6ZZ0it6Qeq
 /S6bylhqY1FmsBJse3Zu/P2LE6LjV2YLjLaoBZAgd55VhN7EBov1IZaEdftm2tk14LO3iI+8A
 5ZbCcH6V1EhktBF9r0+m/zVmTOrRaKxLg0JzLDkF0IURvD3dTxGyk9Ud/yFZQBFkCzU7kTr0/
 vzXN5dMZqh3jfJ2T4LkkkPWPAX6PU3HGvxZQOG6mmI5vn5anfVYQXQ857mo7UPaW32osdMbeU
 Og4DpVaS0VafeV+3bxwuMLhcdFgek9hZ+gM/qCvA6dKc62SJ0rwoGac+A67ETvOpEfg8BXzLI
 VgHm0Av7gdWHutBHen1zWeJOp2w=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a "[no-]" prefix to options without the flag PARSE_OPT_NONEG to
document the fact that you can negate them.

This looks a bit strange for options that already start with "no-", e.g.
for the option --no-name of git show-branch:

    --[no-]no-name        suppress naming strings

You can actually use --no-no-name as an alias of --name, so the short
help is not wrong.  If we strip off any of the "no-"s, we lose either
the ability to see if the remaining one belongs to the documented
variant or to see if it can be negated.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 Documentation/git-rev-parse.txt    |  8 +++---
 contrib/subtree/t/t7900-subtree.sh |  2 +-
 parse-options.c                    | 10 +++++--
 t/t0040-parse-options.sh           | 45 +++++++++++++++++-------------
 t/t1502-rev-parse-parseopt.sh      |  2 +-
 t/t1502/optionspec-neg.help        |  4 +--
 t/t1502/optionspec.help            | 32 +++++++++++----------
 7 files changed, 58 insertions(+), 45 deletions(-)

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse=
.txt
index 6e8ff9ace1..6a4968f68a 100644
=2D-- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -424,10 +424,10 @@ usage: some-command [<options>] <args>...
     some-command does foo and bar!

     -h, --help            show the help
-    --foo                 some nifty option --foo
-    --bar ...             some cool option --bar with an argument
-    --baz <arg>           another cool option --baz with a named argument
-    --qux[=3D<path>]        qux may take a path argument but has meaning =
by itself
+    --[no-]foo            some nifty option --foo
+    --[no-]bar ...        some cool option --bar with an argument
+    --[no-]baz <arg>      another cool option --baz with a named argument
+    --[no-]qux[=3D<path>]   qux may take a path argument but has meaning =
by itself

 An option group Header
     -C[...]               option C with an optional argument
diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-=
subtree.sh
index 341c169eca..49a21dd7c9 100755
=2D-- a/contrib/subtree/t/t7900-subtree.sh
+++ b/contrib/subtree/t/t7900-subtree.sh
@@ -71,7 +71,7 @@ test_expect_success 'shows short help text for -h' '
 	test_expect_code 129 git subtree -h >out 2>err &&
 	test_must_be_empty err &&
 	grep -e "^ *or: git subtree pull" out &&
-	grep -e --annotate out
+	grep -F -e "--[no-]annotate" out
 '

 #
diff --git a/parse-options.c b/parse-options.c
index 87c9fae634..b750bf91cd 100644
=2D-- a/parse-options.c
+++ b/parse-options.c
@@ -1137,8 +1137,14 @@ static enum parse_opt_result usage_with_options_int=
ernal(struct parse_opt_ctx_t
 		}
 		if (opts->long_name && opts->short_name)
 			pos +=3D fprintf(outfile, ", ");
-		if (opts->long_name)
-			pos +=3D fprintf(outfile, "--%s", opts->long_name);
+		if (opts->long_name) {
+			const char *long_name =3D opts->long_name;
+			if (opts->flags & PARSE_OPT_NONEG)
+				pos +=3D fprintf(outfile, "--%s", long_name);
+			else
+				pos +=3D fprintf(outfile, "--[no-]%s", long_name);
+		}
+
 		if (opts->type =3D=3D OPTION_NUMBER)
 			pos +=3D utf8_fprintf(outfile, _("-NUM"));

diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index e19a199636..1dfc431d52 100755
=2D-- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -13,30 +13,34 @@ usage: test-tool parse-options <options>

     A helper function for the parse-options API.

-    --yes                 get a boolean
-    -D, --no-doubt        begins with 'no-'
+    --[no-]yes            get a boolean
+    -D, --[no-]no-doubt   begins with 'no-'
     -B, --no-fear         be brave
-    -b, --boolean         increment by one
-    -4, --or4             bitwise-or boolean with ...0100
-    --neg-or4             same as --no-or4
+    -b, --[no-]boolean    increment by one
+    -4, --[no-]or4        bitwise-or boolean with ...0100
+    --[no-]neg-or4        same as --no-or4

-    -i, --integer <n>     get a integer
+    -i, --[no-]integer <n>
+                          get a integer
     -j <n>                get a integer, too
     -m, --magnitude <n>   get a magnitude
-    --set23               set integer to 23
+    --[no-]set23          set integer to 23
     --mode1               set integer to 1 (cmdmode option)
     --mode2               set integer to 2 (cmdmode option)
-    -L, --length <str>    get length of <str>
-    -F, --file <file>     set file to <file>
+    -L, --[no-]length <str>
+                          get length of <str>
+    -F, --[no-]file <file>
+                          set file to <file>

 String options
-    -s, --string <string> get a string
-    --string2 <str>       get another string
-    --st <st>             get another string (pervert ordering)
+    -s, --[no-]string <string>
+                          get a string
+    --[no-]string2 <str>  get another string
+    --[no-]st <st>        get another string (pervert ordering)
     -o <str>              get another string
     --longhelp            help text of this entry
                           spans multiple lines
-    --list <str>          add str to list
+    --[no-]list <str>     add str to list

 Magic arguments
     -NUM                  set integer to NUM
@@ -45,16 +49,17 @@ Magic arguments
     --no-ambiguous        negative ambiguity

 Standard options
-    --abbrev[=3D<n>]        use <n> digits to display object names
-    -v, --verbose         be verbose
-    -n, --dry-run         dry run
-    -q, --quiet           be quiet
-    --expect <string>     expected output in the variable dump
+    --[no-]abbrev[=3D<n>]   use <n> digits to display object names
+    -v, --[no-]verbose    be verbose
+    -n, --[no-]dry-run    dry run
+    -q, --[no-]quiet      be quiet
+    --[no-]expect <string>
+                          expected output in the variable dump

 Alias
-    -A, --alias-source <string>
+    -A, --[no-]alias-source <string>
                           get a string
-    -Z, --alias-target <string>
+    -Z, --[no-]alias-target <string>
                           alias of --alias-source

 EOF
diff --git a/t/t1502-rev-parse-parseopt.sh b/t/t1502-rev-parse-parseopt.sh
index 0f7c2db4c0..f0737593c3 100755
=2D-- a/t/t1502-rev-parse-parseopt.sh
+++ b/t/t1502-rev-parse-parseopt.sh
@@ -111,7 +111,7 @@ test_expect_success 'test --parseopt help-all output h=
idden switches' '
 |
 |    some-command does foo and bar!
 |
-|    --hidden1             A hidden switch
+|    --[no-]hidden1        A hidden switch
 |
 |EOF
 END_EXPECT
diff --git a/t/t1502/optionspec-neg.help b/t/t1502/optionspec-neg.help
index 591f4dcd9f..156e5f0ed9 100644
=2D-- a/t/t1502/optionspec-neg.help
+++ b/t/t1502/optionspec-neg.help
@@ -3,8 +3,8 @@ usage: some-command [options] <args>...

     some-command does foo and bar!

-    --foo                 can be negated
-    --no-bar              can be positivated
+    --[no-]foo            can be negated
+    --[no-]no-bar         can be positivated
     --positive-only       cannot be negated
     --no-negative         cannot be positivated

diff --git a/t/t1502/optionspec.help b/t/t1502/optionspec.help
index 844eac6704..cbdd54d41b 100755
=2D-- a/t/t1502/optionspec.help
+++ b/t/t1502/optionspec.help
@@ -4,31 +4,33 @@ usage: some-command [options] <args>...
     some-command does foo and bar!

     -h, --help            show the help
-    --foo                 some nifty option --foo
-    --bar ...             some cool option --bar with an argument
-    -b, --baz             a short and long option
+    --[no-]foo            some nifty option --foo
+    --[no-]bar ...        some cool option --bar with an argument
+    -b, --[no-]baz        a short and long option

 An option group Header
     -C[...]               option C with an optional argument
-    -d, --data[=3D...]      short and long option with an optional argume=
nt
+    -d, --[no-]data[=3D...] short and long option with an optional argume=
nt

 Argument hints
     -B <arg>              short option required argument
-    --bar2 <arg>          long option required argument
-    -e, --fuz <with-space>
+    --[no-]bar2 <arg>     long option required argument
+    -e, --[no-]fuz <with-space>
                           short and long option required argument
     -s[<some>]            short option optional argument
-    --long[=3D<data>]       long option optional argument
-    -g, --fluf[=3D<path>]   short and long option optional argument
-    --longest <very-long-argument-hint>
+    --[no-]long[=3D<data>]  long option optional argument
+    -g, --[no-]fluf[=3D<path>]
+                          short and long option optional argument
+    --[no-]longest <very-long-argument-hint>
                           a very long argument hint
-    --pair <key=3Dvalue>    with an equals sign in the hint
-    --aswitch             help te=3Dt contains? fl*g characters!`
-    --bswitch <hint>      hint has trailing tab character
-    --cswitch             switch has trailing tab character
-    --short-hint <a>      with a one symbol hint
+    --[no-]pair <key=3Dvalue>
+                          with an equals sign in the hint
+    --[no-]aswitch        help te=3Dt contains? fl*g characters!`
+    --[no-]bswitch <hint> hint has trailing tab character
+    --[no-]cswitch        switch has trailing tab character
+    --[no-]short-hint <a> with a one symbol hint

 Extras
-    --extra1              line above used to cause a segfault but no long=
er does
+    --[no-]extra1         line above used to cause a segfault but no long=
er does

 EOF
=2D-
2.41.0
