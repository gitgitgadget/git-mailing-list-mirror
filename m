From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8] diff.c: keep arrow(=>) on show_stats()'s shortened filename part to make rename visible
Date: Tue, 22 Oct 2013 11:09:38 -0700
Message-ID: <xmqqob6htbx9.fsf@gitster.dls.corp.google.com>
References: <38848735-7CFA-404E-AE51-4F445F813266@gmail.com>
	<A15CCF08-83FD-4F3C-9773-C26DEE38FD33@gmail.com>
	<660A536D-9993-4B81-B6FF-A113F9111570@gmail.com>
	<AFC93704-D6C5-49AF-9A66-C5EA81348FFA@gmail.com>
	<79A13931-694C-4DDC-BEDF-71A0DBA0ECA1@gmail.com>
	<89A4E8C6-C233-49E2-8141-837ABDBBC976@gmail.com>
	<FB9897CC-EDC7-4EBB-8DAB-140CEB5F93B3@gmail.com>
	<C876399C-9A78-4917-B0CF-D6519C7162F6@gmail.com>
	<87mwm5vkue.fsf@linux-k42r.v.cablecom.net>
	<BB9AEFCE-0E64-4EAA-8DEA-9A8125B8C553@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <tr@thomasrast.ch>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Yoshioka Tsuneo <yoshiokatsuneo@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 22 20:09:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VYgOr-0004SL-5T
	for gcvg-git-2@plane.gmane.org; Tue, 22 Oct 2013 20:09:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753637Ab3JVSJo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Oct 2013 14:09:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65471 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753054Ab3JVSJo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Oct 2013 14:09:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E6B214C2BC;
	Tue, 22 Oct 2013 18:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=a40LJUJHaq2IddS3vr2nXMnyssU=; b=OzV+fV/wbnYDB18t8Zwq
	OtabintEHbIDNFYO0gr7sNPlMkZTzJalrSP7HGHE65KnHLiNqg7oo9OsS8x4qlMO
	T4+S8Vj/qP/EpCl21b2NP/WwLe1C3W0ug2rYVMM18fxsqN5SqH6dYsVbXmvpTBJm
	Gu3LUiz+TdVKxNOPg0nMQE4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=nsgm5p+Rb5cvKpIi1wMoh9z/+EZrlrUhtg22ZCQglsf9wU
	+SaHqXMEBYUsZeMVjlS7FUuLeLWdWwzp0a8bcqOoND9oRi0OPFB4HeGI/9UVndJI
	NZq8KBeEkeThGG8hMZv+EsZ3fhOogEx3w3ovjyfRoar05q8EKFLTaxCqQ+C4w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D41A74C2B9;
	Tue, 22 Oct 2013 18:09:42 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 33D434C2B4;
	Tue, 22 Oct 2013 18:09:42 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 1FB8A554-3B45-11E3-891F-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236480>

Yoshioka Tsuneo <yoshiokatsuneo@gmail.com> writes:

> Also, I guess Junio might be suspicious to the idea to keep arrow("=>") itself, maybe ?

I think there is no single "right" solution to this issue, and it
has to boils down to the taste.

When you are viewing "diff --stat -M" output in wide-enough medium,
you are seeing three pieces of information: what the source path
was, what the destination path will be, and what amount of change is
made with the change. When the output width is too narrow to show
these paths, with the current code, you see truncated destination
path, possibly without the source path, but this patch will show the
source and the destination paths, both of which are truncated even
more severely, because it always has to spend display columns for an
extra "..." (to show truncation of the source side), " => " (to show
that it is a rename), and <"{","}"> pair (again to show that it is a
rename).  If the destination does not fit, the output before this
patch would have thrown these away as part of left-truncation, to
show the destination path as maximally as possible.  We do not have
even half the width of the current "truncated to be destination
only" output for each path.

I am afraid that in the cases where the patch makes a difference,
what happens would be that you can no longer tell what source or
destination paths really are, because the leading directory part
gets truncated too much, and if we didn't have this patch, at least
you can tell what destination path is affected.  We would trade the
guessability of at least one path (the destination) with just a
single bit of information (an unidentifiable path got renamed to
another unidentifiable path).

I am not yet convinced that it is a good trade-off.  Especially
given the diffstat output is not about files but more about
contents, between an output in the extreme case the version after
the patch needs to produce

	{... => ...}/controller/Makefile | 7 +++++++

that tells us "7 lines were updated in the procedure to build some
unknown controller by copying or renaming from the build procedure
of some other unknown controller", and the output the current code
would give to the same rename

	.}/fooGadget/controller/Makefile | 7 +++++++
        
that tells us "7 lines were updated in the build procedure for the
foo Gadget", I think the latter contains more useful information,
even though it does lose one bit of information ("there was a rename
involved in producing this final path") compared to the version with
the patch.

So you are correct to say that I am still skeptical.

In any case, the output from "diff --stat -M" should match the
output from "apply --stat -M", I think.
