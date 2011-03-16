From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git stash: add --index-only, or --keep-index should not stash
 index?
Date: Wed, 16 Mar 2011 15:36:07 -0700
Message-ID: <7vsjum66co.fsf@alter.siamese.dyndns.org>
References: <4D7A6E37.8080104@gmail.com> <4D7E9502.4060502@gmail.com>
 <AANLkTikU0xCBzDya3vyfoH4PwzmRi6qmotxNoVc61b=W@mail.gmail.com>
 <4D80F9F4.9090304@gmail.com>
 <AANLkTing5ZQKF4PXtX1peynx2uuc8s+aeBP=fbJWXvWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Neal Kreitzinger <nkreitzinger@gmail.com>, git@vger.kernel.org
To: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 16 23:36:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzzKJ-0004nY-G8
	for gcvg-git-2@lo.gmane.org; Wed, 16 Mar 2011 23:36:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751272Ab1CPWgT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2011 18:36:19 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:42128 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751688Ab1CPWgS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2011 18:36:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id F25F23D75;
	Wed, 16 Mar 2011 18:37:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vY/UCC8Q/MRDgJCj3USOpso6zuw=; b=Q6oRgm
	+zbmSi/F/RtnfVytWSJuvgzrwJ+JeUFd4ERAobTyU/miqGq8GiZhR3CzN6J8xgkN
	sTBSJVJq29OktLpkg5PLvd888fznPD96io2FuaqkBNsAPGh5mlquVZPVWY8RG4/V
	Bl8YmNlP/ul+q7uxH1261TmX4JSFTeTuxA9s8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Tog7lRoLAdvWRhdxXx95CWwg3O0ucVL/
	Ope5d+YGHQdzmAyiMuRT8jWmKQxE82JhgqY+s4HnGnHyKbbpGeMNoMs3/EhJSSV+
	y+mpEkYaA713LbO/we9u3Ijb2iKlgQdTa4Sh2MYupBa9JcNb/dEdvIlUAzxUVdpU
	vRd06FoGboI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C18753D6E;
	Wed, 16 Mar 2011 18:37:46 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9065A3D68; Wed, 16 Mar 2011
 18:37:42 -0400 (EDT)
In-Reply-To: <AANLkTing5ZQKF4PXtX1peynx2uuc8s+aeBP=fbJWXvWw@mail.gmail.com>
 (Piotr Krukowiecki's message of "Wed, 16 Mar 2011 22:37:01 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 03F89D0C-501E-11E0-AE2A-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169203>

Piotr Krukowiecki <piotr.krukowiecki@gmail.com> writes:

> How about following workflow?
>
>    # ... hack hack hack ...
>    $ git add --patch foo
>    $ git stash save --keep-index
>    $ build/test first part         # note I have removed the "edit" part
>
> There are two possibilities now:
>
> 1. You're happy with the result - you commit your changes:
>
>    $ git commit -m 'First part'
>    $ git stash pop
>
> Important: there will be no conflicts in this case, and committed
> changes won't be reverted/applied/conflicted, because you have
> not edited them!

Exactly; I won't take _any_ credit for --keep-index (I wasn't involved
deeply in "git stash"), but the above matches my understanding of its
primary intended use case.  For this to work well, the stash should record
the index that is going to be committed and the work tree you had before
stashing.

> 2. You're not happy with the result - maybe something does not
> build and you need to stage more changes, or maybe fix is not
> working yet.
>
> You should first pop your stashed changes! This way you'll avoid
> conflicts, you'll be able to stage/modify other changes. So the
> next steps are like this:
>
>    $ git stash pop
>    $ edit/add -p
>    $ git stash save --keep-index
>
> and now you're back to the "build/test" part.

Yes.
