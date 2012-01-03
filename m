From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Submodules always use a relative path to gitdir
Date: Tue, 03 Jan 2012 11:58:22 -0800
Message-ID: <7vobuktv6p.fsf@alter.siamese.dyndns.org>
References: <1325192426-10103-1-git-send-email-antony.male@gmail.com>
 <7vsjk3vw67.fsf@alter.siamese.dyndns.org>
 <CABURp0pdvf9Eo_pM2UCYUBANOJOGON6pQS-SXuCWQE=s2XNOfQ@mail.gmail.com>
 <7vlipovd4n.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Antony Male <antony.male@gmail.com>, git@vger.kernel.org,
	iveqy@iveqy.com
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 03 20:58:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RiAVC-0007Wx-Jd
	for gcvg-git-2@lo.gmane.org; Tue, 03 Jan 2012 20:58:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752502Ab2ACT60 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jan 2012 14:58:26 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37263 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751976Ab2ACT6Z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jan 2012 14:58:25 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A892D5F12;
	Tue,  3 Jan 2012 14:58:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=d6P82dLzlugVMqTrx9DP47ehvTs=; b=sAoXxT
	OTpJ1IPc4VQrQ8J0/AdZQ2EiZ99m/4JIVwDroheSG5YmdIQXSvnNWLd240F+z+h+
	b0Bu5XRzAzzmrHwbU6E6WQrfIeljT+50FM/8nFe3LYTP3c5oJr+OEKGEIHDSVU4T
	PIfeT5tBACGLkcqaXZ4GxJTPw9Z9y9yyL+ubI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=i1g85xURdGW89naLSjzeR4Ck8dOnqhTI
	hy5ygKe3nf5Pr0lgWerG+pNt41Ff9RN/hP7+4A6SWboxa3T5mJ0HhPM7R7zxxGB5
	gyMtr5DOQKV2YrQwFCtNlXnheG9IriKnnKJNysuEB2LvAL5N5mjoFC9N/niWwkos
	nlCUwSsBpJ0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9E1865F11;
	Tue,  3 Jan 2012 14:58:24 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 324475F10; Tue,  3 Jan 2012
 14:58:24 -0500 (EST)
In-Reply-To: <7vlipovd4n.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 03 Jan 2012 10:45:28 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4B528A92-3645-11E1-80BE-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187884>

Junio C Hamano <gitster@pobox.com> writes:

> ...
> And the extent of the design of
>
>     echo "gitdir: $there" >.git && git config core.worktree "$(pwd)"
>
> is to work with the locations of these two places as they are set up.
> Moving one or the other or both may or may not work without adjusting to
> what you did. If you "mv $there $newlocation" (the repository) behind
> Git's back, you may need to update .git to point at the new location of
> the repository.  If you move your working tree woth "mv", you may need to
> update core.worktree to point at the new location of the working tree.
> And until you do so things may not work. That is why we do not explicitly
> say "you can move them to arbitrary places without telling git and things
> will work"---because that is not the case.

Just to avoid any misunderstanding, I still agree with the overall goal of
the original patch to allow moving the whole superproject tree, including
its submodule repositories in its .git/modules/, and the working trees of
itself and its submodules. It is a narrow special case with a very well
defined relative relationships between the working tree of submodules and
the repositories that control them, and having them point to each other
with relative paths will make any post-move adjustments unnecessary, unlike
more general unconstrained uses of the "gitdir: $there" mechanism.
