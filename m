From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH RFC] CYGWIN: avoid implicit declaration warning
Date: Mon, 24 Nov 2014 23:04:57 +0000
Message-ID: <5473B999.2050604@ramsay1.demon.co.uk>
References: <5471EC26.3040705@web.de> <5472159B.4060905@ramsay1.demon.co.uk>	<xmqqegstychq.fsf@gitster.dls.corp.google.com>	<54726A8C.4040600@ramsay1.demon.co.uk>	<5473B0E4.9090900@ramsay1.demon.co.uk> <xmqqlhn0usbq.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 25 00:05:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xt2gy-0007YV-0B
	for gcvg-git-2@plane.gmane.org; Tue, 25 Nov 2014 00:05:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751434AbaKXXFE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Nov 2014 18:05:04 -0500
Received: from mdfmta009.mxout.tch.inty.net ([91.221.169.50]:39744 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751375AbaKXXFD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Nov 2014 18:05:03 -0500
Received: from mdfmta009.tch.inty.net (unknown [127.0.0.1])
	by mdfmta009.tch.inty.net (Postfix) with ESMTP id BF7161280E0;
	Mon, 24 Nov 2014 23:05:00 +0000 (GMT)
Received: from mdfmta009.tch.inty.net (unknown [127.0.0.1])
	by mdfmta009.tch.inty.net (Postfix) with ESMTP id 7006F1280BF;
	Mon, 24 Nov 2014 23:05:00 +0000 (GMT)
Received: from [10.0.2.15] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mdfmta009.tch.inty.net (Postfix) with ESMTP;
	Mon, 24 Nov 2014 23:05:00 +0000 (GMT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <xmqqlhn0usbq.fsf@gitster.dls.corp.google.com>
X-MDF-HostID: 22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260167>

On 24/11/14 22:50, Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:
> 
>> ...
>> Although I have not done an actual diff of the various cdef.h files, they
>> do appear to be more or less the same. In other words, I no longer think
>> that the change results from a 'change in priority of _XOPEN_SOURCE'. The
>> issue is simply that in the old <string.h> header these functions were
>> declared unconditionally; in the new headers the are contained within
>> preprocessor conditionals using the __GNU_VISIBLE and __BSD_VISIBLE macros
>> which are not set when _XOPEN_SOURCE is set (despite _GNU_SOURCE and
>> _BSD_SOURCE being set).
> 
> So I can take your version [*1*], drop this bit from the log:
> 
>     This seems to be caused by a change to the system headers which
>     results in the _XOPEN_SOURCE macro now having prioity over the
>     _GNU_SOURCE and _BSD_SOURCE macros (they are simply ignored).
>     This in turn leads to the declarations of the above functions
>     to be suppressed.
> 
> and replace it with something like:
> 
>     <string.h> on Cygwin used to always declare the above functions,
>     but a recent version of it no longer make them visible when
>     _XOPEN_SOURCE is set (even if _GNU_SOURCE and _BSD_SOURCE is
>     set).
> 
> and keep the rest, I think.

Perfect! Thanks! (actually, another minor typo: the second warning
message, indent the ^ by two spaces - it should be pointing to the
= symbol).

ATB,
Ramsay Jones
