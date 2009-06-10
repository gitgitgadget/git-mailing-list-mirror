From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 1/2] more tests for git rev-parse --parse-opt
Date: Wed, 10 Jun 2009 12:37:32 +0200
Message-ID: <4A2F8CEC.4080600@viscovery.net>
References: <7vzlcgr088.fsf@alter.siamese.dyndns.org> <1244626926-19841-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
	<u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Wed Jun 10 12:38:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MELCG-0005xF-9R
	for gcvg-git-2@gmane.org; Wed, 10 Jun 2009 12:38:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755608AbZFJKhe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Jun 2009 06:37:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755226AbZFJKhe
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jun 2009 06:37:34 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:36652 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755105AbZFJKhd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Jun 2009 06:37:33 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1MELBV-0003Ew-2M; Wed, 10 Jun 2009 12:37:33 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id CFB25C6C1; Wed, 10 Jun 2009 12:37:32 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <1244626926-19841-1-git-send-email-u.kleine-koenig@pengutronix.de>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121270>

Uwe Kleine-K=C3=B6nig schrieb:
> I'm not completely sure that it's portable to use input redirection a=
nd
> && together---at least it looks a bit ugly.  Probably you know better=
=2E

The problem is more likely that there are shells that dislike heredocs =
in
eval'ed expressions. But we use such constructs already in other tests,=
 so
it should not matter a lot. Since you are modifying the code anyway, yo=
u
can "do it right".

> -test_expect_success 'test --parseopt help output' '
> -	git rev-parse --parseopt -- -h 2> output.err <<EOF
> +OPTION_SPEC=3D"\
>  some-command [options] <args>...
> =20
>  some-command does foo and bar!
> @@ -36,8 +35,53 @@ C?        option C with an optional argument
> =20
>  Extras
>  extra1    line above used to cause a segfault but no longer does
> +"
> +
> +test_expect_success 'test --parseopt help output' '
> +	git rev-parse --parseopt -- -h 2> output.err <<EOF
> +$OPTION_SPEC
>  EOF
>  	test_cmp expect.err output.err
>  '

You use the same input in this and all new tests; make this:

cat > optionspec <<EOF
=2E..
EOF

test_expect_success 'test --parseopt help output' '
	git rev-parse --parseopt -- -h 2> output.err < optionspec &&
	test_cmp expect.err output.err

(note the added &&).

-- Hannes
