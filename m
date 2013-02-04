From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2] branch: show rebase/bisect info when possible instead of "(no branch)"
Date: Mon, 04 Feb 2013 14:13:07 +0100
Message-ID: <vpqr4kwmdcs.fsf@grenoble-inp.fr>
References: <1359461574-24529-1-git-send-email-pclouds@gmail.com>
	<1359870520-22644-1-git-send-email-pclouds@gmail.com>
	<vpqpq0hnlb1.fsf@grenoble-inp.fr>
	<7v1ucx83fz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Jonathan Niedier <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 04 14:13:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2Lrs-00061X-1I
	for gcvg-git-2@plane.gmane.org; Mon, 04 Feb 2013 14:13:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755045Ab3BDNN3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Feb 2013 08:13:29 -0500
Received: from mx2.imag.fr ([129.88.30.17]:58880 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754853Ab3BDNN2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2013 08:13:28 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r14DD6j2005262
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 4 Feb 2013 14:13:06 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1U2LrA-0003gz-2Y; Mon, 04 Feb 2013 14:13:08 +0100
In-Reply-To: <7v1ucx83fz.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sun, 03 Feb 2013 13:58:40 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 04 Feb 2013 14:13:07 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r14DD6j2005262
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1360588390.3955@IsCKL/tMIDwg+SpBh0Utvg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215381>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes=
:
>>
>>> --- a/t/t6030-bisect-porcelain.sh
>>> +++ b/t/t6030-bisect-porcelain.sh
>>> @@ -164,7 +164,7 @@ test_expect_success 'bisect start: existing ".g=
it/BISECT_START" not modified if
>>>  	cp .git/BISECT_START saved &&
>>>  	test_must_fail git bisect start $HASH4 foo -- &&
>>>  	git branch > branch.output &&
>>> -	test_i18ngrep "* (no branch)" branch.output > /dev/null &&
>>> +	test_i18ngrep "* (bisecting other)" branch.output > /dev/null &&
[...]
> What does "other" refer to when you start your bisection at a
> detached head?

If I read correctly, the branch name is shown only when the bisection
was not started on a detached HEAD:

+		if (!get_sha1_hex(sb.buf, sha1))
+			strbuf_addstr(&result, _("(bisecting)"));
+		else
+			strbuf_addf(&result, _("(bisecting %s)"), sb.buf);

> I personally think "other" has _no_ value in that message, because
> "(no branch, bisecting)" gives the same amount of information,
> especially because "other" does not say which branch it refers to at
> all.

Just to be sure: "other" here is not a hardcoded message "bisecting
other", but an instance of "bisecting <branch-name>" with the branch
being called "other".

I think this is very valuable information, and most likely the
information you'd be looking for when running "git branch". You're
technically on detached HEAD, but morally on some branch, the HEAD bein=
g
detached only because a bisect is in progress.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
