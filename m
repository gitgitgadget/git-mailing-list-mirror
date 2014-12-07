From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH v2 2/2] send-email: handle adjacent RFC 2047-encoded words properly
Date: Sun, 7 Dec 2014 17:48:05 -0000
Organization: OPDS
Message-ID: <316EF32F3157400882911A84EA0CFC61@PhilipOakley>
References: <1417894583-2352-1-git-send-email-dpb@corrigendum.ru> <1417894583-2352-2-git-send-email-dpb@corrigendum.ru> <20141207091859.GA21311@peff.net> <op.xqh5hrafnngjn5@freezie>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed	reply-type=response
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>, "Junio C Hamano" <gitster@pobox.com>,
	=?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
	<avarab@gmail.com>, "Jay Soffian" <jaysoffian@gmail.com>,
	"Thomas Rast" <tr@thomasrast.ch>
To: "Jeff King" <peff@peff.net>,
	=?UTF-8?B?0KDQvtC80LDQvSDQlNC+0L3Rh9C10L3QutC+?= 
	<dpb@corrigendum.ru>
X-From: git-owner@vger.kernel.org Sun Dec 07 18:47:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xxfvw-00086Y-Lb
	for gcvg-git-2@plane.gmane.org; Sun, 07 Dec 2014 18:47:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752836AbaLGRrp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Dec 2014 12:47:45 -0500
Received: from out1.ip02ir2.opaltelecom.net ([62.24.128.238]:36330 "EHLO
	out1.ip02ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752334AbaLGRro (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Dec 2014 12:47:44 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AqsMALCRhFQCYJpWPGdsb2JhbABagwaBKoMFgy5swHEBhBEEAoEQFwEBAQEBAQUBAQEBODuDfQUBAQEBAwgBARkPAQUeAQEhCwIDBQIBAQIOBwMCAgUhAgIUAQQaBgcDFAYBEggCAQIDAYguoVacZoZnjwsBCyCBKItuglcRAVCCdjKBFQWPRlyKX447hXCBYT8wgQyBNwEBAQ
X-IPAS-Result: AqsMALCRhFQCYJpWPGdsb2JhbABagwaBKoMFgy5swHEBhBEEAoEQFwEBAQEBAQUBAQEBODuDfQUBAQEBAwgBARkPAQUeAQEhCwIDBQIBAQIOBwMCAgUhAgIUAQQaBgcDFAYBEggCAQIDAYguoVacZoZnjwsBCyCBKItuglcRAVCCdjKBFQWPRlyKX447hXCBYT8wgQyBNwEBAQ
X-IronPort-AV: E=Sophos;i="5.07,534,1413241200"; 
   d="scan'208";a="18890268"
Received: from host-2-96-154-86.as13285.net (HELO PhilipOakley) ([2.96.154.86])
  by out1.ip02ir2.opaltelecom.net with SMTP; 07 Dec 2014 17:47:40 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260992>

=46rom: "=D0=A0=D0=BE=D0=BC=D0=B0=D0=BD =D0=94=D0=BE=D0=BD=D1=87=D0=B5=D0=
=BD=D0=BA=D0=BE" <dpb@corrigendum.ru>
> Jeff King <peff@peff.net> =D0=BF=D0=B8=D1=81=D0=B0=D0=BB =D0=B2 =D1=81=
=D0=B2=D0=BE=D1=91=D0=BC =D0=BF=D0=B8=D1=81=D1=8C=D0=BC=D0=B5 Sun, 07 D=
ec 2014=20
> 12:18:59  +0300:
>
>> On Sat, Dec 06, 2014 at 10:36:23PM +0300, =D0=A0=D0=BE=D0=BC=D0=B0=D0=
=BD =D0=94=D0=BE=D0=BD=D1=87=D0=B5=D0=BD=D0=BA=D0=BE wrote:
>>
>>> The RFC says that they are to be concatenated after decoding (i.e.=20
>>> the
>>> intervening whitespace is ignored).
>>
>> Thanks. Both patches look good to me, and I'd be happy to have them
>> applied as-is. I wrote a few comments below, but in all cases I thin=
k=20
>> I
>> convinced myself that what you wrote is best.
>
> I had the same concerns myself, and eventually convinced myself of th=
e=20
> same. :-)
>
>> One final note on this bit of code: if there are multiple encoded=20
>> words,
>> we grab the $charset from the final encoded word, and never report=20
>> the
>> earlier charsets. Technically they do not all have to be the same
>> (rfc2047 even has an example where they are not). I think we can=20
>> dismiss
>> this, though, as:
>>
>>   1. It was like this before your patches (we might have seen=20
>> multiple
>>      non-adjacent encoded words; you're just handling adjacent ones)=
,
>>      and nobody has complained.
>>
>>   2. Using two separate encodings in the same header is sufficiently
>>      ridiculous that I can live with us not handling it properly.
>
> Yeah, that bugs me as well. But I think handling multiple encodings=20
> would  require substantial reworking of the code, so I chickened out=20
> (with the  same excuses :-)).

Would that be worth a terse comment in the documentation change part of=
=20
the patch?
"Multiple  (RFC2047) encodings are not supported.",
or would that be bike shed noise.

Philip=20
