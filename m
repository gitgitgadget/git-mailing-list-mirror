From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git's fascination with absolute paths
Date: Mon, 21 Dec 2009 22:30:01 -0800
Message-ID: <7vy6kv4j2u.fsf@alter.siamese.dyndns.org>
References: <4B2FC17A.3010705@math.purdue.edu>
 <32541b130912211409j540928c0g8e944fcc05c44f82@mail.gmail.com>
 <7v637z6ehg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: J Chapman Flack <jflack@math.purdue.edu>, git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 22 07:52:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NMybk-0000eE-PY
	for gcvg-git-2@lo.gmane.org; Tue, 22 Dec 2009 07:52:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751243AbZLVGaQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Dec 2009 01:30:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751194AbZLVGaP
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Dec 2009 01:30:15 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:35257 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751168AbZLVGaO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Dec 2009 01:30:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 53D2D8A30A;
	Tue, 22 Dec 2009 01:30:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Z485xCxfr+PxQzgOmO6gJUcLF8U=; b=pijdjP
	Z8GClIOqjCRuo7p8TVhrlRv1uzTjyLSfTy99+43AiyCy0LEsVi17Watdg5+oDMkh
	ByoYMWtTcjMWSNazrK7yyoZ4nOHrlqg11H3j9ijmUktitS51TLauUgwZ5jpSG8h5
	vUc1uTfbkhcNnFZijiFVeKUPbUrCLgG7KVHbo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cIoBujK/tl16/tzJUQKbvcehGBA2SXPk
	4y66ItbIk5DAz7SpMk9emtZMg0Gjhs2c03XuVeQmZ+7KHaDUm0RUtnv5AZ4F/Rd+
	s1vOak5RflKnBb88aruyjRUxH+g3f5El1J3/jtRzzpuw5IjJastgXFysDLMTRPgr
	4V3VM9ENW8E=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2193D8A308;
	Tue, 22 Dec 2009 01:30:08 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2FA048A307; Tue, 22 Dec
 2009 01:30:04 -0500 (EST)
In-Reply-To: <7v637z6ehg.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon\, 21 Dec 2009 16\:26\:19 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 72E131A6-EEC3-11DE-8E38-DC0DEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135571>

Junio C Hamano <gitster@pobox.com> writes:

> Not really.  The scripts can work with ".." just fine, as long as they
> know how to use "cd_to_topdir" and "rev-parse --show-prefix" correctly.
>
> While I do not necessarily agree with the original claim that hiding
> higher level of hierarchies are "standard" practice in UNIX (it instead
> falls into "an unusual set-up that is permitted but you have to be
> careful" category), I don't think it is fundamental that we need read
> access all the way up to the root level.  It is only that getcwd(3) does.
>
> At the basic level, work tree and index operations operate relative to the root
> of the work tree.  Originally, almost no privision was made to run from a
> subdirectory of a work tree (you were expected to run from the top-level,
> having ./.git as the meta information sture), and we didn't have to run
> any getcwd(3).  Later we added "look at parent directories until we find
> the one that has .git subdirectory, while remembering how many levels we
> went up", in order to support operations from a subdirectory of a work
> tree.  The commands chdir up to the root of the work tree and would use
> the path they climbed as a pathspec to limit the scope of their operation.
>
> While "counting how many levels we went up" can be expressed by a sequence
> of "../", turning it to the directory prefix means at some point you would
> need to do what getcwd(3) does.  It wants to be able to read ".." to give
> you an absolute path.
>
> By rewriting that part of the "root-level-discovery" code to do something
> like
>
>  - while test -d .git is not true:
>    - stat(".") to get the inum;
>    - chdir(".."); and
>    - opendir(".") and readdir() to find where we were;
>
> while going up every level, you should be able to construct the prefix
> without being to able to read all the way up to the filesystem root.  You
> only need to be able to read your work tree.
>
> Admittedly the code complexity got worse later when we added support for
> GIT_WORK_TREE and also GIT_CEILING_DIRECTORIES, as they fundamentally need
> to know where you are relative to the root of the filesystem tree and need
> a working getcwd(3) support, which J Chapman's set-up refuses to give.
>
> Also I wouldn't be surprised if the support for these two features cheat
> in order to reduce code complexity by always using absolute paths even in
> places where a path relative to the root of the work tree might have
> sufficed.

Clarificaiton.

The above, like many other messages from me, was not meant as a
justification, but a mere explanation of the historical fact.  IOW, don't
get me wrong by interpreting that I am not interested in seeing a solution
that does not use absolute paths.

While I think the original "higher levels in the filesystems may not be
accessible" is a rather unusual set-up, making paths absolute and relying
on being able to always do so have another drawback in a not-so-unusual
setup.  A work tree that is shallow (say, has only one t/ subdirectory and
short filenames) may not be usable if it is so deep in the filesystem
hierarchy that the result of getcwd(3) exceeds PATH_MAX.  The "hand roll
what getcwd(3) did in traditional UNIX while looking for the root level of
the work tree" approach I outlined in the previous message will be a way
to fix such a use case; as long as the deepest level of your work tree
relative to the root of the work tree does not exceed PATH_MAX, you'll be
Ok.

We have a few known issues in the GIT_WORK_TREE (IIRC, it has a funny
interaction with alias expansion).  When we reexamine the codepath that
the introduction of the feature needed to touch, I would love to see us at
least try to see if it is feasible to redo this without calling getcwd(3)
when no GIT_WORK_TREE (or core.worktree) is set.
