From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v13 2/6] test-parse-options: print quiet as integer
Date: Tue, 12 Apr 2016 14:33:35 -0700
Message-ID: <xmqq60vmpl5c.fsf@gitster.mtv.corp.google.com>
References: <01020153faf9fc14-e6ad18fa-c892-4601-bab7-e2cc4cd9e100-000000@eu-west-1.amazonses.com>
	<01020153faf9fcbb-adadd774-db3a-43ce-b908-d08ac1312b31-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 12 23:33:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aq5wU-0007tl-4q
	for gcvg-git-2@plane.gmane.org; Tue, 12 Apr 2016 23:33:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966634AbcDLVdl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2016 17:33:41 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:53815 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S966377AbcDLVdj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2016 17:33:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3B4BC553FE;
	Tue, 12 Apr 2016 17:33:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4UpWIXqeAk+xFGcOnCZa59c8s4U=; b=btNduI
	D6/JzsXFXKtk4ZsxQ9EiqEEBUiqTw0qHnnfnOfTCT6/avB1ftl1jjVt+B5YobFLQ
	m1Qe6duck7IchPQFKguPiUowDcWgJAtuD1MXeZx7GcyYItMTMT55zY+D3J5lG8Pk
	nO29cQKvu+Kx7hB9hEqOy8XciZ2SEmll/KTxg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MyfEm21EsSm8/YMA6V9+ZPcPAXOI24KF
	6T7qncu/iJ8UDGpIOixDyC48tTecD8oPAyRF9Vm8t7KC7JzSm+jmbkpPL2KA9vkg
	iRzD5wLY9jRp02dGLp5db5LIkKm3Zr6uPWu6VSrytRBhj/5ewMmsfnRi2lw2swYd
	G0MTWORnV1I=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 322F9553FD;
	Tue, 12 Apr 2016 17:33:38 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 933BA553FC;
	Tue, 12 Apr 2016 17:33:37 -0400 (EDT)
In-Reply-To: <01020153faf9fcbb-adadd774-db3a-43ce-b908-d08ac1312b31-000000@eu-west-1.amazonses.com>
	(Pranit Bauva's message of "Sat, 9 Apr 2016 12:23:20 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 379A17E2-00F6-11E6-A064-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291299>

Pranit Bauva <pranit.bauva@gmail.com> writes:

> Current implementation of parse-options.c treats OPT__QUIET() as integer
> and not boolean and thus it is more appropriate to print it as integer
> to avoid confusion.

There is no "confusion" factor involved, as we do not use native
"boolean" type in our C code.  IIUC, the reason why we want to do
this is because we may want to see how it would affect the value of
the underlying variable to give multiple --quiet options from the
command line, which is a policy issue (i.e. we want to allow
commands to react to multiple quiet options differently), not an
implementation one (i.e. "current implementation happens to use
integer").

	We would want to see how multiple --quiet options affect the
	value of the underlying variable (we may want "--quiet --quiet"
	to still be 1, or we may want to see the value incremented
	to 2).  Show the value as integer to allow us to inspect it.

perhaps?

>
> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
> ---
>  t/t0040-parse-options.sh | 26 +++++++++++++-------------
>  test-parse-options.c     |  2 +-
>  2 files changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
> index 477fcff..450da45 100755
> --- a/t/t0040-parse-options.sh
> +++ b/t/t0040-parse-options.sh
> @@ -64,7 +64,7 @@ timestamp: 0
>  string: (not set)
>  abbrev: 7
>  verbose: 0
> -quiet: no
> +quiet: 0
>  dry run: no
>  file: (not set)
>  EOF
> @@ -164,7 +164,7 @@ timestamp: 0
>  string: 123
>  abbrev: 7
>  verbose: 2
> -quiet: no
> +quiet: 0
>  dry run: yes
>  file: prefix/my.file
>  EOF
> @@ -184,7 +184,7 @@ timestamp: 0
>  string: 321
>  abbrev: 10
>  verbose: 2
> -quiet: no
> +quiet: 0
>  dry run: no
>  file: prefix/fi.le
>  EOF
> @@ -212,7 +212,7 @@ timestamp: 0
>  string: 123
>  abbrev: 7
>  verbose: 0
> -quiet: no
> +quiet: 0
>  dry run: no
>  file: (not set)
>  arg 00: a1
> @@ -235,7 +235,7 @@ timestamp: 0
>  string: (not set)
>  abbrev: 7
>  verbose: 0
> -quiet: no
> +quiet: 0
>  dry run: no
>  file: (not set)
>  EOF
> @@ -264,7 +264,7 @@ timestamp: 0
>  string: 123
>  abbrev: 7
>  verbose: 0
> -quiet: no
> +quiet: 0
>  dry run: no
>  file: (not set)
>  EOF
> @@ -303,7 +303,7 @@ timestamp: 0
>  string: (not set)
>  abbrev: 7
>  verbose: 0
> -quiet: no
> +quiet: 0
>  dry run: no
>  file: (not set)
>  arg 00: --quux
> @@ -323,7 +323,7 @@ timestamp: 1
>  string: (not set)
>  abbrev: 7
>  verbose: 0
> -quiet: yes
> +quiet: 1
>  dry run: no
>  file: (not set)
>  arg 00: foo
> @@ -345,7 +345,7 @@ timestamp: 0
>  string: (not set)
>  abbrev: 7
>  verbose: 0
> -quiet: no
> +quiet: 0
>  dry run: no
>  file: (not set)
>  EOF
> @@ -374,7 +374,7 @@ timestamp: 0
>  string: (not set)
>  abbrev: 7
>  verbose: 0
> -quiet: no
> +quiet: 0
>  dry run: no
>  file: (not set)
>  EOF
> @@ -399,7 +399,7 @@ timestamp: 0
>  string: (not set)
>  abbrev: 7
>  verbose: 0
> -quiet: no
> +quiet: 0
>  dry run: no
>  file: (not set)
>  EOF
> @@ -430,7 +430,7 @@ timestamp: 0
>  string: (not set)
>  abbrev: 7
>  verbose: 0
> -quiet: no
> +quiet: 0
>  dry run: no
>  file: (not set)
>  EOF
> @@ -449,7 +449,7 @@ timestamp: 0
>  string: (not set)
>  abbrev: 7
>  verbose: 0
> -quiet: no
> +quiet: 0
>  dry run: no
>  file: (not set)
>  EOF
> diff --git a/test-parse-options.c b/test-parse-options.c
> index 2c8c8f1..86afa98 100644
> --- a/test-parse-options.c
> +++ b/test-parse-options.c
> @@ -90,7 +90,7 @@ int main(int argc, char **argv)
>  	printf("string: %s\n", string ? string : "(not set)");
>  	printf("abbrev: %d\n", abbrev);
>  	printf("verbose: %d\n", verbose);
> -	printf("quiet: %s\n", quiet ? "yes" : "no");
> +	printf("quiet: %d\n", quiet);
>  	printf("dry run: %s\n", dry_run ? "yes" : "no");
>  	printf("file: %s\n", file ? file : "(not set)");
>  
>
> --
> https://github.com/git/git/pull/218
