From: Junio C Hamano <gitster@pobox.com>
Subject: Re: A failing attempt to use Git in a centralized environment
Date: Mon, 28 Apr 2014 11:41:43 -0700
Message-ID: <xmqqoazlqot4.fsf@gitster.dls.corp.google.com>
References: <4ay6w9i74cygt6ii1b0db7wg.1398433713382@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Marat Radchenko <marat@slonopotamus.org>
X-From: git-owner@vger.kernel.org Mon Apr 28 21:29:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WerEg-0003DE-UW
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 21:29:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932614AbaD1TZX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 15:25:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40465 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932483AbaD1TZM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 15:25:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A76A281C83;
	Mon, 28 Apr 2014 14:42:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GfnpYQ3kPAdKa0SN9BfYjOE0la0=; b=mb+yBp
	/ofbKljzqx4+yrOQ1kVkGeCtmc/bXsfKZv5K+3igwfSJ0LCKdI7otoRNzYf33GxC
	0x4U2XWthBGnsu+vZ9sG3TZtPRYNz1rtSIqFDx8eyWDyYBJ6SjRFVU87GJfeCtyU
	VLBGIdvxIbs5InVqVg9WUzmLzbNCxavxRGRMc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=f9JbUM3Clhzixq6JiXxVnl8IFBce7PmT
	xB9JJTm5aeS01mJEJuesP8PcazBSYA3dDHjf6suuYoxK1p6tMhCyZeXzwBJpVhR7
	pan9sh5IFQ3GqwULA30ncXatZBFEAfEkJNSGMdNchJvwGW3VePh1+EclEDVBx4z4
	hG33a5TTnmI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8B29481C82;
	Mon, 28 Apr 2014 14:42:17 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7734181C4D;
	Mon, 28 Apr 2014 14:41:45 -0400 (EDT)
In-Reply-To: <4ay6w9i74cygt6ii1b0db7wg.1398433713382@email.android.com> (Marat
	Radchenko's message of "Mon, 28 Apr 2014 10:29:07 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: BFBFAAF4-CF04-11E3-B7A3-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247408>

Marat Radchenko <marat@slonopotamus.org> writes:

> Problem #1: TortoiseGit GUI windows for common tasks have a heck
> lots of controls that a common Git user will never need.

Do people around TortoiseGit lurk on this list?  Otherwise this may
not be something we can help you with here.

> Problem #2 occured the first day we started using Git on real
> project. It is explained in detail in older post to Git ML [3]. I
> call it "swapped/reverse merge problem".
>
> In short:
> 1. Hack, hack, hack
> 2. Commit
> 3. Push, woops, reject (non-ff)
> 4. Pull
> 5. Push
>
> The root of evil is step #4 that creates a merge commit with
> "swapped" parents.

Yes, this is a real issue, and I do not mind seeing a patch to
improve the situation (there may be different approaches, and one
random approach somebody takes may not necessarily be a good way to
improve the situation though).

 - Perhaps by allowing an option to tell the "pull" at the fourth
   step to record swapped parents in the merge?

 - Perhaps in step #3, stop suggesting to "pull first" and instead
   tell them to "fetch upstream, rebase your work on it and then
   push"?

 - Extending on the second one, wrap a large part of the procedure
   in a single handy wrapper "git update" or something, whose point
   is to "update your work to be mergeable and pushable"?

> Problem #3: on conflicts, user ends up with a working copy that
> marks all remote-changed files as modified. Luckily, nobody has
> problems with conflict resolution process, it's just confusing to
> see changes other way round.

If we flip the resolution process to "apply/merge your work to the
updated upstream (i.e. the topic of your problem #2 above)", that
"other way round" issue will disappear, no?
>
> Problem #4: when conflict happens during rebase, mergetool shows
> user own changes as "theirs" and remote changes as "mine". And
> believe me, explaining this to users doesn't increase their
> willingness to adopt Git.

Likewise.
