From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v4 3/8] branch: roll show_detached HEAD into regular ref_list
Date: Thu, 17 Sep 2015 19:08:38 +0200
Message-ID: <vpqmvwlm0rt.fsf@anie.imag.fr>
References: <1442129035-31386-1-git-send-email-Karthik.188@gmail.com>
	<1442129035-31386-4-git-send-email-Karthik.188@gmail.com>
	<xmqqzj0ovlno.fsf@gitster.mtv.corp.google.com>
	<CAOLa=ZQ51+TKvOiJvWa-emmJJGirAqkr9m0a_7BrQ2UbiSJdjA@mail.gmail.com>
	<CAOLa=ZQxounTiJk0t+zB2-7=UQa8oL+uJ9EQpTkWL7kYFHjxwQ@mail.gmail.com>
	<vpqpp1hqgcd.fsf@anie.imag.fr>
	<xmqqh9mtkrg0.fsf@gitster.mtv.corp.google.com>
	<vpqio79oxva.fsf@anie.imag.fr>
	<xmqqeghxj8i1.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Karthik Nayak <karthik.188@gmail.com>, Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 17 19:08:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zccg0-0001ii-Pr
	for gcvg-git-2@plane.gmane.org; Thu, 17 Sep 2015 19:08:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751908AbbIQRIt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2015 13:08:49 -0400
Received: from mx2.imag.fr ([129.88.30.17]:42988 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751418AbbIQRIs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2015 13:08:48 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t8HH8aHb023925
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 17 Sep 2015 19:08:36 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t8HH8cKV029125;
	Thu, 17 Sep 2015 19:08:38 +0200
In-Reply-To: <xmqqeghxj8i1.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Thu, 17 Sep 2015 09:49:58 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 17 Sep 2015 19:08:36 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t8HH8aHb023925
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1443114516.85145@b5DhSBCBZFlpw+fLzF1Byw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278144>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> But that's still workable: struct ref_sorting could contain a flag
>> "head_first" that would be set by ref_default_sorting() and only it, and
>> then read by cmp_ref_sorting.
>
> Hmm, I am still puzzled.  "refname" atom would expand to things like
> "HEAD", "refs/heads/master", etc., so I still do not see a need for
> head_first option at all.  "HEAD" will sort before "refs/anything"
> always, no?

Ah, you mean, the alphabetic order on refname already sorts HEAD first
because other refs will start with "refs/"? So, there's no need for any
special case at all indeed. Nothing to teach compare_refs, it's already
doing it.

However, just relying on this seems a bit fragile to me: if we ever
allow listing e.g. FETCH_HEAD as a reference, then we would get

  FETCH_HEAD
* (HEAD detached at ...)
  master

which seems weird to me. But we can decide "if sorting on refname, then
HEAD always comes first anyway".

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
