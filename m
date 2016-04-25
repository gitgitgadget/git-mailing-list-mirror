From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2] hooks: Add ability to specify where the hook directory
 is
Date: Mon, 25 Apr 2016 21:11:11 +0200
Message-ID: <571E6BCF.5020606@kdbg.org>
References: <CACBZZX7jTHqSq0ADJxO0cP+1MZMWAowLMMj4J0NHkFTYOYsJiw@mail.gmail.com>
 <1461532702-4045-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder@ira.uka.de>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 25 21:11:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auluj-0007or-N9
	for gcvg-git-2@plane.gmane.org; Mon, 25 Apr 2016 21:11:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932961AbcDYTLS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Apr 2016 15:11:18 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:12086 "EHLO bsmtp1.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754766AbcDYTLR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2016 15:11:17 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 3qtwmx4fhJz5tlH;
	Mon, 25 Apr 2016 21:11:13 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id A1E705271;
	Mon, 25 Apr 2016 21:11:12 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
In-Reply-To: <1461532702-4045-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292547>

Am 24.04.2016 um 23:18 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
> +test_expect_success 'set up a pre-commit hook in core.hooksPath' '
> +	mkdir -p .git/custom-hooks .git/hooks &&
> +	write_script .git/custom-hooks/pre-commit <<EOF &&
> +printf "%s" "." >>.git/PRE-COMMIT-HOOK-WAS-CALLED
> +EOF
> +	cat >.git/hooks/pre-commit <<EOF &&
> +	write_script .git/hooks/pre-commit &&
> +printf "%s" "SHOULD NOT BE CALLED" >>.git/PRE-COMMIT-HOOK-WAS-CALLED
> +EOF
> +	chmod +x .git/custom-hooks/pre-commit

Here I see a half-baked attempt to use write_script. Once you've fixed=20
that, we have a pre-commit hook in the regular hook directory.=20
Obviously, the hook is expected not to be called...

> +'
> +
> +test_expect_success 'Check that various forms of specifying core.hoo=
ksPath work' '
> +	test_commit no_custom_hook &&

=2E.. but at this point, it *will* be called...

> +	git config core.hooksPath .git/custom-hooks &&
> +	test_commit have_custom_hook &&
> +	git config core.hooksPath .git/custom-hooks/ &&
> +	test_commit have_custom_hook_trailing_slash &&
> +	git config core.hooksPath "$PWD/.git/custom-hooks" &&
> +	test_commit have_custom_hook_abs_path &&
> +	git config core.hooksPath "$PWD/.git/custom-hooks/" &&
> +	test_commit have_custom_hook_abs_path_trailing_slash &&
> +	printf "%s" "...." >.git/PRE-COMMIT-HOOK-WAS-CALLED.expect &&

=2E.. and this expectation is wrong.

> +	test_cmp .git/PRE-COMMIT-HOOK-WAS-CALLED.expect .git/PRE-COMMIT-HOO=
K-WAS-CALLED
> +'
> +
> +test_done
>

I feel a bit uneasy that expected and actual files are not POSIXly=20
correct text files, i.e., the LF at the end is missing...

-- Hannes
