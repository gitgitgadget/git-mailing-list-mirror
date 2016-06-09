From: Tom Russello <tom.russello@grenoble-inp.org>
Subject: Re: [PATCH v3 1/6] t9001: non order-sensitive file comparison
Date: Thu, 9 Jun 2016 10:15:43 +0200
Message-ID: <214976cd-3876-62ca-b931-338d7f0fd51c@grenoble-inp.org>
References: <1464369102-7551-1-git-send-email-tom.russello@grenoble-inp.org>
 <20160607140148.23242-1-tom.russello@grenoble-inp.org>
 <20160607140148.23242-2-tom.russello@grenoble-inp.org>
 <xmqqziqwmqth.fsf@gitster.mtv.corp.google.com> <vpqporqyko1.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, erwan.mathoniere@grenoble-inp.org,
	samuel.groot@grenoble-inp.org, jordan.de-gea@grenoble-inp.org,
	e@80x24.org, aaron@schrab.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 09 10:16:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAv8D-0001p5-7p
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jun 2016 10:16:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754715AbcFIIP5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2016 04:15:57 -0400
Received: from zm-smtpout-2.grenet.fr ([130.190.244.98]:45819 "EHLO
	zm-smtpout-2.grenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751926AbcFIIPv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2016 04:15:51 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id E167620B2;
	Thu,  9 Jun 2016 10:15:47 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2HxLPSuoD9gc; Thu,  9 Jun 2016 10:15:47 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id CFF3A20A5;
	Thu,  9 Jun 2016 10:15:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id C763B2066;
	Thu,  9 Jun 2016 10:15:47 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id w-lVXckuKdJU; Thu,  9 Jun 2016 10:15:47 +0200 (CEST)
Received: from [130.190.32.197] (eduroam-032197.grenet.fr [130.190.32.197])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id 9B9F52055;
	Thu,  9 Jun 2016 10:15:47 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.1
In-Reply-To: <vpqporqyko1.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296875>

On 06/09/16 07:51, Matthieu Moy wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Tom Russello <tom.russello@grenoble-inp.org> writes:
>>
>>> +# Check if two files have the same content, non-order sensitive
>>> +test_cmp_noorder () {
>>> +	sort $1 >$1;
>>
>> Here is what I think happens:
>>
>>     0) the shell parses this command line;
>>     1) the shell notices that the output has to go to $1;
>>     2) the shell does open(2) of $1,
>>     3) the shell spawns "sort" with a single argument, with its
>>        output connected to the file descriptor obtained in 2).
>>
>> Because "$1" becomes an empty file at 2), "sort" reads nothing and
>> writes nothing.
> 
> Tom: in case you're not convinced, try this:
> 
> $ (echo b; echo a) >f
> $ sort f
> a
> b
> $ sort f >f
> $ cat f
> $
> 
> Also, useless ';' and missing double-quotes around "$1" to avoid bad
> surprises ifever test_cmp_noorder is called on file names with special
> characters.

I was totally convinced by Junio's explanation, it is partially fixed in
v4 and will be entirely fixed in v5.

Thanks.
