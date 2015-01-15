From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: t5539 broken under Mac OS X
Date: Wed, 14 Jan 2015 21:48:28 -0800
Message-ID: <064010B3-BC58-42F2-B5C0-DAADAA59B87D@gmail.com>
References: <54B68D99.2040906@web.de> <xmqqmw5l9pje.fsf@gitster.dls.corp.google.com> <54B6C897.5030405@web.de> <20150114211712.GE1155@peff.net>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 15 06:48:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBdIL-0008QM-C2
	for gcvg-git-2@plane.gmane.org; Thu, 15 Jan 2015 06:48:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751183AbbAOFsd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Jan 2015 00:48:33 -0500
Received: from mail-pa0-f54.google.com ([209.85.220.54]:32817 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751091AbbAOFsc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Jan 2015 00:48:32 -0500
Received: by mail-pa0-f54.google.com with SMTP id fb1so15326652pad.13
        for <git@vger.kernel.org>; Wed, 14 Jan 2015 21:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc;
        bh=3aoYprUUEqkqoKj7ccltkcN8WACHLq0PO/ctKxT020c=;
        b=q6WAaSZt+7ZpyI9U+8S/fa+ruUVkvCLIS3mC+sq++rw5/ZLoalSa4f2an/zJzPbYf/
         q7GhovXp7EwqU/AmQARwiNtmaOwf4TU3/0IY5uITp3l6daC0UBVda1AXeS1cTZU6pfY6
         Esb/Sn2C7wjfyNk9u7IJYHgxEu/IRt4OHosiA2W9UeBDzZ3tn4i/O7JoGuJaXEnR9KdV
         IYSSI1bApUqVE9/EwUjLPWj0BUycxCs7lc7ULn0TMYSg/0b7CDiQCGzzi/1voZPToEcY
         iRhbj1hFXGVufpV10HpvwaDMYP2SSKw6gAwUeDBqhn3dVj5A0HXComT03x99mKQyLB2z
         U1+Q==
X-Received: by 10.66.55.74 with SMTP id q10mr11602550pap.94.1421300912343;
        Wed, 14 Jan 2015 21:48:32 -0800 (PST)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id gw8sm457974pbc.48.2015.01.14.21.48.30
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 14 Jan 2015 21:48:31 -0800 (PST)
In-Reply-To: <20150114211712.GE1155@peff.net>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262456>


On Jan 14, 2015, at 13:17, Jeff King wrote:
> On Wed, Jan 14, 2015 at 08:50:47PM +0100, Torsten B=F6gershausen wrot=
e:
>
>> But, why does e.g. t0004 behave more gracefully (and skips) and =20
>> t5539 just dies ?
>>
>> ./t0004-unwritable.sh
>> ok 1 - setup
>> ok 2 # skip write-tree should notice unwritable repository (missing =
=20
>> SANITY of POSIXPERM,SANITY)
>
> The http code uses test_skip_or_die when it runs into setup errors. =20
> The
> intent there is that the user has either:
>
>  1. Told us explicitly that they want http tests by setting
>     GIT_TEST_HTTPD=3Dtrue.
>
>  2. Wants to run http tests if they can by setting GIT_TEST_HTTPD=3Da=
uto
>     (or leaving it unset, as that is the default).
>
> In case (1), we treat this as a test failure. They asked for httpd
> tests, and we could not run them. In case (2), we would just skip =20
> all of
> the tests.
>
> You may want to loosen your GIT_TEST_HTTPD setting (pre-83d842dc, you
> had to set it to true to run the tests at all, but nowadays we have
> auto).

I ran into this problem.  It seems like (at least on older Mac OS X) =20
that the root directory is created like so:

   drwxrwxr-t  39 root  admin  /

And since the first (and likely only user) on Mac OS X is a member of =20
the admin group, the SANITY test fails and complains even though =20
you're not running as root (the failure message is misleading).

I ended up removing group write permission from / (which happened to =20
find a bug in another script of mine) and then it was happy.

-Kyle