From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v5 03/11] ref-filter: add option to pad atoms to the right
Date: Mon, 27 Jul 2015 17:54:10 +0200
Message-ID: <vpqk2tl4mvx.fsf@anie.imag.fr>
References: <CAOLa=ZTtAepdO5U8zo62VBn_z4-LcKoguPxVGaAnNZULEwzrQQ@mail.gmail.com>
	<1437982035-6658-1-git-send-email-Karthik.188@gmail.com>
	<1437982035-6658-3-git-send-email-Karthik.188@gmail.com>
	<vpq3809aho9.fsf@anie.imag.fr>
	<xmqqr3ntioyh.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org,
	christian.couder@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 27 17:54:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJkjX-0001PY-O8
	for gcvg-git-2@plane.gmane.org; Mon, 27 Jul 2015 17:54:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754016AbbG0PyX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jul 2015 11:54:23 -0400
Received: from mx2.imag.fr ([129.88.30.17]:56481 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752831AbbG0PyS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jul 2015 11:54:18 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t6RFs7D1009827
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 27 Jul 2015 17:54:08 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t6RFsApG015645;
	Mon, 27 Jul 2015 17:54:10 +0200
In-Reply-To: <xmqqr3ntioyh.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 27 Jul 2015 08:45:42 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 27 Jul 2015 17:54:08 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t6RFs7D1009827
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1438617252.32298@oWlVihdQcAMEfRwYbc7/hg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274685>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> See my remark on previous patch: this test is not sufficient. You do
>> not only need to check that %(padright) is taken into account, but you
>> also need to check that it is taken into account for the right atom and
>> only this one. I'd suggest
>>
>> --format '%(refname)%(padright:25)|%(refname)|%(refname)|'
>>
>> Only the middle column should be padded.
>
> This actually raises an interesting point.  It is equally valid to
> view that format string as requesting to pad the first "|" with 24
> spaces; in other words, %(padright:N) would apply to the next span,
> be it a literal string up to the next %(atom), or the %(atom) that
> comes immediately after it.

For an arbitrary %(modifier), I'd agree, but in the particular case of
%(padright), I think it only makes sense if applied to something of
variable length.

> The thing is, the above _might_ be an OK way to ask the middle
> refname to be padded, but I somehow find it very unnatural and
> unintuitive to expect that this:
>
> 	--format '%(padright:25)A Very Long Irrelevancy%(refname)'

Yes, but on the other hand we already have:

  git log --format='%<|(50)A very long irrevlevancy|%an|'

that pads/truncate %an. So, consistancy would dictate that Karthik's
version is the right one.

> My preference between the three is "%(padright:4)", etc. to apply to
> the "next span", but I can live with "it is an error to pad-right
> a far-away %(atom)".

I think there are valid argument for the 3 versions. I'm fine with any
of them, as long as there's a test that shows which one is picked.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
