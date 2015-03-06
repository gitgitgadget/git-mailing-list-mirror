From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Interest in contributing to the Git for GSOC 2015
Date: Fri, 06 Mar 2015 13:53:03 -0800
Message-ID: <xmqqh9txyerk.fsf@gitster.dls.corp.google.com>
References: <CAFAMDXYJAaunegAXFoCK8N-CAaoUXpv-WObhnDC5Wdgy_U99OQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Amate Yolande <yolandeamate@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 06 22:53:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YU0BM-0001Sp-RC
	for gcvg-git-2@plane.gmane.org; Fri, 06 Mar 2015 22:53:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754725AbbCFVxK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2015 16:53:10 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54566 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753170AbbCFVxG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2015 16:53:06 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D18853EE13;
	Fri,  6 Mar 2015 16:53:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2GcP8NZGWoYE6W+s7grl4ykxydk=; b=rP5ya7
	q18KrB+AV/Hi4yGjS/MmVPor0xhq42iJkBSXfxr5WLnPOwzQI8SssXCgG47awKJ3
	2nLAbif46dlUCORjfeys3b0czzC6J8F7tWNGqnP04T/Hzrq+x4OhR+VDdm/NrZuN
	ILygJdfek71KPoaZgh68asGKEvvDKd5kgbxEg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bGN5XhN1znxhPvbZKNSC4lLD616lFyUg
	xxw1xBKph8/PU30zj7CvVxERqszne81GoGzffJNhvnyskM1p1AChszjQpgZZJ/IW
	y+3RirRNfDZsIsJ81yLDQaoPndI9CVINEoGBt+ls0PSiccexYIAbrCihbsLDJ3Sg
	YF2nA8/5MM8=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C9A0D3EE12;
	Fri,  6 Mar 2015 16:53:05 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D6C323EE11;
	Fri,  6 Mar 2015 16:53:04 -0500 (EST)
In-Reply-To: <CAFAMDXYJAaunegAXFoCK8N-CAaoUXpv-WObhnDC5Wdgy_U99OQ@mail.gmail.com>
	(Amate Yolande's message of "Thu, 5 Mar 2015 01:19:11 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2AE0F540-C44B-11E4-A26E-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264966>

Amate Yolande <yolandeamate@gmail.com> writes:

> .... I would like to
> work on the Unifying git branch -l, git tag -l, and git for-each-ref
> project for GSOC 2015 and I hope I can get more directives on how to
> move on with this project.

Hmm, the description on the ideas page looks somewhat sketchy.

    These three commands are all about selecting a subset of a
    repository's refs, and then printing the result. However, the
    implementations are not shared. Some commands know selection
    options the others do not (e.g., --contains, --merged), and
    others know formatting options the others do not (e.g.,
    for-each-ref's --format).

So, if I were a student to tackle this project, I'd start from:

 - Reading these three commands to understand how they currently
   work.

   For example, when I say "git branch -r --no-merged origin/pu",
   what happens, and how exactly does the codepath that is called by
   cmd_branch() in builtin/branch.c choose which branch to show by
   computing what?  Can a user customize how they are shown?  How
   does the customization specified by the user and what code
   actually allows the output to be customized?

   Do the same for other options "git branch" takes.

   What about "git tag"?  "git tag --contains origin/maint" may be a
   good starting point to think about, for example.

 - After doing the above, it would become clear to you that the
   three have different ways to specify what are chosen to be shown,
   and they have different ways to show their results.  What are the
   overlaps in them?  What is missing from what others that might be
   beneficial?

   Do we want "git for-each-ref --contains maint refs/heads/" to
   work, making "for-each-ref" borrow from "tag", for example?

   Do we want "git branch --format='%(refname:short) %(subject)'"
   to work, making "branch" borrow from "for-each-ref", for example?

   Once we have "git branch --format=..." support, can we express
   existing "branch -v" and "branch -v -v" output formats in terms
   of the new facility?  What, if anything, needs to be added to the
   format specifier you can give to the --format option as an
   argument?

 - Then write out the design based on the above preliminary study.

   How you want your new versions of commands to behave can be
   described by updating their documentation and also by adding
   tests (that would fail until you actually implement them) that
   expects the desired behaviour.

 - And then have fun time to code your design ;-)

The second paragraph on the ideas page reads like this:

    There have been experimental patches to unify the selection
    process, and some discussion on unifying the formatting. Based
    on this previous work, factor out a common library which can
    cleanly handle both selection and formatting, and use it
    consistently in the three commands.

I do not have pointers to these "experimental patches" offhand.  You
would want to dig the list archive and/or ask around to find them,
which would help doing the second step (i.e. after understanding the
current state of these commands, start designing what the unified
result should look like).

Have fun.
