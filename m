From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] t1308: do not get fooled by symbolic links to the source
 tree
Date: Fri, 3 Jun 2016 08:05:56 +0200
Message-ID: <57511E44.1090708@kdbg.org>
References: <xmqqzir53mdc.fsf@gitster.mtv.corp.google.com>
 <712e0755-6008-21f5-0ee6-25ed9d97fd45@web.de>
 <xmqq1t4ftheu.fsf@gitster.mtv.corp.google.com>
 <xmqqwpm7s2ex.fsf@gitster.mtv.corp.google.com>
 <20160602213920.GA13356@sigill.intra.peff.net>
 <xmqqeg8fs0dw.fsf_-_@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 03 08:06:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8iFC-0002X9-5G
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 08:06:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751457AbcFCGGA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 02:06:00 -0400
Received: from bsmtp3.bon.at ([213.33.87.17]:1769 "EHLO bsmtp3.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751126AbcFCGF7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2016 02:05:59 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 3rLYVr6ZwCz5tlP;
	Fri,  3 Jun 2016 08:05:56 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 37D8D52C2;
	Fri,  3 Jun 2016 08:05:56 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
In-Reply-To: <xmqqeg8fs0dw.fsf_-_@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296267>

Am 03.06.2016 um 00:15 schrieb Junio C Hamano:
> When your $PWD does not match $(/bin/pwd), e.g. you have your copy
> of the git source tree in one place, point it with a symbolic link,
> and then "cd" to that symbolic link before running 'make test', one
> of the tests in t1308 expects that the per-user configuration was
> reported to have been read from the true path (i.e. relative to the
> target of such a symbolic link), but the test-config program reports
> a path relative to $PWD (i.e. the symbolic link).
>
> Instead, expect a path relative to $HOME (aka $TRASH_DIRECTORY), as
> per-user configuration is read from $HOME/.gitconfig and the test
> framework sets these shell variables up in such a way to avoid this
> problem.

> diff --git a/t/t1308-config-set.sh b/t/t1308-config-set.sh
> index 065d5eb..cf716b4 100755
> --- a/t/t1308-config-set.sh
> +++ b/t/t1308-config-set.sh
> @@ -237,7 +237,7 @@ test_expect_success 'iteration shows correct origins' '
>   	key=foo.bar
>   	value=from-home
>   	origin=file
> -	name=$(pwd)/.gitconfig
> +	name=$HOME/.gitconfig

I haven't tested this, yet, but my guess is that this breaks on Windows: 
test-config will produce C:/foo style path, but the updated test would 
expect /c/foo style path. Dscho, do you have an idea how to fix this?

>   	scope=global
>
>   	key=foo.bar
>

-- Hannes
