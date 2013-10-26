From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: [PATCH 0/3] merge -Xindex-only
Date: Sat, 26 Oct 2013 16:40:22 +0200
Message-ID: <87ob6cm6y1.fsf@linux-k42r.v.cablecom.net>
References: <cover.1373219466.git.trast@inf.ethz.ch>
	<51DAD8F2.5070008@alum.mit.edu>
	<87k3l1gip1.fsf@linux-k42r.v.cablecom.net>
	<51DBDB6F.7090105@alum.mit.edu>
	<878v1gey16.fsf@linux-k42r.v.cablecom.net>
	<51DC66A5.80500@alum.mit.edu> <87wqozbj0d.fsf@hexa.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git discussion list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sat Oct 26 16:40:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Va52h-0002vS-AG
	for gcvg-git-2@plane.gmane.org; Sat, 26 Oct 2013 16:40:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752662Ab3JZOkj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Oct 2013 10:40:39 -0400
Received: from psi.thgersdorf.net ([176.9.98.78]:50856 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751884Ab3JZOki (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Oct 2013 10:40:38 -0400
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id A448F4D6514;
	Sat, 26 Oct 2013 16:40:36 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id J17NDtJM_BEF; Sat, 26 Oct 2013 16:40:26 +0200 (CEST)
Received: from linux-k42r.v.cablecom.net.thomasrast.ch (unknown [213.55.184.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id F358F4D6414;
	Sat, 26 Oct 2013 16:40:24 +0200 (CEST)
In-Reply-To: <87wqozbj0d.fsf@hexa.v.cablecom.net> (Thomas Rast's message of
	"Tue, 9 Jul 2013 22:01:06 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236753>

Thomas Rast <trast@inf.ethz.ch> writes:

> Michael Haggerty <mhagger@alum.mit.edu> writes:
>
> On IRC you said you would like a version that always acts as
> --no-commit, and simply returns the conflict/no conflict bit as usual.
> The caller would then proceed using commit-tree itself.  I think that is
> probably a saner solution than this "output ref" idea.

I just had a huge facepalm moment.  We already have this option.  It is
called git-merge-recursive.

That is,

  git merge-recursive $(git merge-base --all HEAD other) -- HEAD other

will internally do all the work that 'git merge other' would do, but not
update any refs.  With this series, you can therefore say

  git merge-recursive --index-only $(git merge-base --all HEAD other) -- HEAD other

and get an *index-only* merge of HEAD and other.

Can you see if this is enough to build git-imerge on top of it?
Otherwise I'm glad to help with building the git-merge infrastucture to
support it.

I'll send v2 of the series in a minute; the only change is that I
changed the internal flag semantics as per Junio's comment in

  http://thread.gmane.org/gmane.comp.version-control.git/229787/focus=229797

-- 
Thomas Rast
tr@thomasrast.ch
