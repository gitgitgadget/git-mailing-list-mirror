From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git merge no longer handles add/add
Date: Sun, 18 Nov 2007 22:43:53 -0800
Message-ID: <7vtznipweu.fsf@gitster.siamese.dyndns.org>
References: <46a038f90711181918s2743137amc6a827db6d1a6a0@mail.gmail.com>
	<46a038f90711181929x4bf0794eue73a5dbac8e2688a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git list" <git@vger.kernel.org>
To: "Martin Langhoff" <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 19 07:44:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iu0Mi-00017v-5C
	for gcvg-git-2@gmane.org; Mon, 19 Nov 2007 07:44:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752043AbXKSGn7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2007 01:43:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751853AbXKSGn7
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Nov 2007 01:43:59 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:48025 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751756AbXKSGn6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2007 01:43:58 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 5FBDE2EF;
	Mon, 19 Nov 2007 01:44:19 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id D362B941C4;
	Mon, 19 Nov 2007 01:44:16 -0500 (EST)
In-Reply-To: <46a038f90711181929x4bf0794eue73a5dbac8e2688a@mail.gmail.com>
	(Martin Langhoff's message of "Mon, 19 Nov 2007 16:29:27 +1300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65406>

"Martin Langhoff" <martin.langhoff@gmail.com> writes:

> On Nov 19, 2007 4:18 PM, Martin Langhoff <martin.langhoff@gmail.com> wrote:
>> Happens with recursive and resolve. Happy to provide a minimal repro
>> case, but I think this is fairly obvious...
>
> Steps to repro...
>
>     mkdir repro
>     cd repro/
>     cp /etc/resolv.conf ./resolv.conf
>     git init
>     git add resolv.conf
>     git commit -m 'a' resolv.conf
>     cp resolv.conf resolv-1.conf
>     git add resolv-1.conf
>     git commit -m 'a1' resolv-1.conf
>     echo blabla >> resolv-1.conf
      **************
>     git commit -m 'a2' resolv-1.conf
>     git-branch other HEAD^^
>     git checkout other
>     cp resolv.conf resolv-1.conf
>     git add resolv-1.conf
>     git commit -m 'b'
>     git checkout master
>     git merge other
>     ...
>    Auto-merged resolv-1.conf
>    CONFLICT (add/add): Merge conflict in resolv-1.conf
>    Automatic merge failed; fix conflicts and then commit the result.

As far as the point of the merge is concerned, that's an add/add
of _different_ contents, and we have always left the conflict to
resolve for you since day one.  The only case we handle without
complaining is the accidental *clean* merge.  Both branches adds
the path *identically* compared to the common ancestor.

The very initial implementation of merge may have used the total
emptyness as the common ancestor for the merge, and later we
made it a bit more pleasant to resolve by computing the common
part of the file from the two branches to be used as a fake
ancestor contents.  But the fact we left the result as conflict
for you to validate hasn't changed and will not change.
