From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Gitignore file exceptions are not applied to untarcked files
Date: Fri, 29 Jan 2016 10:31:58 -0800
Message-ID: <xmqqd1skjkyp.fsf@gitster.mtv.corp.google.com>
References: <CAMrYpX5n1LHBnr+bMhV=8Eu1K2npKctVZrHxJcStBhSVC70OBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Assen Totin <assen.totin@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 29 19:32:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aPDq7-0008Cm-Ia
	for gcvg-git-2@plane.gmane.org; Fri, 29 Jan 2016 19:32:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932544AbcA2ScG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2016 13:32:06 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:56214 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751950AbcA2ScC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2016 13:32:02 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3A8223F3D8;
	Fri, 29 Jan 2016 13:32:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=u86GVS8zZBU2oNX/BCkizcYyAbg=; b=E468xg
	hOhPXXvkc+ARkzO+VyYNxYO0ImJJggl8ZXgC504W/CVB9cNj3MAt/+sqn3nJPWLe
	dEbAVeZG1OwJOSpe4Itu0cHGxht/b54wgBD+2a9T5rnOjKr8+LSOkpWL8N63ojeS
	nNK+LsXRUbpqWng9FOr1uXOBtoQWSmmVRpIIY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pMk+gYwQ7/cXUP84uTeytMKmv7DsGWE7
	Bc/eaPyltM6M3t2G9CU+6G2BLEus201x3p4bkUS4SPVXTwHVa60jsPFVuTAwRv32
	44EbtG7nsKVtN3KI28oWahm36G3FyaHwyWld5bzPum7XsR4/qRqQiUsTO3kg+4lj
	cStpEq8edJg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CB2613F3D7;
	Fri, 29 Jan 2016 13:32:00 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 251103F3D5;
	Fri, 29 Jan 2016 13:32:00 -0500 (EST)
In-Reply-To: <CAMrYpX5n1LHBnr+bMhV=8Eu1K2npKctVZrHxJcStBhSVC70OBg@mail.gmail.com>
	(Assen Totin's message of "Fri, 29 Jan 2016 17:25:13 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 95A5CCF2-C6B6-11E5-9DB4-04C16BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285083>

Assen Totin <assen.totin@gmail.com> writes:

> I'm not sure if the described issue is a bug or a feature; if it is the
> latter, please, excuse the report.
>
> I'm dealing with git 1.7.12.4. If this has been addressed in the later
> issue, please, point me so.

That is a bit too ancient version, so I am not sure how it behaved
back then.

> I'm only interested in /tracked_dir/.../config files. My .gitignore is as
> follows:
>
> # Ignore everything first
> *
> # Do not ignore tracked files
> !/tracked_dir/*/config
> # Don't ignore .gitignore
> !.gitignore
>
> This works fine until a new directory with a config file is created inside
> /tracked_dir:

I am not sure if that is "working fine".  First, aren't these 'config'
files tracked?  "!/tracked_dir/*/config" or whatever you have in the
gitignore files have no effect on what is already tracked.

That is, if you replace your .gitignore with a single line,

	# ignore everything
        *

your /tracked_dir/foo/config that is already in the index (i.e. "git
ls-files tracked_dir/foo/config" would show it) would not be ignored.

> Is it because the exclusion pattern is never
> applied to untracked files? Or is it because the directory new_subdir is
> itself untracked?

So my suspicion is that (1) you do see tracked_dir/subdir1/config is
not ignored not because of any of your !tracked_dir/*/config lines
but because tracked_dir/subdir1/config is already in the index, and
(2) your tracked_dir/new_subdir/config is shown as ignored because
it is not tracked yet, and '*' tells Git that new_subdir is ignored.

By the way, this area did have a recent regression at v2.7.0, to
which a fix is percolating down to the v2.7.x maintenance track.
