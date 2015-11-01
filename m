From: =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: Re: [PATCH 3/5] wt-status: avoid building bogus branch name with
 detached HEAD
Date: Sun, 1 Nov 2015 19:11:06 +0100
Message-ID: <563655BA.906@web.de>
References: <5634FB59.1000506@web.de> <5634FC23.2090703@web.de>
 <xmqqbnbdip6y.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 01 19:11:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zsx69-0007JE-TV
	for gcvg-git-2@plane.gmane.org; Sun, 01 Nov 2015 19:11:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752790AbbKASLR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 Nov 2015 13:11:17 -0500
Received: from mout.web.de ([212.227.15.14]:62370 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751999AbbKASLQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Nov 2015 13:11:16 -0500
Received: from [192.168.178.36] ([79.253.185.154]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0MSry9-1a0t3Y2zAL-00RsRC; Sun, 01 Nov 2015 19:11:09
 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <xmqqbnbdip6y.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:zxPXQM9/Hn/wpM/dF+ojxKlzHbTJnUbkJ+HqKHf0WcjCmlnds/s
 vESp7zoA5rKPpKDmBHEwMyHGE59Pe1+763YncMobpSVHYOEcSHuYSOScT3kv38zud7zkXXE
 s61PK8zIh01USWPnL9IjqpQcw58btyK4E5yEF6fgHCEq0GbsyxXwGoz8XPs9n4abHUTcL96
 VdnHmvrLJZRWV+xoajAog==
X-UI-Out-Filterresults: notjunk:1;V01:K0:71ouM+qK9Cg=:jRp81aJMYqDqbAp4lstYyI
 yO/D1glggnO4ouDcXtvsxZJdcQm3HnjpqCN/6X3BE6xTG3kazUMYHf8PSMGjNS1yN26TdNfzX
 OVE1PxzrF0fevZA/OJTpTPpZLLTO2ZidYVj4YrRqneKo8ECShxPcBdYW0x5Q6BUyT/3mvKr4C
 +vu4Xt1C16K8Kr34ilp+qDuJUbOpOuqQVpb4Wf8AscraRSoTQI5oeW44nkaKaXns026ehX6cJ
 YI0VQo0eO2/OcSdYI/E+BMV4ayjcQEJolw+VqECEQMVCws5fT9H7WWxFYETcjNOHrjl+Wf2QS
 RNWZBuIQ5tuXewTIS5oXL986NIrncPTYzorzEtYxi4G/X6gHdht/vPkdjc3/RnifETkBlp1sI
 4hLHdgwKL5ASaMCPiyIPyytfQAXKqMc9WXfRyOt7za0jlQhY/xJh1J8eBhQeRkf35CVd9t2v2
 KmfXm25wi34SygJQL5kirnRwAW5B6bq6kuhxpggRNXlUcF4rOCtwS6fktsEj8S4bQeHVd4UJ6
 uyHohySVbMDskFfb9wznHFQdu5FUsVEB2tC89zh5F3hPhU7vdEZp34/dMspDbWHa6qJ8WlF85
 dIc1Acz/YIVIUIFKjdC95ydnN9NMX4ILZADUf5YGGAmhOCGR6vGKB22nwqLvmC05u2AQnSUww
 jqq/H21I3HvXgxxpwXSkNHBulL//CTa47leezhpWUICUf7hn8eGEAxShXv1h1RGsOKDuDVCFL
 3Cws/IMPHaxt0dH+bsoMUPR86rd6D5ul8nqcnmt8cYd37kxjSuzFIv4VDhq2s7gFI60Wcrmj 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280645>

Am 01.11.2015 um 18:50 schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>> If we're on a detached HEAD then wt_shortstatus_print_tracking() tak=
es
>> the string "HEAD (no branch)", translates it, skips the first eleven
>> characters and passes the result to branch_get(), which returns a bo=
gus
>> result and accesses memory out of bounds in order to produce it.
>
> The fix is correct, but the above explanation looks "not quite" to
> me.
>
> That "HEAD (no branch)" thing is in a separate branch_name variable
> that is not involved in the actual computation (i.e. call to
> branch_get()).
>
> The function gets "HEAD" in s->branch, uses that and skips the first
> eleven characters (i.e. beyond the end of that string), lets
> branch_get() to return a garbage and likely missing branch, finds
> that nobody tracks that, and does the right thing anyway.  If the
> garbage past the end of the "HEAD" happens to have a name of an
> existing branch, we would get an incorrect result.

Ah, yes.  This came from an earlier round which had patch 3 and 4=20
reversed, causing the translated string to be passed to branch_get().=20
Thanks for catching the commit message inconsistency!

Ren=C3=A9
