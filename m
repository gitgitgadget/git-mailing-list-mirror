From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 5/5] t/t5520: test --[no-]autostash with pull.rebase=true
Date: Mon, 04 Apr 2016 20:25:32 +0200
Message-ID: <vpqmvp9i63n.fsf@anie.imag.fr>
References: <1459258200-32444-1-git-send-email-mehul.jain2029@gmail.com>
	<1459258200-32444-6-git-send-email-mehul.jain2029@gmail.com>
	<CAPig+cQ93+dCqJMRcQYSRHLDuYtwkeK_aSrfv2=2=g7ZhO85TQ@mail.gmail.com>
	<CA+DCAeQPr2vxvm6MKiOLpDtmpC2d=RcvYhuFeimSn+xX2TAvtQ@mail.gmail.com>
	<CAPig+cQyHu1J=FYOtgsmi3ghuN7YyjNgAz-VgO06isfrS+kUSg@mail.gmail.com>
	<CA+DCAeT1DQvHnRpJeApcm2vO6KhXaMaRXZg9HCUmiiBv=hfxzw@mail.gmail.com>
	<CAPig+cSR9Um5FUWzkzHGAM5RanaKssAysA5hGOP4+E5oA0Y5oA@mail.gmail.com>
	<CA+DCAeRqY7-qZt-upa5=nY8OkUL4Q76ogk5nrF_WAaiFiWOy1A@mail.gmail.com>
	<vpq4mbhmi3g.fsf@anie.imag.fr>
	<CA+DCAeTm7wjgdjLwR__pcyev-EsqecdAT8xdGEFfuekg4ToKSA@mail.gmail.com>
	<CAPig+cTSHQcMh=gTLgE3kCgLqBr55ar9wn3gwXLbvRiOyqch1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Mehul Jain <mehul.jain2029@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Apr 04 20:25:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1an9C3-00044O-Ne
	for gcvg-git-2@plane.gmane.org; Mon, 04 Apr 2016 20:25:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754983AbcDDSZk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2016 14:25:40 -0400
Received: from mx2.imag.fr ([129.88.30.17]:35109 "EHLO mx2.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752972AbcDDSZj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2016 14:25:39 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx2.imag.fr (8.13.8/8.13.8) with ESMTP id u34IPTZE013946
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 4 Apr 2016 20:25:29 +0200
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u34IPW6w000736;
	Mon, 4 Apr 2016 20:25:32 +0200
In-Reply-To: <CAPig+cTSHQcMh=gTLgE3kCgLqBr55ar9wn3gwXLbvRiOyqch1A@mail.gmail.com>
	(Eric Sunshine's message of "Mon, 4 Apr 2016 13:48:10 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (mx2.imag.fr [129.88.30.17]); Mon, 04 Apr 2016 20:25:30 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u34IPTZE013946
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1460399130.4505@Deyb/I3uYBdOL2k1Coofww
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290716>

Eric Sunshine <sunshine@sunshineco.com> writes:

> Although I'm the one who brought up the idea of "automating" these
> tests, I'm not convinced that it's an improvement in this case, but I
> don't feel so strongly that I'd forbid it.

Another option is to define helper functions to shorten the "manual"
tests, e.g. define:

setup_rebase_test () {
	git reset --hard before-rebase &&
	echo dirty >new_file &&
	git add new_file
}

rebase_test_ok () {
        git pull $1 . copy &&
        test_cmp_rev HEAD^ copy &&
        test "$(cat new_file)" = dirty &&
        test "$(cat file)" = "modified again"
}

rebase_test_err () {
        test_must_fail git pull $1 . copy 2>err &&
        test_i18ngrep "uncommitted changes." err
}

I'm also OK with keeping the "manual" tests.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
