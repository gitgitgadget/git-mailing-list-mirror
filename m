From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH 2/2] test-lib: GIT_TEST_ONLY to run only specific tests
Date: Mon, 3 Mar 2014 15:56:02 -0000
Organization: OPDS
Message-ID: <A85165F7C59F4572AB131A02D0E09698@PhilipOakley>
References: <1393842298-5944-1-git-send-email-ilya.bobyr@gmail.com> <1393842298-5944-2-git-send-email-ilya.bobyr@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon Mar 03 16:56:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKVDl-0005qU-BP
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 16:56:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754529AbaCCPz5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 10:55:57 -0500
Received: from out1.ip04ir2.opaltelecom.net ([62.24.128.240]:43791 "EHLO
	out1.ip04ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753716AbaCCPz4 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Mar 2014 10:55:56 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AogXAM2lFFNZ8Ylt/2dsb2JhbABagwY7iRi4BQUBAgEBgSEXdGkBAYEfAQEUAQQBAQUIAQEuHgEBIQsCAwUCAQMVDCUUAQQIEgYHFwYBEggCAQIDAYU4BwGCBw0DFQnFQQ2GXBeMQ4IWgyuBFASJE4Yehx6MQYIPhUiDLTw
X-IPAS-Result: AogXAM2lFFNZ8Ylt/2dsb2JhbABagwY7iRi4BQUBAgEBgSEXdGkBAYEfAQEUAQQBAQUIAQEuHgEBIQsCAwUCAQMVDCUUAQQIEgYHFwYBEggCAQIDAYU4BwGCBw0DFQnFQQ2GXBeMQ4IWgyuBFASJE4Yehx6MQYIPhUiDLTw
X-IronPort-AV: E=Sophos;i="4.97,578,1389744000"; 
   d="scan'208";a="437552381"
Received: from host-89-241-137-109.as13285.net (HELO PhilipOakley) ([89.241.137.109])
  by out1.ip04ir2.opaltelecom.net with SMTP; 03 Mar 2014 15:55:43 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243230>

Minor nits.

From: "Ilya Bobyr" <ilya.bobyr@gmail.com>
> This is a counterpart to GIT_SKIP_TESTS.  Mostly useful when 
> debugging.
> ---
> t/README      |   15 +++++++++++++++
> t/test-lib.sh |    8 ++++++++
> 2 files changed, 23 insertions(+), 0 deletions(-)
>
> diff --git a/t/README b/t/README
> index caeeb9d..f939987 100644
> --- a/t/README
> +++ b/t/README
> @@ -187,6 +187,21 @@ and either can match the "t[0-9]{4}" part to skip 
> the whole
> test, or t[0-9]{4} followed by ".$number" to say which
> particular test to skip.
>
> +Sometimes the opposite is desired - ability to execute only one or
> +several tests.  Mostly while debugging tests.  For that you can say
> +
> +    $ GIT_TEST_ONLY=t9200.8 sh ./t9200-git-cvsexport-commit.sh
> +
> +or, similrary to GIT_SKIP_TESTS
> +
> +    $ GIT_TEST_ONLY='t[0-4]??? t91?? t9200.8' make
> +
> +In additiona to matching against "<test suite number>.<test number>"
> +GIT_TEST_ONLY is matched against just the test .  This comes
s/numbes/numbers/

> +handy when you are running only one test:
s/handy/in handy/

> +
> +    $ GIT_TEST_ONLY='[0-8]' sh ./t9200-git-cvsexport-commit.sh
> +
> Note that some tests in the existing test suite rely on previous
> test item, so you cannot arbitrarily disable one and expect the
> remainder of test to check what the test originally was intended
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 89a405b..12bf436 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -464,6 +464,14 @@ test_skip () {
>  fi
>  skipped_reason="missing $missing_prereq${of_prereq}"
>  fi
> + if test -z "$to_skip" && test -n "$GIT_TEST_ONLY" &&
> + ! match_pattern_list $this_test.$test_count $GIT_TEST_ONLY &&
> + ! match_pattern_list $test_count $GIT_TEST_ONLY
> + then
> + to_skip=t
> + skipped_reason="not in GIT_TEST_ONLY"
> + fi
> +
>  case "$to_skip" in
>  t)
>  say_color skip >&3 "skipping test: $@"
> -- 
Philip 
