From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH] transplant: move a series of commits to a different parent
Date: Mon, 25 Jun 2007 09:49:45 +0200
Message-ID: <21FC6948-6969-47A4-9D6E-EFD9D98FC361@zib.de>
References: <1BD13366-B4BD-4630-9046-49567A345CBC@zib.de> <11826268772950-git-send-email-prohaska@zib.de> <81b0412b0706231404hc8b4bc4xd5bc51c733d8ea69@mail.gmail.com> <9C4338DC-0C4A-4981-9EC9-2417513F629D@zib.de> <467F6BB0.4C7F041E@eudaptics.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <J.Sixt@eudaptics.com>
X-From: git-owner@vger.kernel.org Mon Jun 25 09:49:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2jKZ-0004lg-Sv
	for gcvg-git@gmane.org; Mon, 25 Jun 2007 09:49:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751032AbXFYHtu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Jun 2007 03:49:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750853AbXFYHtu
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jun 2007 03:49:50 -0400
Received: from mailer.zib.de ([130.73.108.11]:56461 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750831AbXFYHtu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2007 03:49:50 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l5P7mcHE020483;
	Mon, 25 Jun 2007 09:49:47 +0200 (CEST)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l5P7mbM0013969
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Mon, 25 Jun 2007 09:48:37 +0200 (MEST)
In-Reply-To: <467F6BB0.4C7F041E@eudaptics.com>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50875>


On Jun 25, 2007, at 9:16 AM, Johannes Sixt wrote:

> Steffen Prohaska wrote:
>>
>> On Jun 23, 2007, at 11:04 PM, Alex Riesen wrote:
>>
>>>> git-transplant.sh <onto> <from> <to>
>>>>
>>>> transplant starts with the contents of <onto> and puts on top of
>>>> it the contents of files if they are touched by the series of
>>>> commits <from>..<to>.  If a commit touches a file the content of
>>>> this file is taken as it is in the commit. No merging is
>>>> performed. Original authors, commiters, and commit messages are
>>>> preserved.
>>>>
>>> [...]
>>> # detached head
>>> git checkout $(git rev-parse onto) && git format-patch --stdout
>>> --full-index from..to|git am -3
>>
>> No. This one tries to apply the _changes_ between from..to. What I
>> need is the resulting _content_ of files modified between from..to.
>
> Install a graft that points the parent of "from" to "onto", then run
> git-filter-branch. Like so:

I stumbled over the grafts yesterday and thought that this may be a  
way...

>  $ echo "$(git-rev-parse from^0) $(git-rev-parse onto^0)" \
>     > .git/info/grafts
>  $ git-filter-branch new-to onto..to

... ok this is interesting: git-filter-branch will take the info from
grafts to create its new commits. The new commits will contain all
information independent of the grafts file, right?

... but, I'm not convinced that this is what I need. I need to mix the
tree of onto with the files _modified_ between from..to. Taking _all_
files from the commits between from..to is _wrong_. And I think that
is what the command you proposed would do.

My feeling is that repairing a repository resulting from a broken
cvsimport is a bit more complex than what the existing tools provide
out-of-the box.

	Steffen
