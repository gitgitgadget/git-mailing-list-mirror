From: Sam Vilain <sam@vilain.net>
Subject: Re: [git-users] worlds slowest git repo- what to do?
Date: Thu, 15 May 2014 12:48:29 -0700
Message-ID: <53751A0D.2020702@vilain.net>
References: <5374F7C6.5030205@gmail.com> <06A2490FC9BC4461A39B982D3C7C85F7@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Philip Oakley <philipoakley@iee.org>,
	John Fisher <fishook2033@gmail.com>, git-users@googlegroups.com
X-From: git-owner@vger.kernel.org Thu May 15 21:56:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wl1ls-0008F1-5Q
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 21:56:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752893AbaEOT4s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 15:56:48 -0400
Received: from tx.vilain.net ([74.50.57.245]:56483 "EHLO tx.vilain.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751163AbaEOT4r (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 15:56:47 -0400
X-Greylist: delayed 496 seconds by postgrey-1.27 at vger.kernel.org; Thu, 15 May 2014 15:56:47 EDT
Received: from [10.10.100.181] (unknown [38.104.194.154])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by tx.vilain.net (Postfix) with ESMTPSA id 646298291;
	Thu, 15 May 2014 20:48:30 +0100 (BST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <06A2490FC9BC4461A39B982D3C7C85F7@PhilipOakley>
X-Enigmail-Version: 1.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249197>

On 05/15/2014 12:06 PM, Philip Oakley wrote:
> From: "John Fisher" <fishook2033@gmail.com>
>> I assert based on one piece of evidence ( a post from a facebook dev)
>> that I now have the worlds biggest and slowest git
>> repository, and I am not a happy guy. I used to have the worlds
>> biggest CVS repository, but CVS can't handle multi-G
>> sized files. So I moved the repo to git, because we are using that
>> for our new projects.
>>
>> goal:
>> keep 150 G of files (mostly binary) from tiny sized to over 8G in a
>> version-control system.
>>
>> problem:
>> git is absurdly slow, think hours, on fast hardware.
>>
>> question:
>> any suggestions beyond these-
>> http://git-annex.branchable.com/
>> https://github.com/jedbrown/git-fat
>> https://github.com/schacon/git-media
>> http://code.google.com/p/boar/
>> subversion
>>

You could shard.  Break the problem up into smaller repositories, eg via
submodules.  Try ~128 shards and I'd expect that 129 small clones should
complete faster than a single 150G clone, as well as being resumable etc.

The first challenge will be figuring out what to shard on, and how to
lay out the repository.  You could have all of the large files in their
own directory, and then the main repository just has symlinks into the
sharded area.  In that case, I would recommend sharding by date of the
introduced blob, so that there's a good chance you won't need to clone
everything forever; as shards with not many files for the current
version could in theory be retired.  Or, if the directory structure
already suits it, you could "directly" use submodules.

The second challenge will be writing the filter-branch script for this :-)

Good luck,
Sam
