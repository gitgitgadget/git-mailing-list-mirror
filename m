From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: Re: [PATCH] imap-send: simplify v_issue_imap_cmd() and get_cmd_result()
 using starts_with()
Date: Wed, 03 Sep 2014 05:50:26 +0200
Message-ID: <54069002.5010404@web.de>
References: <5401F860.4030902@web.de> <xmqqoauxzv1f.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 03 05:50:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XP1ap-0005VW-7X
	for gcvg-git-2@plane.gmane.org; Wed, 03 Sep 2014 05:50:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754877AbaICDuo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Sep 2014 23:50:44 -0400
Received: from mout.web.de ([212.227.15.14]:64881 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753439AbaICDun (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2014 23:50:43 -0400
Received: from [192.168.178.27] ([79.253.169.244]) by smtp.web.de (mrweb003)
 with ESMTPSA (Nemesis) id 0LwqHA-1YVB7G2GeO-016Qx9; Wed, 03 Sep 2014 05:50:38
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.1.0
In-Reply-To: <xmqqoauxzv1f.fsf@gitster.dls.corp.google.com>
X-Provags-ID: V03:K0:rsfGWwbrys4VapCDJzcOJfZqUhgrHodk+h9TJ79dDtIOfeo2FZQ
 xov+WlotQfxXm1kNx1md65j8i+pdSabm5ATeVSODuGQCsUz46zUoVu30KjT/Qkfbd0FWXPh
 3w/bNmrmaNkHOlkqN/13K//v5z1nyhTCVWnDUnz1ly84vtoX+nTvTQ/+yyq4Bi0MO1w9J/y
 LRiL4gQQlTdRQDOOQCzUw==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256377>

Am 02.09.2014 um 21:23 schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>> Use starts_with() instead of memcmp() to check if NUL-terminated
>> strings match prefixes.  This gets rid of some magic string length
>> constants.
>>
>> Signed-off-by: Rene Scharfe <l.s.r@web.de>
>> ---
>>   imap-send.c | 9 ++++++---
>>   1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/imap-send.c b/imap-send.c
>> index 524fbab..b079a0d 100644
>> --- a/imap-send.c
>> +++ b/imap-send.c
>> @@ -802,7 +802,10 @@ static int get_cmd_result(struct imap_store *ct=
x, struct imap_cmd *tcmd)
>>   				resp =3D DRV_OK;
>>   			else {
>>   				if (!strcmp("NO", arg)) {
>> -					if (cmdp->cb.create && cmd && (cmdp->cb.trycreate || !memcmp(c=
md, "[TRYCREATE]", 11))) { /* SELECT, APPEND or UID COPY */
>> +					if (cmdp->cb.create && cmd &&
>> +					    (cmdp->cb.trycreate ||
>> +					     starts_with(cmd, "[TRYCREATE]"))) {
>> +						/* SELECT, APPEND or UID COPY */
>>   						p =3D strchr(cmdp->cmd, '"');
>>   						if (!issue_imap_cmd(ctx, NULL, "CREATE \"%.*s\"", (int)(strc=
hr(p + 1, '"') - p + 1), p)) {
>>   							resp =3D RESP_BAD;
>
> Do we want this hunk, given that it will disappear with the
> tf/imap-send-create topic at e0d8e308 (imap-send: create target
> mailbox if it is missing, 2014-08-01)?

In that case it's unnecessary; apparently I overlooked the conflicting=20
hunk while preparing the patch for sending.

Ren=C3=A9
