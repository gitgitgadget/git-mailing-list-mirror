From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 4/2] grep: turn off threading for non-worktree
Date: Mon, 12 Dec 2011 23:37:09 +0100
Message-ID: <4EE68215.2060609@lsrfire.ath.cx>
References: <cover.1322830368.git.trast@student.ethz.ch> <4EDE9BBA.2010409@lsrfire.ath.cx> <4EDE9ED1.8010502@lsrfire.ath.cx> <201112070912.54766.trast@student.ethz.ch> <4EDF9BA0.2080204@lsrfire.ath.cx> <20111210131305.GA13344@arf.padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Eric Herman <eric@freesa.org>,
	Junio C Hamano <gitster@pobox.com>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Mon Dec 12 23:37:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaEUk-0000l2-LN
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 23:37:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754309Ab1LLWhM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Dec 2011 17:37:12 -0500
Received: from india601.server4you.de ([85.25.151.105]:39597 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754321Ab1LLWhL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 17:37:11 -0500
Received: from [192.168.2.105] (p4FFDA9B5.dip.t-dialin.net [79.253.169.181])
	by india601.server4you.de (Postfix) with ESMTPSA id C59DC2F8032;
	Mon, 12 Dec 2011 23:37:09 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:8.0) Gecko/20111105 Thunderbird/8.0
In-Reply-To: <20111210131305.GA13344@arf.padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186968>

Am 10.12.2011 14:13, schrieb Pete Wyckoff:
> rene.scharfe@lsrfire.ath.cx wrote on Wed, 07 Dec 2011 18:00 +0100:
>> Am 07.12.2011 09:12, schrieb Thomas Rast:
>>> Ren=E9 Scharfe wrote:
>>>> diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.t=
xt
>>>> index 47ac188..e981a9b 100644
>>>> --- a/Documentation/git-grep.txt
>>>> +++ b/Documentation/git-grep.txt
>>>> @@ -228,8 +228,9 @@ OPTIONS
>>>>   	there is a match and with non-zero status when there isn't.
>>>>
>>>>   --threads<n>::
>>>> +	Run<n>  search threads in parallel.  Default is 8 when searching
>>>> +	the worktree and 0 otherwise.  This option is ignored if git was
>>>> +	built without support for POSIX threads.
>>> [...]
>>>> -		nr_threads =3D (online_cpus()>  1) ? THREADS : 0;
>>>> +		nr_threads =3D (online_cpus()>  1&&  !list.nr) ? THREADS : 0;
>>>
>>> It would be more consistent to stick to the pack.threads convention
>>> where 0 means "all of my cores", so to disable threading the user
>>> would set the number of threads to 1.  Or were you trying to measur=
e
>>> the contention between the worker thread and the add_work() thread?
>>
>> Yes, indeed, the cost for the threading overhead does interest me.  =
The
>> documentation should perhaps mention --no-threads explicitly to avoi=
d
>> confusion.
>>
>> Currently there is no way to specify "as many threads as there are
>> cores" here.  Previous measurements indicated that it wasn't too use=
ful,
>> however, because I/O parallelism was beneficial even for machines wi=
th
>> less than eight cores and more threads didn't pay off.
>
> Right.  Even for single CPU machines this is true, so the
> nr_threads calculation above should still use all 8 THREADS
> regardless of the number of online_cpus().

That makes sense.  However, in a quick test with a simple regex against=
=20
a cache-warm Linux repo threading increased the runtime of git grep by=20
30% on a single-core virtual machine.  Let's keep that check until we=20
understand this better..

Ren=E9
