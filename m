From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] Testing: XDG config files: Export a suitable
 `XDG_CONFIG_HOME' environment variable
Date: Tue, 17 Jul 2012 11:31:24 -0700
Message-ID: <7vliiixmrn.fsf@alter.siamese.dyndns.org>
References: <82316e5034d940e09fed719ae7bfdc3b-mfwitten@gmail.com>
 <679ad82bd4604d1c903f3c2fff2a8cfb-mfwitten@gmail.com>
 <vpqmx2yp85z.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Witten <mfwitten@gmail.com>,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jul 17 20:31:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SrCYX-0007Pv-Cj
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jul 2012 20:31:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753379Ab2GQSb2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jul 2012 14:31:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57845 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752059Ab2GQSb1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jul 2012 14:31:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5F1616F7F;
	Tue, 17 Jul 2012 14:31:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XK7z2ytqIVnrjd+a8jumngqpFtc=; b=NmOn11
	dOY+qfqRhURJYDNOJg9ChDKLS8FOlHsP3pXuWKl9gRG/UvRhLRNfh85WobxRcTTB
	ldEOQOtXN0NgnWErKFP+dApyHpgURG1GW9YfaXrkV77icdoV1nEahck7TKDkP1f2
	hIYXOYastvJhwAB2VeD/BJB6ZcrH0BZ+dZNlc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=h1MeOi8VoH2fBypVOJNaUbqZGq6eVVTM
	Z9VEcbT+nmzQdxuiIEvdgQgPglcHjfc/FmXSdks5MVsA8Ix/q1FQmY839wxf0nFc
	lnV9ecakeqFvLBGQBte6q8MVt6BuLzGpYxT67Lu9qD67Y9+JDLuDf+FNVBSP3fv0
	h74dnYvso+k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4B9CC6F7E;
	Tue, 17 Jul 2012 14:31:26 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A22B26F7D; Tue, 17 Jul 2012
 14:31:25 -0400 (EDT)
In-Reply-To: <vpqmx2yp85z.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Tue, 17 Jul 2012 20:14:00 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9DCACB30-D03D-11E1-8F4C-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201617>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Before your patches, the correct management of $XDG_CONFIG_HOME to
> override $HOME/.config/git/ was untested (which is unfortunate, indeed),
> but after your patch serie, the fact that the default is
> $HOME/.config/git/ is untested, which IMHO is even worse.
>
> Unsetting XDG_CONFIG_HOME and adding one test like this would be better
> IMHO.

Absolutely.  We would want to make sure that the new code does not
interfere with established uses when the user does not ask for the
new feature (i.e. XDG not set), and also make sure it does what it
was meant to do when the feature is called for (i.e. XDG set).  It
might be true that the set of tests in the series did not test the
full spectrum of the latter, but then we would want to see the gap
filled by adding missing tests, not by converting tests for former
into the ones that test for the latter.

Even with the patch below there may be other gaps in the test. For
example, core.excludesfile and core.attributesfile must default to
the XDG location when they exist, whether these variables are set;
we may want to make sure that is not broken in the future.

Michael, could you change the direction of the patch and look into
filling such gaps?

Thanks.

> diff --git a/t/t1306-xdg-files.sh b/t/t1306-xdg-files.sh
> index 3c75c3f..f1ea9f1 100755
> --- a/t/t1306-xdg-files.sh
> +++ b/t/t1306-xdg-files.sh
> @@ -38,6 +38,19 @@ test_expect_success 'read with --get: xdg file exists and ~/.gitconfig doesn'\''
>         test_cmp expected actual
>  '
>  
> +test_expect_success '"$XDG_CONFIG_HOME overrides $HOME/.config/git' '
> +       mkdir -p "$HOME"/xdg/git/ &&
> +       echo "[user]" >"$HOME"/xdg/git/config &&
> +       echo "  name = in_xdg" >>"$HOME"/xdg/git/config &&
> +       echo in_xdg >expected &&
> +       (
> +               XDG_CONFIG_HOME="$HOME"/xdg/ &&
> +               export XDG_CONFIG_HOME &&
> +               git config --get-all user.name >actual
> +       ) &&
> +       test_cmp expected actual
> +'
> +
>  
>  test_expect_success 'read with --get: xdg file exists and ~/.gitconfig exists' '
>         >.gitconfig &&
