From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/PATCH 09/11] branch.c: use 'ref-filter' data structures
Date: Wed, 29 Jul 2015 12:08:14 +0200
Message-ID: <vpq7fpjmg35.fsf@anie.imag.fr>
References: <CAOLa=ZT3_DMJWFN62cbF19uxYBFsE69dGaFR=af1HPKsQ42otg@mail.gmail.com>
	<1438066594-5620-1-git-send-email-Karthik.188@gmail.com>
	<1438066594-5620-9-git-send-email-Karthik.188@gmail.com>
	<CAP8UFD3L4QEYQMCda7AbByXGZcvgy5r9y0LMBqEysb6AZ+ydOQ@mail.gmail.com>
	<vpqa8ugwfyf.fsf@anie.imag.fr>
	<CAOLa=ZTXSutXd4HCrXoVoLT0kQzppiC7gUJpnk8DYYCo7M5XNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Christian Couder <christian.couder@gmail.com>,
	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 29 12:08:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKOHg-00023B-CL
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jul 2015 12:08:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751348AbbG2KIU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2015 06:08:20 -0400
Received: from mx2.imag.fr ([129.88.30.17]:35612 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750854AbbG2KIT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2015 06:08:19 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t6TA8CBE003221
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Wed, 29 Jul 2015 12:08:13 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t6TA8Etw015127;
	Wed, 29 Jul 2015 12:08:14 +0200
In-Reply-To: <CAOLa=ZTXSutXd4HCrXoVoLT0kQzppiC7gUJpnk8DYYCo7M5XNw@mail.gmail.com>
	(Karthik Nayak's message of "Wed, 29 Jul 2015 02:11:11 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 29 Jul 2015 12:08:13 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t6TA8CBE003221
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1438769293.56328@IdMF4ViX+Kd7uXl7/gAM4Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274887>

Karthik Nayak <karthik.188@gmail.com> writes:

> On Tue, Jul 28, 2015 at 7:18 PM, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
>> Christian Couder <christian.couder@gmail.com> writes:
>>
>>> On Tue, Jul 28, 2015 at 8:56 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
>>>
>>>> +static void ref_array_append(struct ref_array *array, const char *refname)
>>>> +{
>>>> +       size_t len = strlen(refname);
>>>> +       struct ref_array_item *ref = xcalloc(1, sizeof(struct ref_array_item) + len + 1);
>>>> +       memcpy(ref->refname, refname, len);
>>>> +       ref->refname[len] = '\0';
>>
>> This looks very much like new_ref_array_item, except that the later also
>> takes an objectname parameter. I find it suspicious that you leave the
>> objectname field uninitialized.
>>
>
> Well the objectname is not required here, the idea is to retain the way branch.c
> works.
>
>> Why is this code not calling new_ref_array_item?
>>
>
> Because no objectname is there.

You do have the object_id in the scope of the call-site, so why not use
it?

(Well, in any case, do as you think is best, it's temporary throw-away
code, we shouldn't loose too much time polishing it)

>> The function disapears in the next commit, but I also think that this
>> function deserves to exist in ref-filter.{c,h} and remain after the end
>> of the series.
>>
>
> Why though? I don't see the need when new_ref_array_item() is present.

OK, if the function is specificly for "append an item but leave the
objectname uninitialized", it's too specific to be useful somewhere
else. But then, make it more explicit in the name of the function and/or
in a comment.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
