Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A1D41F597
	for <e@80x24.org>; Thu, 19 Jul 2018 21:11:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730349AbeGSV4K (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jul 2018 17:56:10 -0400
Received: from st42p59im-ztdg12250501.me.com ([17.36.65.27]:25413 "EHLO
        st42p59im-ztdg12250501.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727743AbeGSV4K (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 19 Jul 2018 17:56:10 -0400
Received: from process-dkim-sign-daemon.st42p59im-ztdg12250501.me.com by
 st42p59im-ztdg12250501.me.com
 (Oracle Communications Messaging Server 8.0.1.2.20170607 64bit (built Jun  7
 2017)) id <0PC400B00T91EW00@st42p59im-ztdg12250501.me.com> for
 git@vger.kernel.org; Thu, 19 Jul 2018 21:11:16 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=04042017;
        t=1532034676; bh=uj/da7FhEvrkMmZU0JG0n9TKwoQVmpMphEZXeUnAbJk=;
        h=Content-type:MIME-version:Subject:From:Date:Message-id:To;
        b=TxqL5uzsuTot09h841IzBkazU59WiYBiwYuByUPJCawcvucmfM7DvcMcKa1PmQm8k
 uFMR4dNWuQjii9bdgHHp7jDJPODgw/PL39hcci2q9vXKi6ML4tBcliyLo90pACQe4l
 8SEuMSFY/RN9701bODz+Hzcuvl9c+JBIWGgyu/mdOK39lqlohuXBQdKORZ9Oxdf6nL
 odyTVjiEfxrdfdjpIc6AvDYjXcbjI/kBM7RSeXLI+j70P0Rksy3y48IACsMYrmyQSV
 Q4r/jk+zkUw0pfVE/QOIRgBRaYLhNqi9kt5qQGneh3PCHyi5WvgAppLici9bkckWdd
 TDKv2y37dsdFQ==
Received: from icloud.com ([127.0.0.1]) by st42p59im-ztdg12250501.me.com
 (Oracle Communications Messaging Server 8.0.1.2.20170607 64bit (built Jun  7
 2017)) with ESMTPSA id <0PC400A1TTIP9I20@st42p59im-ztdg12250501.me.com>; Thu,
 19 Jul 2018 21:11:16 +0000 (GMT)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,,
 definitions=2018-07-19_08:,, signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 clxscore=1011 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1707230000 definitions=main-1807190221
Content-type: text/plain; charset=utf-8
MIME-version: 1.0 (Mac OS X Mail 12.0 \(3445.100.17\))
Subject: Re: Gitk doesn't work on macOS Mojave
From:   Evgeny Cherpak <cherpake@me.com>
In-reply-to: <CAPig+cT+Z-hN6WidMOUW2jRVNFovvv03LEFESXpr05NKmpnWAA@mail.gmail.com>
Date:   Fri, 20 Jul 2018 00:11:13 +0300
Cc:     Git List <git@vger.kernel.org>
Content-transfer-encoding: quoted-printable
Message-id: <1569C0A9-7C44-4F28-9C9B-AF2489E021AB@me.com>
References: <D295145E-7596-4409-9681-D8ADBB9EBB0C@me.com>
 <CAPig+cT+Z-hN6WidMOUW2jRVNFovvv03LEFESXpr05NKmpnWAA@mail.gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
X-Mailer: Apple Mail (2.3445.100.17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It seems this code placed at the end of the file, after getcommits() =
does the trick:

if {[tk windowingsystem] eq "aqua"} {=20
	set openscript [format {=20
		open -a \"$(ps -p %d -o comm=3D)\"
	} [pid] ]
    exec osascript -e [format {
		do shell script "%s"
    } "$openscript=E2=80=9D ]
}


> On 19 Jul 2018, at 22:12, Eric Sunshine <sunshine@sunshineco.com> =
wrote:
>=20
> On Thu, Jul 19, 2018 at 2:48 PM Evgeny Cherpak <cherpake@me.com> =
wrote:
>> You have probably heard this by now already, but gitk doesn=E2=80=99t =
work on macOS 10.14 - because it uses Apple Events,
>> And apps on 10.14 require user to give them permissions to control =
other apps with Apple Events.
>=20
> This hasn't been reported, so thanks for bringing it up.
>=20
>> Here is what I get when I try running it on my machine with beta 4 =
installed:
>>=20
>> Error in startup script: 58:102: execution error: Not authorized to =
send Apple events to System Events. (-1743)
>>    while executing
>> "exec osascript -e [format {
>>        tell application "System Events"
>>            set frontmost of processes whose unix id is %d to true
>>        end te..."
>=20
> Fortunately, this feature is merely a convenience, not otherwise
> critical to gitk functioning. It would be ideal if someone running
> Mojave could devise up a patch to work around the problem (either by
> skipping this code on Mojave or discovering a different way to bring
> the application to the foreground). An alternative would be to revert
> 76bf6ff93e (gitk: On OSX, bring the gitk window to front, 2013-04-24),
> which introduced this code.
>=20
> (Note, however, that the gitk project is dormant, so it's not clear if
> such a patch will be picked up.)

