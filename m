From: David Lang <david@lang.hm>
Subject: Re: question about: Facebook makes Mercurial faster than Git
Date: Mon, 10 Mar 2014 10:56:51 -0700 (PDT)
Message-ID: <alpine.DEB.2.02.1403101053120.20306@nftneq.ynat.uz>
References: <531D8ED9.7040305@gmx.net> <alpine.DEB.2.02.1403100310080.25193@nftneq.ynat.uz> <20140310175102.GA17336@domone.podge>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="680960-1449010924-1394474211=:20306"
Cc: Dennis Luehring <dl.soluz@gmx.net>, git@vger.kernel.org
To: =?ISO-8859-2?Q?Ond=F8ej_B=EDlka?= <neleai@seznam.cz>
X-From: git-owner@vger.kernel.org Mon Mar 10 18:57:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WN4S0-0000D8-KH
	for gcvg-git-2@plane.gmane.org; Mon, 10 Mar 2014 18:57:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752992AbaCJR5O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 13:57:14 -0400
Received: from mail.lang.hm ([64.81.33.126]:33805 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753215AbaCJR5E (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2014 13:57:04 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id s2AHupcU002057;
	Mon, 10 Mar 2014 09:56:51 -0800
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <20140310175102.GA17336@domone.podge>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243782>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--680960-1449010924-1394474211=:20306
Content-Type: TEXT/PLAIN; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 10 Mar 2014, Ondøej Bílka wrote:

> On Mon, Mar 10, 2014 at 03:13:45AM -0700, David Lang wrote:
>> On Mon, 10 Mar 2014, Dennis Luehring wrote:
>>
>>> according to these blog posts
>>>
>>> http://www.infoq.com/news/2014/01/facebook-scaling-hg
>>> https://code.facebook.com/posts/218678814984400/scaling-mercurial-at-facebook/
>>>
>>> mercurial "can" be faster then git
>>>
>>> but i don't found any reply from the git community if it is a real problem
>>> or if there a ongoing (maybe git 2.0) changes to compete better in this case
>>
>> As I understand this, the biggest part of what happened is that
>> Facebook made a tweak to mercurial so that when it needs to know
>> what files have changed in their massive tree, their version asks
>> their special storage array, while git would have to look at it
>> through the filesystem interface (by doing stat calls on the
>> directories and files to see if anything has changed)
>>
> That is mostly a kernel problem. Long ago there was proposed patch to
> add a recursive mtime so you could check what subtrees changed. If
> somebody ressurected that patch it would gave similar boost.

btrfs could actually implement this efficiently, but for a lot of other 
filesysems this could be very expensive. The question is if it could be enough 
of a win to make it a good choice for people who are doing a heavy git workload 
as opposed to more generic uses.

there's also the issue of managed vs generated files, if you update the mtime 
all the way up the tree because a source file was compiled and a binary created, 
that will quickly defeat the value of the recursive mtime.

David Lang

> There are two issues that need to be handled, first if you are concerned
> about one mtime change doing lot of updates a application needs to mark
> all directories it is interested on, when we do update we unmark
> directory and by that we update each directory at most once per
> application run.
>
> Second problem were hard links where probably a best course is keep list
> of these and stat them separately.
--680960-1449010924-1394474211=:20306--
