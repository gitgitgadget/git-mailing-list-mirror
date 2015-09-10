From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v17 05/14] ref-filter: introduce match_atom_name()
Date: Thu, 10 Sep 2015 20:58:21 +0200
Message-ID: <vpq1te6aype.fsf@scolette.imag.fr>
References: <1441900110-4015-1-git-send-email-Karthik.188@gmail.com>
	<1441900110-4015-6-git-send-email-Karthik.188@gmail.com>
	<vpqbndap6d1.fsf@scolette.imag.fr>
	<xmqqpp1q428y.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org,
	christian.couder@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 10 20:58:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Za73W-0005FJ-Pa
	for gcvg-git-2@plane.gmane.org; Thu, 10 Sep 2015 20:58:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751598AbbIJS6b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Sep 2015 14:58:31 -0400
Received: from mx2.imag.fr ([129.88.30.17]:36900 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751447AbbIJS63 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Sep 2015 14:58:29 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t8AIwJOn001093
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 10 Sep 2015 20:58:19 +0200
Received: from scolette (scolette.imag.fr [129.88.43.86])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t8AIwLKm026270;
	Thu, 10 Sep 2015 20:58:21 +0200
In-Reply-To: <xmqqpp1q428y.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Thu, 10 Sep 2015 10:23:41 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 10 Sep 2015 20:58:19 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t8AIwJOn001093
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1442516302.92493@EXTBhBg5SCeXK0SQHJO6+w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277627>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> OTOH, you are now accepting %(atom:) as a synonym to %(atom), and it's
>> not clear whether this is a deliberate decition.
>
> I would say so.  When the caller wants to reject %(atom:), the
> caller can tell it by checking val[0] == '\0' and reject that.
>
> So it is better if you did not do this:
>
>> 	if (!body[1]) {
>> 		/* "atom_name:" */
>> 		*val = NULL;
>> 		return 1;
>> 	}
>
> which robs that information from the caller.

OK. Just dropping this part lets the code fall back to

	/* "atom_name:... */
	*val = body + 1;
	return 1;

right below in my version. It also accepts it (return 1) but lets val
point to an empty string. Makes sense.

And indeed, without this, my code looks a lot like Karthik's one, just
dropping the "|| !body[1]" part in a condition.

In any case, I'd like to see "atom_name:" explicitly mentionned
somewhere in a comment, if only to make it clear that what is done with
it is deliberate (e.g. avoid having someone not following this
conversation later considering this %(atom:) thing to be a bug and try
to fix it).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
