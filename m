From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Add bad-branch-first option for git-bisect
Date: Mon, 24 Jan 2011 12:04:01 -0800
Message-ID: <7v8vyam5la.fsf@alter.siamese.dyndns.org>
References: <4D3CDDF9.6080405@intel.com>
 <AANLkTimUkv9+g_+wFcyGhwMjE9zYAKjMn32GL-WOVmoe@mail.gmail.com>
 <4D3D54D3.7040801@intel.com> <4D3D5989.50903@viscovery.net>
 <4D3D5CE5.4050108@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <christian.couder@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	"apenwarr\@gmail.com" <apenwarr@gmail.com>
To: Shuang He <shuang.he@intel.com>
X-From: git-owner@vger.kernel.org Mon Jan 24 21:04:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PhSeH-00018T-6r
	for gcvg-git-2@lo.gmane.org; Mon, 24 Jan 2011 21:04:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751719Ab1AXUEU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jan 2011 15:04:20 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:58314 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751426Ab1AXUET (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jan 2011 15:04:19 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 641D831BA;
	Mon, 24 Jan 2011 15:05:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jEv7wEKRn2l5HurCaH+L+9l1EWo=; b=fFANm7
	tcSyGBs9v0bWFOE4FRcyTomVo9kRt/6ZCbVNSChAZwtDnOcgwQ9aKnrTAVXflD2x
	CD3AOg41BAUhfmEeSHhbtukHYCIftibQj/BblH7Fy8Qa99o1NC0ctAuFCdmwpF1n
	8RCQa75ME1KryQW0ZelZhL54dpuXIelBiGPb8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hCvI8J7Acubomv04GxKeQFxqT5r+8X1t
	pWmM8y/WkBh5pLlpaJNGOxcGSyTeJGyluc3sbWbOIwKItbfOv/2HWp1Wv/Bprsul
	Mi2Lp1TUrAPcbMFjUCYSM+9zMiE6NQLWZQL7F/ajdlrvMZ8LLmCB8Xg5IA45SA3G
	oBdH79TnyWY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E2FA931B9;
	Mon, 24 Jan 2011 15:04:58 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0016C31B5; Mon, 24 Jan 2011
 15:04:51 -0500 (EST)
In-Reply-To: <4D3D5CE5.4050108@intel.com> (Shuang He's message of "Mon\, 24
 Jan 2011 19\:05\:09 +0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3874C8D6-27F5-11E0-8507-BC4EF3E828EC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165454>

Shuang He <shuang.he@intel.com> writes:

> If A is bad commit, and C fixed it, and then F is bad again,
>
> A ->  B ->  C ->  D ->  E ->  F ->  G ->  H   (master)
>   \                    \      /
>     a  ->  b... c ->  d ->  e->f  (feature 1)
>
> Start with H as bad commit, and D as good commit, it's possible git-bisect would jump to c, and it will lead to wrong direction
>
> If bad-branch-first is used, it would be:
> 1. first round found F
> 2. end

It is unclear from the way you drew the picture if "F" is supposed to be a
merge of "E" and "f", but I'd assume that it is.

So what you are saying in 1. is "skip from H until you hit a first merge
(without testing any intermediate commit), find F and stop to check it,
and find that it is broken".

What makes you decide "2. end"?  The fact that both of its parents "E" and
"f" are Ok?  IOW, it won't be "2. end" if one of the parents of the merge
is broken?

What if there is _no_ merge from a side branch but there were breakages in
A (fixed in C) and then F in your original picture, i.e.

  A---B---C---D---E---F---G---H (broken)
  x       o           x       

and you are hunting for the bug starting from H?  How does your algorithm
help?  I grossed over the linear part by saying "skip from H until you hit
a first merge", but in general, what is your plan to handle linear part of
the history?

A totally unacceptable answer is "It does not help linear case, but it
helps when there are merges".  The a-thru-f side branch in your picture,
or any "culprit side branch that was merged" your algorithm finds in
general, would eventually have a linear segment, and having x-o-x in the
history fundmentally breaks "bisect"---your band-aid will not help.

The whole idea behind using "bisect" to gain efficiency in isolating the
issue depends on "Once you see a Good commit, you do not have to search
beyond its ancestors", as it is to look for a single breakage that
persists to the "Bad" commit you give, and as far as "bisect" is
concerned, the breakage at A in your example is an unrelated breakage that
did not persist through the history to the "Bad" commit H.
