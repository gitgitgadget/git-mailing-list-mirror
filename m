From: Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
Subject: Re: [PATCH] commit: add commit.signoff config option
Date: Thu, 25 Jun 2015 10:32:59 +0200 (CEST)
Message-ID: <1228200928.789773.1435221179871.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <1435217454-5718-1-git-send-email-cmarcelo@gmail.com> <20150625082059.GA9937@alex-host>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: cmarcelo@gmail.com
X-From: git-owner@vger.kernel.org Thu Jun 25 10:31:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z82Yr-00040m-65
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jun 2015 10:31:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751576AbbFYIbA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Jun 2015 04:31:00 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:48304 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750968AbbFYIa6 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2015 04:30:58 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id A5069380C;
	Thu, 25 Jun 2015 10:30:55 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1aAEs8YiZVob; Thu, 25 Jun 2015 10:30:55 +0200 (CEST)
Received: from zm-int-mbx1.grenet.fr (zm-int-mbx1.grenet.fr [130.190.242.140])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 960033805;
	Thu, 25 Jun 2015 10:30:55 +0200 (CEST)
In-Reply-To: <20150625082059.GA9937@alex-host>
X-Originating-IP: [130.190.242.136]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF38 (Win)/8.0.9_GA_6191)
Thread-Topic: commit: add commit.signoff config option
Thread-Index: xTcUuWar08Ud0YwoiY4Q07qdQoJvUQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272638>

Caio Marcelo de Oliveira Filho <cmarcelo@gmail.com> writes:
> +test_expect_success 'commit.signoff config option' '
> +        git config commit.signoff true &&
> +        echo "yet another content *narf*" >> foo &&
> +        echo "zort" | git commit -F - foo &&
> +        git cat-file commit HEAD | sed "1,/^\$/d" > output &&
> +        git config --unset commit.signoff &&
> +        test_cmp expect output
> +'
> +
> +cat > expect <<EOF
> +no signed off by here
> +EOF
> +
> +test_expect_success '--no-signoff' '
> +        git config commit.signoff true &&
> +        echo "yet another content *narf*" >> foo &&
> +        echo "no signed off by here" | git commit --no-signoff -F - =
foo &&
> +        git cat-file commit HEAD | sed "1,/^\$/d" > output &&
> +        git config --unset commit.signoff &&
> +        test_cmp expect output
> +'
> +

In both tests, you should probably use 'test_config' instead of 'git
config [...] git config --unset', it takes care of it for you (also
should prevent the case where the config is not unset when your test
fails in the middle).

=46or example, the first test would be:
test_expect_success 'commit.signoff config option' '
	test_config commit.signoff true &&
	echo "yet another content *narf*" >> foo &&
	echo "zort" | git commit -F - foo &&
	git cat-file commit HEAD | sed "1,/^\$/d" > output &&
	test_cmp expect output
'

R=C3=A9mi
