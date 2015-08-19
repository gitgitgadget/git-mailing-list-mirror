From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v12 03/13] ref-filter: introduce the ref_formatting_state stack machinery
Date: Wed, 19 Aug 2015 17:44:29 +0200
Message-ID: <vpqa8tn2sgy.fsf@anie.imag.fr>
References: <1439923052-7373-1-git-send-email-Karthik.188@gmail.com>
	<1439923052-7373-4-git-send-email-Karthik.188@gmail.com>
	<vpqvbcb2uoi.fsf@anie.imag.fr>
	<CAOLa=ZTy8QO=H9g9g3SKU4HaG=qg71GidGuXKLXNgu7Su3FQ9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 19 17:44:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZS5Xd-0002A4-Ad
	for gcvg-git-2@plane.gmane.org; Wed, 19 Aug 2015 17:44:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751410AbbHSPoh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2015 11:44:37 -0400
Received: from mx1.imag.fr ([129.88.30.5]:51396 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751010AbbHSPog (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2015 11:44:36 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t7JFiR0l013996
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Wed, 19 Aug 2015 17:44:27 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t7JFiTb2021305;
	Wed, 19 Aug 2015 17:44:29 +0200
In-Reply-To: <CAOLa=ZTy8QO=H9g9g3SKU4HaG=qg71GidGuXKLXNgu7Su3FQ9A@mail.gmail.com>
	(Karthik Nayak's message of "Wed, 19 Aug 2015 21:09:47 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 19 Aug 2015 17:44:27 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t7JFiR0l013996
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1440603870.62575@5y6+4qgvyt9YtjmlXTDTxA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276197>

Karthik Nayak <karthik.188@gmail.com> writes:

>> --- a/ref-filter.c
>> +++ b/ref-filter.c
>> @@ -155,6 +155,8 @@ static void push_new_state(struct ref_formatting_state **stack)
>>
>>         strbuf_init(&s->output, 0);
>>         s->prev = *stack;
>> +       if (*stack)
>> +               s->quote_style = (*stack)->quote_style;
>>         *stack = s;
>>  }
>>
>>
>
> This seems about right, why do you think it's a stupid fix?

If you have a stack of N elemments, why replicate a field N times if all
the N instances always have the same value?

There's nothing to be pushed or poped with quote_style, so having it in
the stack is confusing to the reader (one has to infer the property "all
instances have the same value" by reading the code instead of having
just one variable), and error-prone for the author: you already got
it wrong once.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
