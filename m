Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A28E9C0015E
	for <git@archiver.kernel.org>; Mon, 24 Jul 2023 12:40:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbjGXMkw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jul 2023 08:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjGXMkt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2023 08:40:49 -0400
Received: from mout.web.de (mout.web.de [212.227.15.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C9C126
        for <git@vger.kernel.org>; Mon, 24 Jul 2023 05:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1690202442; x=1690807242; i=l.s.r@web.de;
 bh=bBrHcbTLg4eWnsL4LMKy9YRlLsI4qDbTaeCE5A6iY7g=;
 h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
 b=XdoVL7Pb5i39ZC+a7H26Ti5hpuoy8+g0Mr5Y/lg2OWBLyxK5D08QHgHeGRPUYBL3WHJ6gj0
 LjBxRUduYCCbFYPvPJGP795nJBvAVtW4RfJjZiibFJpK4vLwG7YHfL9eKpvH7g6gnqFRg+gr0
 MGmV9Pm4kYd6WWlKNa/CUeSJAZLCvw/X0XIk/4xfRbbMhUS0G5z/veEW5I4Ji1ANjgxf8EVkp
 BRMarVRDU2t8vD4RG6i2wp2BWJ4lEiK+y4MTHRUbA++4Vgud3XBU6TDsIDh1D3naKyCAtVXGA
 4weCsKdnzIBVZAHPAvZyHPK0rceb7dQRuf2BsEXIoSMpvtyPaDpA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.150.179]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MjBVh-1pjcND0R0f-00f4jJ; Mon, 24
 Jul 2023 14:40:42 +0200
Message-ID: <eac754dd-0821-cfcb-7f6e-a00a76fde5b2@web.de>
Date:   Mon, 24 Jul 2023 14:40:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: [PATCH v2 5/5] parse-options: show negatability of options in short
 help
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
References: <d392a005-4eba-7cc7-9554-cdb8dc53975e@web.de>
 <xmqqo7k9fa5x.fsf@gitster.g> <a6326aaa-4f05-4d00-8906-2f50ea8e1e7a@web.de>
 <xmqq351hz5xp.fsf@gitster.g> <43ca3f01-ba11-6c29-a8e8-4e6c262a68cc@web.de>
 <xmqq4jlxuiuu.fsf@gitster.g> <4d01e971-07cb-4f11-3cc6-9d9f21e590c1@web.de>
In-Reply-To: <4d01e971-07cb-4f11-3cc6-9d9f21e590c1@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cNMJTHSU6cU8UC1VMynwPMMuTE9ggwlHJLthuktHQvU0JhIkxD4
 gWbfk2/tcYwe96IaTbkKg4q2eR0XpT/nIe89lt+4WvX+Ugo4qvwq077jhOq5Kv322JCJWtK
 znlqcIXTtj/vk0pxemm9vbFtK7MSW8SSoCSfoATRv/zNDIFiFBWzRq29hNxreURaodPG55R
 NJ4s43kfffDNbWkG6hh8A==
UI-OutboundReport: notjunk:1;M01:P0:ZEpdciAL66A=;qlxE3WoJkrwQFvtFHAysuWuNceE
 RLY/V1woptuDITDmv8I+PmVyDBT2rNWnM+35UcTn68lHDvDG/iYL0kBoVvmXd+VjabFnn2NLv
 OPBDLAWEq8gldTaseRyO9k85scROvK6i3AFPCuGt8AhkOUOeGp5hibpZLmISe2f5ajSGd1oRG
 eJHPkWUh2Y7TPBh26syQnUjuKU3S81e+VITsf9DO7aU70zXFA67mM3Q0pMWhO+aPHUbOBN9go
 C5BqECFEPUJAHxUJEFoOIn7Vz1KGFQoetZcLKMBJSQfvhhmBeAVikokbr0vc3IVYtMhtTF+or
 186aQE52EO2HDkfPCpXK2Cop9Mc4As2L97qcJTKXcpQKHmoIf0+/OQOAjFTGkCrQPAp2PLIlr
 ZmUZgvWuOHW9P3mFgBv5iOzHYmEGz2EVtWBUjk7/iAVaXXNLBANCMcp0sZnKNqfk5Kokon0fI
 u2dfRcUD42bjjNazx40ZuzRwPnxVfa75kQRp3S/YB+WfeQFuk27s5gvC6W3yRlMCNF2B14Y0Y
 Q3hd6Gzl9C6YMx7JJ3aLGpkNz961nnn0oNQrz+O6FOzVRu/XCZy61hTGVEohE5f0m4LeqGZdi
 Rr3vcpxj8mLBpN5eOSd/L5jhDuuFe0Ny2QnOuDk5CFl5QJ+NxblWolBN5Icl1akUkMTS9kKH9
 uQjiv9pvqHnQMjKPaQ40Klzi/WQXG5xWXIC5Q1OfUJgQUk9qWCLAXzRaiOTrckF1/Ny0IYy0b
 UKottlGP6tO13sp9ld9dyPlUy69vdCQKcgBLx+b/G54Lo9lnB6JQdySfUQrvPM1E4uynjK4Iq
 eH2rS3m9/BSpKBbjgS3tkgq1I3hjPxQP3z9+4YlIQQ07GRnKM0bEcJLC9VH3eTKqNV0nTrYA6
 VdU6d/llkGXW67ZpJ2MMdFfvnFqkqmtaQJkczSyG51stt6mtzuRG+VzIws2FfuVibx2vntby4
 PRpJTA==
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
 t/t0040-parse-options.sh           | 44 ++++++++++++++++--------------
 t/t1502-rev-parse-parseopt.sh      |  2 +-
 t/t1502/optionspec-neg.help        |  4 +--
 t/t1502/optionspec.help            | 35 ++++++++++++++----------
 7 files changed, 60 insertions(+), 45 deletions(-)

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
index f8a155ee13..6323ca191d 100644
=2D-- a/parse-options.c
+++ b/parse-options.c
@@ -1136,8 +1136,14 @@ static enum parse_opt_result usage_with_options_int=
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
index 7d7ecfd571..f39758d2ef 100755
=2D-- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -13,29 +13,32 @@ usage: test-tool parse-options <options>

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
-    -s, --string <string>
+    -s, --[no-]string <string>
                           get a string
-    --string2 <str>       get another string
-    --st <st>             get another string (pervert ordering)
+    --[no-]string2 <str>  get another string
+    --[no-]st <st>        get another string (pervert ordering)
     -o <str>              get another string
-    --list <str>          add str to list
+    --[no-]list <str>     add str to list

 Magic arguments
     -NUM                  set integer to NUM
@@ -44,16 +47,17 @@ Magic arguments
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
index 844eac6704..64e8ce9f98 100755
=2D-- a/t/t1502/optionspec.help
+++ b/t/t1502/optionspec.help
@@ -4,31 +4,36 @@ usage: some-command [options] <args>...
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
+    -d, --[no-]data[=3D...]
+                          short and long option with an optional argument

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
+    --[no-]bswitch <hint>
+                          hint has trailing tab character
+    --[no-]cswitch        switch has trailing tab character
+    --[no-]short-hint <a>
+                          with a one symbol hint

 Extras
-    --extra1              line above used to cause a segfault but no long=
er does
+    --[no-]extra1         line above used to cause a segfault but no long=
er does

 EOF
=2D-
2.41.0
