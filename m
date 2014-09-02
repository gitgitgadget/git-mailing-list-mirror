From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 22/32] checkout: support checking out into a new working directory
Date: Tue, 02 Sep 2014 10:33:02 -0700
Message-ID: <xmqqfvga2ai9.fsf@gitster.dls.corp.google.com>
References: <1409387642-24492-1-git-send-email-pclouds@gmail.com>
	<1409387642-24492-23-git-send-email-pclouds@gmail.com>
	<70985AC885404243A2B95F534083A0E9@PhilipOakley>
	<CACsJy8CpGhLN58GyJa_3-PDqNqYUCshPEGDr8-pKngad+-oAdg@mail.gmail.com>
	<CACsJy8ASW0xO3WzU7f+T4iDhjL=Y=C6K+Cvi-OWOnS16r=m+9Q@mail.gmail.com>
	<64D6AA311E524C27A8B6EDE7A63489D7@PhilipOakley>
	<CACsJy8CTLRpjmh+0K6ypLKUgi52gsFEqnNsha2yfOvRVCdhdMQ@mail.gmail.com>
	<5405D983.3050707@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Philip Oakley <philipoakley@iee.org>
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Tue Sep 02 19:33:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XOrxJ-00020Z-5R
	for gcvg-git-2@plane.gmane.org; Tue, 02 Sep 2014 19:33:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754769AbaIBRdR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2014 13:33:17 -0400
Received: from smtp.pobox.com ([208.72.237.35]:60594 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754746AbaIBRdQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2014 13:33:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 51779362BA;
	Tue,  2 Sep 2014 13:33:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9T1xgeALWeJZudS3699nzm4h0Nk=; b=r2H8aj
	S9NTIGc6ZPOMC/nLqw3f1zfHFlYa5QZxgHWnbssZInHCiIj9Y84fHj4g0BcMzmpx
	kbADxJ5j1B6GPu+MWMKG7cFV4Lk9sxVq9fImQoIF36UBIqmmBr3EGw+anYaF39DD
	SET/KjcxOOkgx4c/c2KouKLQ2J0iNTPxPO1O4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aALlfKIt+dY90eyvnNBiNvWDUeb5osmj
	NjSoRDwf3Gt8sqt155MxYIeGIQDX49tP805jquhK6b3xMJPFLYpZx8D6tCwXx4oJ
	8sK2TVQV/NlA28COHxETpWFX2v0VYFCp0yQyoOq9LnZ4Z+pfut5sclxSCfSlsCqS
	6blx+sr7gFA=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 45CB6362B9;
	Tue,  2 Sep 2014 13:33:15 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 68012362A1;
	Tue,  2 Sep 2014 13:33:04 -0400 (EDT)
In-Reply-To: <5405D983.3050707@xiplink.com> (Marc Branchaud's message of "Tue,
	02 Sep 2014 10:51:47 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 31E7B0CE-32C7-11E4-A960-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256327>

Marc Branchaud <marcnarc@xiplink.com> writes:

> On 14-09-02 08:27 AM, Duy Nguyen wrote:
>> After reading this "multiple checkout mode" in git-checkout.txt, I'm
>> tempted to rewrite it like this. I think the example makes it clearer
>> what I mean. If nobody has any comments, I'm going to send v2 with
>> this (and other comments collected so far)
>
> Overall I think focusing on the word "checkout" for this feature makes the
> documentation confusing.  It's also not a "mode" but just another git
> feature.  Since this is all about multiple working directories (the phrase is
> actually "working tree" in the existing docs) we should just stick to that
> rather than introduce new terminology.
>
> Finally, a bit of bikeshedding, but I think "$GIT_DIR/repos" is also an
> unfortunate choice and that "$GIT_DIR/worktrees" would be better.

I tried to stay away from bikeshedding, but a good phrasing is
important.  I think $GIT_DIR/worktrees captures what they are trying
to represent better in that they are not storing repository
information, but they are about storing per-worktree state.

> So I suggest the following for the new section:
>
>
> MULTIPLE WORKING TREES
> ----------------------
>
> A git repository can support multiple working trees, allowing you to check
> out more than one branch at a time.  With `git checkout --to` a new working
> tree is associated with the repository.  This new working tree is called a
> "linked working tree" as opposed to the "main working tree" prepared by "git
> init" or "git clone".  A repository has one main working tree (if it's not a
> bare repository) and zero or more linked working trees.
>
> Each linked working tree has a private sub-directory in the repository's
> $GIT_DIR/worktrees directory.  The private sub-directory's name is usually
> the base name of the linked working tree's path, possibly appended with a
> number to make it unique.  For example, when `$GIT_DIR=/path/main/.git` the
> command `git checkout --to /path/other/test-next next` creates the linked
> working tree in `/path/other/test-next` and also creates a
> `$GIT_DIR/worktrees/test-next` directory (or `$GIT_DIR/worktrees/test-next1`
> if `test-next` is already taken).
>
> Within a linked working tree, $GIT_DIR is set to point to this private
> directory (e.g. `/path/main/.git/worktrees/test-next` in the example) and
> $GIT_COMMON_DIR is set to point back to the main working tree's $GIT_DIR
> (e.g. `/path/main/.git`). These settings are made in a `.git` file located at
> the top directory of the linked working tree.
>
> Path resolution via `git rev-parse --git-path` uses either
> $GIT_DIR or $GIT_COMMON_DIR depending on the path. For example, in the
> linked working tree `git rev-parse --git-path HEAD` returns
> `/path/main/.git/worktrees/test-next/HEAD` (not
> `/path/other/test-next/.git/HEAD` or `/path/main/.git/HEAD`) while `git
> rev-parse --git-path refs/heads/master` uses
> $GIT_COMMON_DIR and returns `/path/main/.git/refs/heads/master`,
> since refs are shared across all working trees.
>
> See linkgit:gitrepository-layout[5] for more information. The rule of
> thumb is do not make any assumption about whether a path belongs to
> $GIT_DIR or $GIT_COMMON_DIR when you need to directly access something
> inside $GIT_DIR. Use `git rev-parse --git-path` to get the final path.
>
>
> 		M.
