From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/6] transport-helper: clarify *:* refspec
Date: Thu, 18 Apr 2013 10:27:26 -0700
Message-ID: <7vhaj37nr5.fsf@alter.siamese.dyndns.org>
References: <1366258473-12841-1-git-send-email-felipe.contreras@gmail.com>
	<1366258473-12841-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, John Keeping <john@keeping.me.uk>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Max Horn <max@quendi.de>, Jonathan Nieder <jrnieder@gmail.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 18 19:27:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USscT-0007yM-3F
	for gcvg-git-2@plane.gmane.org; Thu, 18 Apr 2013 19:27:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936405Ab3DRR1a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Apr 2013 13:27:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48951 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935970Ab3DRR13 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Apr 2013 13:27:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DFC3E172AF;
	Thu, 18 Apr 2013 17:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=qqru9JBlmmQEkY2sQeHQWA79Gvg=; b=GImAtlcA83z2jkpq+xD/
	gptMCQ3OW33E3TvcmY8Fp/ulEsLd2aZPZvpC84NmG6LkqxwTbAsX0st/NmigGdDq
	CYox/WaAhhkOjAiWJmUH+6YOsLAJgPPD2Nner008gqi6WA/7FaYBENed36hx4MJ7
	DSarkz6L9FNYKn3W7XlcW+w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=EiSknHOay6V+ZcqzTNVfIrSjIbPZVWyizFSRZGTmCFfYNc
	KXHkZASA16AeGj+EjDLWAM3XE2Zl0bSa7YMhM1Q6LYXP9roGAvCulx5TFTfuWIR0
	/fpb3OSqAivgvIMzoTxpa60UK84L6aFRc5oSFDFJfGyNnqzcFwPTLCLGJ5Muk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D67C9172AE;
	Thu, 18 Apr 2013 17:27:28 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 43E71172AC;
	Thu, 18 Apr 2013 17:27:28 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3E2F2D90-A84D-11E2-B338-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221672>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> The *:* refspec doesn't work, and never has, clarify the code and
> documentation to reflect that. This in effect reverts commit 9e7673e
> (gitremote-helpers(1): clarify refspec behaviour).
> ...
>  applicable refspec takes precedence.  The left-hand of refspecs
>  advertised with this capability must cover all refs reported by
> -the list command.  If a helper does not need a specific 'refspec'
> -capability then it should advertise `refspec *:*`.
> +the list command.  If no 'refspec' capability is advertised,
> +there is an implied `refspec *:*`.

I presume

    s/.$/, but `*:*` does not work so do not use it./

is implied?

> diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
> index f387027..cd1873c 100755
> --- a/t/t5801-remote-helpers.sh
> +++ b/t/t5801-remote-helpers.sh
> @@ -120,21 +120,6 @@ test_expect_failure 'pushing without refspecs' '
>  	compare_refs local2 HEAD server HEAD
>  '
>  
> -test_expect_success 'pulling with straight refspec' '
> -	(cd local2 &&
> -	GIT_REMOTE_TESTGIT_REFSPEC="*:*" git pull) &&
> -	compare_refs local2 HEAD server HEAD
> -'

This one made me raise my eyebrows, first.

The only reason this test "passes" is because this particular
"pull", due to what local2 and server happens to have before this
test runs, is an "Already up-to-date" and a no-op.  You are removing
this because it is not really testing anything useful, and if you
change it to test something real, e.g. by rewinding local2, it will
reveal the breakage.

Am I reading you correctly?

> diff --git a/transport-helper.c b/transport-helper.c
> index dcd8d97..cea787c 100644
> --- a/transport-helper.c
> +++ b/transport-helper.c
> @@ -469,7 +469,7 @@ static int fetch_with_import(struct transport *transport,
>  	 * were fetching.
>  	 *
>  	 * (If no "refspec" capability was specified, for historical
> -	 * reasons we default to *:*.)
> +	 * reasons we default to the equivalent of *:*.)
>  	 *
>  	 * Store the result in to_fetch[i].old_sha1.  Callers such
>  	 * as "git fetch" can use the value to write feedback to the
