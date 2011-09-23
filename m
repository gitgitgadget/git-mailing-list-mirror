From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's The Right Way to Do This?
Date: Fri, 23 Sep 2011 11:13:06 -0700
Message-ID: <7vr537unyl.fsf@alter.siamese.dyndns.org>
References: <loom.20110923T064720-366@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jon Forrest <nobozo@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 23 20:13:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R7AFQ-0006k4-0W
	for gcvg-git-2@lo.gmane.org; Fri, 23 Sep 2011 20:13:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750981Ab1IWSNM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Sep 2011 14:13:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58095 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750736Ab1IWSNJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Sep 2011 14:13:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 014076598;
	Fri, 23 Sep 2011 14:13:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vC5DrlXc24GjBKhkeVHdX+A8o5M=; b=ks9/Or
	9y0GHF2/7SkV5SwQGIS+QkDpptaGt5TXh3TH88dUMYip1VJIuuSj/wXgjzUvfZmT
	y1l18apS8oOS3m3kbkJLcjAl1NvXQKNCBSZ0k8G3Ym5wEBvckSmhPrdPmQfx86AV
	SesHKob0JwEIvRXEIBVei4ujpkAG4IWcyDcxM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=adCMXCMqTh5GEcrUU+j5/gSfVVkr2gDY
	ElfO7g7Esp1exhlwr/dVfjTVBtDnIcc5/UgrtWT1zsiI6UzJtyb4MenwBDhvHElX
	b0NLUQEM4a77MEBzfeaJtmq3ug6m9usKmfl/flXHcoT5GB+M6dE4lWcWHgSbfq6t
	7e36/hdzPpo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ED9526597;
	Fri, 23 Sep 2011 14:13:08 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3AB216595; Fri, 23 Sep 2011
 14:13:08 -0400 (EDT)
In-Reply-To: <loom.20110923T064720-366@post.gmane.org> (Jon Forrest's message
 of "Fri, 23 Sep 2011 04:48:36 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B09431FC-E60F-11E0-BC08-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181983>

Jon Forrest <nobozo@gmail.com> writes:

> I'm just now starting to use git for more than trivial things.
> Today I got myself in trouble. Here's what happened:
>
> 1) I pulled the master branch from the IT repository from our
> main git server.
>
> 2) I created a branch from this called "J" and started making changes.
>
> 3) Other people pulled master from IT and then pushed changes back.
>
> 4) I merged J with my master branch.
>
> 5) I tried pushing my master back to origin but this failed with
> the usual message saying I first needed to pull from origin.
> So, I pulled and then pushed. This worked.
>
> 6) On another server where I was going to use my changes I pulled
> master from IT.

Up to this point you are doing perfectly fine as far as I can tell.

> 6) It turned out that my changes were incorrect. So, I tried to revert
> using various methods I found by googling "git revert". What happened
> was that when I tried to revert back to the commit before the one I
> made,...

Now, in git you do not "revert back TO the commit".  You could reset back
to the commit but that is to discard everything that is done since that
commit.

Imagine this history (time flows from left to right).

At point 4, 'master' in your working repository is at M, and you haven't
seen others' work 'o' yet:

    ---M---o---o---o (others' work)
        \
         x---y---z (your work on J branch)

You merge your work your master and then your 'master' now points at 'z'.

If you push and replace 'master' at the central repository with your
'master', others' work 'o' will be lost. So you pulled in point 5 to make
the history look like this:

    ---M---o---o---o (others' work)
        \           \
         x---y---z---X

You pulled to grab these 'o' commits, and made a merge with your master
(now at J) to create 'X', and then pushed it as 'master' at the central
repository.

Time passes and there may be more changes on top of 'X' now and the
current tip of the shared 'master' may be 'A'.

    ---M---o---o---o (others' work)
        \           \
         x---y---z---X---o---o---A

Even if the changes 'x', 'y', and 'z' later turns out to be unwanted, you
do not want discard others' work 'o'. Rewinding the history to make the
'master' point at 'M' is not what you want.

Instead, you would make commits that revert the effect of them on top of
the current history. That is what "git revert" does.


    ---M---o---o---o (others' work)
        \           \
         x---y---z---X---o---o---A-(z)-(y)-(x)

That is, on top of 'A', you would run "git revert z" to create an "anti-z"
commit "(z)" to cancel the effect of 'z', and do the same for y and x, to
eradicate them.

Another possibility is to revert the merge 'X', but I'll leave it as an
advanced exercise to the readers.
