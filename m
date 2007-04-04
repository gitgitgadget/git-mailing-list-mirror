From: Rogan Dawes <lists@dawes.za.net>
Subject: Re: [PATCH] Show binary file size change in diff --stat
Date: Wed, 04 Apr 2007 18:00:07 +0200
Message-ID: <4613CB87.2090306@dawes.za.net>
References: <200704041414.14797.andyparkins@gmail.com> <4613A974.60808@dawes.za.net> <BAFDAA7B-60EC-44FD-8DAA-EB2F9C835F51@adacore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Geert Bosch <bosch@adacore.com>
X-From: git-owner@vger.kernel.org Wed Apr 04 18:00:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZ7uU-0004IP-Q9
	for gcvg-git@gmane.org; Wed, 04 Apr 2007 18:00:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992977AbXDDQA0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Apr 2007 12:00:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992980AbXDDQA0
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Apr 2007 12:00:26 -0400
Received: from mailbigip.dreamhost.com ([208.97.132.5]:45667 "EHLO
	spunkymail-a1.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S2992978AbXDDQAZ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Apr 2007 12:00:25 -0400
Received: from [192.168.201.103] (dsl-146-24-118.telkomadsl.co.za [165.146.24.118])
	by spunkymail-a1.g.dreamhost.com (Postfix) with ESMTP id 3086AFFAD2;
	Wed,  4 Apr 2007 09:00:23 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.10 (Windows/20070221)
In-Reply-To: <BAFDAA7B-60EC-44FD-8DAA-EB2F9C835F51@adacore.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43750>

Geert Bosch wrote:
> 
> On Apr 4, 2007, at 09:34, Rogan Dawes wrote:
> 
>> For binary files, it would be consistent to show the number of bytes 
>> added/deleted. I have not investigated the output format for the 
>> libxdiff binary patch format, but hopefully it would not be too 
>> difficult to calculate the deletions and additions.
> 
> For binary files it is impractical to do insert/delete type of differences.
> For text files, treating lines as indivisible entities to insert/delete
> make some sense. For binary files, you'd have to use some arbitrary
> context-defined breakpoints and then go from there. The result would
> be some very complicated and unclear algorithm that would have no use
> in the real world.
> 
> Many binary files, such as an images, waveforms or virtually any compressed
> stream, can change in a way that changes all bytes in the file, while
> the changes in the displayed image or the uncompressed stream are
> imperceptible or absent. Guessing semantic differences between binary
> blobs is hopeless and subjective, while differences in size are fact.
> 
>   -Geert

As per my mail to Andy, we *already* do this for text files. e.g. wrap 
an XML document in an additional tag, and update the indentation to match.

The semantic change is minimal (perhaps 2 new lines), but the reported 
change reflects n lines deleted, and n+2 added.

Exactly because we *don't* do any semantic analysis (for text or binary 
files), we should simply report the number of bytes changed, exactly as 
we do for text files (reporting number of lines changed). This is 
_consistent_ with what we do currently for text files.

Note that Andy's apparent preference (to know how the sizes have 
changed) can still largely be satisfied by this approach.

  somefile.bin  | 1000 -> 1000 bytes

and

  somefile.bin  | 500 bytes removed, 500 bytes added

You can still see that the overall size of the file has not changed, but 
you get the additional information about how many bytes were actually 
changed at the same time, which you don't get just showing the sizes.

Rogan
