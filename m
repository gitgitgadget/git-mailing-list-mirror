From: Junio C Hamano <gitster@pobox.com>
Subject: Re: first parent, commit graph layout, and pull merge direction
Date: Fri, 24 May 2013 12:23:56 -0700
Message-ID: <7vmwrk89mb.fsf@alter.siamese.dyndns.org>
References: <20130522115042.GA20649@inner.h.apk.li>
	<7v4ndukhx0.fsf@alter.siamese.dyndns.org>
	<20130523090657.GB23933@inner.h.apk.li>
	<CAEBDL5WqYPYnU=YoCa2gMzcJCxeNbFmFgfWnHh=+HuouXLLsxg@mail.gmail.com>
	<20130523102959.GP9448@inner.h.apk.li>
	<20130523110839.GT27005@serenity.lan>
	<7vd2shheic.fsf@alter.siamese.dyndns.org>
	<20130524171110.GB9448@inner.h.apk.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Keeping <john@keeping.me.uk>,
	John Szakmeister <john@szakmeister.net>, git@vger.kernel.org
To: Andreas Krey <a.krey@gmx.de>
X-From: git-owner@vger.kernel.org Fri May 24 21:24:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ufxay-00042j-3d
	for gcvg-git-2@plane.gmane.org; Fri, 24 May 2013 21:24:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757360Ab3EXTYB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 15:24:01 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46576 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757327Ab3EXTYA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 15:24:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9E2A61F57F;
	Fri, 24 May 2013 19:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BrskUGGD60ZS2Y4Djns4XHf0c3A=; b=Gw5Ll4
	StoUNdiny+23JohiPdjGuBpX+zkYo9hLPwPviPmazfin9kNv+u+mfswmRmmh5fxy
	J7pE+PMz2wVvROlfuI4UXXnkjXt2dq3NUq4IXoxWKg6WgRtRWbdBlurGe1a7x6XW
	bt3DtgpFjyrFPHEE5p6h5fUI6NziLYgaQQJnk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jMXiOdc1fTdobDQRwN218GoTXGDw3eqY
	GMj6mjIG6uQW6UxFE0mYWH5KWiWwrOnLFjlMaMt1vl//8aFYWC+bIpO6/IjfpEmF
	N9qOeE/dPhF/qrFHcwxviUuv6dqq1sKOYCTpebww6ZigFY3jwdGYv0VL4RLCg6gr
	RqFiuGmh7L8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 94BEB1F57E;
	Fri, 24 May 2013 19:23:59 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6891D1F56C;
	Fri, 24 May 2013 19:23:58 +0000 (UTC)
In-Reply-To: <20130524171110.GB9448@inner.h.apk.li> (Andreas Krey's message of
	"Fri, 24 May 2013 19:11:10 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7B753886-C4A7-11E2-8C9A-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225397>

Andreas Krey <a.krey@gmx.de> writes:

> On Thu, 23 May 2013 09:01:15 +0000, Junio C Hamano wrote:
> ...
>> Instead of having a nice "these six commits marked as 'x' were done
>> on a branch forked some time ago, to address only this one issue and
>> to address it fully" history that explains how these commits were
>> related and these commits are the full solution to a single issue:
>> 
>>       x---x---x---x---x---x
>>      /                     \
>>  ---o---o---o---o---o---o---M---o---o---...
>> 
>> they end up with something like this, even with the "flip the heads
>> of a merge" option, by pulling too often:
>> 
>>       x---x   x---x---x   x
>>      /     \ /         \ / \
>>  ---o---o---M---o---o---M---M---o---o---...
>
> Wouldn't that be (you don't want to put your work back into master before
> it's done) the following?
>
>        x---x---M---x---x---M--x
>       /       /           /    \
>   ---o---o---M---o---o---M--o---M---o---o---...

That is what you would get if you "pull from my upstream" with the
current software.

And that is what triggered this discussion thread in which some
people said that they do not want that shape of the history.

At the leftmost merge M you drew on the upper line (i.e. your
topic), the merge pulls in other's commits that are unrelated to
each other as if it were a meaningful group of commits on a side
branch.  They want to see the merge going other way around, pulling
your work done on a side branch, integrating into the mainline.

The second illustration you are commenting on were done to explain
why such a "when pulling from my upstream, I want the order of
parents swapped, so that mainline appears as the first parent" is
not solving the whole issue.  The time series would go more like
this:

(1) While you were working on two 'x's, others have worked to
    advance the mainline:

       x---x  Your 'master'
      /
  ---o---o  Mainline


(2) You cannot push without losing others work, so you pull, but in
    order to avoid the "others work on mixed on a single side
    branch" issue, you use the fictional "flip heads of a merge"
    option, and push the result out.  That becomes the tip of the
    mainline:

       x---x
      /     \
  ---o---o---M

(3) Then you keep working to build more commits on top. 

       x---x   x---x---x
      /     \ /
  ---o---o---M

(4) And others also keep working.

       x---x   x---x---x
      /     \ /
  ---o---o---M---o---o
