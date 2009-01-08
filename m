From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: collapsing commits with rebase
Date: Thu, 8 Jan 2009 04:09:15 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrngmav3b.20e.sitaramc@sitaramc.homelinux.net>
References: <93c3eada0901071608r190a723bma502b68c4ab81a08@mail.gmail.com>
 <200901072011.37299.bss@iguanasuicide.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 08 05:10:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKmEO-0003s9-Th
	for gcvg-git-2@gmane.org; Thu, 08 Jan 2009 05:10:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751743AbZAHEJ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2009 23:09:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751631AbZAHEJ3
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jan 2009 23:09:29 -0500
Received: from main.gmane.org ([80.91.229.2]:53194 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750905AbZAHEJ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2009 23:09:28 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LKmCz-000346-Q9
	for git@vger.kernel.org; Thu, 08 Jan 2009 04:09:25 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 08 Jan 2009 04:09:25 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 08 Jan 2009 04:09:25 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104887>

On 2009-01-08, Boyd Stephen Smith Jr. <bss@iguanasuicide.net> wrote:
>>    A---B---C---D---E---F

> Assuming you also have a ref (e.g. Foo) that points to F:
> git checkout sha(B)
> git merge -s sha(D)

I think you now need to do a commit (assuming you meant
"--squash").  Squash will not commit, and your rebase below
(if it runs at all -- I suspect it will refuse to run) will
hard reset to B, the current HEAD.  IOW

> After the merge:
> A -> B -> C -> D -> E -> F [Foo]
>      |
>      +--> [HEAD]

is not true.  You have C+D in the index, not in the tree.

> git rebase --onto $(cat .git/HEAD) sha(E) Foo

Also I think you have an off-by-one error here; you need
sha(D) in that rebase command, not sha(E).

As your rebase command stands, you will lose commit E
completely; neither the merge nor the rebase will pick it
up.

[Haven't tested, but I *think* I understand rebase well
enough now to say so...]
