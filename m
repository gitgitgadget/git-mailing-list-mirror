From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/PATCH 07/11] branch: move 'current' check down to the presentation layer
Date: Wed, 29 Jul 2015 12:01:27 +0200
Message-ID: <vpqk2tjmgeg.fsf@anie.imag.fr>
References: <CAOLa=ZT3_DMJWFN62cbF19uxYBFsE69dGaFR=af1HPKsQ42otg@mail.gmail.com>
	<1438066594-5620-1-git-send-email-Karthik.188@gmail.com>
	<1438066594-5620-7-git-send-email-Karthik.188@gmail.com>
	<vpqbnewxwcx.fsf@anie.imag.fr>
	<CAOLa=ZTy+KX4K_inpDoMy+thzFdF2RF93yMEHJUExzT4OvjPww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 29 12:01:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKOBB-0005dX-Ft
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jul 2015 12:01:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751328AbbG2KBi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2015 06:01:38 -0400
Received: from mx1.imag.fr ([129.88.30.5]:49375 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750756AbbG2KBg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2015 06:01:36 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t6TA1Ql3017719
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Wed, 29 Jul 2015 12:01:26 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t6TA1RYJ015039;
	Wed, 29 Jul 2015 12:01:27 +0200
In-Reply-To: <CAOLa=ZTy+KX4K_inpDoMy+thzFdF2RF93yMEHJUExzT4OvjPww@mail.gmail.com>
	(Karthik Nayak's message of "Wed, 29 Jul 2015 01:42:10 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 29 Jul 2015 12:01:26 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t6TA1Ql3017719
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1438768890.45157@UKrs9F+qUhTasPQe2AC4Eg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274886>

Karthik Nayak <karthik.188@gmail.com> writes:

> On Tue, Jul 28, 2015 at 6:39 PM, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
>> Karthik Nayak <karthik.188@gmail.com> writes:
>>
>>> We check if given ref is the current branch in print_ref_list().  Move
>>> this check to print_ref_item() where it is checked right before
>>> printing.
>>
>> This means that the '*' and the different color are coded in C, hence
>> it's not possible to mimick this using "git for-each-ref --format ...".
>>
>> I do not consider this as blocking, but I think the ultimate goal should
>> be to allow this, so that all the goodies of "git branch" can be made
>> available to other ref-listing commands.
>>
>
> Not sure what you mean here.

What you already know, but probably badly explained ;-).

Eventually, the output of "git branch" should correspond to a format
string (so git branch would be almost an alias for "git for-each-ref
refs/heads/ --format '...'"). Internally, this would mean using
show_ref_array_item instead of print_ref_item. This is what you managed
to do for "git tag".

You already identified one difficulty with sha1 alignment in "git branch
-v". I'm pointing out another which is that displaying the "*" in front
of the current branch is currently not possible with a format string.
You would need an atom like %(displayAStarIfTheBranchIsTheCurrentOne)
(for which you'd need to find a short-and-sweet name ;-) ).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
