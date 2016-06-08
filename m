From: Samuel GROOT <samuel.groot@grenoble-inp.org>
Subject: Re: [PATCH v4 4/6] send-email: create email parser subroutine
Date: Thu, 9 Jun 2016 01:54:03 +0200
Message-ID: <4c1dcf95-d8bb-4649-8980-fa947617b96e@grenoble-inp.org>
References: <20160607140148.23242-1-tom.russello@grenoble-inp.org>
 <20160608130142.29879-1-samuel.groot@grenoble-inp.org>
 <20160608130142.29879-5-samuel.groot@grenoble-inp.org>
 <xmqq8tyfmuk4.fsf@gitster.mtv.corp.google.com>
 <CAPig+cTO+-aATxyNBt2HtctH_ofgqEc8ik3OLSN+THVgu6dhKQ@mail.gmail.com>
 <fb7795c4-60db-94b3-a584-8fadd0440773@grenoble-inp.org>
 <CAPig+cQ5OKFTA8pEge=0e2RMT3ghmat-szw73aO_3WVW1=eAFQ@mail.gmail.com>
 <xmqqy46fjuzm.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, tom.russello@grenoble-inp.org,
	erwan.mathoniere@grenoble-inp.org, jordan.de-gea@grenoble-inp.org,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>, aaron@schrab.com,
	Eric Wong <e@80x24.org>
To: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Jun 09 01:54:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAnIf-0005nB-RX
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jun 2016 01:54:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753530AbcFHXyJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2016 19:54:09 -0400
Received: from zm-smtpout-1.grenet.fr ([130.190.244.97]:35568 "EHLO
	zm-smtpout-1.grenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751049AbcFHXyI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2016 19:54:08 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 6D8992591;
	Thu,  9 Jun 2016 01:54:04 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id K2u3ZWNr-LsF; Thu,  9 Jun 2016 01:54:04 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 5D6AC222F;
	Thu,  9 Jun 2016 01:54:04 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id 56F4B2066;
	Thu,  9 Jun 2016 01:54:04 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cSYSHcytNo8z; Thu,  9 Jun 2016 01:54:04 +0200 (CEST)
Received: from localhost.localdomain (LFbn-1-8141-97.w90-112.abo.wanadoo.fr [90.112.52.97])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id D2D512064;
	Thu,  9 Jun 2016 01:54:03 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.0
In-Reply-To: <xmqqy46fjuzm.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296860>

On 06/08/2016 10:17 PM, Junio C Hamano wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>> An embedded CR probably shouldn't happen, but I'm not convinced that
>> folding it out is a good idea. I would think that you'd want to
>> preserve the header's value verbatim. If anything, I'd expect to see
>> the regex tightened to:
>>
>>     s/\r?\n$//;
>
> Yes, that would be more sensible than silently removing \r in the
> middle which _is_ a sign of something funny going on.
>> Alternately, consider using 'chop' or 'chomp'.
>
> Even if you use chomp(), you'd still need to worry about possible \r
> at the end, no?

'chomp' is what we used before, but with *.eml files (microsoft's file 
format, with CRLF), '\n' were removed but '\r' remained, that's why we 
used s/\r\n|\r|\n//.

s/\r?\n$// looks fine.

Email::Simple library uses qr/\x0a\x0d|\x0d\x0a|\x0a|\x0d/ [1]. Should 
we handle \n\r at end of line as well?

[1] * 
http://cpansearch.perl.org/src/RJBS/Email-Simple-2.210/lib/Email/Simple.pm
