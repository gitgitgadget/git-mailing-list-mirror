From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH] blame.c: prepare_lines should not call xrealloc for every line
Date: Tue, 4 Feb 2014 22:48:02 -0000
Organization: OPDS
Message-ID: <303363DDF4184D37A3D5A52147EE728B@PhilipOakley>
References: <1391544367-14599-1-git-send-email-dak@gnu.org><87lhxqwse8.fsf@fencepost.gnu.org><xmqq8utq8uxn.fsf@gitster.dls.corp.google.com><xmqq4n4e8uf1.fsf@gitster.dls.corp.google.com> <87d2j2wpnr.fsf@fencepost.gnu.org> <79CA69ED4EBA4271A40DE714AEEA5424@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=response
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "Philip Oakley" <philipoakley@iee.org>,
	"David Kastrup" <dak@gnu.org>, "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 04 23:48:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAomz-0007Qc-Hx
	for gcvg-git-2@plane.gmane.org; Tue, 04 Feb 2014 23:48:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935230AbaBDWsJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Feb 2014 17:48:09 -0500
Received: from out1.ip03ir2.opaltelecom.net ([62.24.128.239]:28629 "EHLO
	out1.ip03ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933355AbaBDWsE (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Feb 2014 17:48:04 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AuQ6ALZs8VICYJR6/2dsb2JhbABZgww4EAM5iEq1UwEDAQECAQEHgQcXdGkBAYEfAQEUAQQBAQEBAwECBQEBLh4BASELAgMFAgEDEQQBAQolFAEEDwsGBw8IBgESCAIBAgMBhTgHAYITJQnOFBeOdTWCdoEUBIkRhhiGLoQGiR2Gb2ODLTw
X-IPAS-Result: AuQ6ALZs8VICYJR6/2dsb2JhbABZgww4EAM5iEq1UwEDAQECAQEHgQcXdGkBAYEfAQEUAQQBAQEBAwECBQEBLh4BASELAgMFAgEDEQQBAQolFAEEDwsGBw8IBgESCAIBAgMBhTgHAYITJQnOFBeOdTWCdoEUBIkRhhiGLoQGiR2Gb2ODLTw
X-IronPort-AV: E=Sophos;i="4.95,782,1384300800"; 
   d="scan'208";a="448920964"
Received: from host-2-96-148-122.as13285.net (HELO PhilipOakley) ([2.96.148.122])
  by out1.ip03ir2.opaltelecom.net with SMTP; 04 Feb 2014 22:48:01 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241580>

From: "Philip Oakley" <philipoakley@iee.org>
> From: "David Kastrup" <dak@gnu.org>
> To: "Junio C Hamano" <gitster@pobox.com>
> Cc: <git@vger.kernel.org>
> Sent: Tuesday, February 04, 2014 9:09 PM
> Subject: Re: [PATCH] blame.c: prepare_lines should not call xrealloc 
> for every line
>
[...]
>>
>> Where's the difference?  This is exactly what will happen with my 
>> code
>> as well.  I _do_ rely on memchr(whatever, '\n', 0) to return NULL
>> without looking at any memory for that.  If there is a fear of memchr
>> not being able to deal with a count of 0, this code needs to be 
>> somewhat
>> more complex.
>
> A bit of googling found 
> http://marc.info/?l=gnulib-bug&m=130108029329021 which suggests that 
> behaviour can't be relied upon, and that perhaps some code is 'buggy' 
> relative to expectations (hence the patch it proposed).
>
> It suggests that one can't properly reference a zero length object.
>

I think I've confused myself between the patch 
https://lkml.org/lkml/2010/11/24/429 which fixed a bug in memchr() and 
the discussion in 
http://lists.gnu.org/archive/html/bug-gnulib/2011-03/msg00273.html 
(alternate link to marc.info) that discusses realloc() which has
"
we changed gnulib's test-memchr to
instead test memchr(zerosize_ptr(),a,0) rather than memchr(NULL,a,0).
However, once you can handle memchr(,0) on any other zero-size object,
most implementations also happen to do what you want for
memchr(NULL,a,0), even though it is technically undefined behavior."
ending with 'technically undefined behavior' which I misconstrued.

Apologies for the noise.

>>
>>>  I do not remember if the rest of the logic
>>>  actually depends on it (I think I use lineno[n+1] - lineno[n] to
>>>  find the end of line,
>>
...
>> -- 
>> David Kastrup
>> --
>
> Philip
> --
