From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] contrib/subtree: t/t7900-subtree.sh: test 21 fails when environment variable 'prefix' is set
Date: Mon, 17 Mar 2014 13:44:07 -0700
Message-ID: <xmqqiorcd088.fsf@gitster.dls.corp.google.com>
References: <5326F158.4050402@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "David A. Greene" <greened@obbligato.org>
To: Gilles Filippini <gilles.filippini@free.fr>
X-From: git-owner@vger.kernel.org Mon Mar 17 21:44:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPeOV-0003Vf-4m
	for gcvg-git-2@plane.gmane.org; Mon, 17 Mar 2014 21:44:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752108AbaCQUoQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2014 16:44:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34067 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752031AbaCQUoM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2014 16:44:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 83E6575DCD;
	Mon, 17 Mar 2014 16:44:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BIl6yufkzC3cZiFcUJuT3mIiqYI=; b=TiwW8n
	cxVlluRJ29aZdZkY0xGmI5nuT6VtuS+9bZPZpJ9TlglpFgHH8ja/53UWViLVCoyE
	3xWc/gGb85t9yLFGBZG1dZbCeJ2vFqraLROJ9bCSdXJzJyIvzav0V2/jOw5aNTVD
	yjoxp4fI8lm+m8BG04DBart7k+6+4f/8Axtac=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pvyLfj0fm46sIHYreihJetSVAzgXtiIt
	941PDZHHaB/oPsAGSjh1wrcNRGGXKaa9ShPOOS8Wed3ieUbvfdsH9dJVLngW2zMa
	dTsx9GDkNTDNiOuOhlXXvDPBSrEbsO9DoZcYAQOyKKmSQd2UtHltwQeM7fIVUeES
	UxygNEvVD4I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6F7C275DCC;
	Mon, 17 Mar 2014 16:44:11 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7899275DC9;
	Mon, 17 Mar 2014 16:44:10 -0400 (EDT)
In-Reply-To: <5326F158.4050402@free.fr> (Gilles Filippini's message of "Mon,
	17 Mar 2014 13:58:00 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E45B7E1C-AE14-11E3-A93F-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244282>

Gilles Filippini <gilles.filippini@free.fr> writes:

> Test 21 from contrib/subtree/t/t7900-subtree.sh fails when an
> environment variable 'prefix' is set. For instance here is what happens
> when prefix=/usr:
>
> expecting success:
>         echo "You must provide the --prefix option." > expected &&
>         test_must_fail git subtree split > actual 2>&1 &&
> 	test_debug "printf 'expected: '" &&
>         test_debug "cat expected" &&
> 	test_debug "printf 'actual: '" &&
>         test_debug "cat actual" &&
>         test_cmp expected actual &&
>         rm -f expected actual
>
> --- expected	2014-03-17 10:39:34.907594853 +0000
> +++ actual	2014-03-17 10:39:34.979595322 +0000
> @@ -1 +1,9 @@
> -You must provide the --prefix option.
> fatal: /usr: '/usr' is outside repository
> fatal: /usr: '/usr' is outside repository
> fatal: /usr: '/usr' is outside repository
> fatal: /usr: '/usr' is outside repository
> fatal: /usr: '/usr' is outside repository
> fatal: /usr: '/usr' is outside repository
> fatal: /usr: '/usr' is outside repository
> fatal: /usr: '/usr' is outside repository
> +No new revisions were found
> not ok 21 - Check that prefix argument is required for split

Thanks.  Although I do not use nor touch git-subtree, I am
reasonably confident that this patch should fix it.

-- >8 --
Subject: subtree: initialise all variables to known state

Parsing the command line options may set prefix to the given value
with --prefix=value or an empty string with --no-prefix, but the
script forgets to protect against a stray environment variable.

Make sure all the variables that can be assigned in the command line
parsing are initialized to empty.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 contrib/subtree/git-subtree.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 7d7af03..90e0b7e 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -46,6 +46,7 @@ ignore_joins=
 annotate=
 squash=
 message=
+prefix=
 
 debug()
 {
