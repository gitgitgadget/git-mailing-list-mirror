From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] grep --no-index: allow use of "git grep" outside a git
 repository
Date: Fri, 15 Jan 2010 23:21:57 -0800
Message-ID: <7v1vhqfrai.fsf@alter.siamese.dyndns.org>
References: <201001131713.05505.agruen@suse.de>
 <7vfx69k0bu.fsf@alter.siamese.dyndns.org>
 <20100115223259.6117@nanako3.lavabit.com>
 <7vska71br0.fsf@alter.siamese.dyndns.org>
 <7vzl4fum3r.fsf_-_@alter.siamese.dyndns.org>
 <20100115210854.GA21540@coredump.intra.peff.net>
 <7vwrzin9jt.fsf@alter.siamese.dyndns.org>
 <20100116011512.GA27082@coredump.intra.peff.net>
 <7vpr5ait1m.fsf@alter.siamese.dyndns.org> <20100116065135.GA15104@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Nanako Shiraishi <nanako3@lavabit.com>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 16 08:23:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NW304-0005Uy-DP
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jan 2010 08:23:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751771Ab0APHWM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Jan 2010 02:22:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751638Ab0APHWM
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jan 2010 02:22:12 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:64475 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751288Ab0APHWL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jan 2010 02:22:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D0F2914B8;
	Sat, 16 Jan 2010 02:22:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gNZBhG8znb62tUhsgunKa9qy6d0=; b=B7/ADb
	sPHl2mf2lhz5ARrbYlmStPb8rmdKfovdKB44TekZsipW6hezkRKPogt0T4v3rul+
	K8N7pV7svEYhqS2ipYks81bPRoKQMKDK6NlgCOmfdWoe4ysegZG0OaPb7BHr3ePU
	CsfC9deFMtW0UVXBpLdzxg+FkGM+Nb9za/YuU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sj7TNOTGYA8eIxBgYVj7yuW9uU7dQsdb
	2/ga/og+7mcaPKarscTt7XCFjcd6uD6B3j4tcKUihlDH/dFyLhIWZQ8KBkiq7m6i
	AOuJ/PK44OwMgPv7AX7KTH+SFiVOm1HNlBU/BnjoBSe6hkSxpFS6SKOhOVusfIEj
	uA6I2ITH/X8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BEDF0914B6;
	Sat, 16 Jan 2010 02:22:03 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B7605914B4; Sat, 16 Jan
 2010 02:21:58 -0500 (EST)
In-Reply-To: <20100116065135.GA15104@gmail.com> (David Aguilar's message of
 "Fri\, 15 Jan 2010 22\:51\:36 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D8469B84-026F-11DF-BF86-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137204>

David Aguilar <davvid@gmail.com> writes:

> On Fri, Jan 15, 2010 at 08:15:49PM -0800, Junio C Hamano wrote:
>
>> Realistically, this most often is used when grepping in the log, e.g.
>> 
>>     git log --all-match --author=peff --grep=test
>> 
>> I actually wish "log" to somehow default to --all-match mode at least when
>> using the --author option.  "Change by Jeff, or about test by anybody" is
>> rarely what I would want to look for.
>
> Kinda like this?

Not quite.  What I really want is

    git log --author=davvid --grep=difftool --grep=mergetool

to find all commits by you that is about (either diff or mergetool).  I
think your patch will limit the search only to your patch that talks about
both of these two tools (not necessarily on the same line, but in the same
commit).

The extended "grep" expression parser by default creates a list of OR'ed
terms.  What --all-match does is to make this top-level chain to mean "all
of these must trigger somewhere in the whole _document_ (not an individual
line), for the document to be considered a hit" for the purpose of "grep -l",
and when used with "log" family, --author/--committer/--grep are used to
limit the output to commits "grep -l" would say "yes, this document has
matched".

Currently,

    git log --author=davvid --grep=difftool --grep=mergetool

will parse to a list of three terms:

    GREP_PATTERN_HEAD("^author .*davvid")
    GREP_PATTERN_BODY("difftool")
    GREP_PATTERN_BODY("mergetool")

And giving --all-match will require all of these OR'ed terms to appear in
the commit object.

My dream one will probably has to make a list of two terms as its parse
tree instead, like this:

    GREP_PATTERN_HEAD("^author .*davvid")
    GREP_NODE_OR(
        GREP_PATTERN_BODY("difftool")
        GREP_PATTERN_BODY("mergetool")
    )           

and then run it with --all-match semantics.  The top-level consists of two
terms, and they both must hit, but the second term is an OR'ed one.

It is unclear how we would want to throw the committer in the mix.  If we
make this parse tree:

    GREP_PATTERN_HEAD("^author .*davvid")
    GREP_PATTERN_HEAD("^committer .*gitster")
    GREP_NODE_OR(
        GREP_PATTERN_BODY("difftool")
        GREP_PATTERN_BODY("mergetool")
    )           

we would be looking for your patch about either diff or mergetool _and_
it has to be committed by me.  On the other hand, if we do this:

    GREP_NODE_OR(
        GREP_PATTERN_HEAD("^author .*davvid")
        GREP_PATTERN_HEAD("^committer .*gitster")
    )
    GREP_NODE_OR(
        GREP_PATTERN_BODY("difftool")
        GREP_PATTERN_BODY("mergetool")
    )           

we would be looking for a patch about (either diff or mergetool) _and_
(either committed by me or written by you).

I think the former makes more sense in _our_ project (because there are
very few committers), but in the context of other projects, e.g. the Linux
kernel, you may want to give "Linus" to both --author and --committer to
track what he did (either as an author to some other subsystem, or as the
top-level integrator for the entire system), and for such a use case, the
latter would make more sense.

Unfortunately, the parsing of --grep/--author/--committer options to the
log family is quite limited (you cannot give --and, --or and --not, for
example), and it would be hard to express these distinction.
