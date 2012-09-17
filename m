From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv5] clone --single: limit the fetch refspec to fetched
 branch
Date: Mon, 17 Sep 2012 14:39:35 -0700
Message-ID: <7vlig8s50o.fsf@alter.siamese.dyndns.org>
References: <CACsJy8BGBwNp-oDsnB1QObrVLU54rtDmGGBF=Muww8ZJjfZScA@mail.gmail.com>
 <1347909706-22888-1-git-send-email-ralf.thielow@gmail.com>
 <7v8vc8v1wd.fsf@alter.siamese.dyndns.org>
 <CAN0XMOKCsjfG-DgV_rr99mYXHBSKryL1O46X+7r5ie+=2aKmmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: pclouds@gmail.com, git@vger.kernel.org
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 17 23:39:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDj2g-0006NV-O2
	for gcvg-git-2@plane.gmane.org; Mon, 17 Sep 2012 23:39:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752674Ab2IQVji (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 17:39:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51433 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754533Ab2IQVjh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 17:39:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 32F98932D;
	Mon, 17 Sep 2012 17:39:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=t9uTHnJw89rWol243trsbS9ObVU=; b=xDCKbL
	ovczbiwKRHmFaJzpWakJ8SHM0LwP18sBjJbku9dccU4u+xxCJlT7BmmLZUs7AoA1
	5nz3c+FZXYxTlmGCAZxVErYC17EYEGWTt36dH24SqC1CepdCICNPVhu2bFmd1adr
	0eNgBf+7UBAjWQbH99/J3pVSN64Oj4MdyQbS4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OB//BRJRQPQlFMut/FqsBnuzcxE7ZuWS
	gxtMa0r8zpIg7ger+CSMcLBTflVrna3M1Bu1WXdnr+TRIn/bmYXkq7FAZntHG6Do
	FRoYs4emFwZkFO13hnrjYwqGieXUJgLk3mIswyW1vVE7+EGZGFNH1VVsklVqYo0y
	zNag9w9oW2Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 20D09932C;
	Mon, 17 Sep 2012 17:39:37 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 78284932B; Mon, 17 Sep 2012
 17:39:36 -0400 (EDT)
In-Reply-To: <CAN0XMOKCsjfG-DgV_rr99mYXHBSKryL1O46X+7r5ie+=2aKmmA@mail.gmail.com> (Ralf
 Thielow's message of "Mon, 17 Sep 2012 23:04:09 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2D42E5EC-0110-11E2-B417-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205757>

Ralf Thielow <ralf.thielow@gmail.com> writes:

>>> - install correct refspec if the value of --branch is a tag (test added)
>>
>> What is the definition of "correct"?  I see the documentation says
>> "--branch can also take tags and treat them like detached HEAD", and
>> even though I _think_ allowing tags was a huge mistake, if we claim
>> we treat it like detached HEAD, we should do the same when coming up
>> with the refspec used for the follow-up "fetch".
>>
>
> This patch would install the refspec "+refs/tags/v1.7.10:refs/tags/v1.7.10",
> so we would do the same with the follow-up "fetch", not?
> This can be seen as "it's not a bug, it's a feature". Why not cloning a
> tag of a repo if someone just want to build a tag without having anything else.

Even though I did say I thought allowing tags was a huge mistake, I
was not suggesting to break existing users by making such a clone
into an error.

But the main point of the discussion is what should happen upon the
next "git fetch" in the repository, no?  Shouldn't the refspec be
the same as the case where you "clone --single" a repository whose
HEAD is detached at v1.7.10 in that example, instead of saying
"fetch the same tag over and over"?  After all that is the way I
expect that most people would read "treat them line detached HEAD"
in the documentation.  Subsequent "git fetch" would fetch from the
HEAD of the upstream just like a clone from a repository with a
detached HEAD.

The above is *not* a rhetorical question; I just do not think of a
sensible reason why we want a refspec that says "keep updating the
v1.7.10 tag, as it might change on the other end, and do not bother
what other things that happen in that upstream repository".  What
sensible workflow would benefit from such a refspec?
