From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [RFC/PATCH] pathspec: allow escaped query values
Date: Thu, 2 Jun 2016 20:52:21 +0100
Message-ID: <57508E75.8050501@ramsayjones.plus.com>
References: <20160601235233.21040-1-sbeller@google.com>
 <574F800D.6070107@ramsayjones.plus.com>
 <xmqqy46ouorn.fsf@gitster.mtv.corp.google.com>
 <57505105.2000801@ramsayjones.plus.com>
 <xmqqoa7jvag0.fsf@gitster.mtv.corp.google.com>
 <57507DFD.6010800@ramsayjones.plus.com>
 <CAPc5daWQYRbV_Oc-xCKE2R_O=aMBm_g_CLB=RPUam7EtbGPTgQ@mail.gmail.com>
 <xmqqmvn3tmnm.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Stefan Beller <sbeller@google.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 02 21:52:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8YfO-0004nU-D3
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jun 2016 21:52:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752131AbcFBTw0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2016 15:52:26 -0400
Received: from avasout01.plus.net ([84.93.230.227]:35973 "EHLO
	avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751148AbcFBTwZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2016 15:52:25 -0400
Received: from [10.0.2.15] ([84.92.139.254])
	by avasout01 with smtp
	id 1vsN1t0035VX2mk01vsPmX; Thu, 02 Jun 2016 20:52:23 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=bsGxfxui c=1 sm=1 tr=0
 a=RCQFcU9wfaUQolwYLdiqXg==:117 a=RCQFcU9wfaUQolwYLdiqXg==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=N659UExz7-8A:10
 a=ybZZDoGAAAAA:8 a=EBOSESyhAAAA:8 a=5PrWbbM9Az9Wqm5W7ckA:9 a=pILNOxqGKmIA:10
 a=0RhZnL1DYvcuLYC8JZ5M:22 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
In-Reply-To: <xmqqmvn3tmnm.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296230>



On 02/06/16 20:29, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> On Thu, Jun 2, 2016 at 11:42 AM, Ramsay Jones
>> <ramsay@ramsayjones.plus.com> wrote:
>>>>
>>>> That would be workable, I would think.  Before attr:VAR=VAL
>>>> extention, supported pathspec <magic> were only single lowercase-ascii
>>>> alphabet tokens, so nobody would have used " as a part of magic.  So
>>>> quting with double-quote pair would work.
>>>
>>> I was thinking about both ' and ", so that you could do:
>>
>> Yes, I understood your suggestion as such. Quoting like shells would work
>> without breaking backward compatibility for the same reason quoting with
>> double-quote and backslash only without supporting single-quotes would
>> work.
> 
> Having said that, "It would work" does not have to mean "Hence we
> must do it that way" at all.  Quoting character pairs make the
> parsing and unquoting significantly more complex.
> 
> As you said, not many people used attributes and pathspec magic, and
> I do not think those who want to use the new "further limits with
> attributes" magic, envisioned primarily to be those who want to give
> classes to submodules, have compelling reason to name their classes
> with anything but lowercase-ascii-alphabet tokens.  So for a practical
> purposes, I'd rather see Stefan
> 
>  * just implement backquote-blindly-passes-the-next-byte and nothing
>    more elaborate; and
> 
>  * forbid [^-a-z0-9,_] from being used in the value part in the
>    attr:VAR=VAL magic.
> 
> at least for now, and concentrate more on the other more important
> parts of the submodule enhancement topic.

OK, that reasonable. I didn't mean to derail Stefan's development!

ATB,
Ramsay Jones

> 
> That way, those who will start using attr:VAR=VAL magic will stick
> themselves to lowercase-ascii-alphabet tokens for now (simply
> because an attribut that has the forbidden characters in its value
> would not be usable with the magic), and we can later extend the
> magic syntax parser in a backward compatible way to allow paired
> quotes and other "more convenient" syntax.
> 
> 
> [Footnote]
> 
> *1* The reason I prefer to keep the initially allowed value
> characters narrow is because I envision that something like
> 
> 	:(attr:VAR=(<some expression we will come up with later>))
> 
> may become necessary, and do not want to promise users that open or
> close parentheses will forever be taken literally.
> 
> 
