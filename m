From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: RE: [RFC/PATCH 3/4] test-lib: provide lazy TIME_COMMAND prereq
Date: Tue, 16 Oct 2012 16:13:02 +0200
Message-ID: <007001cdaba8$5afc6c00$10f54400$@schmitz-digital.de>
References: <k5gq60$q8c$1@ger.gmane.org> <0140f3f2f2f4bded6868f4082bef0c36e9a8560e.1350387132.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "'Junio C Hamano'" <gitster@pobox.com>
To: "'Michael J Gruber'" <git@drmicha.warpmail.net>,
	<git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 16 16:14:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TO7uY-0005T2-Hs
	for gcvg-git-2@plane.gmane.org; Tue, 16 Oct 2012 16:14:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754573Ab2JPOOJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2012 10:14:09 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:49465 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754527Ab2JPOOI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2012 10:14:08 -0400
Received: from DualCore (dsdf-4db552a4.pool.mediaWays.net [77.181.82.164])
	by mrelayeu.kundenserver.de (node=mrbap2) with ESMTP (Nemesis)
	id 0LqnUA-1Ttctp412o-00dhOO; Tue, 16 Oct 2012 16:13:28 +0200
In-Reply-To: <0140f3f2f2f4bded6868f4082bef0c36e9a8560e.1350387132.git.git@drmicha.warpmail.net>
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQJeqU/4XWJERJTycJKdEfjaJWW8tQL0cImCloJYoGA=
Content-Language: de
X-Provags-ID: V02:K0:0RtQeMZWo3s0bLV1pLEiR1kJjMaqBeihfmP7ys4+Fm7
 tyK63bmswQ+mchF8zBjxiaIL7WbSozt0ucXsX2Sjy7oytpUsDv
 AoFzgSFAGv0XRe1UecaQDWVdqSAA05fgdrhZyoENIq5WSzRY+3
 9ZPvpjx7XNgobjbi/ySHli0lUnUBih0wZNVI0WLCTmAZEWd9n4
 jyNlH3QXxWSLTp6wJZpfgsUvkIEZmkC9fFaLPtfZsUXouC0ube
 XOzVXR/zte3b4qAsOIS2TmM8pcq/VfvXym83cS8NvWZVXcD3zW
 0kIHm0z8n5Sk74QxM9oc8qsUuxssPEYjo9BKA0aSiqmekFZwJA
 UhPPH/ciYsBsznEZEitSiqQmLUbRugglp+YnyJ5/ymklpPVlY3
 vwS9ncTTIcDjA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207832>

> From: Michael J Gruber [mailto:git@drmicha.warpmail.net]
> Sent: Tuesday, October 16, 2012 1:40 PM
> To: git@vger.kernel.org
> Cc: Joachim Schmitz; Junio C Hamano
> Subject: [RFC/PATCH 3/4] test-lib: provide lazy TIME_COMMAND prereq
> 
> Some test want to use the time command (not the shell builtin) and test
> for its availability at /usr/bin/time.
> 
> Provide a lazy prereq TIME_COMMAND which tests for /usr/bin/time and
> /bin/time. If any is found, set TEST_COMMAND_PATH to the first match.
> 
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
> Rather than iterating over 2 or more hardcoded paths, one could use
> "test -P time" or allow a make variable TIME_COMMAND_PATH whose

test -P time won't work for me:
test -P: unary operator expected

I do have another one in /usr/local/bin, maybe that could get added too?

> executability is checked by the prereq. I really don't know what's best.
> 
>  t/test-lib.sh | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 489bc80..7977c15 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -738,6 +738,13 @@ test_lazy_prereq UTF8_NFD_TO_NFC '
>  	esac
>  '
> 
> +test_lazy_prereq TIME_COMMAND '
> +	for command in /usr/bin/time /bin/time
> +	do
> +		test -x "$command" && break
> +	done && TIME_COMMAND_PATH="$command"
> +'
> +
>  # When the tests are run as root, permission tests will report that
>  # things are writable when they shouldn't be.
>  test -w / || test_set_prereq SANITY
> --
> 1.8.0.rc2.304.g9f3ac5c
