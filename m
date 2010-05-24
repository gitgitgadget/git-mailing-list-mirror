From: John <john@puckerupgames.com>
Subject: Re: serious performance issues with images, audio files, and other
 "non-code" data
Date: Sun, 23 May 2010 20:21:12 -0400
Message-ID: <4BF9C678.6010108@puckerupgames.com>
References: <4BEAF941.6040609@puckerupgames.com> <20100514051049.GF6075@coredump.intra.peff.net> <4BED47EA.9090905@puckerupgames.com> <20100517231642.GB12092@coredump.intra.peff.net> <4BF2E168.2020706@puckerupgames.com> <20100518191933.GB2383@coredump.intra.peff.net> <alpine.LFD.2.00.1005181528550.12758@xanadu.home> <20100518194105.GA4723@coredump.intra.peff.net> <alpine.LFD.2.00.1005181557250.12758@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Mon May 24 02:23:40 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGLSF-00066d-Qw
	for gcvg-git-2@lo.gmane.org; Mon, 24 May 2010 02:23:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755815Ab0EXAVP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 May 2010 20:21:15 -0400
Received: from caiajhbdcagg.dreamhost.com ([208.97.132.66]:48892 "EHLO
	postalmail-a4.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755648Ab0EXAVO (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 23 May 2010 20:21:14 -0400
Received: from dev.newmarket (c-71-225-50-119.hsd1.pa.comcast.net [71.225.50.119])
	by postalmail-a4.g.dreamhost.com (Postfix) with ESMTP id 2E22F11E06B;
	Sun, 23 May 2010 17:21:13 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.5) Gecko/20091204 Thunderbird/3.0
In-Reply-To: <alpine.LFD.2.00.1005181557250.12758@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147598>

Just to follow up, the two solutions which have had a noticeable effect are, 
first to run daily `gc`s, and, second, to configure a ".gitattributes" file as such:

*.jpg  binary -delta
*.png  binary -delta
*.psd  binary -delta
*.gz  binary -delta
*.bz2  binary -delta
.. and so on.

On my first go-round with ".gitattributes" (earlier in this thread), my patterns 
were setup incorrectly, as in,

*.{gz,bz2,tgz,psd,png,jpg} binary -delta

Since git does not perform brace expansion, the above patterns never matched. 
After revising the .gitattributes file, a ~6 minute gc dropped down to just 
under ~3 minutes.

Is there any reason why someone would NOT want the above ".gitattributes" 
defined by default?




On 05/18/2010 03:59 PM, Nicolas Pitre wrote:
> On Tue, 18 May 2010, Jeff King wrote:
>
>> On Tue, May 18, 2010 at 03:33:58PM -0400, Nicolas Pitre wrote:
>>
>>>> It will have to write the whole 200M packfile out each time, though.
>>>
>>> No.  gc will only create a pack with new loose objects by default.
>>> Only if the number of packs grow too large will it combine them into one
>>> pack.
>>
>> I think that is only "gc --auto".
>
> Argh. You're right.  And "gc --auto" is already ran by many commands
> already.
>
> It is "git repack" that doesn't combine packs by default.
>
>
> Nicolas
