From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jan 2013, #04; Wed, 9)
Date: Fri, 11 Jan 2013 08:07:35 -0800
Message-ID: <7vehhrd7p4.fsf@alter.siamese.dyndns.org>
References: <7vmwwi3w5r.fsf@alter.siamese.dyndns.org>
 <CACsJy8CZ9YuzRW6-dh6293EQJAhCDL9wsMdb=NSxMRq060wPbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 11 17:08:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tth9E-0005DN-7Y
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jan 2013 17:08:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755020Ab3AKQHk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2013 11:07:40 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43997 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754621Ab3AKQHj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2013 11:07:39 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 547BCB1C1;
	Fri, 11 Jan 2013 11:07:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=q492koo3X/62/bTwUOziN1KeuNI=; b=ScO7r/
	L/k0MoNwupvTdvfRqXMueJdpnV4h28wdFYfCYfMFl2saUggM7TMtILKp5aBMQCRe
	g+ydcR9DUUvbwLHjajnnLKOIYVF/fCKubCMAigNQ4LlWrtXYvlx4dYPNcninlVgr
	t1FQxDJ0weCtjPKlhs4pirl7q4iy5GYkN1dYA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tA3jCQnMBh25WX1wvKUcgfl3wVp9K1kk
	Wmv1bQrVjQ5TJhDQ881s5Dk/723xvAxVH+AHMuFiDD0KusR9JAfbJH3urDDau1R6
	mcXzNiPVXNE90iMvWQsiMJtb3ZJ+o8uP+QlGNtt3E60sVveuHwx4coCsEFLsQ5tE
	9KBMl7a5Er4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 47751B1C0;
	Fri, 11 Jan 2013 11:07:38 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7D59EB1BF; Fri, 11 Jan 2013
 11:07:37 -0500 (EST)
In-Reply-To: <CACsJy8CZ9YuzRW6-dh6293EQJAhCDL9wsMdb=NSxMRq060wPbA@mail.gmail.com> (Duy
 Nguyen's message of "Fri, 11 Jan 2013 19:56:10 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 048AEB82-5C09-11E2-8B1B-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213220>

Duy Nguyen <pclouds@gmail.com> writes:

> On Thu, Jan 10, 2013 at 4:04 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Here are the topics that have been cooking.  Commits prefixed with
>> '-' are only in 'pu' (proposed updates) while commits prefixed with
>> '+' are in 'next'.
>
> I see you start to use no-change commits as a way to keep notes in
> 'pu'. Isn't git notes designed for that?

It is not designed for this.

You could (ab)use notes for that purpose, but at the semantic level,
I do not think notes is a good match.

The branches 'pu' and its subset 'jch' (designed to be slightly
ahead of 'next', and this is what I regularly do my Git work with)
are rebuilt on top of 'master' in every integration cycle (like 2 to
3 times a day).  The insn to rebuild the latter currently looks like
this (familiarity with the Documentation/howto/maintain-git.txt
document in 'pu' would help understanding this section):

    $ cat Meta/redo-jch.sh
    Meta/Reintegrate <<\EOF
    jc/format-patch-reroll
    nd/retire-fnmatch
    ...
    jk/maint-fast-import-doc-reorder
    nd/upload-pack-shallow-must-be-commit
    ap/log-mailmap
    ### match next
    jc/doc-maintainer
    mk/complete-tcsh
    pe/doc-email-env-is-trumped-by-config
    as/check-ignore
    EOF

The Reintegrate machinery merges the topic listed on each line, and
the "### match next" marks the point _between_ the two merges to
remind me that merging everything before this line to 'master' must
match what the 'next' branch has.  The markers on 'pu' are similar.

You can emulate that semantics by attaching a note to the merge
commit that merges ap/log-mailmap topic, but that is unwieldy, and
more importantly, it does not correctly express the meaning of the
marker.  I often reorder lines before that "### match next" marker
between integration rounds, to float topics that are more ready than
others near the top, to make sure that they do not depend on other
topics and cause mismerges when merged to 'master' without others.
The next integration cycle may have ap/log-mailmap earlier, e.g.

    $ cat Meta/redo-jch.sh
    Meta/Reintegrate <<\EOF
    nd/upload-pack-shallow-must-be-commit
    ap/log-mailmap
    jc/format-patch-reroll
    ...
    jk/maint-fast-import-doc-reorder
    nd/retire-fnmatch
    ### match next
    jc/doc-maintainer
    mk/complete-tcsh
    ...

and having a note on the previous merge of ap/log-mailmap does not
help expressing the semantics correctly.  It is not like I cease to
declare the merge of ap/log-mailmap ought to match 'next' and now
declare the merge of nk/retire-fnmatch ought to match 'next'.

It's much clearer to have the marker as a separate entity, as
opposed to emulating it with an attribute of a merge commit that
happens to be adjacent to what I really want to mark (i.e. a place
*between* two merge commits).

Another way you could use notes to emulate this is to give each
merge that comes before the marker line a note that says "this merge
is before the marker line".  But it still is more work to present
the result as "here is a sequence, then a marker, and then another
sequence, then another marker...".  In short, notes may be able to
emulate it but it is not the best tool for the job.

It is not like I'll be running format-patch and rebasing these
throw-away integration branches, so no-change commits are the best
way to express what I want to in the history.
