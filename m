From: Ben Aveling <bena.001@optusnet.com.au>
Subject: fsck option to remove corrupt objects - why/why not?
Date: Thu, 16 Oct 2014 11:13:34 +1100
Message-ID: <543F0DAE.2050205@optusnet.com.au>
References: <20141015234637.9B4FC781EFB@mail110.syd.optusnet.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 16 02:13:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XeYhZ-0004qi-Rz
	for gcvg-git-2@plane.gmane.org; Thu, 16 Oct 2014 02:13:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751537AbaJPANy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2014 20:13:54 -0400
Received: from mail106.syd.optusnet.com.au ([211.29.132.42]:43622 "EHLO
	mail106.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751262AbaJPANx (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Oct 2014 20:13:53 -0400
Received: from [192.168.1.100] (pa49-195-58-202.pa.nsw.optusnet.com.au [49.195.58.202])
	(Authenticated sender: bena.001@optusnet.com.au)
	by mail106.syd.optusnet.com.au (Postfix) with ESMTPSA id DE0EF3C3EA2;
	Thu, 16 Oct 2014 11:13:45 +1100 (AEDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <20141015234637.9B4FC781EFB@mail110.syd.optusnet.com.au>
X-Forwarded-Message-Id: <20141015234637.9B4FC781EFB@mail110.syd.optusnet.com.au>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.1 cv=dMCfxopb c=1 sm=1 tr=0
	a=JJrwPEo+JedI19BPoS439w==:117 a=JJrwPEo+JedI19BPoS439w==:17
	a=PO7r1zJSAAAA:8 a=tcnv99F1KMcA:10 a=IkcTkHD0fZMA:10
	a=gT4vuqMxxM7KBDd5s_gA:9 a=QEXdDO2ut3YA:10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 14/10/2014 19:21, Jeff King wrote:
> On Mon, Oct 13, 2014 at 09:37:27AM +1100, Ben Aveling wrote:
>> A question about fsck - is there a reason it doesn't have an option to
>> delete bad objects?
> If the objects are reachable, then deleting them would create other big
> problems (i.e., we would be breaking the object graph!).

The man page for fsck advises:

    "Any corrupt objects you will have to find in backups or other
    archives (i.e., you can just remove them and do an /rsync/ with some
    other site in the hopes that somebody else has the object you have
    corrupted)."


And that seems sensible to me - the object is corrupt, it is unusable, 
the object graph is already broken, we already have big problems, 
removing the corrupt object(s) doesn't create any new problems, and it 
allows the possibility that the damaged objects can be restored.

I ask because I have a corrupt repository, and every time I run fsck, it 
reports one corrupt object, then stops. I could write a script to 
repeatedly call fsck and then remove the next corrupt object, but it 
raises the question for me; could it make sense to extend fsck with the 
option to do to the removes? Or even better, do the removes and then do 
the necessary [r]sync, assuming the user has another repository that has 
a good copy of the bad objects, which in this case I do.

Regards, Ben
