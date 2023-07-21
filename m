Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3489DEB64DD
	for <git@archiver.kernel.org>; Fri, 21 Jul 2023 19:29:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbjGUT3v (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jul 2023 15:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbjGUT3u (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jul 2023 15:29:50 -0400
Received: from mout.web.de (mout.web.de [212.227.15.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE4430E8
        for <git@vger.kernel.org>; Fri, 21 Jul 2023 12:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1689967776; x=1690572576; i=l.s.r@web.de;
 bh=Ej5gWg/T75fKec/6XiFHGq1Uw698WoXYZK3nwYpL9BU=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=M5Eo8hOe5xESB9oTajm/GHw6/xkGVU2JmA/vixtUMxL2yEqH7pnm0f6o4C3IQr0qrbHjA4C
 +7k/qqtj8ycoERSe9gvvrqn1r+tnxWmWtxvs4NKw7C+Ke/RAbh9J09aDimE5FKEJG1eOVdlQC
 fDvglFe4B0PbnW6A5z0MsQOujoUOkTrJgdTIiP2Kb3Ne7bMpSqOXhSPMsu8RpkGGnZghkZzR+
 9xQjItSD6P0PH1XtRRtDqMMnrr7TWfHh8Iy9FY/dFAQ2pplvkLg0JEvKNE4Xccz3YymJcmG3A
 3hxDsuqmflgixiqfTjucrURsZbZqMGXfqHEPF6CoZlUKqiNb7w3Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.150.179]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N5ljL-1ppSpY3y0Z-016wX0; Fri, 21
 Jul 2023 21:29:35 +0200
Message-ID: <43ca3f01-ba11-6c29-a8e8-4e6c262a68cc@web.de>
Date:   Fri, 21 Jul 2023 21:29:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH] ls-tree: fix --no-full-name
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
References: <d392a005-4eba-7cc7-9554-cdb8dc53975e@web.de>
 <xmqqo7k9fa5x.fsf@gitster.g> <a6326aaa-4f05-4d00-8906-2f50ea8e1e7a@web.de>
 <xmqq351hz5xp.fsf@gitster.g>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqq351hz5xp.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lsyw1FRJgbNOs7L3W1xj3ltqUu3cUIG+LaJk2W92k9iWWd/sPa0
 KoH4OjJMwbVmRb5B6gnYISI8Vg74+9m/XxcpNJ9YKMO/25ANz5ipiakxNacyxKOSzGs4fvD
 f50b67rBK/xX1TPjKXZOdtiJkttNVJ5pp2grJYKOt/wEjL9hAOnkmOyBViK4VNV5Tt6rPl6
 hzIZqrYLGemKS955VvKIA==
UI-OutboundReport: notjunk:1;M01:P0:4hmCa+p0xkE=;mUHauQk3TZuffFlTkyFFPYze0Ds
 u54mV5lzooz6Y/S8G/g+RJZX+DxqwE1dBxif6Eu/AgMeNHx4CeTun8iXVYTJppfw99uqwvI/g
 f/45kvpR5Y1KjHkWe22qCUS8J2CVXJmI98YTqA7f9ciRQ1G+tMQm0TGEuUXo2yMZNnfNjFMNd
 qV6eDT+ksk61Ch3tjMvTPu9IWtScDyySvGB2ajNX2tZSMwEVmavRw3/IUgZRpG0e9Rqi/KMYs
 VHA7zra+hpUT2byzKpK8MbTdNdIv0PZ9xzVDqab/eiRZe5sH71mDrQyaTHlLumR6CkpR0CzS6
 w0DvKpxnXZTPtze3iZ5wNUcnrduZ7bzxaFhgNqhPlFcx0IRizVKkBmFi2hKkYfwO2WEB2nC4Y
 GGt4LAU1BatDXfliGwRVA72jNhME86Lh4lRa/945T10ql4RLBUCZJYzsNzWhOk577OtclW86Z
 tH4DntnWZkmRKnU02ozd3nnSqdTP93bH5l+TCfoIeZUOE1kzyl8pexuPY/nORzfigT6m+Iaw9
 sYpXteu2X8mcWcyVAcx+oLZkOQRrAqwDZcaUepzvY2butR5J9yzL1GUxPQ4UdX3gYhy5ks16/
 RdkTkFlIdGGd+IA7InSORern+slwD0M1gAVo1X1gjKqEEDBQaPzgH9U1+SccsNL/1u8WK5MT6
 EjSBr5NiGmBIb+HEit7cZbGjifgY5ppvOjBSjzG3lGoK/XebuFIlFT1ydmumMv9ix9BC9G92Z
 Qck0YFc4KSRjdxUqJi+jYGZTh1lKG6UtI0q7d3PxTl74gZjEo4SnPGmp4ZNMVgsM/V3y9HvwU
 JGjK4nRAn3FQJTo97++4HbP6WUOPuCB4l9YvReIbqqmDdpId0ySV/XjL+4XCrKACM1/bd+5g7
 x8XsKADBXx1zcTBhkNgu0P7p/mCYjO4jd6MFEnR7rHh1bjGt4l/yToHoV8ZUrsK9TcroulfVX
 Jy/PjOtixU3QqWtmmGthY8AvLxg=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 21.07.23 um 16:37 schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>> Overall I get the impression that having the negative form enabled by
>> default was not a good idea.  For boolean options it makes sense, for
>> options with arguments perhaps as well, but for OPT_SET_INT we would
>> have less confusion if the negated form was opt-in.
>>
>> To make it easier discoverable we could let the short help include
>> the optional "no-" part, which would look like this:
>>
>> usage: git ls-tree [<options>] <tree-ish> [<path>...]
>>
>>     -d                    only show trees
>>     -r                    recurse into subtrees
>>     -t                    show trees when recursing
>>     -z                    terminate entries with NUL byte
>>     -l, --long            include object size
>>     --name-only           list only filenames
>>     --name-status         list only filenames
>>     --object-only         list only objects
>>     --[no-]full-name      use full path names
>>     --[no-]full-tree      list entire tree; not just current directory =
(implies --full-name)
>>     --format <format>     format to use for the output
>>     --[no-]abbrev[=3D<n>]   use <n> digits to display object names
>>
>> Thoughts?
>
> I like the "optional no- accepted" markings, but I suspect there may
> be quite a lot of fallouts.

Some test expectations in t0040 and t1502 would have to be adjusted.

This reveals, by the way, that t1502 doesn't yet exercise the "!" flag
of "git rev-parse --parseopt" that turns on PARSE_OPT_NONEG.  I find
the "-h, --[no-]help" option strangely amusing..

=2D-- >8 ----
Subject: [PATCH] parse-options: show negatability of options in short help

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
 parse-options.c               | 10 ++++-
 t/t0040-parse-options.sh      | 44 ++++++++++---------
 t/t1502-rev-parse-parseopt.sh | 80 ++++++++++++++++++++---------------
 3 files changed, 77 insertions(+), 57 deletions(-)

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
index dd811b7fb4..0a67e2dd4f 100755
=2D-- a/t/t1502-rev-parse-parseopt.sh
+++ b/t/t1502-rev-parse-parseopt.sh
@@ -64,33 +64,38 @@ test_expect_success 'test --parseopt help output' '
 |
 |    some-command does foo and bar!
 |
-|    -h, --help            show the help
-|    --foo                 some nifty option --foo
-|    --bar ...             some cool option --bar with an argument
-|    -b, --baz             a short and long option
+|    -h, --[no-]help       show the help
+|    --[no-]foo            some nifty option --foo
+|    --[no-]bar ...        some cool option --bar with an argument
+|    -b, --[no-]baz        a short and long option
 |
 |An option group Header
 |    -C[...]               option C with an optional argument
-|    -d, --data[=3D...]      short and long option with an optional argum=
ent
+|    -d, --[no-]data[=3D...]
+|                          short and long option with an optional argumen=
t
 |
 |Argument hints
 |    -B <arg>              short option required argument
-|    --bar2 <arg>          long option required argument
-|    -e, --fuz <with-space>
+|    --[no-]bar2 <arg>     long option required argument
+|    -e, --[no-]fuz <with-space>
 |                          short and long option required argument
 |    -s[<some>]            short option optional argument
-|    --long[=3D<data>]       long option optional argument
-|    -g, --fluf[=3D<path>]   short and long option optional argument
-|    --longest <very-long-argument-hint>
+|    --[no-]long[=3D<data>]  long option optional argument
+|    -g, --[no-]fluf[=3D<path>]
+|                          short and long option optional argument
+|    --[no-]longest <very-long-argument-hint>
 |                          a very long argument hint
-|    --pair <key=3Dvalue>    with an equals sign in the hint
-|    --aswitch             help te=3Dt contains? fl*g characters!`
-|    --bswitch <hint>      hint has trailing tab character
-|    --cswitch             switch has trailing tab character
-|    --short-hint <a>      with a one symbol hint
+|    --[no-]pair <key=3Dvalue>
+|                          with an equals sign in the hint
+|    --[no-]aswitch        help te=3Dt contains? fl*g characters!`
+|    --[no-]bswitch <hint>
+|                          hint has trailing tab character
+|    --[no-]cswitch        switch has trailing tab character
+|    --[no-]short-hint <a>
+|                          with a one symbol hint
 |
 |Extras
-|    --extra1              line above used to cause a segfault but no lon=
ger does
+|    --[no-]extra1         line above used to cause a segfault but no lon=
ger does
 |
 |EOF
 END_EXPECT
@@ -131,7 +136,7 @@ test_expect_success 'test --parseopt help-all output h=
idden switches' '
 |
 |    some-command does foo and bar!
 |
-|    --hidden1             A hidden switch
+|    --[no-]hidden1        A hidden switch
 |
 |EOF
 END_EXPECT
@@ -146,33 +151,38 @@ test_expect_success 'test --parseopt invalid switch =
help output' '
 |
 |    some-command does foo and bar!
 |
-|    -h, --help            show the help
-|    --foo                 some nifty option --foo
-|    --bar ...             some cool option --bar with an argument
-|    -b, --baz             a short and long option
+|    -h, --[no-]help       show the help
+|    --[no-]foo            some nifty option --foo
+|    --[no-]bar ...        some cool option --bar with an argument
+|    -b, --[no-]baz        a short and long option
 |
 |An option group Header
 |    -C[...]               option C with an optional argument
-|    -d, --data[=3D...]      short and long option with an optional argum=
ent
+|    -d, --[no-]data[=3D...]
+|                          short and long option with an optional argumen=
t
 |
 |Argument hints
 |    -B <arg>              short option required argument
-|    --bar2 <arg>          long option required argument
-|    -e, --fuz <with-space>
+|    --[no-]bar2 <arg>     long option required argument
+|    -e, --[no-]fuz <with-space>
 |                          short and long option required argument
 |    -s[<some>]            short option optional argument
-|    --long[=3D<data>]       long option optional argument
-|    -g, --fluf[=3D<path>]   short and long option optional argument
-|    --longest <very-long-argument-hint>
+|    --[no-]long[=3D<data>]  long option optional argument
+|    -g, --[no-]fluf[=3D<path>]
+|                          short and long option optional argument
+|    --[no-]longest <very-long-argument-hint>
 |                          a very long argument hint
-|    --pair <key=3Dvalue>    with an equals sign in the hint
-|    --aswitch             help te=3Dt contains? fl*g characters!`
-|    --bswitch <hint>      hint has trailing tab character
-|    --cswitch             switch has trailing tab character
-|    --short-hint <a>      with a one symbol hint
+|    --[no-]pair <key=3Dvalue>
+|                          with an equals sign in the hint
+|    --[no-]aswitch        help te=3Dt contains? fl*g characters!`
+|    --[no-]bswitch <hint>
+|                          hint has trailing tab character
+|    --[no-]cswitch        switch has trailing tab character
+|    --[no-]short-hint <a>
+|                          with a one symbol hint
 |
 |Extras
-|    --extra1              line above used to cause a segfault but no lon=
ger does
+|    --[no-]extra1         line above used to cause a segfault but no lon=
ger does
 |
 END_EXPECT
 	test_expect_code 129 git rev-parse --parseopt -- --does-not-exist 1>/dev=
/null 2>output < optionspec &&
@@ -297,7 +307,7 @@ test_expect_success 'test --parseopt help output: "wra=
pped" options normal "or:"
 	|   or:     [--another-option]
 	|   or: cmd [--yet-another-option]
 	|
-	|    -h, --help            show the help
+	|    -h, --[no-]help       show the help
 	|
 	|EOF
 	END_EXPECT
@@ -334,7 +344,7 @@ test_expect_success 'test --parseopt help output: mult=
i-line blurb after empty l
 	|    line
 	|    blurb
 	|
-	|    -h, --help            show the help
+	|    -h, --[no-]help       show the help
 	|
 	|EOF
 	END_EXPECT
=2D-
2.41.0
