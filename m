From: "Long, Martin" <martin@longhome.co.uk>
Subject: Re: Git commit generation numbers
Date: Fri, 15 Jul 2011 10:17:03 +0100
Message-ID: <CANfMb_-ZxGGzpKDnhG46HK+DZ1UN+_kxccKuSrZtO41N0EFy6Q@mail.gmail.com>
References: <CA+55aFxZq1e8u7kXu1rNDy2UPgP3uOyC5y2j7idKSZ_4eL=bWw@mail.gmail.com>
	<20110714183710.GA26820@sigill.intra.peff.net>
	<CA+55aFwuK+krTA4OcnYhLXtKM5HQ1yuPK+J_vC-5R7AthrHWbg@mail.gmail.com>
	<20110714190844.GA26918@sigill.intra.peff.net>
	<CA+55aFx=ACnVBGU8_9wa=9xTbxVoOWKnsqfmBvzq7qzOeMGSNA@mail.gmail.com>
	<20110714200144.GE26918@sigill.intra.peff.net>
	<69e0ad24-32b7-4e14-9492-6d0c3d653adf@email.android.com>
	<20110714203141.GA28548@sigill.intra.peff.net>
	<CA+55aFyDzr+SfgSzWMr9pQuQUXTw9mcjZ-00NZof74PKZzbGPA@mail.gmail.com>
	<m3fwm7aox1.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 15 11:17:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QheWF-0005tw-Bt
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jul 2011 11:17:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965398Ab1GOJRG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jul 2011 05:17:06 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:38963 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965364Ab1GOJRE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2011 05:17:04 -0400
Received: by vws1 with SMTP id 1so747330vws.19
        for <git@vger.kernel.org>; Fri, 15 Jul 2011 02:17:03 -0700 (PDT)
Received: by 10.52.89.211 with SMTP id bq19mr3756407vdb.22.1310721423482; Fri,
 15 Jul 2011 02:17:03 -0700 (PDT)
Received: by 10.220.185.204 with HTTP; Fri, 15 Jul 2011 02:17:03 -0700 (PDT)
X-Originating-IP: [192.165.213.18]
In-Reply-To: <m3fwm7aox1.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177194>

I strongly agree with Linus that the cache should not form part of the
solution to this problem, but could maybe be a later add-on, which
improved performance.

There is a possible improvement, which may remove the need for the
cache. It doesn't solve the issue of broken numbers, but I think the
key to that is just to ensure the traversal algorithm is
deterministic, stable, and immutable.

Firstly, I presume the generation number would not form part of the
SHA1 calculation? No? Cool.

When calculating a generation number by doing a traversal, would it
not be possible to update some, or all, commit objects touched, with
their generation numbers. Again, this would be expensive, but there
would possibly be even quicker gains than Linus's original proposal to
just add numbers to the new commit.

A compromise might be to only update some commits - notably those with
2 or more parents, so that both parents don't need to be traversed,
and possibly every nth commit (to give regular checkpoints that can be
utilised when traversing a branch). I would suggest commits with 2
children for the latter, but with my limited knowledge of the
implementation, I understand that Is more difficult to find.
Obviously, these numbers would only be pegged locally, and wouldn't by
synced on push, as they already exist on the far end. However, it
could be possible to run a process on a bare repo to shoot through and
peg commits, then at least new clones will be "well pegged"

Martin Long
UK
