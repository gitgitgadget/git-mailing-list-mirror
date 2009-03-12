From: david@lang.hm
Subject: Re: Google Summer of Code 2009: GIT
Date: Thu, 12 Mar 2009 11:00:12 -0700 (PDT)
Message-ID: <alpine.DEB.1.10.0903121052310.16753@asgard.lang.hm>
References: <49B74373.3090609@gmail.com>  <alpine.DEB.1.00.0903111458340.10498@intel-tinevez-2-302>  <alpine.DEB.1.10.0903110931070.13653@asgard.lang.hm>  <ab9fa62a0903111007w4772b234x8e6fd19cdc7fc595@mail.gmail.com>  <alpine.DEB.1.10.0903111223470.16753@asgard.lang.hm>
  <ab9fa62a0903111302j46c46c2q96af497fa2ac513e@mail.gmail.com>  <alpine.DEB.1.10.0903111307050.16753@asgard.lang.hm>  <alpine.DEB.1.00.0903112136560.10279@pacific.mpi-cbg.de>  <alpine.DEB.1.10.0903111401520.16753@asgard.lang.hm>  <7veix33f5e.fsf@gitster.siamese.dyndns.org>
 <ab9fa62a0903120545o7e5bc359g7df233b00858869c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="680960-807451073-1236880812=:16753"
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: saurabh gupta <saurabhgupta1403@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 12 19:03:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhpEN-0000Ce-3S
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 19:02:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755539AbZCLSAh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2009 14:00:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755176AbZCLSAh
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 14:00:37 -0400
Received: from mail.lang.hm ([64.81.33.126]:58722 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753006AbZCLSAg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2009 14:00:36 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id n2CI0Cqj016909;
	Thu, 12 Mar 2009 10:00:12 -0800
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <ab9fa62a0903120545o7e5bc359g7df233b00858869c@mail.gmail.com>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113097>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--680960-807451073-1236880812=:16753
Content-Type: TEXT/PLAIN; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT

On Thu, 12 Mar 2009, saurabh gupta wrote:

> On Thu, Mar 12, 2009 at 3:17 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> You can cut it both ways.  For an OO document, you do not necessarily need
>> any file-level merger at the driver level, but just let the "binary"
>> driver declare conflicts and punt.  A merge helper can do all the work
>> starting from the "original, ours and theirs" that are not smudged with
>> conflict markers.
>>
>> Between these two extremes, the discussion from other people in the thread
>> seemed to all focus too heavily on the "driver punts" approach, forgetting
>> that mergetool is useful only because most of the time we do not have to
>> even use it, thanks to the fact that "xdl" driver works reasonably well
>> for most trivial cases where branches being merged stayed away from each
>> other, which is the majority case.  It is a huge win from the productivity
>> point of view, and many people might be unaware of it because it is so
>> invisible.
>
> If I am not wrong, then for merging two xml files, if we use a simple
> xdl merge driver then it will mark the conflicts in the normal way as
> it does for simple text files. As far as I can understand, the
> following things are supposed to be aimed here taking an example of
> xml file:
>
>
> =>Merging of two xml files
>
> => existing merge driver (like xdl) is called which marks the
> conflicts points just like a normal text file.
>
> => the conflicted file can be read through a text terminal and
> conflicted lines can be seen.
>
> => suppose the xml file is from the domain of OO document. Then, a
> merge helper for OO xml type file is called which takes input as the
> conflicted file produced by xdl driver.
>
> => The merge helper creates a new file or changes the input file to
> make it a valid xml file so that it can be opened in OpenOffice and
> user can see the markers like "====" or "<<<<<"  in an appropriate
> manner and can resolve the file manually.

with XML files it's possible to be symanticly identical, but not identical 
as far as a text merge driver is concerned.

for example, the following two tags are identical in meaning, but would 
show up as different (and therefor in conflict) in a text merge


<tag attr1='foo' attr2='bar' />
<tag attr2='bar' attr1='foo' />

in many instances (such as config files), the order of items doesn't 
change the meaning. so the following two items would be identical

<tag1>
   stuff
</tag1>
<tag2>
   more stuff
</tag2>

vs

<tag2>
   more stuff
</tag2>
<tag1>
   stuff>
</tag1>

in addition whitespace may or may not be relavent (depending on how the 
XML is used) so the following may also be identical

<tag>stuff<tag>

vs
<tag>
stuff
</tag>

a good XML merge driver would have options that you could set for a 
particular file type to know about these sorts of things.


>>  When it cannot autoresolve,
>> but there is no way to "mark" a tentative result with conflict markers, it
>> can do the same thing as the "binary" driver and let the mergetool backend
>> handle the "driver punted" case.
>
> I think you mean to say that in case, there is a conflict and the
> changes don't overlap, then merge driver leaves the file as it is and
> the merge helper will handle the file.

if there is a conflict it should be because the changes do overlap. if 
they don't overlap why is it a conflict?

David Lang
--680960-807451073-1236880812=:16753--
