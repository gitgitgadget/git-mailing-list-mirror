From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCHv2 1/2] wt-status: better advices for git status
Date: Mon, 28 May 2012 09:05:10 +0200
Message-ID: <vpqwr3whjkp.fsf@bauges.imag.fr>
References: <1337852264-32619-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
	<1338035905-24166-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
	<7v1um47vik.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Kong Lucien <Lucien.Kong@ensimag.imag.fr>, git@vger.kernel.org,
	Duperray Valentin <Valentin.Duperray@ensimag.imag.fr>,
	Jonas Franck <Franck.Jonas@ensimag.imag.fr>,
	Nguy Thomas <Thomas.Nguy@ensimag.imag.fr>,
	Nguyen Huynh Khoi Nguyen Lucien 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 28 09:05:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYu15-0002SO-7y
	for gcvg-git-2@plane.gmane.org; Mon, 28 May 2012 09:05:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752893Ab2E1HFR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 May 2012 03:05:17 -0400
Received: from mx2.imag.fr ([129.88.30.17]:54655 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751915Ab2E1HFQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2012 03:05:16 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q4S6utNX006220
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 28 May 2012 08:56:55 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SYu0t-00069J-Ma; Mon, 28 May 2012 09:05:11 +0200
In-Reply-To: <7v1um47vik.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sun, 27 May 2012 21:57:23 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 28 May 2012 08:56:55 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q4S6utNX006220
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1338793016.60031@gA9evm0G44BgeZcjKd1F+Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198632>

Junio C Hamano <gitster@pobox.com> writes:

> These are not independent (you cannot be in bisect and am at the
> same time).

You should not, but it seems you can. At least, I just successfully
started a "git am" during a "git bisect".

Even if some checks may be added to actually prevent the situation, it
seems better to keep "git status" robust to this kind of situation. If
the user did something really wrong, nice advices in "git status" will
be particularly helpful.

>> +	int conflict = 0;
>
> How is this different from "unmerged"?
[...]
>> +	path = mkpath("%s/MERGE_HEAD", git_dir);
>> +	if (!access(path, R_OK))
>> +		unmerged_state = 1;
>
> Ahh, so "unmerged" is "conflicted during merge" (as opposed to
> rebase_state is "conflicted during rebase")?  Doesn't the naming
> sound odd?  If it were "merge_state", it might have made a bit more
> sense (but again, these are not independent conditions, so multiple
> variables do not make sense).

The variable naming is wrong (it could be s/conflicts/unmerged_present/
and s/unmerged_state/merge_in_progress/ for example). But these two
variables are indeed independant. You can have unmerged path without an
actual merge in progress (conflicts during "git am"), an you can have a
merge in progress without conflicts (if you've just "git add"-ed them).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
