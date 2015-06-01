From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 2/2] send-email: allow multiple emails using --cc, --to and --bcc
Date: Mon, 01 Jun 2015 17:12:05 +0200
Message-ID: <vpqa8wjcvju.fsf@anie.imag.fr>
References: <1433168042-28269-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
	<1433168042-28269-2-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
To: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jun 01 17:12:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzRNx-0005HX-Al
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jun 2015 17:12:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752864AbbFAPMN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2015 11:12:13 -0400
Received: from mx1.imag.fr ([129.88.30.5]:55543 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752325AbbFAPML (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2015 11:12:11 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t51FC3H9029964
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 1 Jun 2015 17:12:03 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t51FC50w021668;
	Mon, 1 Jun 2015 17:12:05 +0200
In-Reply-To: <1433168042-28269-2-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
	(Remi Lespinet's message of "Mon, 1 Jun 2015 16:14:02 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 01 Jun 2015 17:12:03 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t51FC3H9029964
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1433776327.83477@/NSkS+odMDnKtjqEvnlNoA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270424>

Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr> writes:

> Remove the limitation imposed by 79ee555b (Check and document the
> options to prevent mistakes, 2006-06-21) which rejected every argument
> with comma in --cc, --to and --bcc

Missing "." at the end of sentence.

> -The --bcc option must be repeated for each user you want on the bcc list.
> +Addresses containing commas ("Foo, Bar" <foobar@example.com>) are not
> +currently supported.
> ++
> +This option may be specified multiple times

Likewise (more instances in the patch).

> +test_expect_success $PREREQ 'setup expected-list' '
> +	git send-email \
> +	--dry-run \
> +	--from="Example <from@example.com>" \
> +	--to="to1@example.com" \
> +	--to="to2@example.com" \
> +	--to="to3@example.com" \
> +	--cc="cc1@example.com" \
> +	--cc="Cc 1 <cc1@example.com>" \
> +	--cc="Cc 2 <cc2@example.com>" \
> +	--bcc="bcc1@example.com" \
> +	--bcc="bcc2@example.com" \
> +	0001-add-master.patch |	replace_variable_fields \

Tab after |. Not really serious, but why not a space?

> +	>expected-list
> +'
> +
> +test_expect_success $PREREQ 'use email list in --cc --to and --bcc' '
> +	git send-email \
> +	--dry-run \
> +	--from="Example <from@example.com>" \
> +	--to="to1@example.com, to2@example.com" \
> +	--to="to3@example.com" \
> +	--cc="cc1@example.com, Cc 1 <cc1@example.com>" \
> +	--cc="Cc 2 <cc2@example.com>" \
> +	--bcc="bcc1@example.com, bcc2@example.com" \
> +	0001-add-master.patch |	replace_variable_fields \
> +	 >actual-list &&

You may drop the space between TAB and >.

I would group the tests: the 'setup' is only used to generate
expected-list which is used only in the second test, so one is not
useful without the other (we commonly have a 'setup ...' test which sets
up something used by several other tests).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
