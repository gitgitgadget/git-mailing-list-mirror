From: Rogan Dawes <lists@dawes.za.net>
Subject: Re: [PATCH] Show binary file size change in diff --stat
Date: Wed, 04 Apr 2007 17:51:24 +0200
Message-ID: <4613C97C.9050600@dawes.za.net>
References: <200704041414.14797.andyparkins@gmail.com> <4613A974.60808@dawes.za.net> <200704041540.59977.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 04 17:52:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZ7mO-0000LW-Vx
	for gcvg-git@gmane.org; Wed, 04 Apr 2007 17:52:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992964AbXDDPvf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Apr 2007 11:51:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992939AbXDDPvf
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Apr 2007 11:51:35 -0400
Received: from sd-green-bigip-83.dreamhost.com ([208.97.132.83]:44460 "EHLO
	spunkymail-a12.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S2992945AbXDDPvd (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Apr 2007 11:51:33 -0400
Received: from [192.168.201.103] (dsl-146-24-118.telkomadsl.co.za [165.146.24.118])
	by spunkymail-a12.g.dreamhost.com (Postfix) with ESMTP id E279B7FB6;
	Wed,  4 Apr 2007 08:51:31 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.10 (Windows/20070221)
In-Reply-To: <200704041540.59977.andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43749>

Andy Parkins wrote:
> On Wednesday 2007 April 04 14:34, Rogan Dawes wrote:
> 
>> Well, how about my comments in <45E67978.9030805@dawes.za.net>,
>> suggesting that the edit difference (number of steps required to
>> transform one to the other) would be a better indication?
> 
> Perhaps.  There is certainly a difference between:
> 
>  somefile.bin  | 1000 -> 1000 bytes
> 
> and
> 
>  somefile.bin  | 500 bytes removed, 500 bytes added
> 
>> I think it is better because it is consistent with what we currently do
>> for text files: show the number of lines added/deleted.
> 
> The thing is, "lines" is an understandable unit for a text file, so it's 
> useful to show.  I'm not sure the same is true of "bytes" for a binary file.  
> Those bytes could represent anything; the true unit of a binary file is 
> dependent on its type.

I think bytes are the only reasonable unit for a binary file, since we 
have no idea what a meaningful divisor may be. So, defaulting to the 
smallest possible unit (other than going to the bit-level) makes perfect 
sense.

>> For binary files, it would be consistent to show the number of bytes
>> added/deleted. I have not investigated the output format for the
>> libxdiff binary patch format, but hopefully it would not be too
>> difficult to calculate the deletions and additions.
> 
> I'm inclined to agree with Johannes, while it's certainly something 
> that /could/ be shown - is it more useful?  There is no guarantee that a 
> small change in the underlying content is represented by a small change in 
> the binary diff.
> 
> As an example: compress a file, change a byte, compress it again, perform a 
> binary diff; what is that diff telling you about the change?  (My answer is: 
> not much).

Well, at least as much as the resulting sizes tell you, if not more.

Here is a counter example for a text file, where lines changed do not 
actually reflect the real changes in the file: the contents of an XML 
file being wrapped in an additional tag.

Semantically, all that has changed is an opening and closing tag. But, 
we still show that on a line by line basis, the entire file has changed 
(because the indentation changes). So you'd have n lines deleted, and 
n+2 lines added (for the additional opening and closing tag).

> Andy

I still maintain that showing bytes changed is the only consistent thing 
to do, unless we have additional logic that allows us to do "per 
file-type" diff statistics. Maybe .gitattributes will allow/enable this?

Regards,

Rogan

P.S. I'm not volunteering to inflict my novice C-skills on the git 
community, so this is really "just my 2c"
