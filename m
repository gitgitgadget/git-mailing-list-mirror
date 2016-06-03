From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH 03/10] builtin/tag.c: convert trivial snprintf calls to
 xsnprintf
Date: Fri, 3 Jun 2016 16:37:52 +0100
Message-ID: <5751A450.4040702@ramsayjones.plus.com>
References: <20160603074724.12173-1-gitter.spiros@gmail.com>
 <20160603074724.12173-3-gitter.spiros@gmail.com>
 <20160603085231.GB28401@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>, Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 03 17:38:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8rAf-0003aa-LF
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 17:38:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752793AbcFCPh5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 11:37:57 -0400
Received: from avasout01.plus.net ([84.93.230.227]:54379 "EHLO
	avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751545AbcFCPh5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2016 11:37:57 -0400
Received: from [10.0.2.15] ([84.92.139.254])
	by avasout01 with smtp
	id 2Fdt1t0095VX2mk01FduCl; Fri, 03 Jun 2016 16:37:54 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=bsGxfxui c=1 sm=1 tr=0
 a=RCQFcU9wfaUQolwYLdiqXg==:117 a=RCQFcU9wfaUQolwYLdiqXg==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=IkcTkHD0fZMA:10
 a=nIsvIaSKVGcqvGpAJycA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
In-Reply-To: <20160603085231.GB28401@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296338>



On 03/06/16 09:52, Jeff King wrote:
> On Fri, Jun 03, 2016 at 07:47:17AM +0000, Elia Pinto wrote:
> 
>>  builtin/tag.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/builtin/tag.c b/builtin/tag.c
>> index 50e4ae5..0345ca3 100644
>> --- a/builtin/tag.c
>> +++ b/builtin/tag.c
>> @@ -225,7 +225,7 @@ static void create_tag(const unsigned char *object, const char *tag,
>>  	if (type <= OBJ_NONE)
>>  	    die(_("bad object type."));
>>  
>> -	header_len = snprintf(header_buf, sizeof(header_buf),
>> +	header_len = xsnprintf(header_buf, sizeof(header_buf),
>>  			  "object %s\n"
>>  			  "type %s\n"
>>  			  "tag %s\n"
> 
> This is another of my "type 2" cases. I'd argue it should be using a
> heap buffer to handle tag and tagger names of arbitrary size.

Yep. As it stands, the code following this hunk:

        if (header_len > sizeof(header_buf) - 1)
                die(_("tag header too big."));

is now dead code, and the new error message is not as useful.

ATB,
Ramsay Jones
