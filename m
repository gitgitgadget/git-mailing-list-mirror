From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCHv2] rev-parse --parseopt: allow [*=?!] in argument hints
Date: Mon, 13 Jul 2015 12:19:19 +0100
Organization: OPDS
Message-ID: <FD4C89DDA11A4B20B62703A2D7B4BD10@PhilipOakley>
References: <1436693990-2908-1-git-send-email-ilya.bobyr@gmail.com> <1436782355-3576-1-git-send-email-ilya.bobyr@gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Pierre Habouzit" <madcoder@debian.org>,
	"Ilya Bobyr" <ilya.bobyr@gmail.com>
To: <ilya.bobyr@gmail.com>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 13 13:18:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZEbka-000312-Od
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jul 2015 13:18:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750956AbbGMLSQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jul 2015 07:18:16 -0400
Received: from out1.ip07ir2.opaltelecom.net ([62.24.128.243]:52534 "EHLO
	out1.ip07ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750792AbbGMLSP (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Jul 2015 07:18:15 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2BiXABGnaNVPEsrBlxbgxRUaYZQbbV3ggyDZQQEAoEqC00BAQEBAQEHAQEBAUABJBtBAQICg1gFAQEBAQIBCAEBHREeAQEhCwIDBQIBAxUMJRQBBAgSBgcDFAYBEggCAQIDAYgIAwoMCbl9iTcNhgSLTIJNgW9Kgx6BFAWHCYUjOIdNAYEGg2KCXoJXgyWEGIMPiGKHI4IyHIFUPTGBBoFFAQEB
X-IPAS-Result: A2BiXABGnaNVPEsrBlxbgxRUaYZQbbV3ggyDZQQEAoEqC00BAQEBAQEHAQEBAUABJBtBAQICg1gFAQEBAQIBCAEBHREeAQEhCwIDBQIBAxUMJRQBBAgSBgcDFAYBEggCAQIDAYgIAwoMCbl9iTcNhgSLTIJNgW9Kgx6BFAWHCYUjOIdNAYEGg2KCXoJXgyWEGIMPiGKHI4IyHIFUPTGBBoFFAQEB
X-IronPort-AV: E=Sophos;i="5.15,462,1432594800"; 
   d="scan'208";a="163831663"
Received: from host-92-6-43-75.as43234.net (HELO PhilipOakley) ([92.6.43.75])
  by out1.ip07ir2.opaltelecom.net with ESMTP; 13 Jul 2015 12:18:12 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273913>

From: <ilya.bobyr@gmail.com>
> From: Ilya Bobyr <ilya.bobyr@gmail.com>
>
> A line in the input to "rev-parse --parseopt" describes an option by
> listing a short and/or long name, optional flags [*=?!], argument 
> hint, and
> then whitespace and help string.
>
> We did not allow any of the [*=?!] characters in the argument hints. 
> The
> following <opt-spec>
>
>    pair=key=value  equals sign in the hint
>
> used to generate a help line like this:
>
>    --pair=key <value>   equals sign in the hint
>
> and used to expect "pair=key" as the argument name.
>
> That is not very helpful as we generally do not want any of the [*=?!]
> characters in the argument names.  But we do want to use at least the
> equals sign in the argument hints.
>
> Now long argument names stop at the very first [*=?!] character.
>
> Added test case with equals sign in the argument hint and updated the
> test to perform all the operations in test_expect_success matching the
> t\README requirements and allowing commands like
>
>    ./t1502-rev-parse-parseopt.sh --run=1-2
>
> to stop at the test case 2 without any further modification of the 
> test
> state area.
>
> Signed-off-by: Ilya Bobyr <ilya.bobyr@gmail.com>
> ---
> Junio, thank you very much for all the comments.  I hope I have 
> included
> all of the suggestions you made.  Please, let me know if I have missed
> anything or if there is something else you think should be improved.
>
> I assumed that the commit description would be read by someone making
> changes in the same area of code.  So, I thought that an explanation
> similar to the one in the very first paragraph would be redundant.
>
> I have also made a slight addition to the man page to clarify the 
> <flags>
> parsing, based on the Philip Oakley comment.  Not sure if it is at the
> level Philip wants it to be.  Please, let me know if you think it is 
> still
> not good enough.

The doc patch looks good. I've made one minor suggestion for clarity.

I hadn't noticed the reverse order parsing that Junio pointed out. The 
new wording makes it clear that the flag chars can only occur in the 
arg-name-hint, and after the initial non-flag character.
Philip

>
> Documentation/git-rev-parse.txt |  9 ++--
> builtin/rev-parse.c             | 57 +++++++++++++-----------
> t/t1502-rev-parse-parseopt.sh   | 99 
> +++++++++++++++++++++++++----------------
> 3 files changed, 95 insertions(+), 70 deletions(-)
>
> diff --git a/Documentation/git-rev-parse.txt 
> b/Documentation/git-rev-parse.txt
> index c483100..2ea169d 100644
> --- a/Documentation/git-rev-parse.txt
> +++ b/Documentation/git-rev-parse.txt
> @@ -311,8 +311,8 @@ Each line of options has this format:
> `<opt-spec>`::
>  its format is the short option character, then the long option name
>  separated by a comma. Both parts are not required, though at least 
> one
> - is necessary. `h,help`, `dry-run` and `f` are all three correct
> - `<opt-spec>`.
> + is necessary. May not contain any of the `<flags>` characters.
> + `h,help`, `dry-run` and `f` are all three correct `<opt-spec>`.
>
> `<flags>`::
>  `<flags>` are of `*`, `=`, `?` or `!`.
> @@ -331,8 +331,9 @@ Each line of options has this format:
> `<arg-hint>`::
>  `<arg-hint>`, if specified, is used as a name of the argument in the
>  help output, for options that take arguments. `<arg-hint>` is
> - terminated by the first whitespace.  It is customary to use a
> - dash to separate words in a multi-word argument hint.
> + terminated by the first whitespace.  It may contain any of the
> + `<flags>` characters after the first character. It is customary to

s/the/its/  to clarify it's the first character of the hint, not of the 
flag chars ;-)
or perhaps s/first character/first hint character/, dunno.

> + use a dash to separate words in a multi-word argument hint.
>
> The remainder of the line, after stripping the spaces, is used
> as the help associated to the option.
> diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
> index b623239..15acea4 100644
> --- a/builtin/rev-parse.c
> +++ b/builtin/rev-parse.c
> @@ -371,6 +371,7 @@ static int cmd_parseopt(int argc, const char 
> **argv, const char *prefix)
>  N_("output in stuck long form")),
>  OPT_END(),
>  };
> + static const char * const flag_chars = "*=?!";
>
>  struct strbuf sb = STRBUF_INIT, parsed = STRBUF_INIT;
>  const char **usage = NULL;
> @@ -400,7 +401,7 @@ static int cmd_parseopt(int argc, const char 
> **argv, const char *prefix)
>  /* parse: (<short>|<short>,<long>|<long>)[*=?!]*<arghint>? SP+ <help> 
> */
>  while (strbuf_getline(&sb, stdin, '\n') != EOF) {
>  const char *s;
> - const char *end;
> + const char *help;
>  struct option *o;
>
>  if (!sb.len)
> @@ -410,54 +411,56 @@ static int cmd_parseopt(int argc, const char 
> **argv, const char *prefix)
>  memset(opts + onb, 0, sizeof(opts[onb]));
>
>  o = &opts[onb++];
> - s = strchr(sb.buf, ' ');
> - if (!s || *sb.buf == ' ') {
> + help = strchr(sb.buf, ' ');
> + if (!help || *sb.buf == ' ') {
>  o->type = OPTION_GROUP;
>  o->help = xstrdup(skipspaces(sb.buf));
>  continue;
>  }
>
>  o->type = OPTION_CALLBACK;
> - o->help = xstrdup(skipspaces(s));
> + o->help = xstrdup(skipspaces(help));
>  o->value = &parsed;
>  o->flags = PARSE_OPT_NOARG;
>  o->callback = &parseopt_dump;
>
> - /* Possible argument name hint */
> - end = s;
> - while (s > sb.buf && strchr("*=?!", s[-1]) == NULL)
> - --s;
> - if (s != sb.buf && s != end)
> - o->argh = xmemdupz(s, end - s);
> - if (s == sb.buf)
> - s = end;
> -
> - while (s > sb.buf && strchr("*=?!", s[-1])) {
> - switch (*--s) {
> + /* name(s) */
> + s = strpbrk(sb.buf, flag_chars);
> + if (s == NULL)
> + s = help;
> +
> + if (s - sb.buf == 1) /* short option only */
> + o->short_name = *sb.buf;
> + else if (sb.buf[1] != ',') /* long option only */
> + o->long_name = xmemdupz(sb.buf, s - sb.buf);
> + else {
> + o->short_name = *sb.buf;
> + o->long_name = xmemdupz(sb.buf + 2, s - sb.buf - 2);
> + }
> +
> + /* type */
> + while (s < help) {
> + switch (*s++) {
>  case '=':
>  o->flags &= ~PARSE_OPT_NOARG;
> - break;
> + continue;
>  case '?':
>  o->flags &= ~PARSE_OPT_NOARG;
>  o->flags |= PARSE_OPT_OPTARG;
> - break;
> + continue;
>  case '!':
>  o->flags |= PARSE_OPT_NONEG;
> - break;
> + continue;
>  case '*':
>  o->flags |= PARSE_OPT_HIDDEN;
> - break;
> + continue;
>  }
> + s--;
> + break;
>  }
>
> - if (s - sb.buf == 1) /* short option only */
> - o->short_name = *sb.buf;
> - else if (sb.buf[1] != ',') /* long option only */
> - o->long_name = xmemdupz(sb.buf, s - sb.buf);
> - else {
> - o->short_name = *sb.buf;
> - o->long_name = xmemdupz(sb.buf + 2, s - sb.buf - 2);
> - }
> + if (s < help)
> + o->argh = xmemdupz(s, help - s);
>  }
>  strbuf_release(&sb);
>
> diff --git a/t/t1502-rev-parse-parseopt.sh 
> b/t/t1502-rev-parse-parseopt.sh
> index ebe7c3b..63392a8 100755
> --- a/t/t1502-rev-parse-parseopt.sh
> +++ b/t/t1502-rev-parse-parseopt.sh
> @@ -3,7 +3,40 @@
> test_description='test git rev-parse --parseopt'
> . ./test-lib.sh
>
> -sed -e 's/^|//' >expect <<\END_EXPECT
> +test_expect_success 'setup optionspec' '
> + sed -e "s/^|//" >optionspec <<\EOF
> +|some-command [options] <args>...
> +|
> +|some-command does foo and bar!
> +|--
> +|h,help    show the help
> +|
> +|foo       some nifty option --foo
> +|bar=      some cool option --bar with an argument
> +|b,baz     a short and long option
> +|
> +| An option group Header
> +|C?        option C with an optional argument
> +|d,data?   short and long option with an optional argument
> +|
> +| Argument hints
> +|B=arg     short option required argument
> +|bar2=arg  long option required argument
> +|e,fuz=with-space  short and long option required argument
> +|s?some    short option optional argument
> +|long?data long option optional argument
> +|g,fluf?path     short and long option optional argument
> +|longest=very-long-argument-hint  a very long argument hint
> +|pair=key=value  with an equals sign in the hint
> +|short-hint=a    with a one simbol hint
> +|
> +|Extras
> +|extra1    line above used to cause a segfault but no longer does
> +EOF
> +'
> +
> +test_expect_success 'test --parseopt help output' '
> + sed -e "s/^|//" >expect <<\END_EXPECT &&
> |cat <<\EOF
> |usage: some-command [options] <args>...
> |
> @@ -28,49 +61,23 @@ sed -e 's/^|//' >expect <<\END_EXPECT
> |    -g, --fluf[=<path>]   short and long option optional argument
> |    --longest <very-long-argument-hint>
> |                          a very long argument hint
> +|    --pair <key=value>    with an equals sign in the hint
> +|    --short-hint <a>      with a one simbol hint
> |
> |Extras
> |    --extra1              line above used to cause a segfault but no 
> longer does
> |
> |EOF
> END_EXPECT
> -
> -sed -e 's/^|//' >optionspec <<\EOF
> -|some-command [options] <args>...
> -|
> -|some-command does foo and bar!
> -|--
> -|h,help    show the help
> -|
> -|foo       some nifty option --foo
> -|bar=      some cool option --bar with an argument
> -|b,baz     a short and long option
> -|
> -| An option group Header
> -|C?        option C with an optional argument
> -|d,data?   short and long option with an optional argument
> -|
> -| Argument hints
> -|B=arg     short option required argument
> -|bar2=arg  long option required argument
> -|e,fuz=with-space  short and long option required argument
> -|s?some    short option optional argument
> -|long?data long option optional argument
> -|g,fluf?path     short and long option optional argument
> -|longest=very-long-argument-hint  a very long argument hint
> -|
> -|Extras
> -|extra1    line above used to cause a segfault but no longer does
> -EOF
> -
> -test_expect_success 'test --parseopt help output' '
>  test_expect_code 129 git rev-parse --parseopt -- -h > output < 
> optionspec &&
>  test_i18ncmp expect output
> '
>
> -cat > expect <<EOF
> +test_expect_success 'setup expect.1' "
> + cat > expect <<EOF
> set -- --foo --bar 'ham' -b -- 'arg'
> EOF
> +"
>
> test_expect_success 'test --parseopt' '
>  git rev-parse --parseopt -- --foo --bar=ham --baz arg < optionspec > 
> output &&
> @@ -82,9 +89,11 @@ test_expect_success 'test --parseopt with mixed 
> options and arguments' '
>  test_cmp expect output
> '
>
> -cat > expect <<EOF
> +test_expect_success 'setup expect.2' "
> + cat > expect <<EOF
> set -- --foo -- 'arg' '--bar=ham'
> EOF
> +"
>
> test_expect_success 'test --parseopt with --' '
>  git rev-parse --parseopt -- --foo -- arg --bar=ham < optionspec > 
> output &&
> @@ -96,54 +105,66 @@ test_expect_success 
> 'test --parseopt --stop-at-non-option' '
>  test_cmp expect output
> '
>
> -cat > expect <<EOF
> +test_expect_success 'setup expect.3' "
> + cat > expect <<EOF
> set -- --foo -- '--' 'arg' '--bar=ham'
> EOF
> +"
>
> test_expect_success 'test --parseopt --keep-dashdash' '
>  git rev-parse --parseopt --keep-dashdash -- --foo -- arg --bar=ham < 
> optionspec > output &&
>  test_cmp expect output
> '
>
> -cat >expect <<EOF
> +test_expect_success 'setup expect.4' "
> + cat >expect <<EOF
> set -- --foo -- '--' 'arg' '--spam=ham'
> EOF
> +"
>
> test_expect_success 
> 'test --parseopt --keep-dashdash --stop-at-non-option with --' '
>  git 
> rev-parse --parseopt --keep-dashdash --stop-at-non-option -- --foo --  
> arg --spam=ham <optionspec >output &&
>  test_cmp expect output
> '
>
> -cat > expect <<EOF
> +test_expect_success 'setup expect.5' "
> + cat > expect <<EOF
> set -- --foo -- 'arg' '--spam=ham'
> EOF
> +"
>
> test_expect_success 
> 'test --parseopt --keep-dashdash --stop-at-non-option without --' '
>  git 
> rev-parse --parseopt --keep-dashdash --stop-at-non-option -- --foo 
> arg --spam=ham <optionspec >output &&
>  test_cmp expect output
> '
>
> -cat > expect <<EOF
> +test_expect_success 'setup expect.6' "
> + cat > expect <<EOF
> set -- --foo --bar='z' --baz -C'Z' --data='A' -- 'arg'
> EOF
> +"
>
> test_expect_success 'test --parseopt --stuck-long' '
>  git rev-parse --parseopt --stuck-long -- --foo --bar=z -b arg -CZ -dA 
> <optionspec >output &&
>  test_cmp expect output
> '
>
> -cat > expect <<EOF
> +test_expect_success 'setup expect.7' "
> + cat > expect <<EOF
> set -- --data='' -C --baz -- 'arg'
> EOF
> +"
>
> test_expect_success 'test --parseopt --stuck-long and empty optional 
> argument' '
>  git rev-parse --parseopt --stuck-long -- --data= arg -C -b 
> <optionspec >output &&
>  test_cmp expect output
> '
>
> -cat > expect <<EOF
> +test_expect_success 'setup expect.8' "
> + cat > expect <<EOF
> set -- --data --baz -- 'arg'
> EOF
> +"
>
> test_expect_success 'test --parseopt --stuck-long and long option with 
> unset optional argument' '
>  git rev-parse --parseopt --stuck-long -- --data arg -b <optionspec 
>  >output &&
> -- 
> 2.4.5
>
> 
