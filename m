From: Miles Bader <miles@gnu.org>
Subject: Re: [RFC] deprecating and eventually removing "git relink"?
Date: Tue, 15 Nov 2011 13:40:24 +0900
Message-ID: <buok472t2vb.fsf@dhlpc061.dev.necel.com>
References: <7v4ny7mtbx.fsf@alter.siamese.dyndns.org>
 <buomxbzutjm.fsf@dhlpc061.dev.necel.com>
 <7vmxbzj927.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 15 05:40:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQAp2-0003uC-8u
	for gcvg-git-2@lo.gmane.org; Tue, 15 Nov 2011 05:40:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751624Ab1KOEkb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Nov 2011 23:40:31 -0500
Received: from relmlor2.renesas.com ([210.160.252.172]:41676 "EHLO
	relmlor2.renesas.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751092Ab1KOEka (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2011 23:40:30 -0500
Received: from relmlir1.idc.renesas.com ([10.200.68.151])
 by relmlor2.idc.renesas.com ( SJSMS)
 with ESMTP id <0LUO008FHQBHMQ00@relmlor2.idc.renesas.com> for
 git@vger.kernel.org; Tue, 15 Nov 2011 13:40:29 +0900 (JST)
Received: from relmlac4.idc.renesas.com ([10.200.69.24])
 by relmlir1.idc.renesas.com (SJSMS)
 with ESMTP id <0LUO007W8QBHZEE0@relmlir1.idc.renesas.com> for
 git@vger.kernel.org; Tue, 15 Nov 2011 13:40:29 +0900 (JST)
Received: by relmlac4.idc.renesas.com (Postfix, from userid 0)
	id 4849B4808A; Tue, 15 Nov 2011 13:40:29 +0900 (JST)
Received: from relmlac4.idc.renesas.com (localhost [127.0.0.1])
	by relmlac4.idc.renesas.com (Postfix) with ESMTP id 3125148087; Tue,
 15 Nov 2011 13:40:29 +0900 (JST)
Received: from relmlii1.idc.renesas.com [10.200.68.65]	by
 relmlac4.idc.renesas.com with ESMTP id PAB21208; Tue,
 15 Nov 2011 13:40:29 +0900
X-IronPort-AV: E=Sophos;i="4.69,513,1315148400";   d="scan'208";a="54783003"
Received: from unknown (HELO relay51.aps.necel.com) ([10.29.19.60])
 by relmlii1.idc.renesas.com with ESMTP; Tue, 15 Nov 2011 13:40:28 +0900
Received: from dhlpc061 (dhlpc061.dev.necel.com [10.114.96.50])
	by relay51.aps.necel.com (8.14.4+Sun/8.14.4) with ESMTP id pAF4ePLs012555;
 Tue, 15 Nov 2011 13:40:25 +0900 (JST)
Received: by dhlpc061 (Postfix, from userid 31295)	id EA06452E283; Tue,
 15 Nov 2011 13:40:24 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
Blat: Foop
In-reply-to: <7vmxbzj927.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185421>

Junio C Hamano <gitster@pobox.com> writes:
>> It might be nice to have a mechanism where new objects would update
>> the _alternate_ rather than the object-store in the tree where the
>> command was run.
>
> With the alternate mechanism, your borrowing is read-only and that is
> exactly why you can borrow from other peoples' repositories to which you
> have no write permission to.
>
> What you are suggesting is fundamentally different from the alternates
> mechanism. I am not saying it is better or worse, though. Not yet at this
> point in this message.

Sure, and I don't even claim it's a viable idea, just something that
"seems useful."

>> .. then you could easily have a bunch of trees using a central
>> object store without needing to update the central store
>> occasionally by hand (and do gc in its "clients")...
>
> If you write objects to the central store, "gc" in the "clients"
> will be a no-op because they do not have their own objects. But
> instead, crufts your "clients" accumulate will be in the central
> store. There is still need for "gc" at the central store to remove
> things that are no longer used by any client, isn't it? Unless you
> declare that you do not care because perhaps the central store is
> large enough, that is.

Sure, if git had this mode of operation, it would seem desirable for
"git gc" to act on the central store just at the same points it acts
on the "local store" today.

As obviously a gc needs to know all the roots, that suggests the
central store needs to have a list of clients it can scan for roots.

[I suppose the other "problem" is locking; I guess that would
technically be no different that multiple git commands running
simulataneously in the same tree today, but maybe the presence of a
central store would make such situations occur more frequently...]

> At least with the alternates, running "gc" in the "clients" is a
> safe operation and the only change necessary is to make fsck/repack
> aware of the repositories that borrow from the repository these
> commands are run, and the logic to do so is exactly the same as the
> case to run "gc" in your central store, I would think.

Hmmm sure.

-miles

-- 
=====
(^o^;
(()))
*This is the cute octopus virus, please copy it into your sig so it can spread.
