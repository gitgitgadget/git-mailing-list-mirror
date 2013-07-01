From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t4205: replace .\+ with ..* in sed commands
Date: Mon, 01 Jul 2013 12:26:34 -0700
Message-ID: <7vtxkef5ed.fsf@alter.siamese.dyndns.org>
References: <1372705199-17679-1-git-send-email-brian@gernhardtsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Brian Gernhardt <brian@gernhardtsoftware.com>
X-From: git-owner@vger.kernel.org Mon Jul 01 21:26:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UtjkH-0004C6-Lf
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jul 2013 21:26:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754255Ab3GAT0h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jul 2013 15:26:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43281 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753207Ab3GAT0h (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jul 2013 15:26:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7406B2CF58;
	Mon,  1 Jul 2013 19:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BoIVOtDIW1fimMUfC6n17QD4294=; b=Ci/PlE
	gz+oPmPZxnpYDeVOWYMA5ld+GIE1F1uwXQuUHZ2/UzbECMR+8K2qz/TYB4v2tciN
	dapmkr0jVS5lQLehQ47IThq1rA9WG4vY5el19Tru7hym+rH9zl0R1NrC67eACPWr
	/+EHGVKJNARji4zbq9hB60mSHhEje/1XiXAuw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jFZzgFJa1lZy4caBUof3wzc9fpF5pHTM
	w1WOOjbIshHS0jUlphQKfQitdCp/jOh56RPrgNDfw9i4wMaRozkOxl/FjQbopB3t
	uFFTRos/yUxtZOsKvz2VN7ycznzeibLBR0b2b7cUtEB5m8MlQyB5YbfhL1lUDHql
	HEFOSEIuI98=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6B55A2CF54;
	Mon,  1 Jul 2013 19:26:36 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C53812CF51;
	Mon,  1 Jul 2013 19:26:35 +0000 (UTC)
In-Reply-To: <1372705199-17679-1-git-send-email-brian@gernhardtsoftware.com>
	(Brian Gernhardt's message of "Mon, 1 Jul 2013 14:59:59 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 24F58452-E284-11E2-8311-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229324>

Brian Gernhardt <brian@gernhardtsoftware.com> writes:

> OS X's sed only accepts basic regular expressions, which does not
> allow the + quantifier.  However '..*' (anything, followed by zero or
> more anything) is the same as '.\+' (one or more anything) and valid
> in any regular expression language.

Thanks for spotting this.

We shouldn't mark this as "OS X's sed is broken", but as "We try to
stick to POSIX BRE, and calling ERE elements via backslash escape,
e.g. \+, is a GNU extension we try to avoid".  Obviously we are not
always careful and sometimes these slip through the review process.

>
> Signed-off-by: Brian Gernhardt <brian@gernhardtsoftware.com>
> ---
>  t/t4205-log-pretty-formats.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
> index 719d132..3cfb744 100755
> --- a/t/t4205-log-pretty-formats.sh
> +++ b/t/t4205-log-pretty-formats.sh
> @@ -192,7 +192,7 @@ test_expect_success 'left alignment formatting with trunc' "
>  message ..
>  message ..
>  add bar  Z
> -$(commit_msg "" "8" ".\+$")
> +$(commit_msg "" "8" "..*$")
>  EOF
>  	test_cmp expected actual
>  "
> @@ -310,7 +310,7 @@ test_expect_success 'left/right alignment formatting with stealing' "
>  short long  long long
>  message ..   A U Thor
>  add bar      A U Thor
> -$(commit_msg "" "8" ".\+$")   A U Thor
> +$(commit_msg "" "8" "..*$")   A U Thor
>  EOF
>  	test_cmp expected actual
>  "
