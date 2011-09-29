From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: Git is not scalable with too many refs/*
Date: Thu, 29 Sep 2011 20:10:57 +0100
Message-ID: <67aa39596ee72e1abbecf488a2916923@quantumfyre.co.uk>
References: <4DF6A8B6.9030301@op5.se>
 <CAP8UFD3TWQHU0wLPuxMDnc3bRSz90Yd+yDMBe03kofeo-nr7yA@mail.gmail.com>
 <201109281338.04378.mfick@codeaurora.org>
 <201109281610.49322.mfick@codeaurora.org>
 <c76d7f65203c0fc2c6e4e14fe2f33274@quantumfyre.co.uk>
 <960aacbf-8d4d-4b2a-8902-f6380ff9febd@email.android.com>
 <7c0105c6cca7dd0aa336522f90617fe4@quantumfyre.co.uk>
 <4E84B89F.4060304@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Martin Fick <mfick@codeaurora.org>,
	Christian Couder <christian.couder@gmail.com>,
	<git@vger.kernel.org>, Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Thu Sep 29 21:11:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9M0f-0003ev-Py
	for gcvg-git-2@lo.gmane.org; Thu, 29 Sep 2011 21:11:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757476Ab1I2TLA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 Sep 2011 15:11:00 -0400
Received: from neutrino.quantumfyre.co.uk ([93.93.128.23]:57396 "EHLO
	neutrino.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753880Ab1I2TK7 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Sep 2011 15:10:59 -0400
Received: from reaper.quantumfyre.co.uk (quantumfyre-1-pt.tunnel.tserv5.lon1.ipv6.he.net [IPv6:2001:470:1f08:1724::2])
	by neutrino.quantumfyre.co.uk (Postfix) with ESMTP id AEF05C060D;
	Thu, 29 Sep 2011 20:10:58 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id 8FB5B36A880;
	Thu, 29 Sep 2011 20:10:58 +0100 (BST)
X-Virus-Scanned: amavisd-new at reaper
Received: from reaper.quantumfyre.co.uk ([127.0.0.1])
	by localhost (reaper.quantumfyre.co.uk [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id GrTjNfgWgztv; Thu, 29 Sep 2011 20:10:58 +0100 (BST)
Received: from webmail.quantumfyre.co.uk (reaper.quantumfyre.co.uk [192.168.0.2])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id 1AD0136A7BE;
	Thu, 29 Sep 2011 20:10:57 +0100 (BST)
In-Reply-To: <4E84B89F.4060304@lsrfire.ath.cx>
X-Sender: julian@quantumfyre.co.uk
User-Agent: Roundcube Webmail/0.5.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182426>

On Thu, 29 Sep 2011 20:27:43 +0200, Ren=C3=A9 Scharfe wrote:
> Am 29.09.2011 04:19, schrieb Julian Phillips:
>> Does the following help?
>>
>> diff --git a/builtin/checkout.c b/builtin/checkout.c
>> index 5e356a6..f0f4ca1 100644
>> --- a/builtin/checkout.c
>> +++ b/builtin/checkout.c
>> @@ -605,7 +605,7 @@ static int add_one_ref_to_rev_list_arg(const=20
>> char
>> *refname,
>>                                        int flags,
>>                                        void *cb_data)
>>  {
>> -       add_one_rev_list_arg(cb_data, refname);
>> +       add_one_rev_list_arg(cb_data, strdup(sha1_to_hex(sha1)));
>>         return 0;
>>  }
>
> Hmm.  Can we get rid of the multiple ref lookups fixed by the above
> *and* the overhead of dealing with a textual argument list at the=20
> same
> time by calling add_pending_object directly, like this?  (Factoring
> out add_pending_sha1 should be a separate patch..)

Seems like a good idea.  I get the same sort of times as with my patch,=
=20
but it makes the code _feel_ much nicer (and slightly smaller).  Mine=20
was definitely more of a "it's 2am, but I think the problem is here"=20
type of patch ;)

--=20
Julian
