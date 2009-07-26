From: Avi Kivity <avi@redhat.com>
Subject: Re: Performance issue of 'git branch'
Date: Sun, 26 Jul 2009 20:07:07 +0300
Message-ID: <4A6C8D3B.101@redhat.com>
References: <20090723160740.GA5736@Pilar.aei.mpg.de> <alpine.LFD.2.01.0907230913230.21520@localhost.localdomain> <20090723165335.GA15598@Pilar.aei.mpg.de> <alpine.LFD.2.01.0907231158280.21520@localhost.localdomain> <alpine.LFD.2.01.0907231212180.21520@localhost.localdomain> <20090723195548.GA28494@Pilar.aei.mpg.de> <alpine.LFD.2.01.0907241327410.3960@localhost.localdomain> <alpine.LFD.2.01.0907241346450.3960@localhost.localdomain> <alpine.LFD.2.01.0907241349390.3960@localhost.localdomain> <20090724225415.GC6832@mit.edu> <20090724225917.GA11191@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Theodore Tso <tytso@mit.edu>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"Carlos R. Mafra" <crmafra2@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Jul 26 19:03:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MV77l-0001lS-Uq
	for gcvg-git-2@gmane.org; Sun, 26 Jul 2009 19:03:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753878AbZGZRCu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jul 2009 13:02:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753852AbZGZRCt
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Jul 2009 13:02:49 -0400
Received: from mx2.redhat.com ([66.187.237.31]:42224 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753802AbZGZRCt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jul 2009 13:02:49 -0400
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id n6QH2hgM028462;
	Sun, 26 Jul 2009 13:02:43 -0400
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id n6QH2fAG010745;
	Sun, 26 Jul 2009 13:02:42 -0400
Received: from cleopatra.tlv.redhat.com (cleopatra.tlv.redhat.com [10.35.255.11])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id n6QH2eYp007102;
	Sun, 26 Jul 2009 13:02:40 -0400
Received: from balrog.qumranet.com (dhcp-1-197.tlv.redhat.com [10.35.1.197])
	by cleopatra.tlv.redhat.com (Postfix) with ESMTP id D38D5250061;
	Sun, 26 Jul 2009 20:02:39 +0300 (IDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b3pre) Gecko/20090513 Fedora/3.0-2.3.beta2.fc11 Lightning/1.0pre Thunderbird/3.0b2
In-Reply-To: <20090724225917.GA11191@spearce.org>
X-Scanned-By: MIMEDefang 2.58 on 172.16.27.26
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124130>

On 07/25/2009 01:59 AM, Shawn O. Pearce wrote:
> Theodore Tso<tytso@mit.edu>  wrote:
>    
>> On Fri, Jul 24, 2009 at 02:21:20PM -0700, Linus Torvalds wrote:
>>      
>>> I wonder if there is some way to only load the crazy curl stuff when we
>>> actually want open a http: connection.
>>>        
>> Well, we could use dlopen(), but I'm not sure that qualifies as a
>> _sane_ solution --- especially given that there are approximately 15
>> interfaces used by git, that we'd have to resolve using dlsym().
>>      
>
> Yea, that's not sane.
>
> Probably the better approach is to have git fetch and git push be a
> different binary from main git, so we only pay the libcurl loading
> overheads when we hit transport.
>    

Or make the transports shared libraries, and use dlopen() to open the 
transport and dlsym() to resolve the struct transport object exported by 
the library.

-- 
error compiling committee.c: too many arguments to function
