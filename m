From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] status: disable translation when --porcelain is used
Date: Fri, 21 Mar 2014 09:29:53 +0100
Message-ID: <vpqior8dke6.fsf@anie.imag.fr>
References: <CAPP0M7Rw50hPHm49FetNXPGESXOoAND4NXU9F=rajv+NA=G32Q@mail.gmail.com>
	<1395317561-9380-1-git-send-email-Matthieu.Moy@imag.fr>
	<xmqq38iczrr4.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, ghostanarky@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 21 09:30:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQuqI-0004qs-Fi
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 09:30:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759996AbaCUIaM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2014 04:30:12 -0400
Received: from mx2.imag.fr ([129.88.30.17]:34947 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753943AbaCUIaI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2014 04:30:08 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s2L8TsXW006747
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 21 Mar 2014 09:29:54 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s2L8Trs0031850;
	Fri, 21 Mar 2014 09:29:53 +0100
In-Reply-To: <xmqq38iczrr4.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 20 Mar 2014 10:47:43 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 21 Mar 2014 09:29:55 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s2L8TsXW006747
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1395995396.05639@jSGj8XF+tt/RoFqQjMhLJg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244682>

Junio C Hamano <gitster@pobox.com> writes:

>> diff --git a/wt-status.c b/wt-status.c
>> index a452407..e55e5b9 100644
>> --- a/wt-status.c
>> +++ b/wt-status.c
>> @@ -1509,19 +1509,23 @@ static void wt_shortstatus_print_tracking(struct wt_status *s)
>>  		return;
>>  	}
>>  
>> +	const char *gone   = s->no_gettext ? "gone"   : _("gone");
>> +	const char *behind = s->no_gettext ? "behind " : _("behind ");
>> +	const char *ahead  = s->no_gettext ? "ahead "  : _("ahead ");
>
> Having to repeat the same string constant twice (and a half for the
> variable name) each is an eyesore.  I wonder if we can do better,
> perhaps with:
>
> #define LABEL(string) (s->no_gettext ? (string) : _(string))
>
> and then
>
> 	color_fprintf(s->fp, header_color, LABEL(N_("gone")));
>
> or something along those lines?

I first thought about trying something clever with the preprocessor, but
since it's only for 3 strings, I went the KISS way. I tend to prefer my
version for simplicity, but no strong opinion here.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
