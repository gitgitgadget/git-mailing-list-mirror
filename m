From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] [GIT PULL] ktest: A couple of fixes
Date: Tue, 01 May 2012 20:49:58 -0700
Message-ID: <7v62cf6y3d.fsf@alter.siamese.dyndns.org>
References: <20120502004439.965120020@goodmis.org>
 <CA+55aFy02d13HkfwY-TEGwu=2cd8en+_rnrnwcwixGKRmdJRtA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: linux-kernel-owner@vger.kernel.org Wed May 02 05:50:21 2012
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1SPQa2-0004nj-Ad
	for glk-linux-kernel-3@plane.gmane.org; Wed, 02 May 2012 05:50:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758827Ab2EBDuE (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Tue, 1 May 2012 23:50:04 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33504 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758603Ab2EBDuA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 May 2012 23:50:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 02C807FD6;
	Tue,  1 May 2012 23:50:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9MZz+diyd14xXxWJ65U1u9Qd0Bk=; b=Z54Tuv
	5ujr478iFwbiNXbFM4beOZhSHSTiDlwI/aW0Do1kKRKHaSosfgAqRnyD5hhEWGLs
	Iid/i75fR38KGVPZtfNFfbfxKqIlz8KoO6PZ6kUAiFDwOOpfSBiZbws0WTrjC7yE
	SiiTsR1SXQHyS+QymFc6v+P3dibCfhJheM5XM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Xu5RPjjeEU7o0h/BCm92e7ImuNPqXgRI
	SJ54b53gWYF5j4slwKuOBtrexao+eg0o+Qm/SenDhn2t/Y0X4ZkDDk6kqHug+YQY
	BCZakGlVuRfzzAjVdWKOWkgfLdM260ejNX3e7u6c26DlRdZUcilOgnQyo+p3uUoW
	PvgadTz2/Tw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EE37D7FD4;
	Tue,  1 May 2012 23:49:59 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7EB5C7FD2; Tue,  1 May 2012
 23:49:59 -0400 (EDT)
In-Reply-To: <CA+55aFy02d13HkfwY-TEGwu=2cd8en+_rnrnwcwixGKRmdJRtA@mail.gmail.com> (Linus
 Torvalds's message of "Tue, 1 May 2012 19:58:46 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E3CCD85A-9409-11E1-9CF8-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196782>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> If you do a
>
>   git pull linus v3.4-rc5
>
> in order to just update to the state of my latest tag, then git will
> assume you want to do a new commit (and thus a non-fast-forward) just
> so that git can record the tag signature in the commit.
>
> The sad part is that I don't think you can even override the second
> case.
> ...
> That's inconvenient, and an unintended consequence of the behavior I
> wanted as a top-level maintainer. But I really do think it's wrong for
> normal developers who might validly just want to update to some
> particular tagged release.
>
> Junio? Any ideas?

"Ideas" meaning "recipe to do with deployed binaries"?

When a normal developer wants to _reset to_ a particular tagged release,
in order to _start_ new work, she wouldn't be doing even the above "git
pull linus v3.4-rc5".  That will contaminate the result with whatever
random stuff she happened to have on the current branch.  A more natural
sequence would be "git fetch --tags linus" followed by either

        git checkout v3.4-rc5 ;# to detach

or

        git checkout -b mywork v3.4-rc5 ;# to start

So the case to "reset to" is not very interesting.

But when a normal developer wants to _sync to_ a particular tagged
release, in order to _continue_ working on her topic, she would need to
have a merge (unless she does not have _anything_ herself), and at that
point, merging v3.4-rc5 vs v3.4-rc5^0 would not make that much of a
difference.  If she absolutely detests the "mergetag" header, she could do
a "git fetch --tags linus" followed by

	git merge v3.4-rc5^0

which admittedly is two more letters than she used to type.

If you mean by "Ideas" for additional features, obviously the last step
could be enhanced to use a more intuitive command line that requires the
user to type even more, i.e.

	git merge --ff v3.4-rc5

Once that is done, "git pull --ff linus v3.4-rc5" would fall out as a
logical consequence.

But obviously these two would need new code ;-)
