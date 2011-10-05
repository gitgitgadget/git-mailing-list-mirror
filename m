From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] Add multiple workdir support to branch/checkout
Date: Wed, 05 Oct 2011 09:46:07 -0700
Message-ID: <7vpqib8jzk.fsf@alter.siamese.dyndns.org>
References: <1317786204-57335-1-git-send-email-jaysoffian@gmail.com>
 <CACsJy8AqYq+YF+rvUp=BBeFUAtUz783iF2jbUp3fO58yLp9ptQ@mail.gmail.com>
 <CAG+J_DygQTD5ibco=-NOiKg0BLgBGFJnvV8zPyhngC2iZv_H8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 05 18:46:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBUbo-0007lY-9D
	for gcvg-git-2@lo.gmane.org; Wed, 05 Oct 2011 18:46:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934999Ab1JEQqL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Oct 2011 12:46:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:32870 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934922Ab1JEQqK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Oct 2011 12:46:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E4BDA401B;
	Wed,  5 Oct 2011 12:46:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Fdi2KsL9fCH0dxk34QxKrQWgTJM=; b=XlrVyX
	SJZfTKoLaEMfB51XYRHG33ypVc6Qdkv0AOQje0U04PRN2ZYCphh7nS3y2Fz2kDik
	VugL5Ou7E4joorJuSe8pzfnQlC1GkzXlsIbaFM6RB55ho5oSJBHCbtuOUwD6COqE
	zU2wq9rviW/O4GGRs9YTrfP2i5GZyZ87zyAK0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jNvEpfORs9eXGmjja7PrKm75blS9+E/D
	B6zDSsrnIqLRWscl7NXFt394RV8/y2M7CyQuvG5czDJKR1qAAYI8nWxOKsrlWj0A
	/iaqLIfQgKL+7IJN5yNDy5N41+zb7kCOi2xEn7cj0wACnAV//4Thqf80HeIP6kG/
	ILsoA84QB0M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DC3E84019;
	Wed,  5 Oct 2011 12:46:09 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 41D4E4016; Wed,  5 Oct 2011
 12:46:09 -0400 (EDT)
In-Reply-To: <CAG+J_DygQTD5ibco=-NOiKg0BLgBGFJnvV8zPyhngC2iZv_H8g@mail.gmail.com> (Jay
 Soffian's message of "Wed, 5 Oct 2011 09:11:47 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 86C98730-EF71-11E0-BB20-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182860>

Jay Soffian <jaysoffian@gmail.com> writes:

> On Wed, Oct 5, 2011 at 12:02 AM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
>> Could you please consider a more generic approach? What I have in mind
>> is a mechanism to "lock" a branch, so that only commands that have the
>> key can update it.
>>
>> So instead of branch.<name>.checkout, I would have something like
>> branch.<name>.locked = <key>, where <key> is just a string. Only
>> commands that provide the matching <key> are allowed to update the
>> branch. In checkout case, <key> could be "checkout: worktree".
>
> In this case, each workdir needs its own key, so I'd have to record
> the key somewhere, unless you meant using a key of "checkout:
> </path/to/workdir>".

That actually is how I read his message.

I do not think "we cannot off the top of our heads think of the reason
other than the branch is checked out that we might want to forbid its
update" is a very good excuse to cast the word "checkout" in the UI; you
would paint yourself in a difficult corner that you have to expend more
energy to get out of by later adding backward compatibility support.

I think "switch_branches()" that updates HEAD to point at a local branch
is one good place to lock the branch, but I do not know if it is a good
idea to hook the check into the codepaths for deletion of the branch using
"branch -[dD]" and check-out of the branch using "checkout $branch". I
wonder if it makes sense to add the "checking" hook into much lower level
in the callchain, perhaps delete_ref(), rename_ref() and update_ref() to
catch attempts to update "your" current branch by other people. For that
matter, instead of switch_branches(), would it make more sense to add this
lock/unlock logic to symbolic_ref() that repoints HEAD to other branch?
