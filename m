From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH 02/10] builtin/index-pack.c: convert trivial snprintf
 calls to xsnprintf
Date: Fri, 3 Jun 2016 16:32:41 +0100
Message-ID: <5751A319.1030806@ramsayjones.plus.com>
References: <20160603074724.12173-1-gitter.spiros@gmail.com>
 <20160603074724.12173-2-gitter.spiros@gmail.com>
 <20160603085320.GC28401@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>, Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 03 17:32:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8r5e-0007aX-BC
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 17:32:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752083AbcFCPcq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 11:32:46 -0400
Received: from avasout01.plus.net ([84.93.230.227]:52350 "EHLO
	avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751384AbcFCPcp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2016 11:32:45 -0400
Received: from [10.0.2.15] ([84.92.139.254])
	by avasout01 with smtp
	id 2FYh1t00L5VX2mk01FYjyJ; Fri, 03 Jun 2016 16:32:43 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=bsGxfxui c=1 sm=1 tr=0
 a=RCQFcU9wfaUQolwYLdiqXg==:117 a=RCQFcU9wfaUQolwYLdiqXg==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=IkcTkHD0fZMA:10
 a=tHLVe309DjWccNNqqC0A:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
In-Reply-To: <20160603085320.GC28401@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296337>



On 03/06/16 09:53, Jeff King wrote:
> On Fri, Jun 03, 2016 at 07:47:16AM +0000, Elia Pinto wrote:
> 
>> diff --git a/builtin/index-pack.c b/builtin/index-pack.c
>> index e8c71fc..c032fe7 100644
>> --- a/builtin/index-pack.c
>> +++ b/builtin/index-pack.c
>> @@ -1443,7 +1443,7 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
>>  		printf("%s\n", sha1_to_hex(sha1));
>>  	} else {
>>  		char buf[48];
>> -		int len = snprintf(buf, sizeof(buf), "%s\t%s\n",
>> +		int len = xsnprintf(buf, sizeof(buf), "%s\t%s\n",
>>  				   report, sha1_to_hex(sha1));
>>  		write_or_die(1, buf, len);
> 
> So it's pretty unclear here whether that 48 is big enough (it is, if you
> read the whole function, because "report" is always a 4-char string).
> Yuck. At least there should be a comment explaining why 48 is big
> enough.

Agreed, again I would use something like:

		char buf[GIT_SHA1_HEXSZ + 7]; /* 40 (sha1) + 4 (report) + 3 (\t\n\0) */

(and yes yuck - is report ever likely to increase? "bitmap" perhaps?)

ATB,
Ramsay Jones
