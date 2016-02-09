From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v1] travis-ci: override CFLAGS properly, add
 -Wdeclaration-after-statement
Date: Tue, 9 Feb 2016 20:51:22 +0000
Message-ID: <56BA514A.8040209@ramsayjones.plus.com>
References: <1454921958-53129-1-git-send-email-larsxschneider@gmail.com>
 <20160208122551.GD24217@sigill.intra.peff.net>
 <9FBB5AFB-D44C-43A1-A0C5-A5A45675A122@gmail.com>
 <20160209173622.GA28699@sigill.intra.peff.net>
 <xmqqlh6t4vya.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Lars Schneider <larsxschneider@gmail.com>,
	Git Users <git@vger.kernel.org>, linux.mdb@gmail.com,
	Stefan Beller <sbeller@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 09 21:51:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTFFy-0006o6-8z
	for gcvg-git-2@plane.gmane.org; Tue, 09 Feb 2016 21:51:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755367AbcBIUv1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2016 15:51:27 -0500
Received: from avasout07.plus.net ([84.93.230.235]:47598 "EHLO
	avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752997AbcBIUv0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2016 15:51:26 -0500
Received: from [10.0.2.15] ([46.208.159.221])
	by avasout07 with smtp
	id GLrN1s00C4mu3xa01LrPbs; Tue, 09 Feb 2016 20:51:24 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=QqujpgGd c=1 sm=1 tr=0
 a=Sp5fw55EgyGSOjouSGNDoQ==:117 a=Sp5fw55EgyGSOjouSGNDoQ==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=N659UExz7-8A:10
 a=PKzvZo6CAAAA:8 a=eHSkpm1wAAAA:8 a=bgfd-LT2L0-XMSaKQOcA:9
 a=ItoAIhu68LhpWib0:21 a=pILNOxqGKmIA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
In-Reply-To: <xmqqlh6t4vya.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285858>



On 09/02/16 17:47, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
>> Perhaps. I'm not sure that people actually use checkpatch.pl for git.
>>
>> Out of curiosity, I tried:
>>
>>   mkdir out
>>   git format-patch -o out v2.6.0..v2.7.0
>>   checkpatch.pl out/*
>>
>> It's rather noisy, and after skimming, I'd say (subjectively) that only
>> a small fraction are actual style issues we try to enforce. So it would
>> certainly need a fair bit of tweaking for regular use, I think.
>>
>> -Peff
> 
> FWIW, I use the attached (it assumes a recent kernel checkout at
> certain location and checkpatch-original.pl being a symlink to it)
> occasionally.  I found patches from some people are consistently
> clean and suspect they may be running checkpatch themselves.
> 
> -- >8 -- Meta/CP (not on 'todo' branch) -- >8 --
> #!/bin/sh
> 
> # Run checkpatch on the series
> Meta=$(git rev-parse --show-cdup)Meta
> cp0="$Meta/checkpatch-original.pl"
> cp1="$Meta/checkpatch.pl"
> tmp="/var/tmp/CP.$$"
> 
> mkdir "$tmp" || exit
> trap 'rm -fr "$tmp"' 0
> 
> if	! test -f "$cp1" ||
> 	test "$cp0" -nt "$cp1"
> then
> 	cat "$cp0" >"$cp1" &&
> 	(cd "$Meta" &&
> patch -p1 <<\EOF
> --- a/checkpatch.pl
> +++ b/checkpatch.pl
> @@ -282,6 +282,8 @@
>  	Reviewed-by:|
>  	Reported-by:|
>  	Suggested-by:|
> +	Helped-by:|
> +	Mentored-by:|
>  	To:|
>  	Cc:
>  )};
> @@ -2338,7 +2340,7 @@
>  
>  # check for new typedefs, only function parameters and sparse annotations
>  # make sense.
> -		if ($line =~ /\btypedef\s/ &&
> +		if (0 && $line =~ /\btypedef\s/ &&
>  		    $line !~ /\btypedef\s+$Type\s*\(\s*\*?$Ident\s*\)\s*\(/ &&
>  		    $line !~ /\btypedef\s+$Type\s+$Ident\s*\(/ &&
>  		    $line !~ /\b$typeTypedefs\b/ &&
> @@ -2607,8 +2609,7 @@
>  
>  				# No spaces for:
>  				#   ->
> -				#   :   when part of a bitfield
> -				} elsif ($op eq '->' || $opv eq ':B') {
> +				} elsif ($op eq '->') {
>  					if ($ctx =~ /Wx.|.xW/) {
>  						ERROR("SPACING",
>  						      "spaces prohibited around that '$op' $at\n" . $hereptr);
> 
> EOF
> )
> fi || exit
> 
> cat "$@" | git mailsplit -b -o"$tmp" >/dev/null
> 
> for mail in "$tmp"/*
> do
> 	(
> 		git mailinfo -k "$mail.msg" "$mail.patch" >"$mail.info" <"$mail"
> 		echo
> 		cat "$mail.msg"
> 		printf "%s\n" -- "---"
> 		cat "$mail.patch"
> 	) >"$mail.mbox"
> 	perl "$Meta/checkpatch.pl" $ignore --no-tree --max-line-length=120 "$mail.mbox" || {
> 		grep "Subject: " "$mail.info"
> 		printf "%s\n" -- "------------------------------------------------"
> 	}
> done

I have used checkpatch on some small (new) projects from a 'style'
target in the makefile. (Checking both *.c and *.h)

If we try something similar on git, (while on current pu branch):

$ git diff
diff --git a/Makefile b/Makefile
index fd80e94..3d6f1d8 100644
--- a/Makefile
+++ b/Makefile
@@ -2247,6 +2247,14 @@ test-%$X: test-%.o GIT-LDFLAGS $(GITLIBS)
 check-sha1:: test-sha1$X
        ./test-sha1.sh
 
+ST_OBJ = $(patsubst %.o,%.st,$(C_OBJ))
+
+$(ST_OBJ): %.st: %.c GIT-CFLAGS FORCE
+       checkpatch.pl --no-tree --show-types --ignore=NEW_TYPEDEFS -f $<
+
+.PHONY: style $(ST_OBJ)
+style: $(ST_OBJ)
+
 SP_OBJ = $(patsubst %.o,%.sp,$(C_OBJ))
 
 $(SP_OBJ): %.sp: %.c GIT-CFLAGS FORCE
$ make -k style >zzz 2>&1
$ grep "^WARNING:" zzz | wc -l
7320
$ grep "^ERROR:" zzz | wc -l
1155
$ 

To try and summarize a little:

$ grep '^WARNING:' zzz | sort | uniq -c
      1 WARNING:AVOID_EXTERNS: externs should be avoided in .c files
     18 WARNING:BRACES: braces {} are not necessary for any arm of this statement
     82 WARNING:BRACES: braces {} are not necessary for single statement blocks
      5 WARNING:CVS_KEYWORD: CVS style keyword markers, these will _not_ be updated
     23 WARNING:DEEP_INDENTATION: Too many leading tabs - consider code refactoring
      2 WARNING:DEFAULT_NO_BREAK: switch default: should use break
     33 WARNING:INDENTED_LABEL: labels should not be indented
    539 WARNING:LEADING_SPACE: please, no spaces at the start of a line
      1 WARNING:LINE_CONTINUATIONS: Avoid unnecessary line continuations
   3422 WARNING:LONG_LINE: line over 80 characters
     14 WARNING:MISSING_BREAK: Possible switch case/default not preceeded by break or fallthrough comment
      1 WARNING:ONE_SEMICOLON: Statements terminations use 1 semicolon
     19 WARNING:PREFER_PRINTF: __printf(string-index, first-to-check) is preferred over __attribute__((format(printf, string-index, first-to-check)))
      7 WARNING:QUOTED_WHITESPACE_BEFORE_NEWLINE: unnecessary whitespace before a quoted newline
     17 WARNING:RETURN_VOID: void function return statements are not generally useful
      4 WARNING:SINGLE_STATEMENT_DO_WHILE_MACRO: Single statement macros should not use a do {} while (0) loop
      2 WARNING:SIZEOF_PARENTHESIS: sizeof msg should be sizeof(msg)
      1 WARNING:SIZEOF_PARENTHESIS: sizeof opts should be sizeof(opts)
      3 WARNING:SIZEOF_PARENTHESIS: sizeof sa should be sizeof(sa)
      2 WARNING:SIZEOF_PARENTHESIS: sizeof sin should be sizeof(sin)
      1 WARNING:SIZEOF_PARENTHESIS: sizeof timeout_buf should be sizeof(timeout_buf)
     15 WARNING:SPACE_BEFORE_TAB: please, no space before tabs
   2401 WARNING:SPACING: Missing a blank line after declarations
      1 WARNING:SPACING: space prohibited before semicolon
    180 WARNING:SPACING: space prohibited between function name and open parenthesis '('
      6 WARNING:SPACING: Unnecessary space before function pointer arguments
    280 WARNING:SPLIT_STRING: quoted string split across lines
     51 WARNING:STATIC_CONST_CHAR_ARRAY: char * array declaration might be better as static const
      3 WARNING:STATIC_CONST_CHAR_ARRAY: static char array declaration should probably be static const char
     37 WARNING:STATIC_CONST_CHAR_ARRAY: static const char * array should probably be static const char * const
     11 WARNING:SUSPECT_CODE_INDENT: suspect code indent for conditional statements (10, 12)
      9 WARNING:SUSPECT_CODE_INDENT: suspect code indent for conditional statements (10, 14)
      9 WARNING:SUSPECT_CODE_INDENT: suspect code indent for conditional statements (12, 14)
      6 WARNING:SUSPECT_CODE_INDENT: suspect code indent for conditional statements (14, 18)
      1 WARNING:SUSPECT_CODE_INDENT: suspect code indent for conditional statements (16, 16)
      1 WARNING:SUSPECT_CODE_INDENT: suspect code indent for conditional statements (16, 18)
      2 WARNING:SUSPECT_CODE_INDENT: suspect code indent for conditional statements (16, 20)
      4 WARNING:SUSPECT_CODE_INDENT: suspect code indent for conditional statements (18, 20)
      3 WARNING:SUSPECT_CODE_INDENT: suspect code indent for conditional statements (18, 22)
     35 WARNING:SUSPECT_CODE_INDENT: suspect code indent for conditional statements (2, 4)
      3 WARNING:SUSPECT_CODE_INDENT: suspect code indent for conditional statements (24, 28)
      1 WARNING:SUSPECT_CODE_INDENT: suspect code indent for conditional statements (24, 30)
      2 WARNING:SUSPECT_CODE_INDENT: suspect code indent for conditional statements (24, 31)
     21 WARNING:SUSPECT_CODE_INDENT: suspect code indent for conditional statements (2, 6)
      2 WARNING:SUSPECT_CODE_INDENT: suspect code indent for conditional statements (32, 36)
      3 WARNING:SUSPECT_CODE_INDENT: suspect code indent for conditional statements (4, 6)
     17 WARNING:SUSPECT_CODE_INDENT: suspect code indent for conditional statements (6, 10)
      5 WARNING:SUSPECT_CODE_INDENT: suspect code indent for conditional statements (8, 10)
      8 WARNING:SUSPECT_CODE_INDENT: suspect code indent for conditional statements (8, 12)
      1 WARNING:SUSPECT_CODE_INDENT: suspect code indent for conditional statements (8, 15)
      1 WARNING:TRAILING_SEMICOLON: macros should not use a trailing semicolon
      4 WARNING:VOLATILE: Use of volatile is usually wrong: see Documentation/volatile-considered-harmful.txt
$ 

Hmm, I'm a little surprised by 2401 'Missing a blank line after declarations'! ;-)

$ grep '^ERROR:' zzz | sort | uniq -c
    181 ERROR:ASSIGN_IN_IF: do not use assignment in if condition
     42 ERROR:CODE_INDENT: code indent should use tabs where possible
      6 ERROR:COMPLEX_MACRO: Macros with complex values should be enclosed in parenthesis
    266 ERROR:ELSE_AFTER_BRACE: else should follow close brace '}'
     50 ERROR:INITIALISED_STATIC: do not initialise statics to 0 or NULL
      1 ERROR:OPEN_BRACE: open brace '{' following enum go on the same line
     37 ERROR:OPEN_BRACE: open brace '{' following function declarations go on the next line
      6 ERROR:OPEN_BRACE: open brace '{' following struct go on the same line
      1 ERROR:OPEN_BRACE: open brace '{' following union go on the same line
     83 ERROR:OPEN_BRACE: that open brace { should be on the previous line
     16 ERROR:POINTER_LOCATION: "foo * bar" should be "foo *bar"
     10 ERROR:POINTER_LOCATION: "foo* bar" should be "foo *bar"
      1 ERROR:POINTER_LOCATION: "foo** bar" should be "foo **bar"
      1 ERROR:POINTER_LOCATION: "foo * const * bar" should be "foo * const *bar"
     42 ERROR:POINTER_LOCATION: "(foo*)" should be "(foo *)"
     10 ERROR:POINTER_LOCATION: "(foo**)" should be "(foo **)"
      6 ERROR:RETURN_PARENTHESES: return is not a function, parentheses are not required
      2 ERROR:SPACING: need consistent spacing around '-' (ctx:WxV)
      1 ERROR:SPACING: need consistent spacing around '*' (ctx:WxV)
     25 ERROR:SPACING: need consistent spacing around '+' (ctx:WxV)
      5 ERROR:SPACING: space prohibited after that '!' (ctx:BxW)
      2 ERROR:SPACING: space prohibited after that '!' (ctx:ExW)
      1 ERROR:SPACING: space prohibited after that '~' (ctx:WxW)
      1 ERROR:SPACING: space prohibited after that '*' (ctx:WxW)
     59 ERROR:SPACING: space prohibited after that open parenthesis '('
      2 ERROR:SPACING: space prohibited after that open square bracket '['
     36 ERROR:SPACING: space prohibited before that close parenthesis ')'
      2 ERROR:SPACING: space required after that close brace '}'
      1 ERROR:SPACING: space required after that ';' (ctx:BxV)
      1 ERROR:SPACING: space required after that ',' (ctx:OxV)
      4 ERROR:SPACING: space required after that ',' (ctx:VxO)
     58 ERROR:SPACING: space required after that ',' (ctx:VxV)
      1 ERROR:SPACING: space required after that ';' (ctx:WxV)
      3 ERROR:SPACING: space required before that '-' (ctx:OxV)
      1 ERROR:SPACING: space required before that '&' (ctx:OxV)
      1 ERROR:SPACING: space required before that '*' (ctx:VxB)
      2 ERROR:SPACING: space required before that '*' (ctx:VxV)
     26 ERROR:SPACING: space required before the open parenthesis '('
      4 ERROR:SPACING: spaces prohibited around that '->' (ctx:WxW)
      1 ERROR:SPACING: spaces required around that '=' (ctx:VxE)
      3 ERROR:SPACING: spaces required around that '==' (ctx:VxV)
     11 ERROR:SPACING: spaces required around that '=' (ctx:VxV)
      4 ERROR:SPACING: spaces required around that '>' (ctx:VxV)
      2 ERROR:SPACING: spaces required around that '=' (ctx:VxW)
     20 ERROR:SPACING: spaces required around that ':' (ctx:VxW)
      1 ERROR:SPACING: spaces required around that '<=' (ctx:WxV)
      1 ERROR:SPACING: spaces required around that '!=' (ctx:WxV)
      6 ERROR:SWITCH_CASE_INDENT_LEVEL: switch and case should be at the same indent
    105 ERROR:TRAILING_STATEMENTS: trailing statements should be on next line
      4 ERROR:TRAILING_WHITESPACE: trailing whitespace
$ 

I don't know if that helps! :-D

ATB,
Ramsay Jones
