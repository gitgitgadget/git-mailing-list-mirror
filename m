From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2] git-remote-mediawiki: bugfix for pages w/ >500 revisions
Date: Tue, 24 Sep 2013 10:19:02 +0200
Message-ID: <vpqk3i67hu1.fsf@anie.imag.fr>
References: <1379957175-8606-1-git-send-email-benoit.person@gmail.fr>
	<CAPig+cSVeJX2wHo7TTJe2oa+_pD7EPdmMo_BGO_Bj-ZKgRD6wA@mail.gmail.com>
	<CAETqRCjo3_nr0+Jh_0XTPZysfzhtGaeFMGswog--Era31jQo1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>
To: Benoit Person <benoit.person@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 24 10:19:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VONqJ-0007DS-BW
	for gcvg-git-2@plane.gmane.org; Tue, 24 Sep 2013 10:19:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750790Ab3IXITb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Sep 2013 04:19:31 -0400
Received: from mx2.imag.fr ([129.88.30.17]:57894 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750737Ab3IXIT3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Sep 2013 04:19:29 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r8O8J2Fp011087
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 24 Sep 2013 10:19:02 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1VONpn-00065C-7u; Tue, 24 Sep 2013 10:19:03 +0200
In-Reply-To: <CAETqRCjo3_nr0+Jh_0XTPZysfzhtGaeFMGswog--Era31jQo1Q@mail.gmail.com>
	(Benoit Person's message of "Tue, 24 Sep 2013 10:05:34 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 24 Sep 2013 10:19:02 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r8O8J2Fp011087
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1380615545.53375@5hqzesni4VsAiFBAJ7K2mg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235285>

Benoit Person <benoit.person@gmail.com> writes:

>> d17cf5f3a32f07bf (tests: Introduce test_seq;  2012-08-03)
>>
>>> +       do
>>> +               echo "creating revision $i"
>>
>> Do you want to end this line with '&&'?
> The way it's intended is that it's more a debug information to see how
> it's going on (creating >500 revs is *quite* long). If I understand it
> correctly, using '&&' would mean that the return value of the echo
> statement will be tested for success ? Anyway, I am not sure it makes
> sense to fail on a "debug echo" ?

I don't think you should bother with such reasoning: just put the &&
everywhere.

Without the &&, it's OK in the current version, but what if someone adds
something before the echo? Then it becomes

git something-important &&
echo debug
git something-else-important

and a failure on the first call is unnoticed because of the missing &&
afterwards.

The echo is not supposed to fail, so either the && does not change
anything, or something went terribly wrong and you'd rather notice it.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
