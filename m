From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] t5004: test ZIP archives with many entries
Date: Fri, 28 Aug 2015 08:57:38 -0700
Message-ID: <xmqqsi732yod.fsf@gitster.mtv.corp.google.com>
References: <20150811104056.16465.58131@localhost> <55CBA140.7050301@web.de>
	<20150813022545.30116.44787@localhost> <55D8C824.6000704@web.de>
	<CAPig+cSy+c9mOGOTN9e4xfLrvPc8nv7e0T_4PDA-vB-otwrvjw@mail.gmail.com>
	<trinity-6e67d416-0a61-4e73-9779-63519dd83fdb-1440322151491@3capp-webde-bs47>
	<CAPig+cSNSfpt7gOLvz7P4oDrNF5fTQ38v1pfncJU3h7a6FjMyQ@mail.gmail.com>
	<xmqqwpwf2z8c.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
	Johannes Schauer <josch@debian.org>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Aug 28 17:57:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZVM2H-0007pO-Eu
	for gcvg-git-2@plane.gmane.org; Fri, 28 Aug 2015 17:57:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752497AbbH1P5m convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Aug 2015 11:57:42 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:36591 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752458AbbH1P5k (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2015 11:57:40 -0400
Received: by padhm10 with SMTP id hm10so11002041pad.3
        for <git@vger.kernel.org>; Fri, 28 Aug 2015 08:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=CaUD3Q+SD3m794ChQl0VlHU05cbVqwqlUjHt9oVrFeo=;
        b=EaaiIUwZNZv4BrLIM/c1pfAF/izFpZxyx3+58JxqCm9p1bqXO9joy/bmr5OuwLT/Lr
         iJ8dd+iHfAk26Dok7kx1udQo5DBV8sQRW0Twtr2JmfL9RgODHJmE3azPcRRko0HJFIe9
         3+M41U88C1x6lPwTxu1Rx6lKRB8npZBLSBxU71HdQySKghNtXTzmt87oTmwlzeuezOI+
         U932rvVNH4b7scOxkH6RKcrBexL3gkhvo1PZhwkhYQKVE0Ro/qb+aWpc8o+0DY9yl7nV
         UEA3FwdMhxsmXsXwlJLfFwmPLOEttAo/bvqyltejZ4xbHufiETDNdZ/is5PRnMu49Rwr
         6XHw==
X-Received: by 10.68.178.36 with SMTP id cv4mr16319879pbc.161.1440777460110;
        Fri, 28 Aug 2015 08:57:40 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:c919:3f20:8560:5a06])
        by smtp.gmail.com with ESMTPSA id im2sm6157503pbc.34.2015.08.28.08.57.39
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Fri, 28 Aug 2015 08:57:39 -0700 (PDT)
In-Reply-To: <xmqqwpwf2z8c.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Fri, 28 Aug 2015 08:45:39 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276725>

Junio C Hamano <gitster@pobox.com> writes:

> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>> On Sun, Aug 23, 2015 at 5:29 AM, "Ren=C3=A9 Scharfe" <l.s.r@web.de> =
wrote:
>>> I suspected that zipinfo's output might be formatted differently on
>>> different platforms and tried to guard against it by checking for t=
he
>>> number zero there. Git's ZIP file creation is platform independent
>>> (modulo bugs), so having a test run at least somewhere should
>>> suffice. In theory.
>>>
>>> We could add support for the one-line-summary variant on OS X easil=
y,
>>> though.
>>
>> Probably, although it's looking like testing on Mac OS X won't be
>> fruitful (see below).
>
> Can we move this topic forward by introducing a new prerequisite
> ZIPINFO and used at the beginning of these tests (make it a lazy
> prereq)?  Run zipinfo on a trivial archive and see if its output is
> something we recognize to decide if the platform supports that
> ZIPINFO prerequisite and do this test only on them.

Heh, that is exactly what the patch under discussion does.  So...

> After all, what _is_ being tested, i.e. our archive creation, would
> not change across platforms, so having a test that runs on a known
> subset of platforms is better than not having anything at all.
>
> Thanks.

=2E..I'd say we can take this patch as-is, and those who want to have
a working test on MacOS can come up with an enhancement to the way
the script parses output from zipinfo that would also work on their
platforms.

Thanks and sorry for the noise ;-)
