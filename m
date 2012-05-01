From: =?UTF-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpld3NraS1Tem1law==?= 
	<zbyszek@in.waw.pl>
Subject: Re: [PATCH 3/3] t5541: test more combinations of --progress
Date: Tue, 01 May 2012 22:45:00 +0200
Message-ID: <4FA04B4C.4090507@in.waw.pl>
References: <20120501084048.GA21904@sigill.intra.peff.net> <20120501084307.GC4998@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Clemens Buchacher <drizzd@aon.at>,
	Junio C Hamano <gitster@pobox.com>,
	dfowler <davidfowl@gmail.com>, git@vger.kernel.org,
	msysgit@googlegroups.com, Paul Betts <paul@github.com>,
	David Ebbo <david.ebbo@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 01 22:45:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPJwo-00055x-Uq
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 22:45:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753795Ab2EAUpP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 May 2012 16:45:15 -0400
Received: from kawka.in.waw.pl ([178.63.212.103]:35819 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752853Ab2EAUpO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2012 16:45:14 -0400
Received: from ip-78-30-111-99.free.aero2.net.pl ([78.30.111.99])
	by kawka.in.waw.pl with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1SPJwa-0004xj-AY; Tue, 01 May 2012 22:45:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.3) Gecko/20120329 Icedove/10.0.3
In-Reply-To: <20120501084307.GC4998@sigill.intra.peff.net>
X-Enigmail-Version: 1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196742>

On 05/01/2012 10:43 AM, Jeff King wrote:
> -test_expect_success TTY 'quiet push' '
> +test_expect_success TTY 'push shows progress when stderr is a tty' '
> +	cd "$ROOT_PATH"/test_repo_clone &&
> +	test_commit noisy &&
> +	test_terminal git push 2>&1 | tee output &&
> +	grep "^Writing objects" output
> +'
> +
> +test_expect_success TTY 'push --quiet silences status and progress' '
>  	cd "$ROOT_PATH"/test_repo_clone &&
>  	test_commit quiet &&
> -	test_terminal git push --quiet --no-progress 2>&1 | tee output &&
> +	test_terminal git push --quiet 2>&1 | tee output &&
>  	test_cmp /dev/null output
>  '
>  
> +test_expect_success TTY 'push --no-progress silences progress but not status' '
> +	cd "$ROOT_PATH"/test_repo_clone &&
> +	test_commit no-progress &&
> +	test_terminal git push --no-progress 2>&1 | tee output &&
> +	grep "^To http" output &&
> +	! grep "^Writing objects"
        ! grep "^Writing objects" output

> +'
> +
> +test_expect_success 'push --progress shows progress to non-tty' '
> +	cd "$ROOT_PATH"/test_repo_clone &&
> +	test_commit progress &&
> +	git push --progress 2>&1 | tee output &&
> +	grep "^To http" output &&
> +	grep "^Writing objects" output
> +'
> +
I understand that test_i18ngrep is not necessary, because pack-objects.c
is not internationalized. But wouldn't it make sense to use
test_i18ngrep in preparation, so that tests don't have to be modified
later on?

-
Zbyszek
