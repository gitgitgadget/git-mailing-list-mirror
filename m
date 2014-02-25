From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] difftool: support repositories with .git-files
Date: Tue, 25 Feb 2014 10:02:27 -0800
Message-ID: <xmqq1tyr6pfw.fsf@gitster.dls.corp.google.com>
References: <1393211555-50270-1-git-send-email-davvid@gmail.com>
	<xmqqr46s9yzx.fsf@gitster.dls.corp.google.com>
	<530BB548.3050603@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org,
	=?utf-8?B?R8OhYm9yIExpcHTDoWs=?= <gabor.liptak@gmail.com>,
	John Keeping <john@keeping.me.uk>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Feb 25 19:02:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIMKy-00019P-K6
	for gcvg-git-2@plane.gmane.org; Tue, 25 Feb 2014 19:02:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753350AbaBYSCc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Feb 2014 13:02:32 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56064 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753258AbaBYSCb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Feb 2014 13:02:31 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CF2656F650;
	Tue, 25 Feb 2014 13:02:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=zjL2yWgMjac+
	aN3qnCStTZS2dI8=; b=JuALB1PYoKB/v70CpZE47r34G9vNw9RqK4sp2F7UjCxY
	uiMip8XrGtYi3vgTnRGEglQP0as/zRfAq8gkUNfH5wsZ0iTekkA/rmjWj/Ugl5AI
	q3j6Qy18Y/TkA+wJY+tEDr52lp5V5O2oVjuwJ17rZVqmuIZStZgKJWWp8cEbMn0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Gcmj1E
	8yWmk7eQhkqwDfraaybl5xf6EIG8hiqcjZR+4i4qg6f7Gdo3tU9pkqsEc+vtqkDi
	LSywiI+LXdEgNvr4qg5XgPw6BRIfFJ3grsUf+3L0BwysZ02MbwKhCNccPK6pSR7W
	KSWObtftTsl1m/hEd6oivMhBUbaBEVuMXH0zQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A39B56F64F;
	Tue, 25 Feb 2014 13:02:30 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ADBBE6F64E;
	Tue, 25 Feb 2014 13:02:29 -0500 (EST)
In-Reply-To: <530BB548.3050603@web.de> (Jens Lehmann's message of "Mon, 24 Feb
	2014 21:10:32 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: FDFA75E0-9E46-11E3-BEAB-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242678>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Am 24.02.2014 17:55, schrieb Junio C Hamano:
>> David Aguilar <davvid@gmail.com> writes:
>>=20
>>> Modern versions of "git submodule" use .git-files to setup the
>>> submodule directory.  When run in a "git submodule"-created
>>> repository "git difftool --dir-diff" dies with the following
>>> error:
>>>
>>> 	$ git difftool -d HEAD~
>>> 	fatal: This operation must be run in a work tree
>>> 	diff --raw --no-abbrev -z HEAD~: command returned error: 128
>>>
>>> core.worktree is relative to the .git directory but the logic
>>> in find_worktree() does not account for it.
>>>
>>> Use `git rev-parse --show-toplevel` to find the worktree so that
>>> the dir-diff feature works inside a submodule.
>>>
>>> Reported-by: G=C3=A1bor Lipt=C3=A1k <gabor.liptak@gmail.com>
>>> Helped-by: Jens Lehmann <jens.lehmann@web.de>
>>> Helped-by: John Keeping <john@keeping.me.uk>
>>> Signed-off-by: David Aguilar <davvid@gmail.com>
>>> ---
>>=20
>> Looks good; thanks.
>
>
> FWIW:
> Tested-by: Jens Lehmann <jens.lehmann@web.de>
>
> What about squashing this in to detect any future regressions?
>
> diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
> index 2418528..d86ad68 100755
> --- a/t/t7800-difftool.sh
> +++ b/t/t7800-difftool.sh
> @@ -434,4 +434,12 @@ test_expect_success PERL 'difftool --no-symlinks=
 detects conflict ' '
>  	)
>  '
>
> +test_expect_success PERL 'difftool properly honours gitlink and core=
=2Eworktree' '
> +	git submodule add ./. submod/ule &&
> +	(
> +		cd submod/ule &&
> +		git difftool --tool=3Decho  --dir-diff --cached

In the context of this fix, finishing with 0 exit status may be all
we care about, but do we also care about things like in what
directory the tool is invoked in, what arguments and extra
environment settings (if any) it is given, and stuff like that?

In fact, the "echo" in the above is very misleading.  The test
relies on the fact that immediately after the submod/ule is cloned,
"diff --cached" does not have to call any tool backend---if you
modify some tracked file in its working tree and dropped --cached
on the command line, the command will fail with "Huh?  I do not know
what 'echo' diff/merge backend is", no?

> +	)
> +'
> +
>  test_done
