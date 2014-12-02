From: Aarni Koskela <aarni.koskela@andersinnovations.com>
Subject: RE: [PATCH] git add -i: allow list (un)selection by regexp
Date: Tue, 2 Dec 2014 12:12:48 +0000
Message-ID: <DB3PR04MB2509E51F1DE708549483845EB7A0@DB3PR04MB250.eurprd04.prod.outlook.com>
References: <DB3PR04MB25020F247555E521936E676EB7D0@DB3PR04MB250.eurprd04.prod.outlook.com>
 <xmqqiohvqqqv.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"akx@iki.fi" <akx@iki.fi>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 02 13:14:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvmLZ-0004ko-Qx
	for gcvg-git-2@plane.gmane.org; Tue, 02 Dec 2014 13:14:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932961AbaLBMOW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2014 07:14:22 -0500
Received: from mail-am1on0063.outbound.protection.outlook.com ([157.56.112.63]:38185
	"EHLO emea01-am1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932257AbaLBMOU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Dec 2014 07:14:20 -0500
Received: from DB3PR04MB250.eurprd04.prod.outlook.com (10.242.130.14) by
 DB3PR04MB252.eurprd04.prod.outlook.com (10.242.130.26) with Microsoft SMTP
 Server (TLS) id 15.1.26.15; Tue, 2 Dec 2014 12:12:48 +0000
Received: from DB3PR04MB250.eurprd04.prod.outlook.com ([169.254.2.138]) by
 DB3PR04MB250.eurprd04.prod.outlook.com ([169.254.2.138]) with mapi id
 15.01.0026.003; Tue, 2 Dec 2014 12:12:48 +0000
Thread-Topic: [PATCH] git add -i: allow list (un)selection by regexp
Thread-Index: AdANSY4HwbHWiaTnRVO1IoZWMHUGowAOkLHTAClH7RA=
In-Reply-To: <xmqqiohvqqqv.fsf@gitster.dls.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [213.157.91.17]
x-microsoft-antispam: BCL:0;PCL:0;RULEID:;SRVR:DB3PR04MB252;
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:;SRVR:DB3PR04MB252;
x-forefront-prvs: 0413C9F1ED
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(6009001)(52044002)(199003)(51704005)(189002)(95666004)(33656002)(46102003)(101416001)(110136001)(76576001)(54206007)(4396001)(31966008)(62966003)(77156002)(122556002)(68736005)(77096004)(19580405001)(40100003)(19580395003)(105586002)(54606007)(20776003)(54356999)(74316001)(106356001)(64706001)(66066001)(120916001)(50986999)(76176999)(107046002)(97736003)(87936001)(21056001)(2656002)(86362001)(99396003)(575784001)(92726001)(92566001)(7059030);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR04MB252;H:DB3PR04MB250.eurprd04.prod.outlook.com;FPR:;SPF:None;MLV:sfv;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-OriginatorOrg: andersinnovations.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260561>

>From 9096652a71666920ae8d59dd4317d536ba974d5b Mon Sep 17 00:00:00 2001
From: Aarni Koskela <akx@iki.fi>
Date: Tue, 2 Dec 2014 13:56:15 +0200
Subject: [PATCH] git-add--interactive: allow list (un)selection by regular
 expression

Teach `list_and_choose` to allow `/regexp` and `-/regexp` syntax to
select items based on regular expression match.

This feature works in all list menus in `git-add--interactive`, and is not
limited to file menus only.

For instance, in file lists, `/\.c$` will select all files whose extension
is `.c`.  In option menus, such as the main menu, `/pa` could be used to
choose the `patch` option.

Signed-off-by: Aarni Koskela <akx@iki.fi>
---

Thank you for the insightful comments, Junio, and sorry for the confusion
regarding email-patch formatting.  Hoping I get it right this time.

> Usually the responsibility to ensure correctness lies on the person who
> proposes a change, not those who relies on the continued correct operation
> of the existing code.

You're of course absolutely right.  My point was that I can't think of an use
case where one would need to otherwise have "/" or "-/" as the first characters
of input in a list_and_choose situation, but someone else might.

> [...] but is this about the selection that happens after showing you a
> list of filenames to choose from?

I clarified this in the commit message.  Selection by regexp works in all
list_and_choose situations, including the main menu of `git add -i`, hence "option".

Regarding the unchoose quantifier -- yes, silly me.

And regarding error checking for the regular expression, you're right -- the
program promptly blew up when entering an invalid regexp.  I incorporated your
suggestion for error checking, with the addition of using the `error_msg` sub
for colorized error reporting.

Best regards,

Aarni Koskela

 git-add--interactive.perl | 49 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 1fadd69..28e4c2d 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -483,6 +483,8 @@ sub is_valid_prefix {
 	    !($prefix =~ /[\s,]/) && # separators
 	    !($prefix =~ /^-/) &&    # deselection
 	    !($prefix =~ /^\d+/) &&  # selection
+	    !($prefix =~ /^\//) &&   # regexp selection
+	    !($prefix =~ /^-\//) &&  # regexp unselection
 	    ($prefix ne '*') &&      # "all" wildcard
 	    ($prefix ne '?');        # prompt help
 }
@@ -585,6 +587,50 @@ sub list_and_choose {
 			    prompt_help_cmd();
 			next TOPLOOP;
 		}
+		if ($line =~ /^(-)?\/(.+)$/) {
+			# The first capture group ("-") being missing means "choose" is
+			# requested. If the first group exists at all, "unchoose" is
+			# requested.
+			my $choose = !(defined $1);
+
+			# Validate the regular expression and complain if compilation failed.
+			my $re = eval { qr/$2/ };
+			if (!$re) {
+				error_msg "Invalid regular expression:\n  $@\n";
+				next TOPLOOP;
+			}
+
+			my $found = 0;
+			for ($i = 0; $i < @stuff; $i++) {
+				my $val = $stuff[$i];
+
+				# Figure out the display value for $val.
+				# Some lists passed to list_and_choose contain
+				# items other than strings; in order to match
+				# regexps against them, we need to extract the
+				# displayed string. The logic here is approximately
+				# equivalent to the display logic above.
+
+				my $ref = ref $val;
+				if ($ref eq 'ARRAY') {
+					$val = $val->[0];
+				}
+				elsif ($ref eq 'HASH') {
+					$val = $val->{VALUE};
+				}
+
+				# Match the string value against the regexp,
+				# then act accordingly.
+
+				if ($val =~ $re) {
+					$chosen[$i] = $choose;
+					$found = $found || $choose;
+					last if $choose && $opts->{SINGLETON};
+				}
+			}
+			last if $found && ($opts->{IMMEDIATE});
+			next TOPLOOP;
+		}
 		for my $choice (split(/[\s,]+/, $line)) {
 			my $choose = 1;
 			my ($bottom, $top);
@@ -635,6 +681,7 @@ sub singleton_prompt_help_cmd {
 Prompt help:
 1          - select a numbered item
 foo        - select item based on unique prefix
+/regexp    - select item based on regular expression
            - (empty) select nothing
 EOF
 }
@@ -648,6 +695,8 @@ Prompt help:
 foo        - select item based on unique prefix
 -...       - unselect specified items
 *          - choose all items
+/regexp    - select items based on regular expression
+-/regexp   - unselect items based on regular expression
            - (empty) finish selecting
 EOF
 }
-- 
1.9.2.msysgit.0


-----Original Message-----
From: Junio C Hamano [mailto:gitster@pobox.com] 
Sent: 1. joulukuuta 2014 18:28
To: Aarni Koskela
Cc: git@vger.kernel.org; akx@iki.fi
Subject: Re: [PATCH] git add -i: allow list (un)selection by regexp

Aarni Koskela <aarni.koskela@andersinnovations.com> writes:

> Hello!
>
> This patch makes it possible to select or unselect files in `git add 
> -i` by regular expression instead of unique prefix only.
>
> The command syntax is `/foo` for selection and `-/foo` for unselection.
> I don't think the syntax will conflict with any existing use cases, 
> but feel free to prove me wrong.

Usually the responsibility to ensure correctness lies on the person who proposes a change, not those who relies on the continued correct operation of the existing code.

> I'm not a Perl programmer, but I've tried to follow the style of the 
> existing code as much as possible. :)
>
> Note I'm currently not on the mailing list, so please cc.
>
> Best regards,
>
> Aarni Koskela

All of the above do not belong to the commit log message.  Please have these commentaries after the three-dash line you have under your Signed-off-by line.

>
> From 53c12d9c9928dc93a57595e92d785ecc0b245390 Mon Sep 17 00:00:00 2001
> From: Aarni Koskela <akx@iki.fi>
> Date: Mon, 1 Dec 2014 11:06:10 +0200
> Subject: [PATCH] git-add--interactive: allow list (un)selection by 
> regular  expression

Remove these four lines when sending out a patch in the e-mail.

> Teach `list_and_choose` to allow `/regexp` and `-/regexp` syntax to 
> select items based on regular expression match.
>
> For instance, `/jpg$` will select all options whose display name ends 
> with `jpg`.

It has been a long time since I wrote this code, but is this about the selection that happens after showing you a list of filenames to choose from?  "all options" together with "jpg" made me go "Huh?
Does any of our command have jpeg related options?  We are not in the image processing business".

Perhaps s/all options/all files/ or something.

> Signed-off-by: Aarni Koskela <akx@iki.fi>
> ---
>  git-add--interactive.perl | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/git-add--interactive.perl b/git-add--interactive.perl 
> index 1fadd69..34cc603 100755
> --- a/git-add--interactive.perl
> +++ b/git-add--interactive.perl
> @@ -483,6 +483,8 @@ sub is_valid_prefix {
>  	    !($prefix =~ /[\s,]/) && # separators
>  	    !($prefix =~ /^-/) &&    # deselection
>  	    !($prefix =~ /^\d+/) &&  # selection
> +	    !($prefix =~ /^\//) &&   # regexp selection
> +	    !($prefix =~ /^-\//) &&  # regexp unselection
>  	    ($prefix ne '*') &&      # "all" wildcard
>  	    ($prefix ne '?');        # prompt help
>  }
> @@ -585,6 +587,28 @@ sub list_and_choose {
>  			    prompt_help_cmd();
>  			next TOPLOOP;
>  		}
> +		if ($line =~ /^(-)*\/(.+)$/) {

You want zero or one '-', not zero or arbitrary large number of '-', as a sign to unchoose.  (-)? instead of (-)*, perhaps?

> +			my $choose = !($1 && $1 eq '-');

The first $1 is an attempt to catch non-negative case where it is "undef"; it might be more explicit this way?

			my $choose = !(defined $1);

> +			my $re = $2;

Mental note.  $re is an end-user supplied random string that may or may not be a valid regular expression.

> +			my $found = 0;
> +			for ($i = 0; $i < @stuff; $i++) {
> +				my $val = $stuff[$i];
> +				my $ref = ref $val;
> +				if ($ref eq 'ARRAY') {
> +					$val = $val->[0];
> +				}
> +				elsif ($ref eq 'HASH') {
> +					$val = $val->{VALUE};
> +				}
> +				if ($val =~ /$re/) {

... which makes me wonder what happens when $re is a bogus regular expression here.  Does the program die?  Does the user get an error message about bad regexp and the condition to this if expression is false?  Something else?

Perhaps validating and catching regexp errors early like this might be sufficient:

        		my $re = eval { qr/$2/ };
                        if (!$re) {
				print STDERR "$@\n";
                                next TOPLOOP;
			}


Thanks.
