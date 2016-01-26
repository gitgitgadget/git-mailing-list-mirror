From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 12/19] mingw: skip test in t1508 that fails due to path conversion
Date: Tue, 26 Jan 2016 14:02:30 -0800
Message-ID: <xmqqk2mwatjd.fsf@gitster.mtv.corp.google.com>
References: <cover.1453650173.git.johannes.schindelin@gmx.de>
	<cover.1453818789.git.johannes.schindelin@gmx.de>
	<5aea04c3f348e3891a01b6908bf6562a26f9dd1e.1453818790.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jan 26 23:02:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOBh8-0002wk-I7
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jan 2016 23:02:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752591AbcAZWCf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2016 17:02:35 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:53616 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752330AbcAZWCd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2016 17:02:33 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0BAFB3F748;
	Tue, 26 Jan 2016 17:02:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0tjG+ro51/xrXnRWePnLn5lvQzc=; b=u6383T
	su6MVHbsiKlPLDr7mxrAeMHAltNCNdgylwgtz0/dc1sB7QfmNPil5avxbcx1cEz2
	8CyDnmqHlD6FsWGAlFdakZL/GH9uNDkgvFe/p/16+kd17fTFsq639AoLrxQOA5PB
	MsIYQV1/OrrhyzYBqPcEClwY9K2MZB1Vywths=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QcL+k8a+/LvzKoFXAmTlzp4xCiMiTZcz
	9B5t3qQPobAen4mNXE7vSrJn42jN0UqvJuRDRKsLalTPtDKvGN2SgeOyLctppzw4
	Bmz/IAlbirqK0LWSKs3svtgXnXBsLUYmJIS9I13pthZ1yVBCwSmn5HmlJkI2LdyK
	ryLCiD/B5fg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 02E2C3F747;
	Tue, 26 Jan 2016 17:02:33 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 638663F746;
	Tue, 26 Jan 2016 17:02:32 -0500 (EST)
In-Reply-To: <5aea04c3f348e3891a01b6908bf6562a26f9dd1e.1453818790.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Tue, 26 Jan 2016 15:35:14 +0100
	(CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7FD0D13C-C478-11E5-B8D8-80A36AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284860>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> In Git for Windows, the MSYS2 POSIX emulation layer used by the Bash
> converts command-line arguments that looks like they refer to a POSIX
> path containing a file list (i.e. @<absolute-path>) into a Windows path
> equivalent when calling non-MSYS2 executables, such as git.exe.
>
> Let's just skip the test that uses the parameter `@/at-test` that
> confuses the MSYS2 runtime.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  t/t1508-at-combinations.sh | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/t/t1508-at-combinations.sh b/t/t1508-at-combinations.sh
> index 078e119..c59d554 100755
> --- a/t/t1508-at-combinations.sh
> +++ b/t/t1508-at-combinations.sh
> @@ -35,7 +35,10 @@ test_expect_success 'setup' '
>  	git checkout -b upstream-branch &&
>  	test_commit upstream-one &&
>  	test_commit upstream-two &&
> -	git checkout -b @/at-test &&
> +	if ! test_have_prereq MINGW
> +	then
> +		git checkout -b @/at-slash

I presume that this is meant to be "@/at-test", not "@/at-slash".

> +	fi &&
>  	git checkout -b @@/at-test &&
>  	git checkout -b @at-test &&
>  	git checkout -b old-branch &&
> @@ -64,6 +67,7 @@ check "@{-1}@{u}@{1}" commit master-one
>  check "@" commit new-two
>  check "@@{u}" ref refs/heads/upstream-branch
>  check "@@/at-test" ref refs/heads/@@/at-test
> +test_have_prereq MINGW ||
>  check "@/at-test" ref refs/heads/@/at-test
>  check "@at-test" ref refs/heads/@at-test
>  nonsense "@{u}@{-1}"
