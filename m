From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/PATCH 02/11] ref-filter: add 'colornext' atom
Date: Tue, 28 Jul 2015 10:45:07 +0200
Message-ID: <vpqd1zc1xik.fsf@anie.imag.fr>
References: <CAOLa=ZT3_DMJWFN62cbF19uxYBFsE69dGaFR=af1HPKsQ42otg@mail.gmail.com>
	<1438066594-5620-1-git-send-email-Karthik.188@gmail.com>
	<1438066594-5620-2-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 28 10:45:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZK0Vp-0003Ph-Gr
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 10:45:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932262AbbG1IpR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 04:45:17 -0400
Received: from mx1.imag.fr ([129.88.30.5]:54612 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932261AbbG1IpN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 04:45:13 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t6S8j6a1005727
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Tue, 28 Jul 2015 10:45:07 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t6S8j7Vg026756;
	Tue, 28 Jul 2015 10:45:07 +0200
In-Reply-To: <1438066594-5620-2-git-send-email-Karthik.188@gmail.com> (Karthik
	Nayak's message of "Tue, 28 Jul 2015 12:26:27 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 28 Jul 2015 10:45:07 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t6S8j6a1005727
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1438677907.54785@VpMijtOF74SOcDDgLAfXSw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274759>

Karthik Nayak <karthik.188@gmail.com> writes:

> --- a/t/t6302-for-each-ref-filter.sh
> +++ b/t/t6302-for-each-ref-filter.sh
> @@ -133,4 +133,20 @@ test_expect_success 'reverse version sort' '
>  	test_cmp expect actual
>  '
>  
> +get_color ()
> +{
> +	git config --get-color no.such.slot "$1"
> +}
> +
> +cat >expect <<EOF &&
> +$(get_color green)foo1.10$(get_color reset)||
> +$(get_color green)foo1.3$(get_color reset)||
> +$(get_color green)foo1.6$(get_color reset)||
> +EOF
> +
> +test_expect_success 'check `colornext` format option' '
> +	git for-each-ref --format="%(colornext:green)%(refname:short)||" | grep "foo" >actual &&
> +	test_cmp expect actual
> +'

This is not a very good test: you're not checking that colornext applies
to the next and only this one. Similarly to what I suggested for
padright, I'd suggest

  --format="%(refname:short)%(colornext:green)|%(refname:short)|%(refname:short)|"

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
