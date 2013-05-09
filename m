From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 3/3] Initialize variables with values
Date: Thu, 09 May 2013 16:32:55 +0200
Message-ID: <518BB397.901@lsrfire.ath.cx>
References: <518AF79A.5000408@cs-ware.de> <518AF843.6040501@cs-ware.de> <20130509132115.GA3375@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sven Strickroth <sven@cs-ware.de>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 09 16:33:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaRu5-0006LD-Mj
	for gcvg-git-2@plane.gmane.org; Thu, 09 May 2013 16:33:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754792Ab3EIOc7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 May 2013 10:32:59 -0400
Received: from india601.server4you.de ([85.25.151.105]:51365 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752860Ab3EIOc6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 May 2013 10:32:58 -0400
Received: from [192.168.2.105] (p4FFD9FB6.dip0.t-ipconnect.de [79.253.159.182])
	by india601.server4you.de (Postfix) with ESMTPSA id 359DE4B9;
	Thu,  9 May 2013 16:32:57 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <20130509132115.GA3375@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223735>

Am 09.05.2013 15:21, schrieb Jonathan Nieder:
> Hi,
>
> Sven Strickroth wrote:
>
>> With MSVC initializing a variable with "int a=3Da" causes a warning =
about
>> using an uninitialized value.
> [...]
>> --- a/builtin/rev-list.c
>> +++ b/builtin/rev-list.c
>> @@ -338,7 +338,7 @@ int cmd_rev_list(int argc, const char **argv, co=
nst char *prefix)
>>   		mark_edges_uninteresting(revs.commits, &revs, show_edge);
>>
>>   	if (bisect_list) {
>> -		int reaches =3D reaches, all =3D all;
>> +		int reaches =3D 0, all =3D 0;
>
> A correct way to spell this is
>
> 		int reaches, all;
>
> which, as a bonus, lets the compiler warn if they are used
> uninitialized.  Does that provoke warnings?

Only find_bisection() (defined in bisect.c) is used to set these=20
variables in that block.  While it sets "all" unconditionally, it=20
doesn't always set "reaches" -- only if it actually finds something.=20
That's still safe because the following code path errors out early if=20
nothing was found before it uses "reaches".

Are there C compilers that can analyse initialization and usage of=20
variables across compilation units like that?

Anyway, initializing the variables to zero makes this code consistent=20
with the second call-site of find_bisection().  Making sure this=20
function sets "reaches" unconditionally as well and dropping the=20
initialization from both places may be even better.

Ren=E9
