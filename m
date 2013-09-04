From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Bug in git rebase --continue in v1.8.4
Date: Wed, 04 Sep 2013 10:18:35 +0200
Message-ID: <vpqsixl9ezo.fsf@anie.imag.fr>
References: <5221E661.1070200@gmx.de> <5226E8FC.8070208@FreeBSD.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Andriy Gapon <avg@FreeBSD.org>
X-From: git-owner@vger.kernel.org Wed Sep 04 10:18:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VH8Ii-0005P2-Hj
	for gcvg-git-2@plane.gmane.org; Wed, 04 Sep 2013 10:18:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756275Ab3IDISr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Sep 2013 04:18:47 -0400
Received: from mx2.imag.fr ([129.88.30.17]:56246 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754478Ab3IDISp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Sep 2013 04:18:45 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r848IY6Y019301
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 4 Sep 2013 10:18:34 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1VH8IN-0003JH-ML; Wed, 04 Sep 2013 10:18:35 +0200
In-Reply-To: <5226E8FC.8070208@FreeBSD.org> (Andriy Gapon's message of "Wed,
	04 Sep 2013 11:02:04 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 04 Sep 2013 10:18:34 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r848IY6Y019301
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1378887518.25178@Y0x8UzIR8bExYdsUrA1vtQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233820>

[ Cc-ing Ram, as he is the author of the possibly guilty commit. ]

Andriy Gapon <avg@FreeBSD.org> writes:

> Christoph Mallon said:
>> if I run rebase --continue (e.g. after a conflict resolution), then the rebase always ends with this error message:
>> 	It seems that there is already a rebase-apply directory, and
>> 	I wonder if you are in the middle of another rebase.  If that is the
>> 	case, please try
>>         	git rebase (--continue | --abort | --skip)
>> 	If that is not the case, please
>>         	rm -fr "/home/tron/gitRebaseTest/test/.git/rebase-apply"
>> 	and run me again.  I am stopping in case you still have something
>> 	valuable there.
>> 
>> This happens on git v1.8.4 on FreeBSD. It is fine with v1.8.3.4.
>
> I observe exactly the same problem.
> I also use FreeBSD and the problem started with 1.8.4.
>
> Judging by the lack of followups, could this be a FreeBSD-specific problem?

I can't reproduce here (Debian GNU/Linux). Do the testsuite pass for
you?

If not, can you write a failing test? A minimalist script outside the
testsuite may help too if you're not familiar with Git's testsuite.

> Any thoughts / suggestions?
> Thank you!
>
>> It seems to be caused by
>> a1549e1049439386b9fd643fae236ad3ba649650, specifically this hunk:
>> 	--- a/git-rebase--am.sh
>> 	+++ b/git-rebase--am.sh
>> 	 <at>  <at>  -7,12 +7,12  <at>  <at>  case "$action" in
>> 	 continue)
>> 	  git am --resolved --resolvemsg="$resolvemsg" &&
>> 	  move_to_original_branch
>> 	- exit
>> 	+ return
>> 	  ;;
>> 	 skip)
>> 	  git am --skip --resolvemsg="$resolvemsg" &&

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
