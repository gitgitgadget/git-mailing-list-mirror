From: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Subject: Re: [PATCH v5 07/10] send-email: reduce dependancies impact on
 parse_address_line
Date: Sun, 21 Jun 2015 12:07:36 +0200 (CEST)
Message-ID: <1692637261.3463890.1434881256090.JavaMail.zimbra@imag.fr>
References: <1434550720-24130-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr> <1434842273-30945-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr> <1434842273-30945-7-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sun Jun 21 12:07:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z6cAH-0001Sf-FO
	for gcvg-git-2@plane.gmane.org; Sun, 21 Jun 2015 12:07:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753431AbbFUKHp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jun 2015 06:07:45 -0400
Received: from mx2.imag.fr ([129.88.30.17]:48695 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752285AbbFUKHn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jun 2015 06:07:43 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t5LA7ZES024020
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 21 Jun 2015 12:07:35 +0200
Received: from z8-mb-verimag.imag.fr (z8-mb-verimag.imag.fr [129.88.4.38])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t5LA7bdk022048;
	Sun, 21 Jun 2015 12:07:37 +0200
In-Reply-To: <1434842273-30945-7-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
X-Originating-IP: [129.88.6.115]
X-Mailer: Zimbra 8.0.6_GA_5922 (ZimbraWebClient - FF31 (Linux)/8.0.6_GA_5922)
Thread-Topic: send-email: reduce dependancies impact on parse_address_line
Thread-Index: +M3vEpJoD3pi1fRp2/fC1zqK+r+ZxQ==
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sun, 21 Jun 2015 12:07:36 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t5LA7ZES024020
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@imag.fr
MailScanner-NULL-Check: 1435486060.24685@dmIW3U6QfX/hyg305tpl8Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272253>

This is the last message I received in the series, and it's labeled 07/10. Is that normal?

> parse_address_line had not the same behavior whether the user had

had not -> did not have

> I've added the function in Git.pm as suggested. I've also added a test
> named t9000-addresses.sh (I've read the README to name tests but I'm
> not sure about the name of this test). I made a separated test
> (t9000-addresses.sh) because I think it's better not to pollute
> t9001-send-email with this.

Sounds good to me.

> About the test itself, file t/t9000-addresses.sh is just a copy/paste
> of t/t0202-gettext-perl.sh. For the perl part, the TODO tests are
> verbose: they print out commands whereas test_expect_success doesn't.

It seems it's how Test::More works. I'd keep it like this, but I have no real experience with Test::More.

> We can redirect todo_output to a variable but I've not found better...
> (Maybe someone has the solution here ?). Also there's no summary at
> the end of the test (as with other perl tests).

You can get the 1..44 at the end with

printf "1..%d\n", Test::More->builder->current_test;

This is what t9700/test.pl does.

> diff --git a/perl/Git.pm b/perl/Git.pm
> index 9026a7b..97633e9 100644
> --- a/perl/Git.pm
> +++ b/perl/Git.pm
> @@ -1584,6 +1584,73 @@ sub DESTROY {
>  	$self->_close_cat_blob();
>  }
>  
> +=item parse_mailboxes
> +
> +Returns an array of mailboxes extracted from a string.

Imperative tone => Return, not Returns.

I would have put parse_mailbox near ident_person because both functions are somehow about email.

> +BEGIN { use_ok('Git') }
> +BEGIN { use_ok('Mail::Address') }

This will fail if Mail::Address is not available. It would be better to declare Mail::Address as a prerequisite in t9000-address.sh (like what you're already doing for Test::More).

Good job, modulo these minor details, the series looks good to me.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
