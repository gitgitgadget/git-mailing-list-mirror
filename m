From: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [RFC PATCHv3 1/4] am: avoid re-directing stdin twice
Date: Sat, 06 Sep 2014 14:46:32 +0200
Message-ID: <540B0228.1070201@web.de>
References: <1409911611-20370-1-git-send-email-judge.packham@gmail.com>	<1409911611-20370-2-git-send-email-judge.packham@gmail.com>	<540A1C7B.80109@kdbg.org>	<CAFOYHZBct1CRA+NumVMvbbuELWTRoGL5FkhBfHD2Wk7QZVe1fA@mail.gmail.com>	<xmqqoautpw1g.fsf@gitster.dls.corp.google.com>	<xmqqk35hpvbg.fsf@gitster.dls.corp.google.com>	<xmqqfvg5puws.fsf@gitster.dls.corp.google.com>	<CALaEz9Xbk_sAAJ0wNCgC9Rzr=E9Ke0H3YEwGr1_4VNgv0AwYhw@mail.gmail.com> <xmqqbnqtp5he.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j6t@kdbg.org>, GIT <git@vger.kernel.org>,
	Chris Packham <judge.packham@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 06 14:46:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XQFOM-00031X-QT
	for gcvg-git-2@plane.gmane.org; Sat, 06 Sep 2014 14:46:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751011AbaIFMqt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Sep 2014 08:46:49 -0400
Received: from mout.web.de ([212.227.15.4]:62930 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750863AbaIFMqs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Sep 2014 08:46:48 -0400
Received: from macce.local ([78.72.74.102]) by smtp.web.de (mrweb001) with
 ESMTPSA (Nemesis) id 0Ma2lb-1Xg0BS2opz-00Lnik; Sat, 06 Sep 2014 14:46:33
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.0
In-Reply-To: <xmqqbnqtp5he.fsf@gitster.dls.corp.google.com>
X-Provags-ID: V03:K0:Rmr/hZpH5pnyu00pBrZGRnpHME0uemL6mlb+2cQ9MouEplDH4Fz
 MaNwjshDA5mCUSWX5phvYZ2ftzMkYpE26oyEFj0wGl+0+c622ik/6192FCAIvw18tMRPIpX
 +oAB/d810HxEWWVdIpmJ+z8dENA+DQkC9Mwdw7/Z3UO13Q4oWXwVdI1TyWH28PhtuJZ2S6K
 Hu+4JKV9zYscKC7oB0s6A==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256586>

On 2014-09-06 09.34, Junio C Hamano wrote:
> Stephen Boyd <bebarino@gmail.com> writes:
> 
>>>> I see Stephen who wrote the original "Thunderbird save-as" is
>>>> already on the Cc list.  How about doing it this way instead?
>>
>> It was so long ago I can't even remember writing that patch. But I
>> googled the thread from 4.5 years ago and I see that you suggested we
>> use tr because \r is not portable[1].
> 
> Hmph.  That's unfortunate that this may be one of those things that
> even though it is in POSIX the real world prevents us from using it.
> 
> I wonder if things changed over the past four years, though.  Can
> folks on OSX or BSD do a quick check?
>
I may have missed the discussion, does this help?
"\r" can be used with tr, but not with sed:


tb@macosx:/tmp> cat ./xx.sh 
#!/bin/sh
which tr
printf "AB\rCD\n" | tr 'A\r\n\BCD' 'aRNbcd' | xxd
printf "E\rE" | tr -d '\r' | xxd
which sed
printf "AB\rCD\n" | sed -e  's/\r/R/g' | xxd
printf "E\rE" | sed -e 's/\r//g' | xxd

tb@macosx:/tmp> ./xx.sh 
/usr/bin/tr
0000000: 6162 5263 644e                           abRcdN
0000000: 4545                                     EE
/usr/bin/sed
0000000: 4142 0d43 440a                           AB.CD.
0000000: 450d 450a                                E.E.
tb@macosx:/tmp> 
