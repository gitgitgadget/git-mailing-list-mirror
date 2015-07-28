From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/PATCH 09/11] branch.c: use 'ref-filter' data structures
Date: Tue, 28 Jul 2015 15:48:40 +0200
Message-ID: <vpqa8ugwfyf.fsf@anie.imag.fr>
References: <CAOLa=ZT3_DMJWFN62cbF19uxYBFsE69dGaFR=af1HPKsQ42otg@mail.gmail.com>
	<1438066594-5620-1-git-send-email-Karthik.188@gmail.com>
	<1438066594-5620-9-git-send-email-Karthik.188@gmail.com>
	<CAP8UFD3L4QEYQMCda7AbByXGZcvgy5r9y0LMBqEysb6AZ+ydOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Karthik Nayak <karthik.188@gmail.com>, git <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 28 15:49:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZK5G0-0003Jr-NP
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 15:49:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932270AbbG1NtS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 09:49:18 -0400
Received: from mx1.imag.fr ([129.88.30.5]:32911 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752559AbbG1NtP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 09:49:15 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t6SDmd0C011409
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Tue, 28 Jul 2015 15:48:39 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t6SDmeY4032751;
	Tue, 28 Jul 2015 15:48:40 +0200
In-Reply-To: <CAP8UFD3L4QEYQMCda7AbByXGZcvgy5r9y0LMBqEysb6AZ+ydOQ@mail.gmail.com>
	(Christian Couder's message of "Tue, 28 Jul 2015 10:17:09 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 28 Jul 2015 15:48:39 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t6SDmd0C011409
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1438696120.36504@BV9Ndb89C6cJyOlBK7lRqA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274772>

Christian Couder <christian.couder@gmail.com> writes:

> On Tue, Jul 28, 2015 at 8:56 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
>
>> +static void ref_array_append(struct ref_array *array, const char *refname)
>> +{
>> +       size_t len = strlen(refname);
>> +       struct ref_array_item *ref = xcalloc(1, sizeof(struct ref_array_item) + len + 1);
>> +       memcpy(ref->refname, refname, len);
>> +       ref->refname[len] = '\0';

This looks very much like new_ref_array_item, except that the later also
takes an objectname parameter. I find it suspicious that you leave the
objectname field uninitialized.

Why is this code not calling new_ref_array_item?

A detail: you could return a pointer to the newly allocated object to
write

	item = ref_array_append(array, refname);

instead of

	ref_array_append(array, refname);
	item = array->items[array->nr - 1];

>> +       REALLOC_ARRAY(array->items, array->nr + 1);
>> +       array->items[array->nr++] = ref;
>> +}
>
> This function belongs more to ref-filter.{c,h}...

The function disapears in the next commit, but I also think that this
function deserves to exist in ref-filter.{c,h} and remain after the end
of the series.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
