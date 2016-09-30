Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B73FF207EC
	for <e@80x24.org>; Fri, 30 Sep 2016 20:49:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932233AbcI3UtI (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Sep 2016 16:49:08 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62137 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751130AbcI3UtH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2016 16:49:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6A49F402F3;
        Fri, 30 Sep 2016 16:49:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tmYZu7zyBTnTDALH44kqh3cCm+s=; b=hLiGeP
        vhBIB+FsFK77mfkqCNZtU8ghWSkFPA/sTdM4zE4ADPhUckWfaBq2DX4KdjS+Dlrt
        zUh23bNdnPEL1psGwOzabHEXWjxHiRTgnWzMIu6VIOsNQ3rARsmD3HdNFm3R18Jz
        ablBuEXBd8iPDvdJSQm/eZ3H+yyvEK/ig1aUo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cUQKZTMrYrfbqfNnNHGB9hv10LlGxoll
        v7I+/gfhCvtZD55/53T5OLvubxldwiGS8AqDyRFfP1El3psea9LWd20Rr+D3Re43
        bsUzOGqlkqWfDBDpJyLSUt0NsO0aMh/ZRzLBVqEHZoL7okIdMKGKaFoi5sB3dCS8
        cPeKhx+XW+g=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 63C5C402F2;
        Fri, 30 Sep 2016 16:49:05 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D7486402F1;
        Fri, 30 Sep 2016 16:49:04 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
Subject: Re: [RFC/PATCH 0/2] place cherry pick line below commit title
References: <cover.1475176070.git.jonathantanmy@google.com>
        <xmqqtwcycqul.fsf@gitster.mtv.corp.google.com>
        <11e41a94-df8c-494a-584b-e2bc8da2de3a@google.com>
        <xmqq8tu99o75.fsf@gitster.mtv.corp.google.com>
Date:   Fri, 30 Sep 2016 13:49:02 -0700
In-Reply-To: <xmqq8tu99o75.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Fri, 30 Sep 2016 12:34:22 -0700")
Message-ID: <xmqqtwcx8669.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 532C7CEA-874F-11E6-BCFA-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Jonathan Tan <jonathantanmy@google.com> writes:
>
>>> I vaguely recall that there were some discussion on the definition
>>> of "what's a trailer line" with folks from the kernel land, perhaps
>>> while discussing the interpret-trailers topic.  IIRC, when somebody
>>> passes an improved version along, the resulting message's trailer
>>> block may look like this:
>>>
>>>     Signed-off-by: Original Author <original@author.xz>
>>>     [fixed typo in the variable names]
>>>     Signed-off-by: Somebhody Else <somebody@else.xz>
>>>
>>> and an obvious "wish" of theirs was to treat not just RFC2822-like
>>> "a line that begins with token followed by a colon" but also these
>>> short comments as part of the trailer block.  Your original wish in
>>> [*1*] is to also treat "a line that begin with a whitespace that
>>> follows a line that begins with token followed by a colon" as part
>>> of the trailer block and I personally think that is a reasonable
>>> thing to wish for, too.
>>
>> If we allowed arbitrary lines in the trailer block, this would solve
>> my original problem, yes.

Here is an experiment I ran during my lunch break.  The script
(attached) is meant to run in the kernel repository and
for each log messages of each non-merge commit:

 * find its last paragraph, where the definition of paragraph is
   simply "a blank/empty line";

 * inspect if there is at least one RFC2822-header-looking line, or
   a line that begins with "(cherry picked from";

 * dump the ones that do not pass the above criteria.

My cursory look of the output did not spot a legitimate trailer
block that we should have identified.  The output lines shown were
ones that are not signed off at all (e.g. af8c34ce6ae32add that says
"Linux 4.7-rc2"), ones that has three-dash line "---" in them
(e.g. 133d558216d9), ones that has diffstat that should have been
after "---" (e.g. 259307074bfcf1f).

The story is the same if you run it in git.git; the "do we have at
least one rfc2822-header-looking line or '(cherry picked from' line
in the last paragraph? if so, then that is an existing trailer
block" seems to be a good heuristics to cover many cases like
these:

    d0196c8d5d3057c5c21a82f3d0113ca8e501033b
    Signed-off-by: Arnd Bergmann <arnd@arndb.de>
    [tomi.valkeinen@ti.com: resolved conflicts]
    Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

    59f0aa9480cfef9173a648cec4537addc5f3ad94
    Link 1: https://bugzilla.kernel.org/show_bug.cgi?id=9916
            http://bugzilla.kernel.org/show_bug.cgi?id=10100
            https://lkml.org/lkml/2008/2/25/282
    Link 2: https://bugzilla.kernel.org/show_bug.cgi?id=9399
            https://bugzilla.kernel.org/show_bug.cgi?id=12461
            https://bugzilla.kernel.org/show_bug.cgi?id=11880
    Link 3: https://bugzilla.kernel.org/show_bug.cgi?id=11884
            https://bugzilla.kernel.org/show_bug.cgi?id=14081
            https://bugzilla.kernel.org/show_bug.cgi?id=14086
            https://bugzilla.kernel.org/show_bug.cgi?id=14446
    Link 4: https://bugzilla.kernel.org/show_bug.cgi?id=112911
    Signed-off-by: Lv Zheng <lv.zheng@intel.com>
    Tested-by: Chris Bainbridge <chris.bainbridge@gmail.com>
    Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

-- >8 --
#!/bin/sh

git log --no-merges |
perl -e '
	sub flush {
		my ($commit, @lines) = @_;
		my $seen_good = 0;
		for (@lines) {
			if (/^[-A-Za-z0-9]+: / ||
			    /^\(cherry picked from/) {
				$seen_good = 1;
				last;
			}
		}
		if (!$seen_good) {
			print "\n$commit\n";
			for (@lines) {
				print;
			}
		}
	}

	my (@lines, $this);
	while (<>) {
		if (/^commit (.*)$/) {
			my $next = $1;
			flush($this, @lines);
			@lines = ();
			$this = $next;
		}
		if (s/^    //) {
			if (/^\s*$/) {
				@lines = ();
			} else {
				push @lines, $_;
			}
		}
	}
	if (@lines && $this) {
		flush($this, @lines);
	}
'
