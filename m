From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH 1/2] test-lib: tests skipped by GIT_SKIP_TESTS say so
Date: Mon, 3 Mar 2014 15:11:29 -0000
Organization: OPDS
Message-ID: <C65A743B56974711A3806272E9B2C1DD@PhilipOakley>
References: <1393842298-5944-1-git-send-email-ilya.bobyr@gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Jonathan Nieder" <jrnieder@gmail.com>,
	"Thomas Rast" <tr@thomasrast.ch>
To: "Ilya Bobyr" <ilya.bobyr@gmail.com>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 03 16:11:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKUWg-0000CB-4h
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 16:11:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755259AbaCCPLU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 10:11:20 -0500
Received: from out1.ip02ir2.opaltelecom.net ([62.24.128.238]:54836 "EHLO
	out1.ip02ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754441AbaCCPLR (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Mar 2014 10:11:17 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AhMXAGWaFFNZ8Ylt/2dsb2JhbABagwY7iRi4CgECAQGBIRd0giAFAQEEAQgBAS4eAQEhBQYCAwUCAQMVDCUUAQQIEgYHFwYBEggCAQIDAYdUAwkMxT4Nhx0XjEOBYzODK4EUBIkThh6HHoxBgg+FSIMtPA
X-IPAS-Result: AhMXAGWaFFNZ8Ylt/2dsb2JhbABagwY7iRi4CgECAQGBIRd0giAFAQEEAQgBAS4eAQEhBQYCAwUCAQMVDCUUAQQIEgYHFwYBEggCAQIDAYdUAwkMxT4Nhx0XjEOBYzODK4EUBIkThh6HHoxBgg+FSIMtPA
X-IronPort-AV: E=Sophos;i="4.97,577,1389744000"; 
   d="scan'208";a="456184311"
Received: from host-89-241-137-109.as13285.net (HELO PhilipOakley) ([89.241.137.109])
  by out1.ip02ir2.opaltelecom.net with SMTP; 03 Mar 2014 15:11:13 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243228>

From: "Ilya Bobyr" <ilya.bobyr@gmail.com>
> We used to show "(missing )" next to tests skipped because they are
> specified in GIT_SKIP_TESTS.  Use "(matched by GIT_SKIP_TESTS)" 
> instead.

The message below forgets the "by". Otherwise looks sensible.

> ---
> t/test-lib.sh |   13 ++++++++-----
> 1 files changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 1531c24..89a405b 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -446,25 +446,28 @@ test_finish_ () {
>
> test_skip () {
>  to_skip=
> + skipped_reason=
>  if match_pattern_list $this_test.$test_count $GIT_SKIP_TESTS
>  then
>  to_skip=t
> + skipped_reason="matched GIT_SKIP_TESTS"

s/matched GIT_SKIP_TESTS/matched by GIT_SKIP_TESTS/

>  fi
>  if test -z "$to_skip" && test -n "$test_prereq" &&
>     ! test_have_prereq "$test_prereq"
>  then
>  to_skip=t
> - fi
> - case "$to_skip" in
> - t)
> +
>  of_prereq=
>  if test "$missing_prereq" != "$test_prereq"
>  then
>  of_prereq=" of $test_prereq"
>  fi
> -
> + skipped_reason="missing $missing_prereq${of_prereq}"
> + fi
> + case "$to_skip" in
> + t)
>  say_color skip >&3 "skipping test: $@"
> - say_color skip "ok $test_count # skip $1 (missing 
> $missing_prereq${of_prereq})"
> + say_color skip "ok $test_count # skip $1 ($skipped_reason)"
>  : true
>  ;;
>  *)
> -- 
> 1.7.9
