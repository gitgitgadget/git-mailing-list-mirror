From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [Q] merging from one (kernel) stable to another?
Date: Mon, 30 Mar 2009 14:19:08 +0200
Message-ID: <49D0B8BC.2010405@viscovery.net>
References: <200903301024.08848.brian.foster@innova-card.com> <49D09207.9080407@op5.se> <49D0A133.80503@viscovery.net> <200903301358.48864.brian.foster@innova-card.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andreas Ericsson <ae@op5.se>,
	git mailing list <git@vger.kernel.org>
To: Brian Foster <brian.foster@innova-card.com>
X-From: git-owner@vger.kernel.org Mon Mar 30 14:21:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoGU5-00083f-0i
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 14:20:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755920AbZC3MSv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Mar 2009 08:18:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755602AbZC3MSt
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 08:18:49 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:45405 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754089AbZC3MSs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Mar 2009 08:18:48 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LoGRx-00063x-0v; Mon, 30 Mar 2009 14:18:45 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 484DE69F; Mon, 30 Mar 2009 14:18:44 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <200903301358.48864.brian.foster@innova-card.com>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115143>

Brian Foster schrieb:
> On Monday 30 March 2009 12:38:43 Johannes Sixt wrote:
>> Andreas Ericsson schrieb:
>>> A possibly better approach for you is to "git format-patch"
>>> your own changes and apply them to a clean 2.6.26.8 tree
>>> instead of trying to merge 2.6.26.8 into 2.6.21.
> [ I'm going from .21 to .26.8, so I think you've got that reversed? ]
>> After you have successfully done *that*, you know how the resulting
>> tree must look like, and you give it a tag, say "like-this".
>> If you really want to have a merge, then you can just repeat the
>> merge with your original branch, at which time you will get tons
>> of conflicts.  Now you just 'git checkout like-this -- .' and you
>> have all your conflicts resolved in the way you need them.
>=20
> Andreas & Hannes,
>=20
>   Thanks for the suggestion.  I'll have to experiment,
>  but off-the-top-of-my-head, I think I do want a merge,
>  so that it's easier to track the history of individual
>  local changes.  Having said that, I'm not entirely sure
>  I follow your suggestions.  What I think you mean is:
>=20
>   (1)  Create a patch which is all (local) changes
>          (n=C3=A9e diffs) from linux-mips.21 to our.21;
>   (2)  Checkout linux-mips.26.8 (e.g.);
>   (3)  Apply the patch created in (1), above;

format-patch creates a patch series. You apply the whole series, e.g. w=
ith
'git am'. But for this workflow you could also just create a single pat=
ch
and apply it to linux-mips.26.8, just as you wrote.

The important point is that you forge this tree into the shape that you
finally want to have in the merge (that you will make later). At this
point you only have to deal with conflicts and regressions that arise f=
rom
your own changes, which makes your life much easier than if you also ha=
d
to deal with conflicts that are outside your own changes.

>   (4)  Tag the result `like-this';
>   (5)  Checkout our.21;  and
>   (6)  Merge with `like-this'.

No, you merge with linux-mips.26.8. This will again give you a lot of
conflicts. But you do

   (7) git checkout like-this -- .

that is, you overwrite the merge result (that has conflicts) with your
known-good tree called "like-this". This resolves all conflicts in the =
way
that you wanted them.

-- Hannes
