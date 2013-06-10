From: garciagj <garciagj@ensibm.imag.fr>
Subject: Re: [PATCH 1/2] status: introduce status.short to enable --short by  default
Date: Mon, 10 Jun 2013 10:01:34 +0200
Message-ID: <3774bdd37ba5b330143d5a2b675955dc@ensibm.imag.fr>
References: <1370683737-28823-1-git-send-email-Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>
 <CALkWK0kvKzFoZmz313hR-3Z71y-MDPT37BfUi7Qrgy7hz_sErQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jorge Juan Garcia Garcia 
	<Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>, <git@vger.kernel.org>,
	<gitster@pobox.com>,
	Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 10 10:01:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ulx33-0007IV-Hv
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 10:01:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751372Ab3FJIBt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Jun 2013 04:01:49 -0400
Received: from mx1.imag.fr ([129.88.30.5]:45850 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751117Ab3FJIBt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 04:01:49 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r5A81XcK009569
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 10 Jun 2013 10:01:33 +0200
Received: from web-ensimag.imag.fr (web-ensimag.imag.fr [195.221.228.24])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r5A81Yjw010245;
	Mon, 10 Jun 2013 10:01:34 +0200
Received: from web-ensimag.imag.fr (localhost [127.0.0.1])
	by web-ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens) with ESMTP id r5A81YYv026214;
	Mon, 10 Jun 2013 10:01:34 +0200
Received: (from apache@localhost)
	by web-ensimag.imag.fr (8.13.8/8.13.8/Submit) id r5A81Yjk026213;
	Mon, 10 Jun 2013 10:01:34 +0200
X-Authentication-Warning: web-ensimag.imag.fr: apache set sender to garciagj@ensibm.imag.fr using -f
In-Reply-To: <CALkWK0kvKzFoZmz313hR-3Z71y-MDPT37BfUi7Qrgy7hz_sErQ@mail.gmail.com>
X-Sender: garciagj@ensibm.imag.fr
User-Agent: Roundcube Webmail/0.8.1
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 10 Jun 2013 10:01:34 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227256>

El 2013-06-08 17:25, Ramkumar Ramachandra escribi=C3=B3:
> Jorge Juan Garcia Garcia wrote:
>> Some people always run 'git status -s'.
>> The configuration variable status.short allows to set it by default.
>
> Good feature.
>
>> @@ -1112,6 +1112,15 @@ static int git_status_config(const char *k,=20
>> const char *v, void *cb)
>>                         s->submodule_summary =3D -1;
>>                 return 0;
>>         }
>> +       if (!strcmp(k, "status.short")) {
>> +               if (!v)
>> +                       return config_error_nonbool(k);
>> +               if (git_config_bool(k,v)) {
>> +                       status_format =3D STATUS_FORMAT_SHORT;
>> +                       wt_shortstatus_print(s);
>> +               }
>> +               return 0;
>> +       }
>
> Incorrect.  This is the wrong place to use config_error_nonbool():
> this is very much a bool, and a "[status] short" in ~/.gitconfig
> should not error out (all boolean variables behave in the same
> manner).  When in doubt, consult config_error_nonbool(); there's
> clearly a comment stating:

Ok. We will change it.

>
> /*
>  * Call this to report error for your variable that should not
>  * get a boolean value (i.e. "[my] var" means "true").
>  */
>
> Also, why are you calling wt_shortstatus_print() here, instead of
> returning control to cmd_status(), which is going to do it anyway?
Yes, it's obviously a mistake.
