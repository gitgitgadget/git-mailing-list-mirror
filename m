From: =?windows-1252?Q?Ren=E9_Scharfe?= <l.s.r@web.de>
Subject: Re: [PATCH] grep: correctly initialize help-all option
Date: Fri, 10 Apr 2015 18:34:29 +0200
Message-ID: <5527FB95.5010806@web.de>
References: <1428586916-22679-1-git-send-email-ps@pks.im> <5526F535.4020407@web.de> <20150410052250.GA372@pks-pc.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Patrick Steinhardt <ps@pks.im>
X-From: git-owner@vger.kernel.org Fri Apr 10 18:35:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YgbtC-0002ii-6f
	for gcvg-git-2@plane.gmane.org; Fri, 10 Apr 2015 18:34:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755530AbbDJQeh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Apr 2015 12:34:37 -0400
Received: from mout.web.de ([212.227.15.3]:53316 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751554AbbDJQeg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Apr 2015 12:34:36 -0400
Received: from [192.168.178.27] ([79.250.171.213]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0LjJWR-1ZFwAf14lb-00dVTi; Fri, 10 Apr 2015 18:34:34
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <20150410052250.GA372@pks-pc.localdomain>
X-Provags-ID: V03:K0:G0u4EttxZvBsB2aoCM9opyJjJ41Q5POfTDoicI33RQa0W5WkUN3
 pesTDeTa5FYBA2A70bgq6OtwZOdN3kjpjXywe5a6KspwWREQxont2oRDhgG5ODfI7Gai1r6
 9Vj5aMOSV/Jpbrrki//tlSI7cIvVythHdm+Cf4B/0HtqHZ1DAiGPetSMSHJn/su1lfh73Tb
 /7WHfn4hBmn0L20wMVfqQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267014>

Am 10.04.2015 um 07:22 schrieb Patrick Steinhardt:
> On Thu, Apr 09, 2015 at 11:55:01PM +0200, Ren=E9 Scharfe wrote:
>> Am 09.04.2015 um 15:41 schrieb Patrick Steinhardt:
>>> ---
>>>    builtin/grep.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/builtin/grep.c b/builtin/grep.c
>>> index abc4400..c0bf005 100644
>>> --- a/builtin/grep.c
>>> +++ b/builtin/grep.c
>>> @@ -738,7 +738,7 @@ int cmd_grep(int argc, const char **argv, const=
 char *prefix)
>>>    			PARSE_OPT_OPTARG, NULL, (intptr_t)default_pager },
>>>    		OPT_BOOL(0, "ext-grep", &external_grep_allowed__ignored,
>>>    			 N_("allow calling of grep(1) (ignored by this build)")),
>>> -		{ OPTION_CALLBACK, 0, "help-all", &options, NULL, N_("show usage=
"),
>>> +		{ OPTION_CALLBACK, 0, "help-all", &opt, NULL, N_("show usage"),
>>>    		  PARSE_OPT_HIDDEN | PARSE_OPT_NOARG, help_callback },
>>>    		OPT_END()
>>>    	};
>>
>> help_callback() returns -1 immediately, IOW the value pointer is nev=
er
>> used anyway.  So why does your change make a difference?  *puzzled*
>>
>> We could pass NULL instead, as in builtin/show-ref.c, which would ma=
ke
>> it clear that the pointer is just a dummy.
>
> Changed in v2, as well.

Thank you.  I should really re-fetch from Gmane before finishing an=20
interrupted reply..

> In general the change won't make any difference when running the
> command. But as said in the commit message it caused gcc (gcc
> version 4.8.3 (Gentoo Hardened 4.8.3 p1.1, pie-0.5.9), ARMv7 HF)
> to segfault when &options was passed in as value. Even though
> this is probably an error in gcc we can easily work around it by
> doing the Right Thing here.

OK, so does it crash on this one-liner as well?

	struct t {void *p;} s =3D {&s};

Or on this?

	void *p =3D &p;

If yes then the author of the hardening feature might be interested in=20
this fact.

Ren=E9
