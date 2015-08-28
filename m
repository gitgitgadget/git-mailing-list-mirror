From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] t5004: test ZIP archives with many entries
Date: Fri, 28 Aug 2015 08:45:39 -0700
Message-ID: <xmqqwpwf2z8c.fsf@gitster.mtv.corp.google.com>
References: <20150811104056.16465.58131@localhost> <55CBA140.7050301@web.de>
	<20150813022545.30116.44787@localhost> <55D8C824.6000704@web.de>
	<CAPig+cSy+c9mOGOTN9e4xfLrvPc8nv7e0T_4PDA-vB-otwrvjw@mail.gmail.com>
	<trinity-6e67d416-0a61-4e73-9779-63519dd83fdb-1440322151491@3capp-webde-bs47>
	<CAPig+cSNSfpt7gOLvz7P4oDrNF5fTQ38v1pfncJU3h7a6FjMyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
	Johannes Schauer <josch@debian.org>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Aug 28 17:45:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZVLqd-00039e-2y
	for gcvg-git-2@plane.gmane.org; Fri, 28 Aug 2015 17:45:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752208AbbH1Ppm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Aug 2015 11:45:42 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:36608 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752072AbbH1Ppl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2015 11:45:41 -0400
Received: by padhm10 with SMTP id hm10so10713017pad.3
        for <git@vger.kernel.org>; Fri, 28 Aug 2015 08:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=Eir6+FgPKgiYXBR5jjsttG8wlxtFmUuiYXSVJOMnwpQ=;
        b=Axnprxg2QSWRPwJPDdtQDqTp9CTtW1kjHCX3zF5WxM2todAT/NWFGHQEE8DSdeY3v+
         zpEnKV+z/34egWMR11KAneoKhsFlFlqkZ7ZKf+YqCDEfpCRq7kaL7qZPbEhYiLWTmuVK
         4rAOhG/zNpSQo1o4TXUGRtO+egX9HxfJeYexfObIFMTzyps3TRUAuWynNFvTUyQVRohE
         wU/bo4umXF3JaTBrxqng63pHQyCCbx1NPGE16rnl6gdEDIZSrPMTQ8CJd3GUTY7Mo1Ox
         WbNwZ4cqODWRYV6eAQCzXWqhBTSjrZ/HaYOVKquqOy3qF++cmDG0kiNmBzhpcj5Ofu0w
         v2sw==
X-Received: by 10.68.221.198 with SMTP id qg6mr15684294pbc.147.1440776741101;
        Fri, 28 Aug 2015 08:45:41 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:c919:3f20:8560:5a06])
        by smtp.gmail.com with ESMTPSA id qr5sm6136569pbb.26.2015.08.28.08.45.40
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Fri, 28 Aug 2015 08:45:40 -0700 (PDT)
In-Reply-To: <CAPig+cSNSfpt7gOLvz7P4oDrNF5fTQ38v1pfncJU3h7a6FjMyQ@mail.gmail.com>
	(Eric Sunshine's message of "Sun, 23 Aug 2015 13:45:26 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276724>

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Sun, Aug 23, 2015 at 5:29 AM, "Ren=C3=A9 Scharfe" <l.s.r@web.de> w=
rote:
>> I suspected that zipinfo's output might be formatted differently on
>> different platforms and tried to guard against it by checking for th=
e
>> number zero there. Git's ZIP file creation is platform independent
>> (modulo bugs), so having a test run at least somewhere should
>> suffice. In theory.
>>
>> We could add support for the one-line-summary variant on OS X easily=
,
>> though.
>
> Probably, although it's looking like testing on Mac OS X won't be
> fruitful (see below).

Can we move this topic forward by introducing a new prerequisite
ZIPINFO and used at the beginning of these tests (make it a lazy
prereq)?  Run zipinfo on a trivial archive and see if its output is
something we recognize to decide if the platform supports that
ZIPINFO prerequisite and do this test only on them.

After all, what _is_ being tested, i.e. our archive creation, would
not change across platforms, so having a test that runs on a known
subset of platforms is better than not having anything at all.

Thanks.
