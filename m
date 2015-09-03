From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v15 07/13] ref-filter: add support for %(contents:lines=X)
Date: Thu, 03 Sep 2015 17:01:18 +0200
Message-ID: <vpqwpw7fsxt.fsf@anie.imag.fr>
References: <1441131994-13508-1-git-send-email-Karthik.188@gmail.com>
	<1441131994-13508-8-git-send-email-Karthik.188@gmail.com>
	<CAPig+cRJG7t1M-FyrB84UG4Ar_NBW3J+wFvFeLg599sAEAweHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Sep 03 17:02:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXW1h-00068F-VN
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 17:02:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756547AbbICPCE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Sep 2015 11:02:04 -0400
Received: from mx2.imag.fr ([129.88.30.17]:52308 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756523AbbICPCC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Sep 2015 11:02:02 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t83F1GCa030393
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 3 Sep 2015 17:01:16 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t83F1ImA018523;
	Thu, 3 Sep 2015 17:01:18 +0200
In-Reply-To: <CAPig+cRJG7t1M-FyrB84UG4Ar_NBW3J+wFvFeLg599sAEAweHw@mail.gmail.com>
	(Eric Sunshine's message of "Thu, 3 Sep 2015 10:39:29 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 03 Sep 2015 17:01:16 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t83F1GCa030393
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1441897277.24582@/nckYUlgTQSniZJbfTGLdg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277209>

Eric Sunshine <sunshine@sunshineco.com> writes:

>> @@ -624,6 +633,33 @@ static void find_subpos(const char *buf, unsigned long sz,
>>         *nonsiglen = *sig - buf;
>>  }
>>
>> +/*
>> + * If 'lines' is greater than 0, append that many lines from the given
>> + * 'buf' of length 'size' to the given strbuf.
>> + */
>> +static void append_lines(struct strbuf *out, const char *buf, unsigned long size, int lines)
>> +{
>> +       int i;
>> +       const char *sp, *eol;
>> +       size_t len;
>> +
>> +       if ((sp = strstr(buf, "\n\n")) && (sp <= buf + size))
>> +               size += 2;
>
> Aside from the +2 which Matthieu already questioned, this code has a
> much more serious problem. strstr() assumes that 'buf' is
> NUL-terminated, however, the fact that buf's size is also being passed
> to the function, implies that it may not be NUL-terminated.

If Karthik applies my suggestion, then the strstr would go away. I think
the code would be correct even on non-null-terminated strings.

Actually, we're already making the assumption that the buffer for the
whole tag object is null-terminated (and contains no '\0') for
%(contents):

		else if (!strcmp(name, "contents"))
			v->s = xstrdup(subpos);

(But I agree that even if the assumption is correct, it should be made
explicit if it remains a precondition of append_lines).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
