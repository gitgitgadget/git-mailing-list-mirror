From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What should "git fetch origin +next" should do?
Date: Mon, 17 Oct 2011 10:09:26 -0700
Message-ID: <7v8vojo88p.fsf@alter.siamese.dyndns.org>
References: <7v7h45s8rh.fsf@alter.siamese.dyndns.org>
 <4E9C3D27.3060504@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Mon Oct 17 19:09:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFqgx-0006bZ-Jj
	for gcvg-git-2@lo.gmane.org; Mon, 17 Oct 2011 19:09:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756477Ab1JQRJa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Oct 2011 13:09:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54029 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753476Ab1JQRJ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Oct 2011 13:09:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B39F558EF;
	Mon, 17 Oct 2011 13:09:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WUM+O5adSRPQ5bSBdfz0TqMkYKg=; b=IACPgD
	6J2/zCvDuDB9TPy7wh1NqCzejVJSmpycP+pkJjEmjBIpz/9w9AdUFfD6NIVwid/V
	2l5VgIVd+qcQENHmGgDDXVQnBKaP7orXB+xtuP0MMZie5SKAVy9mI6u7lv7GHa1C
	mv0Xw8p/0DzvM2s6pUPoshLcBTwdpNXRz1y0c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=s77aBrQHa73UOXhQSEJsUVEJKrR1Xw4i
	ZnNtMzDI3lzjjRRWhYmIbEz6lTYC/YO+i6MOMxfybzm2Ew0FUMNv45Cw34hluyRl
	amXaQjSOPdV/+hNtMRd15y0ai515nqHxJyyz/KMJNr4XWkrehj6NW5M9ZiTK6Wb3
	xU7KKI8LYjs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ABCD358EE;
	Mon, 17 Oct 2011 13:09:28 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0354858EC; Mon, 17 Oct 2011
 13:09:27 -0400 (EDT)
In-Reply-To: <4E9C3D27.3060504@xiplink.com> (Marc Branchaud's message of
 "Mon, 17 Oct 2011 10:35:19 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C575D82E-F8E2-11E0-BA78-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183798>

Marc Branchaud <marcnarc@xiplink.com> writes:

> On 11-10-16 03:20 AM, Junio C Hamano wrote:
>> As some might know, I use the traditional non-separate-remotes layout in
>> many of my working trees. I am old fashioned.
>
> Being hip and modern :) I use separate remote refspecs.  As I read your post,
> I kept thinking that it makes no sense for fetch to ever update local refs
> and that you're a victim of your stodgy old ways.

Imagine a scenario where I run the same "git fetch origin +next" in a
repository with separate remotes layout, expecting that the remote
tracking branch refs/remotes/origin/next to be force updated. The fetched
value will be stored only in FETCH_HEAD, and I would feel exactly the same
minor irritation.

In other words, the issue does not have anything to do with the layout.
My mention of layout variants was only to clarify that the ref to be force
updated on the local side is determined by the suggested behaviours (2)
and (3) based on the fetch refspec (i.e. refs/heads/next in the
traditional layout, refs/remotes/origin/next in the separate remotes
layout).

This is a tangent but we have seen in the past some new people wonder why
their configured remote tracking refs are not updated when they do

	$ git fetch origin next

This is a variant without '+', and in such a case, in addition to list the
fetched tip in FETCH_HEAD, it might be more natural for the user to expect
that the usual remote tracking branch update to happen.  And I suspect
that the suggested semantics (2) might better match what the users expect
in general.

That is, when fetching from a remote that has configured fetch refspecs,
colon-less refspecs are given from the command line, are first matched
against the configured fetch refspecs for the remote, and used to update
the remote tracking branches. IOW, with the separate remote layout fetch
refspec, the above command line is re-written to

	$ git fetch origin refs/heads/next:refs/remotes/origin/next

and leaves the fetched tip of 'next' in FETCH_HEAD and updates the remote
tracking branch; nothing else is fetched.


And if we apply the '+' prefix in this context, as the natural
consequence, my original example would be rewritten to:

	$ git fetch origin +refs/heads/next:refs/remotes/origin/next

in a repository with the separate remote layout fetch refspec, and in a
repository with the non-separate remote layout, it would be rewritten to:

	$ git fetch origin +refs/heads/next:refs/heads/next

Historically, we never used configured fetch refspecs when refspecs are
given on the command line, so such a change definitely breaks backward
compatibility, but possibly in a good way, and might deserve consideration
for Git 2.0.
