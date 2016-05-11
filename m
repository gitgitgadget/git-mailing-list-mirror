From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v9 2/6] convert.c: stream and early out
Date: Wed, 11 May 2016 06:30:51 +0200
Message-ID: <eaf7b2e2-59d3-7b12-e9dd-d63203b05384@web.de>
References: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
 <1462601460-23543-1-git-send-email-tboegi@web.de>
 <xmqqtwi7t1of.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>, tboegi@web.de
X-From: git-owner@vger.kernel.org Wed May 11 06:31:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0Lnz-00025B-GK
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 06:31:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751542AbcEKEbI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 00:31:08 -0400
Received: from mout.web.de ([212.227.15.3]:63842 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751445AbcEKEbH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 00:31:07 -0400
Received: from birne9.local ([195.252.60.88]) by smtp.web.de (mrweb003) with
 ESMTPSA (Nemesis) id 0Lal0y-1bSmmb3efo-00kOcl; Wed, 11 May 2016 06:30:53
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:45.0)
 Gecko/20100101 Thunderbird/45.0
In-Reply-To: <xmqqtwi7t1of.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:glEeehjGd+W+NI8vbXB5iokQfmjJlhwO0Xg//ZgxIbZc3/rS+sU
 VOUiy+7ixzSbjAfdoRkZ1lDXV3hi4O6/eqtasAaDRZ7QJqneogvmPD+biB04ILZf5JhDsW/
 o4mbE4ZIHQfgZOPtUHo25nK9USbZVq86U1Jan6z6DLGu2JlqTWu//aW5lTFQAcgiM+c0fzX
 M72+OaFD/V5x6oKmufQmg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:lAznrMhoDIw=:vpsVBW0a4xB09G/PrFApew
 SbDT7FevCf68OC6fEi3vOwWhSIOB1hdoBJCBHQ2HFChUL7PTRv0LT0bRPpMX5FnDVmyhKJayn
 VvNUbO8sdzkdPFRLqP9KIFwIivaetcXiwDeF3GJ5U3d2HQBhVEH9B74VyT0kd7SOlIxDUT/a7
 1Jfvwyjwto4tvaNL5Pn4MiBggdBvhkv7jGdtPJRTTRXyAPigetvLqDO+qqtc4k+YBx1KtvNH6
 jf5MjdMcovnP+kiSkSZUHyy36MB1hwKzO0gSTIxxotmj4YSIFqFnCsIAGDj9vwXZIRL/Vg0ff
 4yR9WSnBaSio6xiLleivcdEVTBbEtFGujLlm6zhTjpcDwpA0/SmxrjlXOfDD/7W2sCrTY01bO
 eVrGg9D60y/L5m/Ubrun57REovdBIDtqQvmghiRjYS8VccqUqiy6GFkL2UZk+dSxDqc/htW/L
 tiL8lI8+KLeikRjzByJgevBO3RZ6RUSedyZl1Ol3fxcdkdtsP9hqmhf2NHiQaQlusRLqW/J7U
 8+otvoJVclUbrgXq6LPJLukAMJlKi0nWHYtpQiclI9LrpxZg7A+ZHceo9wUfUUZxw2Kr7Q+nj
 r/RcL375nXzrEGapQVFm+JSi1IuHBv3umpobaoGhhiCU26l7Yz/j1Uj3hlTgWirIqC5d9Tk0X
 B74QTU5owP7NAWMOfjr4k4cyhYrDW1JUkjAm5uaRvMlDQb3iqf30n2qSZkEHSo1SqUWO6krqV
 m9zdaiy3PYAxOZUFi2qBKRwQ77V/broQGYG87v/7Jl9RfwiGLDHkdCNVUNDw8mGdJli/xNJ2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294225>

On 09.05.16 22:29, Junio C Hamano wrote:
> tboegi@web.de writes:
> 
>> +		if (stats->stat_bits & earlyout)
>> +			break; /* We found what we have been searching for */
> 
> Are we sure if our callers are only interested in just one bit at a
> time?  Otherwise, if we want to ensure all of the given bits are
> set,
> 
> 	if ((stats->stat_bits & earlyout) == earlyout)
>         	break;
> 
> would be necessary.  Otherwise, the "only one bit" assumption on the
> "earlyout" parameter somehow needs to be documented in the code.
Thanks for pointing that out.
I have changed the code a couple of times, forth and back.
I want to re-roll the series anyway (probably in the next weeks),
so something like "search_only_flags" may be a better name.
