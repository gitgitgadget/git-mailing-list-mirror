From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v15 05/13] ref-filter: implement an `align` atom
Date: Wed, 02 Sep 2015 17:50:05 +0200
Message-ID: <vpqsi6wom6q.fsf@anie.imag.fr>
References: <1441131994-13508-1-git-send-email-Karthik.188@gmail.com>
	<1441131994-13508-6-git-send-email-Karthik.188@gmail.com>
	<xmqqegihrg6t.fsf@gitster.mtv.corp.google.com>
	<CAOLa=ZQ0nyaQmvE3suT6hh0jO3s_iYxFLjSuLUY4STneMFJf9Q@mail.gmail.com>
	<xmqqd1y0q30g.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Karthik Nayak <karthik.188@gmail.com>, Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 02 17:50:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXAIk-00021a-Pq
	for gcvg-git-2@plane.gmane.org; Wed, 02 Sep 2015 17:50:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754623AbbIBPuN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2015 11:50:13 -0400
Received: from mx1.imag.fr ([129.88.30.5]:55141 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752827AbbIBPuM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2015 11:50:12 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t82Fo3nF022818
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Wed, 2 Sep 2015 17:50:03 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t82Fo5IN029308;
	Wed, 2 Sep 2015 17:50:05 +0200
In-Reply-To: <xmqqd1y0q30g.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Wed, 02 Sep 2015 08:01:19 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 02 Sep 2015 17:50:03 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t82Fo3nF022818
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1441813804.85853@hN3V0X0bV2sfucaXK8cI9g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277101>

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>>>> +             } else if (skip_prefix(name, "align", &valp)) {
>>>
>>> This looked as if you are willing to take %(align) in addition to
>>> %(align:...), but...
>>>
>>>> +                     struct align *align = &v->align;
>>>> +                     struct strbuf **s;
>>>> +
>>>> +                     if (valp[0] != ':')
>>>> +                             die(_("format: usage %%(align:<width>,<position>)"));
>>>
>>> ... apparently that is not what is happening.  Why not skip "align:"
>>> with colon as the prefix, then?
>>
>> Cause we wanted to provide an error for usage of "%(ailgn)" without any
>> subvalues as such.
>
> Wouldn't it be something that would be caught in the same codepath
> as what catches %(unrecognized) in the format string?

After thinking about it, I agree with Karthik: if we get the same
codepath to complain about %(nosuchatom) and %(align), then we won't be
able to provide an accurate error message. Or we would need to re-parse
the atom, notice that it's one we know about, i.e. redo what we're
already doing here.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
