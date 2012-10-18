From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/6] Bring "format-patch --notes" closer to a real
 feature
Date: Thu, 18 Oct 2012 10:04:11 -0700
Message-ID: <7v391bn244.fsf@alter.siamese.dyndns.org>
References: <1350539128-21577-1-git-send-email-gitster@pobox.com>
 <CACsJy8Dxx6JtRXP_HWNBrobNems+4UsaOGSRef08cf8--b5dOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 18 19:04:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOtWG-0005xA-Mm
	for gcvg-git-2@plane.gmane.org; Thu, 18 Oct 2012 19:04:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757285Ab2JRREQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2012 13:04:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51073 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757196Ab2JRREP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2012 13:04:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 23AF48F78;
	Thu, 18 Oct 2012 13:04:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kY9SgWISw8Q3DzaytJgetIKAckg=; b=RM2Vkx
	3YvIj2TkVrq8QEiiGWkpy/BeqN8k+3lGM9v964QawCV5F3yyNwNl/AvEw8O9/OOe
	MA9miGtRorD1TMbF2vXlqJ6wwRq+c7SqZsVIh4voj2G4UMBTQe041YNp2fWDbi65
	QvUhP8qDipw2s5JPx/RTg16XpdQc1yNHg5KwY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CLL0bqJZxu+IUNPHIw9MitAYBo8sq1jk
	1AiwvqFKOiipEQKnnQAKmzl/JgwUMEtCPx61qg5FmbLOLwjZ9JFWE+IwWGvenMeG
	9On98AeOkSm74pcfN21sLtB3rRtjIJsWVNtnHjMPCBCW+/cMbe/8/oPDEc1spN+y
	kkfKlhNHWXA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0C0498F77;
	Thu, 18 Oct 2012 13:04:14 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5F0A38F74; Thu, 18 Oct 2012
 13:04:13 -0400 (EDT)
In-Reply-To: <CACsJy8Dxx6JtRXP_HWNBrobNems+4UsaOGSRef08cf8--b5dOw@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Thu, 18 Oct 2012 18:06:10 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D787AEDC-1945-11E2-9B1F-84882E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208015>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> On Thu, Oct 18, 2012 at 12:45 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> This replaces the earlier "wip" with a real thing.
>>
>> We never advertised the "--notes" option to format-patch (or
>> anything related to the pretty format options for that matter)
>> because the behaviour of these options was whatever they happened to
>> do, not what they were designed to do.
>
> Stupid question: does "git am" recreate notes from "format-patch
> --notes" output? If it does not, should it? I think it could be a nice
> way of copying notes from one machine to another, but not enabled by
> default (iow "am --notes").

Thinking about what the "notes" are, I do not think it should, at
least by default; the model is broken at the conceptual level.

The notes are comments on a commit you make after the fact, because
you do not want to (or cannot afford to) amend the commit to include
the comment.  When you are sending it out over e-mailto be applied
with "am", as opposed to asking the other to pull, you are by
definition willing to see the commit replayed with modification.

I think it is sensible for format-patch/am pipeline when asked to
use --notes to add the notes section after "---" as additional
material to help the recipient understand the context of the patch
better, which is done with this series.  If the submitter (or the
recipient) wants to incorporate the description from the notes to
update the proposed log message, it can easily be done by editing
the output of "format-patch --notes" before sending it out (or
before applying it with "am").

That does not mean that the recipient should not use notes for his
own purpose on the resulting commit, by the way.  It would be a
convenient feature to prime the contents of such a new note the
recipient creates on the resulting commit from the comment after
"---" before the diffstat or "diff --git" line.  Note that (no pun
intended) that additional comment does not have to originate from
any notes in the submitter's repository.  If saving the additional
comments the submitter attached from the notes to the patch is
useful, it would equally be useful to save typed-in comments on the
patch that came from the submitter's fingers, not from the notes.

It is something you can do by inspecting $dotest/patch file in your
post-applypatch hook with today's git.  If many people use and find
such a feature desirable, we could add inbuilt support for it, but I
do not think we are there yet.
