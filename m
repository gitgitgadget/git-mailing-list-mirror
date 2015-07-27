From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v5 03/11] ref-filter: add option to pad atoms to the right
Date: Mon, 27 Jul 2015 14:50:14 +0200
Message-ID: <vpq3809aho9.fsf@anie.imag.fr>
References: <CAOLa=ZTtAepdO5U8zo62VBn_z4-LcKoguPxVGaAnNZULEwzrQQ@mail.gmail.com>
	<1437982035-6658-1-git-send-email-Karthik.188@gmail.com>
	<1437982035-6658-3-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 27 14:50:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJhrT-0006mb-U1
	for gcvg-git-2@plane.gmane.org; Mon, 27 Jul 2015 14:50:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752323AbbG0Mu1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jul 2015 08:50:27 -0400
Received: from mx1.imag.fr ([129.88.30.5]:37191 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751261AbbG0Mu0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jul 2015 08:50:26 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t6RCoDP2020962
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 27 Jul 2015 14:50:13 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t6RCoF5R011759;
	Mon, 27 Jul 2015 14:50:15 +0200
In-Reply-To: <1437982035-6658-3-git-send-email-Karthik.188@gmail.com> (Karthik
	Nayak's message of "Mon, 27 Jul 2015 12:57:07 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 27 Jul 2015 14:50:13 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t6RCoDP2020962
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1438606216.79958@V6ijKJRXBglj7ZgRcotSOg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274674>

Karthik Nayak <karthik.188@gmail.com> writes:

> --- a/t/t6302-for-each-ref-filter.sh
> +++ b/t/t6302-for-each-ref-filter.sh
> @@ -81,4 +81,20 @@ test_expect_success 'filtering with --contains' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'padding to the right using `padright`' '
> +	cat >expect <<-\EOF &&
> +	refs/heads/master        |
> +	refs/heads/side          |
> +	refs/odd/spot            |
> +	refs/tags/double-tag     |
> +	refs/tags/four           |
> +	refs/tags/one            |
> +	refs/tags/signed-tag     |
> +	refs/tags/three          |
> +	refs/tags/two            |
> +	EOF
> +	git for-each-ref --format="%(padright:25)%(refname)|" >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_done

See my remark on previous patch: this test is not sufficient. You do
not only need to check that %(padright) is taken into account, but you
also need to check that it is taken into account for the right atom and
only this one. I'd suggest

--format '%(refname)%(padright:25)|%(refname)|%(refname)|'

Only the middle column should be padded.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
