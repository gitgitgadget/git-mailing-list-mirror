From: Junio C Hamano <gitster@pobox.com>
Subject: Re: more novice-friendly behaviour of `git add -p`
Date: Fri, 20 May 2016 08:05:44 -0700
Message-ID: <xmqq7feohirb.fsf@gitster.mtv.corp.google.com>
References: <loom.20160520T150517-391@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: enrico <enrico.guiraud@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 20 17:05:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3lzt-0003hJ-EH
	for gcvg-git-2@plane.gmane.org; Fri, 20 May 2016 17:05:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933019AbcETPFt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 May 2016 11:05:49 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50110 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932985AbcETPFs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2016 11:05:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B380C16BAE;
	Fri, 20 May 2016 11:05:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Kky52Jxl2GOPTqBKFBDDQkDEJSE=; b=mtXZGI
	xFhD0PLmXUZV1TADFMe4xzEfIM+ib3TtZs9qk2EGwIO6dmZXCZu2cgfgUhO8FBSM
	eLOBnAwn0NkB/XsIL+CeesXfvP6tjFZhmVlsGy7WUxNNHZbE5LmuYvL0vrtMOs6f
	etKOPmQO6U6SKLCjzf5fRv0FWWopSjP0v/5JE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=F7xdMy13qPhd0vL9FHBFGJAOzkl6IQDK
	EpPHjloaVFyZBFKhiYi2ygyf+rd3L4+/KOHwPC2Sc6idWSq49yi0OuB4T3pn2pfx
	tL8WwkTfpvaoKGAisOu+dignAFHxnDUslHWYaY5UFQ1gHQNJ0Ole+Qi9X3XF1qjE
	wYZT2heqR+k=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A842216BAD;
	Fri, 20 May 2016 11:05:46 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2210E16BAC;
	Fri, 20 May 2016 11:05:46 -0400 (EDT)
In-Reply-To: <loom.20160520T150517-391@post.gmane.org> (enrico's message of
	"Fri, 20 May 2016 13:06:15 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 546CF45C-1E9C-11E6-BE0B-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295172>

enrico <enrico.guiraud@gmail.com> writes:

> Hello all,
> I have encountered a couple of non-necessary difficulties when editing a
> patch during a `git add -p`.
>
> Firstly, the help message says
> "To remove '-' lines, make them ' ' lines (context)."
> which is a bit confusing because that "them" refers to '-', not to 'lines'.

I think that sentence refers to a line line this in a patch:

    -This is what the line used to be

as a '-'-line.  A line that does not change between preimage and
postimage have SP instead of '-' at the beginning, and the sentence
seems to refer to it as a ' '-line.  So from that reading, "turning
'-'-lines that you do not want to loes into ' '-lines" is perfectly
sensible phrasing.

In any case, "edit" is about giving a low-level access and precise
control to people who are familiar with (1) what each line of "diff"
output means and (2) what is done to them by "patch" (rather, in
Git's context, "apply").

I agree with you that "edit" mode is a too-advanced tool for those
who are not comfortable with these two things.  A solution would
however not be to modify "edit" mode (which would affect those who
are prepared to and want to use the "low-level access and precise
control" to their advantage), but to introduce an easier-to-use,
and perhaps a bit limited for safety, mode for those who are not the
target audience for "edit" mode.

The "split" subcommand to split the hunk before applying was an
attempt to go in that direction; it never allows you the user to
make an arbitrary change to corrupt the patch and make it unusable.
Perhaps you can mimick its spirit and come up with a new "guarded
edit" command?
