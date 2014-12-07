From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] git-svn: Support for git-svn propset
Date: Sun, 7 Dec 2014 04:23:20 -0500
Message-ID: <CAPig+cTH5XXxMkaB9HOSm6ppFuZj4fVnCRmbSva2i_h5d4QVOA@mail.gmail.com>
References: <20141206222942.GB91825@elvis.mu.org>
	<5483E968.6060708@web.de>
	<5484090C.8070101@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alfred Perlstein <alfred@freebsd.org>,
	Git List <git@vger.kernel.org>,
	Eric Wong <normalperson@yhbt.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"Michael G. Schwern" <schwern@pobox.com>,
	David Fraser <davidf@sjsoft.com>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun Dec 07 10:23:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XxY3q-0007Ut-4t
	for gcvg-git-2@plane.gmane.org; Sun, 07 Dec 2014 10:23:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752801AbaLGJXW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Dec 2014 04:23:22 -0500
Received: from mail-yk0-f176.google.com ([209.85.160.176]:42999 "EHLO
	mail-yk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752659AbaLGJXV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Dec 2014 04:23:21 -0500
Received: by mail-yk0-f176.google.com with SMTP id q200so1487013ykb.21
        for <git@vger.kernel.org>; Sun, 07 Dec 2014 01:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=9OTODYqyDEV9kMwJoyrFjivF1B0s55I0weGONr6JzL4=;
        b=jtAtdvURzMI8F3NPKIP0qQFUuQ3FM1MDSTCL1jXmLSeXLINQTPqd2Ld/cqX6OvOfqk
         17MTTbkStjaroadqb0JP+2jP2CPdVwE08bBNfVG4pD1izoAbaaTb5xj8sEKwGv9YG5mS
         xaahwOSefbG5iRtLQSmsBGbKfKE/S7Vw4xKNfBOdKK+NLgeDzGH+pVjkAyuFfonWLUbP
         Ara+/InkTq4YwJVY0pO6c7l797WfTnlN2FZ2P2ErsSYGcbzlCkDKp3jEDuLtI8vNrMzj
         A2e9w8No8f4CDTQmmaZpORZRrXbUjyWNYfbjnKFk9rg07SpB85kYWIbf2MOibZ3tpnEH
         YqVA==
X-Received: by 10.236.8.100 with SMTP id 64mr25853060yhq.112.1417944200166;
 Sun, 07 Dec 2014 01:23:20 -0800 (PST)
Received: by 10.170.68.68 with HTTP; Sun, 7 Dec 2014 01:23:20 -0800 (PST)
In-Reply-To: <5484090C.8070101@web.de>
X-Google-Sender-Auth: whAr6JbTZqapw23umgWWOJNTFxA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260978>

On Sun, Dec 7, 2014 at 3:00 AM, Torsten B=C3=B6gershausen <tboegi@web.d=
e> wrote:
> On 2014-12-07 06.45, Torsten B=C3=B6gershausen wrote:
> []
>>> +
>>> +test_expect_success 'add multiple props' '
>>> +    git svn propset svn:keywords "FreeBSD=3D%H" foo &&
>>> +    git svn propset fbsd:nokeywords yes foo &&
>>> +    echo hello >> foo &&
>>> +    git commit -m "testing propset" foo &&
>>> +    git svn dcommit
>>> +    svn_cmd co "$svnrepo" svn_project &&
>>> +    (cd svn_project && test "`svn propget svn:keywords foo`" =3D "=
=46reeBSD=3D%H") &&
>>> +    (cd svn_project && test "`svn propget fbsd:nokeywords foo`" =3D=
 "yes") &&
>>> +    (cd svn_project && test "`svn proplist -q foo | wc -l`" -eq 2)=
 &&
>>> +    rm -rf svn_project
>>> +    '
>>> +
>> Ah, another small thing:
>> the "wc -l" will not work under Mac OS X.
>> Please see test_line_count() in t/test-lib-functions.sh
>>
> My excuse:
> I think I am wrong here and I need to correct myself after having loo=
ked at other TC's.
> The "wc -l" should work under Mac OS X.

More specifically: On Mac OS X, "wc -l" outputs "{whitespace}number"
which won't match "2" with the string '=3D' operator, however, this cas=
e
works because the '-eq' operator coerces the output of "wc -l" to a
number, which can match the 2.
