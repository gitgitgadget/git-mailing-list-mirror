From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] commit: teach --gpg-sign option
Date: Thu, 06 Oct 2011 14:29:00 -0700
Message-ID: <7v8voxzu5f.fsf@alter.siamese.dyndns.org>
References: <7vaa9f3pk8.fsf@alter.siamese.dyndns.org>
 <CAJo=hJvWbjEM9E5AjPHgmQ=eY8xf=Q=xtukeu2Ur7auUqeabDg@mail.gmail.com>
 <20111006171107.GA10973@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 06 23:29:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBvV8-0003DH-9D
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 23:29:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756964Ab1JFV3F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Oct 2011 17:29:05 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37100 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755602Ab1JFV3E (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2011 17:29:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 29DC7691F;
	Thu,  6 Oct 2011 17:29:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pNUJdG1Eu6NhsWfcvDXLMOoOjrA=; b=q/C0jA
	XiGZwMckqhDBeY1qHok4CWsMT5QrcY2B8GFLYwEkp65qFGIyqw3dMpVMApTtkWOm
	uYYrNDvg+4dav60NA+yTPA1C3KuK1L6qIrs7oQM6er3xgtxdGssM2vTs4rZ5kASZ
	xC49mxO8044cGVo4lk0i8xW694QZzyn73N7Ts=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=x6RMP8zvWVVZcKJEUx0lLaM9lXuR++YO
	p1UHtXYWVI9w7j+mFLTMDJRX273/fIQJXwxr9uE1klCbxGVFhUY1UR25TyZYgN8k
	zc/wYgUhCZeMBs8yLnmVu0X5skLJcmEfkP0m00D7UohayfJkBcebkEp8Jvk41iVq
	hzj650TnA9w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2158B691E;
	Thu,  6 Oct 2011 17:29:03 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5EFAE691A; Thu,  6 Oct 2011
 17:29:02 -0400 (EDT)
In-Reply-To: <20111006171107.GA10973@elie> (Jonathan Nieder's message of
 "Thu, 6 Oct 2011 12:11:07 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 35F7B7F4-F062-11E0-BE3D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183038>

Jonathan Nieder <jrnieder@gmail.com> writes:

>> I like this approach better than the prior "push certificate" idea.
>> The signature information is part of the history graph
>
> I probably missed some earlier discussion (so please forgive me this),

Heh, you are not forgiven when the original message has a clear pointer to
the previous discussion ;-).

> but how is it intended to be used?  Would projects
>
>  a. require as a matter of policy that all commits be signed

Possible. Personally I would _not_ advise it but they can send in a patch
to add a configuration or two if they do want to run their project that
way.

>  b. just sign releases as usual, but as commits in the history graph
>     instead of tags

This is not meant to replace tags that is attached after the fact. If
anything...

>  c. sign the occasional especially interesting commit

...with the definition of "interesting" being "this is tonight's tip of
branch Linus is pushing out between releases", "I shortly will ask Linus
to pull from the history leading up to this commit", etc., this is the
primary scenario I personally envision the feature would be used in.
Without having to have "nightly" signed tags that clutter the tag
namespace, we can gain more confidence in the integrity of the history
between officially tagged release points that may be a few months apart,
depending on projects.

> ... How
> does this relate to the "push certificate" use case, which seemed to
> be mostly about authenticating published branch tips with signatures
> that are not necessarily important in the long term?

To the upstream project whose participants are signing its history, these
publish points may not be important in the longer term, but for downstream
consumers that have to fork from an in-between point for the next embedded
device release track, it serves the same purpose as push certificates and
is equally important: it allows them to limit the length of near-tip
history that might have been tampered that needs to be validated. If the
downstream consumers fork only from a signed commit point, they only need
to audit their own history without worrying about imported stuff after
incident like what k.org had recently.

I am also somewhat disturbed by "have to sign when committing, long before
I am confident that this is worth pushing" aspect of this approach, but I
do not think it would be much of an issue in practice.

 - If you are only pubishing one independent branch, it is just the matter
   of either "commit --amend --gpg-sign" or "commit --allow-empty --gpg-sign"
   before you push;

 - If you are publishing multiple related branches (e.g. maint, master,
   next) like I do, and want to correct a mistake discovered at a lower
   branch (e.g. master) after it has been already merged in higher
   branches (e.g. next), you have to either amend the tip of the lower
   branch and rebuild the higher branches, or queue a fix-up to the tip of
   the lower branch and merge the result to the higher branches _anyway_,
   before you push.
