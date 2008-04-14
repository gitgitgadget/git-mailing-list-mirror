From: Sergio Callegari <scallegari@arces.unibo.it>
Subject: Re: Interaction between clean/smudge and git status
Date: Mon, 14 Apr 2008 07:38:58 +0000 (UTC)
Message-ID: <loom.20080414T072615-85@post.gmane.org>
References: <loom.20080413T231611-113@post.gmane.org> <4802FE3C.4090306@viscovery.net> <7vej98apdo.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 14 09:40:05 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlJIG-00017b-VH
	for gcvg-git-2@gmane.org; Mon, 14 Apr 2008 09:40:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756204AbYDNHjR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Apr 2008 03:39:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755926AbYDNHjQ
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Apr 2008 03:39:16 -0400
Received: from main.gmane.org ([80.91.229.2]:38950 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755551AbYDNHjQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Apr 2008 03:39:16 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JlJHR-0004zl-Up
	for git@vger.kernel.org; Mon, 14 Apr 2008 07:39:09 +0000
Received: from host40-61-dynamic.6-87-r.retail.telecomitalia.it ([87.6.61.40])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 14 Apr 2008 07:39:09 +0000
Received: from scallegari by host40-61-dynamic.6-87-r.retail.telecomitalia.it with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 14 Apr 2008 07:39:09 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 87.6.61.40 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.13) Gecko/20080325 Ubuntu/7.10 (gutsy) Firefox/2.0.0.13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79480>

Junio C Hamano <gitster <at> pobox.com> writes:


> 
> What is to "re-zip"?  You have a .zip file that contains a single file in
> your work tree, and the index and the tree objects record that single file
> deflated?  When you "check out" from the index, you run smudge to create a
> new .zip file with that single file?

I have a zip file that contains a collection of files (or I have an openoffice
file that is just the same).  The program that creates the zip file uses default
compression.  In this way, things managed by git result in objects that cannot
be deltified one against the other very well by git repack.

my re-zip script takes a zip file on stdin, unpacks everything in a temporary
directory, then recreates the archive with a different compression level and
puts it out on stdout.  When the compression is 0, things are merely put in the
archive. In this way the files managed git result in objects that do deltify
well one against the other and in much smaller packs.

> Are you recreating the .zip file in the filter in such a way that a file
> with the same contents results in byte-to-byte identical .zip file?
> Otherwise as far as git is concerned you have changed the file in the work
> tree.

And here you are right!!!
I thought that re-zip script was repeatable in behaviour, but it is not
(probably because things like file dates change when files are unpacked in the
temporary dir and dates get stored).

I absolutely overlooked that.

Then to do what I want to do, I need to work at a lower level, I cannot just
unzip and zip again.

Thanks
