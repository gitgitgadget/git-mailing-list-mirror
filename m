From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] submodule helper: accept '.' for repositories with no submodules
Date: Tue, 22 Mar 2016 13:06:49 -0700
Message-ID: <xmqqoaa6gtuu.fsf@gitster.mtv.corp.google.com>
References: <1458669579-32160-1-git-send-email-sbeller@google.com>
	<xmqqy49agx98.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kaMa3CyJ-Y9Xn9QShzTUGythos+pmKZXQ7m-2c0bF0u9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Per Cederqvist <cederp@opera.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Mar 22 21:07:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiSZu-0007gj-Jc
	for gcvg-git-2@plane.gmane.org; Tue, 22 Mar 2016 21:06:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751328AbcCVUGy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2016 16:06:54 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:58889 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751286AbcCVUGx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2016 16:06:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E2E0B4E2AD;
	Tue, 22 Mar 2016 16:06:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AU4eR0uOxtSPgNstHa5BvRdvTzU=; b=krIhCl
	eS+5l/Mjmijrs+N3fi9CpSKze/wZOWDCEogkVjtBOD+D6g+5ntLGNv+2ISPL+cE/
	T+lTJH0SnXsT1hDZPJ+/9XzAsI4V9ot9b9YhZ6nr/USw1yQxvbLvfRq50yrYq5Y0
	rOMR+EeTDvM/ERdSxBvJpZVB4w4Di7ZWDUUAA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YxDNW9b6n18k5BaSlMITgCCTmyFgGNCX
	2jfF36QwMyOB5XX90im3I90wI+vPzf9SWeJTe0ctT2t87J21RqkZeDc3AQ9CXbX4
	aH92vaa+MI93RNxnGxnhE8vXWiSSB/jVLBi7WH0GZFp0+EivZ623KlWrbcdx+pLN
	yFRXvFyY4kQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D8A414E2AC;
	Tue, 22 Mar 2016 16:06:51 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 3EB404E2AB;
	Tue, 22 Mar 2016 16:06:51 -0400 (EDT)
In-Reply-To: <CAGZ79kaMa3CyJ-Y9Xn9QShzTUGythos+pmKZXQ7m-2c0bF0u9A@mail.gmail.com>
	(Stefan Beller's message of "Tue, 22 Mar 2016 12:30:13 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9DB3F59A-F069-11E5-8937-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289553>

Stefan Beller <sbeller@google.com> writes:

> Maybe we can also special case the "force" argument only here for
> Cedars use case.  ("git submodule deinit ." complains because
> there are no further submodules, but -f solves the complaint?)

I think that would have been the most sensible thing to do when
we were adding "git submodule deinit", and it would be the most
sensible behaviour in the longer term.


> So I have 2 goals in mind:

> * Git suggested to use '.' explicitly, so it should just work
> --even for a completely empty repository (see the test for it)

I actually view this as either a low-prio goal or even a
non-goal, as long as we have a sensible migration plan to stop
suggesting '.'.

> * Eventually -- not in this patch, but a later patch targeted
> at master -- we want to remove the recommendation to use '.',
> and allow no arguments or a different argument for "all
> submodules".

> git add uses '.' for it though, so '.' seems right and valid.
> git add '*' is also valid.

Perhaps I am misunderstanding what you want.  Do you want a
regular file that happens to match pathspec to prevent
module_list from noticing "pathspec did not match" situation and
giving the user an error?  That would be the "match-pathspec first
and then mode-check" behaviour, that is the same as v2.6.x
series [*1*].

> Maybe combine the second idea with a slight refactoring of
> parse_pathspec, such that you can pass a callback function to
> parse_pathspec which can decided on each file if it is a file
> to inspect. (i.e. for our usecase we'd check for ce_mode to be
> GITLINK, another hypothetical use case would be using
> parse_pathspec for finding all files with a certain property,
> e.g. finding all files ending in .c or files written in all
> capital letters or such)
>
> Then you could do a conditional parse_pathspec over the partial
> repository which matched
> the additional filtering function.
>

I do not think that buys us much.  You have already shown how to
implement "filter first and then pathspec match" if a caller
wants to (which turned out to be a regression in this case, but
that is besides the point).



[Footnote]

*1* If not, then similaritly with "git add" does not have much
    to do with what module_list() should do.  "git add $pathspec"
    fails if there is nothing that matches the pathspec, but
    "module_list" wants to complain if $pathspec does not match
    any submodule.  And it is an accident that "git add ." in
    an empty directory does not complain (indeed "git add '*'"
    does complain because it sidesteps the accident).
