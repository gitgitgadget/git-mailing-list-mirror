From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v2 2/2] grep: stop looking at random places for .gitattributes
Date: Wed, 10 Oct 2012 16:21:43 +0200
Message-ID: <50758477.3030304@viscovery.net>
References: <1349868894-3579-1-git-send-email-pclouds@gmail.com> <1349877544-17648-1-git-send-email-pclouds@gmail.com> <1349877544-17648-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 10 16:22:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLxAg-0005DL-Fy
	for gcvg-git-2@plane.gmane.org; Wed, 10 Oct 2012 16:22:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756644Ab2JJOVv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Oct 2012 10:21:51 -0400
Received: from so.liwest.at ([212.33.55.24]:35146 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756505Ab2JJOVu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Oct 2012 10:21:50 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1TLxAO-0000Kz-Dk; Wed, 10 Oct 2012 16:21:44 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 25EF31660F;
	Wed, 10 Oct 2012 16:21:44 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:15.0) Gecko/20120907 Thunderbird/15.0.1
In-Reply-To: <1349877544-17648-3-git-send-email-pclouds@gmail.com>
X-Enigmail-Version: 1.4.4
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207414>

Am 10/10/2012 15:59, schrieb Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy:
> This patch passes real paths down to grep_source_load_driver(). Excep=
t
> grepping a blob, all other cases should have right paths down to

=2E.. grepping a blob or tree object...

> grep_source_load_driver(). In other words, .gitattributes are still
> respected.
=2E..
> +test_expect_success 'grep --cached respects binary diff attribute (2=
)' '
> +	git add .gitattributes &&
> +	rm .gitattributes &&
> +	git grep --cached text t >actual &&
> +	test_cmp expect actual &&
> +	git checkout .gitattributes &&
> +	git rm --cached .gitattributes
> +'

This should perhaps be test_when_finished "git rm --cached .gitattribut=
es".

> +
> +test_expect_success 'grep tree respects binary diff attribute' '

I was confused by the word "tree" here. Isn't "pathspec" more correct?

> +	git commit -m new &&
> +	echo "Binary file HEAD:t matches" >expect &&
> +	git grep text HEAD -- t >actual &&
> +	test_cmp expect actual &&
> +	git reset HEAD^
> +'

And in yet another test, should

	git grep text HEAD:t

/not/ respect the binary attribute?

At any rate, I don't observe the warnings anymore with this series.

Thanks,
-- Hannes
