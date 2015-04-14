From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git fsck: unreachable vs. dangling
Date: Tue, 14 Apr 2015 10:50:16 +0200
Message-ID: <552CD4C8.2020700@drmicha.warpmail.net>
References: <CAHGBnuOYLpkeUop9vNH3+WSKqrM3NCSqvu-NZnPnk3gEkAr6eg@mail.gmail.com> <CAPc5daXRpfSrvcae0W+YU-51prCoFGxz_hkhtp7FZ-K9_eeeBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 14 10:50:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YhwY7-0005MJ-AC
	for gcvg-git-2@plane.gmane.org; Tue, 14 Apr 2015 10:50:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753283AbbDNIuX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Apr 2015 04:50:23 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:53773 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753227AbbDNIuS (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Apr 2015 04:50:18 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by mailout.nyi.internal (Postfix) with ESMTP id 489F920D21
	for <git@vger.kernel.org>; Tue, 14 Apr 2015 04:50:18 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute2.internal (MEProxy); Tue, 14 Apr 2015 04:50:18 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=1Od1XwYUmqrliCzwFUUkl2yedew=; b=FDZxxp
	vMJH0T197Qc1JGpiWBenHqMZ0nZ8bkj1QOwOiTw8R4sPZQdSIrznkDf+x4/+4dcV
	CzJc6ZqtXULqqF2wWU2P32eAe+JJiMxbgbeU++nVt0pZAi41irIZw/P1TJvcN2Ue
	9vrI3P/MPTow3d7K0an+SDtDmZylyGQYjI5QM=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=1Od1XwYUmqrliCz
	wFUUkl2yedew=; b=JFsMPGWNRRaSYo8Wxmx+XnR+Y5BglaJyeRNnKarlTDVjExX
	+8GztdAkzl+S3BW5v2mORHZLfOTVsov5seZdB5R9wvlkB7JvnjX8RjrdzTQjf4VS
	vgB3h23HoAfE9gIqSsekSyzLNMZGoVhZZjzBNS2pSw1+iq8LJ2qi7BSOL1C4=
X-Sasl-enc: F6fGsW5oCWTFNvJdI3vggB0zlve5uMm812xc3WyTJvm7 1429001418
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id A59D168010B;
	Tue, 14 Apr 2015 04:50:17 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <CAPc5daXRpfSrvcae0W+YU-51prCoFGxz_hkhtp7FZ-K9_eeeBQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267122>

Junio C Hamano venit, vidit, dixit 14.04.2015 10:05:
> On Tue, Apr 14, 2015 at 12:16 AM, Sebastian Schuberth
> <sschuberth@gmail.com> wrote:
>> Hi,
>>
>> reading through the fsck docs [1] I'm having a hard time understanding
>> what the difference between "unreachable" and "dangling" objects are.
>>
>> By example, suppose I have a commit A that is the tip of exactly one
>> branch (and no tag or other ref points to A). If I delete that branch,
>> is A now dangling, or unreachable, or both?
> 
> Suppose that branch consists of two commits, A and A^.
> When you lose that branch (git branch -D that-branch),
> both A and A^ become unreachable. So are trees and
> blobs that appear only in A and A^ and nowhere else;
> they are also unreachable.
> 
> A dangling object is an unreachable object that cannot be
> made reachable by any way other than pointing at it
> directly with a ref. A^ is not dangling, because you can
> make it reachable by pointing A (the tip of the original
> branch you just lost) with a ref. A on the other hand is
> dangling (if you had a tag object that points at A that
> you lost, then A is merely unreachable but not dangling,
> because you can point at that tag with a ref and make A
> reachable).
> 

This terminology is established, but misleading if you try to
understanding things from the word and the technical tree structure:

"to dangle" means "to hang loosely".

So, in the description above, "A^ dangles from A loosely" because it
hangs from A (you can reach it from A) but loosely, because it would
"drop" if A gets dropped and A is "likely" to be dropped (because it is
unreachable by refs). But A^ is not dangling in our terminology.

If you *reverse the arrows*, i.e. consider A^ pointing to A, it becomes
more apparent that A is dangling: it is an unreferenced leaf node.

But really, we're switching directions of the arrows again and again
when, on the one hand, we talk about refs pointing to commits, commits
pointing to parent commits (which they are, of course) but then, on the
other hand, use terms like "root" and "dangling" which make sense only
when you think of the oppositely oriented tree.

Maybe we should introduce the terms DAG and reverse DAG (GAD?) to make
this clearer. Our DAG is technically oriented from commits to their
parents all the way "up" to the root.

Visually, we often orient it from the root towards child commits.

When we do a revision walk, do we walk forward or backwards?

I'd say users think in the ordering in which they create commits (from
root to children), let's call that DAG. It explains "root" and "dangle"
and such, and a revision walk is a walk backwards in that orientation.

Technically, our acyclic graph is oriented the other way, a revision
walk walks forward in that orientation - it couldn't walk any other way
without extensive searching. This orientation (GAD?) explains "points
to", be it "ref to rev" or "commit to parent".

Michael

P.S.: The more mathematically inclined will notice that we can have more
than 2 orientations if our graph is not connected... But I'd say we have
one "technical" orientation (commit->parent) and the opposite and can
forget about others.
