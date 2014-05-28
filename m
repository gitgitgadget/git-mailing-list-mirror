From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH 1/5] progress.c: replace signal() with sigaction()
Date: Wed, 28 May 2014 10:19:21 +0200
Message-ID: <87sinuiad2.fsf@fencepost.gnu.org>
References: <1401257655-6043-1-git-send-email-jmmahler@gmail.com>
	<1401257655-6043-2-git-send-email-jmmahler@gmail.com>
	<5385994A.5040507@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeremiah Mahler <jmmahler@gmail.com>, git@vger.kernel.org
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 28 10:19:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpZ5I-0005Pb-LF
	for gcvg-git-2@plane.gmane.org; Wed, 28 May 2014 10:19:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932142AbaE1ITg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 May 2014 04:19:36 -0400
Received: from fencepost.gnu.org ([208.118.235.10]:38898 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932100AbaE1ITd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 May 2014 04:19:33 -0400
Received: from localhost ([127.0.0.1]:37940 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WpZ5A-0001jC-Sm; Wed, 28 May 2014 04:19:33 -0400
Received: by lola (Postfix, from userid 1000)
	id 234EDE084B; Wed, 28 May 2014 10:19:22 +0200 (CEST)
In-Reply-To: <5385994A.5040507@gmail.com> (Chris Packham's message of "Wed, 28
	May 2014 20:07:38 +1200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250272>

Chris Packham <judge.packham@gmail.com> writes:

> On 28/05/14 18:14, Jeremiah Mahler wrote:
>> From signal(2)
>>=20
>>   The behavior of signal() varies across UNIX versions, and has also=
 var=E2=80=90
>>   ied historically across different versions of Linux.   Avoid  its =
 use:
>>   use sigaction(2) instead.  See Portability below.
>
> Minor nit. The last sentence applies to the man page you're quoting a=
nd
> doesn't really make sense when viewed in the context of this commit
> message. Same applies to other patches in this series.
>
>>=20
>> Replaced signal() with sigaction() in progress.c
>>=20
>> Signed-off-by: Jeremiah Mahler <jmmahler@gmail.com>
>> ---
>>  progress.c | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/progress.c b/progress.c
>> index 261314e..24df263 100644
>> --- a/progress.c
>> +++ b/progress.c
>> @@ -66,8 +66,12 @@ static void set_progress_signal(void)
>>  static void clear_progress_signal(void)
>>  {
>>  	struct itimerval v =3D {{0,},};
>> +	struct sigaction sa;
>> +
>> +	memset(&sa, 0, sizeof(sa));
>> +	sa.sa_handler =3D SIG_IGN;
>
> A C99 initialiser here would save the call to memset. Unfortunately
> Documentation/CodingGuidelines is fairly clear on not using C99
> initialisers, given the fact we're now at git 2.0 maybe it's time to
> revisit this policy?

If I look at the initialization of v in the context immediately above
the new code, it would appear that somebody already revisited this
policy.

--=20
David Kastrup
