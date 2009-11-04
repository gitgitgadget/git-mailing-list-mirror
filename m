From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: How to ensure a word has been removed from repository?
Date: Tue, 03 Nov 2009 21:49:07 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0911032138400.13333@xanadu.home>
References: <6fb3af8e0911031812j54a9b698xca9f5301ac07442a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Patrick Higgins <patrick.allen.higgins@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 04 03:49:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5Vvx-0008IN-4J
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 03:49:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754033AbZKDCtE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2009 21:49:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753797AbZKDCtD
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Nov 2009 21:49:03 -0500
Received: from relais.videotron.ca ([24.201.245.36]:15314 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753105AbZKDCtD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2009 21:49:03 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KSK003JGD5VFWA0@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 03 Nov 2009 21:49:07 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <6fb3af8e0911031812j54a9b698xca9f5301ac07442a@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132026>

On Tue, 3 Nov 2009, Patrick Higgins wrote:

> Hi all,
> 
> I just completed a series of filter-branch commands to remove a couple
> of sensitive words from a repository before I publish it. The words
> were found in commit messages, directory names, file contents, and
> various other places (kind of weird, I know). I believe I have removed
> them all, but I would like to double check but don't know how.
> 
> Given that much of the repository is stored in compressed packs, I
> can't just use grep to look for the words. To get around this, I've
> unpacked the objects, use a Perl script (filtinf example script) to
> decompress them and then use grep (this has proven to be quite slow).
> 
> Is that going to find every possible occurrence if all the relevant
> files are plain text?
> 
> Is there an easier way to search the repository? The way I'm doing it
> has required some awfully deep knowledge to expire and prune
> everything. I feel like I must be missing something.

An easy way to look for the presence of a particular string in all the 
repository data is:

	git rev-list --all --objects | cut -c -40 | \
		git cat-file --batch | grep <string>

Alternatively you can use:

	git fast-export --all --signed-tag=verbatim | grep <string>


Nicolas
