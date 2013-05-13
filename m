From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 7/7] rebase: implement --[no-]autostash and rebase.autostash
Date: Mon, 13 May 2013 10:24:18 +0200
Message-ID: <vpq1u9be18t.fsf@grenoble-inp.fr>
References: <1368359801-28121-1-git-send-email-artagnon@gmail.com>
	<1368359801-28121-8-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 13 10:24:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ubo3X-0006gR-KB
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 10:24:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752618Ab3EMIYX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 04:24:23 -0400
Received: from mx2.imag.fr ([129.88.30.17]:34445 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752462Ab3EMIYX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 04:24:23 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r4D8OHBf001357
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 13 May 2013 10:24:17 +0200
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Ubo3O-000127-He; Mon, 13 May 2013 10:24:18 +0200
In-Reply-To: <1368359801-28121-8-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Sun, 12 May 2013 17:26:41 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 13 May 2013 10:24:17 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r4D8OHBf001357
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1369038257.93166@giS4fA+Ca3NyBYmOwsm0dg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224110>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> +finish_rebase () {
> +	if test -f "$state_dir/autostash"
> +	then
> +		stash_sha1=$(cat "$state_dir/autostash")
> +		if git stash apply $stash_sha1 2>&1 >/dev/null
> +		then
> +			echo "Applied autostash"

Any reason why this is not using gettext and the other messages do.

> +		else
> +			ref_stash=refs/stash &&
> +			: >>"$GIT_DIR/logs/$ref_stash" &&
> +			git update-ref -m "autostash" $ref_stash $stash_sha1 \
> +				|| die "$(eval_gettext 'Cannot store $stash_sha1')"
> +			echo "
> +$(gettext 'Applying autostash resulted in conflicts.
> +Your changes are safe in the stash.
> +You can apply or drop it at any time.')"

Good idea to put the autostash in an actual stash. Perhaps the message
can be made more explicit, e.g. 

  You can run "git stash apply" or "git stash drop" at any time.

(actually, "git stash pop" may be a better suggestion to "git stash
apply" here).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
