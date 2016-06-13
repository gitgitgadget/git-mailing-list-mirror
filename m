From: Samuel GROOT <samuel.groot@grenoble-inp.org>
Subject: Re: [PATCH v4 4/6] send-email: create email parser subroutine
Date: Tue, 14 Jun 2016 00:15:28 +0200
Message-ID: <39dae1da-e300-3ebe-5f04-393b2f71017b@grenoble-inp.org>
References: <20160607140148.23242-1-tom.russello@grenoble-inp.org>
 <20160608130142.29879-1-samuel.groot@grenoble-inp.org>
 <20160608130142.29879-5-samuel.groot@grenoble-inp.org>
 <xmqq8tyfmuk4.fsf@gitster.mtv.corp.google.com>
 <CAPig+cTO+-aATxyNBt2HtctH_ofgqEc8ik3OLSN+THVgu6dhKQ@mail.gmail.com>
 <fb7795c4-60db-94b3-a584-8fadd0440773@grenoble-inp.org>
 <CAPig+cQ5OKFTA8pEge=0e2RMT3ghmat-szw73aO_3WVW1=eAFQ@mail.gmail.com>
 <xmqqy46fjuzm.fsf@gitster.mtv.corp.google.com>
 <4c1dcf95-d8bb-4649-8980-fa947617b96e@grenoble-inp.org>
 <CAPig+cSn5LQ0OxDbg5y=dv16VC-jCaehnss_14mc34o95QbEpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	tom.russello@grenoble-inp.org, erwan.mathoniere@grenoble-inp.org,
	jordan.de-gea@grenoble-inp.org,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>, aaron@schrab.com,
	Eric Wong <e@80x24.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Jun 14 00:15:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCa8v-000803-Uf
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jun 2016 00:15:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422658AbcFMWPe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2016 18:15:34 -0400
Received: from zm-smtpout-2.grenet.fr ([130.190.244.98]:36272 "EHLO
	zm-smtpout-2.grenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161258AbcFMWPd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2016 18:15:33 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 9DE3A20AA;
	Tue, 14 Jun 2016 00:15:29 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id j52QVzHUtLc9; Tue, 14 Jun 2016 00:15:29 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 80C7620A7;
	Tue, 14 Jun 2016 00:15:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id 76BC92077;
	Tue, 14 Jun 2016 00:15:29 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IK3vQVjEtHDP; Tue, 14 Jun 2016 00:15:29 +0200 (CEST)
Received: from localhost.localdomain (che44-2-88-185-231-114.fbx.proxad.net [88.185.231.114])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id EA9572066;
	Tue, 14 Jun 2016 00:15:28 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.0
In-Reply-To: <CAPig+cSn5LQ0OxDbg5y=dv16VC-jCaehnss_14mc34o95QbEpw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297250>



On 06/09/2016 08:51 AM, Eric Sunshine wrote:
> On Wed, Jun 8, 2016 at 7:54 PM, Samuel GROOT
> <samuel.groot@grenoble-inp.org> wrote:
>> On 06/08/2016 10:17 PM, Junio C Hamano wrote:
>>> Eric Sunshine <sunshine@sunshineco.com> writes:
>>>> An embedded CR probably shouldn't happen, but I'm not convinced that
>>>> folding it out is a good idea. I would think that you'd want to
>>>> preserve the header's value verbatim. If anything, I'd expect to see
>>>> the regex tightened to:
>>>>
>>>>     s/\r?\n$//;
>>>
>>> Yes, that would be more sensible than silently removing \r in the
>>> middle which _is_ a sign of something funny going on.
>>
>> s/\r?\n$// looks fine.
>>
>> Email::Simple library uses qr/\x0a\x0d|\x0d\x0a|\x0a|\x0d/ [1].
>> [1] * http://cpansearch.perl.org/src/RJBS/Email-Simple-2.210/lib/Email/Simple.pm
>
> You could certainly use s/\x0d?\x0a$// rather than s/\r?\n$// to be
> really robust, but I doubt it matters much today. The reason for using
> hex codes is that \r and \n will resolve to CR and LF in the local
> character encoding, and those may not be 0x0d and 0x0a, respectively.
> I believe the canonical example given in the Camel book was EBCIDIC in
> which \r is 0x0d, but \n is 0x25, not 0x0a as it is in ASCII.

My question was more about the `\n\r` case handled by Email::Simple, 
does it make sense to handle it?
