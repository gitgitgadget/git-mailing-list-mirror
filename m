From: Stephan Beyer <s-beyer@gmx.net>
Subject: t5561 failing after make PROFILE=GEN
Date: Wed, 23 Sep 2015 01:21:39 +0200
Message-ID: <5601E283.2030507@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 23 01:23:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZeWuI-00071H-2Q
	for gcvg-git-2@plane.gmane.org; Wed, 23 Sep 2015 01:23:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759696AbbIVXXX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Sep 2015 19:23:23 -0400
Received: from mout.gmx.net ([212.227.17.21]:58701 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759619AbbIVXXV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Sep 2015 19:23:21 -0400
Received: from [192.168.178.43] ([88.71.191.237]) by mail.gmx.com (mrgmx101)
 with ESMTPSA (Nemesis) id 0Lat5o-1aOYxE0GpE-00kNBY for <git@vger.kernel.org>;
 Wed, 23 Sep 2015 01:23:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.7.0
X-Provags-ID: V03:K0:RuTR8dPggpN/TiO0AXPVQ16wgUBr8UEEsqMv9lZFPlJjsdWZ6cG
 pKaevFqyLCpYez2mkgwgLlLksWpiLUMQDTX4k5pv8SrjwXDdPGppgRNCMHT0A86/mXVwbdh
 x6ZzCwttZCOMsVtRlbTcrRGSS6t2sYprIdRyBZGd3ve9+mArbCkxIaAkJHR27BCESSp5qKe
 CLc6A8hLMy7l/4Q3NqCVg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:hcu2T8cF1Ug=:0OyNb38nfUnOIgZ2T3AUIq
 ExpppBdssNq6Vab/xyQpuvdRqKjgY9EuX6TL9Ep7ec4QhZdwiyGOUhQr0uW2Ph2My+97AMwxg
 pd5B8XT7DSHvQ890FmLayaG3pfKogykq7TnP/z0Lr7NcCNbdRdbfMXK+HbeeipEk2dFk2cYGL
 REJhBkhqlLXNhgE7K8OUW81xvaJFHKLZvmT5C4jVqhEzXskQ3xC1+VmjHI/4dmJalN1cyhvIN
 0FskqhKcZT+zeRXK8Q0gt5tBFe/zxE85QDKNw2T3syx7NfmZ8PZLBIUpe5IcZilJNjuF7gVtC
 uAJn+fWuywMNL0Pg7L+50ZJx4AWF7Jspr2QydeF6xyYqJHKwA7HZJTaSqta6wO9UfH1dbGJ2C
 Xk6WFV3LfS0ccyYm8vpGonw416lEQM30th25S1uY4Otb21KQarfaOMeVEqWEMXJl8GmCluIXt
 8NcwxOzDdD/wXivWmcdQTORSIDll2PHyeTpySRdWLGRkWLbIf1Cs4WY6lIKiH4erPFlLtWKNo
 0eMxJIjYF6JZ4T0gz7OsphNGzrsA3T2mcXYRQjwNe4lZkUF/Xx4fefNiR8pV5kkfp08WtmdNo
 am90dYCcLsWwGjvJEOCnW2meEL3C2xg7oAYJvCCvlatd7MTMhzYHHULUCng2b1ZVRFK/ibmPm
 4gdpeod3Pceb3XUQ0Tx9cag4n9qp4fk+BQdeilE1ON3CIsFOFn8dvP5i5RchAxNcUJb7o0lqr
 25BKjdzpFEbxG0NAlMo7D1Q2dTKxBbv75Hmqww==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278447>

Hi,

I noticed that t5561 fails on my machine when compiling with
"make PROFILE=GEN". Luckily, the reason seems to be the test only,
not the tool it is testing.

I tracked it down that far that log_div() (defined in
t/t5561-http-backend.sh but used in t/t556x_common) appends
the given text to the access.log *before* the last GET log entry
is written.

The test code does it right (as far as I managed to look over it),
so this is maybe some odd flushing behavior of the web server?
On the other hand, the problem only occurs with PROFILE=GEN
but the web server should be independent of the Git compile-time
configuration, right? Looks weird to me but I did not dig deep.

Replacing the log_div() implementation by "return 0" and removing
the implied output solves the problem without breaking any test
functionality. (For more clarity, the log_div() calls and definitions
should be removed.) I refrained from sending this trivial patch
because I am not sure if this is the right way to cope with the issue.

Best
  Stephan
