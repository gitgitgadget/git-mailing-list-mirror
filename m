From: Rogan Dawes <lists@dawes.za.net>
Subject: Re: [PATCH 2/2] Add keyword unexpansion support to convert.c
Date: Wed, 18 Apr 2007 18:09:18 +0200
Message-ID: <462642AE.2060708@dawes.za.net>
References: <200704171041.46176.andyparkins@gmail.com> <"200704171803.58940.a n  dyparkins"@gmail.com> <200704172012.31280.andyparkins@gmail.com> <alpine.LFD.0.98.0704171530220.4504@xanadu.home> <Pine.LNX.4.63.0704171244450.1696@qynat.qvtvafvgr.pbz> <alpine.LFD.0.98.0704171624190.4504@xanadu.home> <Pine.LNX.4.63.0704171302200.1696@qynat.qvtvafvgr.pbz> <alpine.LFD.0.98.0704171708360.4504@xanadu.home> <4625B99D.9090409@dawes.za.net> <alpine.LFD.0.98.0704180748460.2828@woody.linux-foundation.org> <46263B8E.9080500@dawes.za.net> <alpine.LFD.0.98.0704181147330.4504@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	David Lang <david.lang@digitalinsight.com>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Apr 18 18:10:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeCjg-0002qF-9w
	for gcvg-git@gmane.org; Wed, 18 Apr 2007 18:10:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992778AbXDRQKV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Apr 2007 12:10:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992782AbXDRQKV
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 12:10:21 -0400
Received: from sd-green-bigip-81.dreamhost.com ([208.97.132.81]:48868 "EHLO
	spunkymail-a18.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S2992778AbXDRQKU (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Apr 2007 12:10:20 -0400
Received: from [10.54.171.19] (vc-196-207-32-232.3g.vodacom.co.za [196.207.32.232])
	by spunkymail-a18.g.dreamhost.com (Postfix) with ESMTP id AE59E5B533;
	Wed, 18 Apr 2007 09:10:15 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.10 (Windows/20070221)
In-Reply-To: <alpine.LFD.0.98.0704181147330.4504@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44908>

Nicolas Pitre wrote:
> On Wed, 18 Apr 2007, Rogan Dawes wrote:
> 
>> Right. I would imagine that the script would have to take care of setting
>> timestamps in the filesystem appropriately, as well as passing them back to
>> git when queried.
>>
>> e.g. expanding test.odf/: (since we store it as a directory)
>>
>> git calls "odf.sh checkout test.odf/ <sha1> <perms> <stat>"
>>
>> odf checkout calls back into git to find out the details of the files under
>> test.odf/, and creates a zip file containing the individual files, with
>> appropriate timestamps.
> 
> Why would you need to store the document as multiple files into Git?
> 
> The only reasons I can see for external filters are:
> 
>  1) Normalization, e.g. the LF->CRLF thing.
> 
>     Some might want to do keyword expansion which would fall into this
>     category as well.
> 
>  2) Better archiving with Git's deltas.
> 
>     That means storing files uncompressed into Git since Git will
>     compress them anyway, after significant space reduction due to 
>     deltas which cannot occur on already compressed data.
> 
> So if your .odf file is actually a zip with multiple files, then all you 
> have to do is to convert that zip archive into a non compressed tar 
> archive on checkins, and the reverse transformation on checkouts.  The 
> non compressed tar content will delta well, the Git archive will be 
> small, and no tricks with the index will be needed.
> 
> Or am I missing something?
> 
> 
> Nicolas

Probably not! ;-)

I was just thinking that it would be easier to see diffs between 
individual files, rather than between entries in a zip. But if we are 
calling out to a specialized handler, the handler can do that just as 
easily, and without the added complexity in the index, etc.

It also means that someone without the attributes and specialized 
handler would not be able to use the file (if it is stored as a directory).

Clearly a bad idea! Just ignore me, I'm used to it! ;-)

Rogan
