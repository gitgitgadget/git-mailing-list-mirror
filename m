From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH 1/2 v3] mergetool: use path to mergetool in config var mergetool.<tool>.path
Date: Thu, 18 Oct 2007 10:40:09 +0200
Message-ID: <4591BA15-EB6B-4058-A2D0-879556481E59@zib.de>
References: <11926413722362-git-send-email-prohaska@zib.de> <11926413723666-git-send-email-prohaska@zib.de> <20071018052724.GA27813@spearce.org> <923DDB10-C9E9-4797-9FC1-D31DEEBE75B7@zib.de> <20071018080049.GK14735@spearce.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Oct 18 10:38:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiQu8-0001Yv-Om
	for gcvg-git-2@gmane.org; Thu, 18 Oct 2007 10:38:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757924AbXJRIip (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 04:38:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755953AbXJRIip
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 04:38:45 -0400
Received: from mailer.zib.de ([130.73.108.11]:51479 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762737AbXJRIin (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 04:38:43 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l9I8cexn019822;
	Thu, 18 Oct 2007 10:38:40 +0200 (CEST)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l9I8cdoE010918
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Thu, 18 Oct 2007 10:38:39 +0200 (MEST)
In-Reply-To: <20071018080049.GK14735@spearce.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61507>


On Oct 18, 2007, at 10:00 AM, Shawn O. Pearce wrote:

> Steffen Prohaska <prohaska@zib.de> wrote:
>> On Oct 18, 2007, at 7:27 AM, Shawn O. Pearce wrote:
>>> ...
>>>> +    test -n "$merge_tool" || valid_tool "$merge_tool" || {
>>>
>>> Wouldn't an empty $merge_tool string be caught above in the
>>> valid_tool function where it falls through and returns 1?
>>> So isn't test -n here redundant?
>>
>> Sharp eyes, thanks.
>>
>> Correct is
>>
>> test -z "$merge_tool" || valid_tool "$merge_tool" || {
>>
>> No merge tool or a valid merge tool is allowed at this place.
>> If the tool's already empty there's no need to tell the user
>> that it will be reset to empty.
>>
>> I'll send a v4 version.
>
> Thanks but its a little late.

Sorry.


> I'm about to push maint/master/next/pu
> and this series is in next.  While testing it I found another
> bug related to init_tool_merge_tool_path() not having $merge_tool
> initialized and thus causing it to never select a default tool if
> the user didn't have one configured.

I see. Thanks for fixing this.


> Here's what I'm actually about to push out:

One remark ...

[...]
>
>  if test -z "$merge_tool"; then
>      merge_tool=`git config merge.tool`
> -    case "$merge_tool" in
> -	kdiff3 | tkdiff | xxdiff | meld | opendiff | emerge | vimdiff |  
> gvimdiff | "")
> -	    ;; # happy
> -	*)
> +    if ! valid_tool "$merge_tool"; then

I think its ok to have an empty tool here ...

>  	    echo >&2 "git config option merge.tool set to unknown tool:  
> $merge_tool"
>  	    echo >&2 "Resetting to default..."

... So we should not print this message if the tool is empty.

But an empty tool is not valid. Therefore a check if "$merge_tool"
is not empty should be added to the if.

	Steffen
