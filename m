From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC v2 0/2] add regex match flags to git describe
Date: Mon, 04 Jan 2016 09:46:42 -0800
Message-ID: <xmqqmvslp799.fsf@gitster.mtv.corp.google.com>
References: <cover.1451298323.git.mostynb@opera.com>
	<xmqqy4cejoz4.fsf@gitster.mtv.corp.google.com>
	<5681D02C.1040609@opera.com>
	<xmqqk2nxi002.fsf@gitster.mtv.corp.google.com>
	<5684702C.3040802@opera.com>
	<xmqqy4cbbh5e.fsf@gitster.mtv.corp.google.com>
	<5684FE61.4010701@opera.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>
To: Mostyn Bramley-Moore <mostynb@opera.com>
X-From: git-owner@vger.kernel.org Mon Jan 04 18:46:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aG9Dc-0008At-7z
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jan 2016 18:46:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752707AbcADRqx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jan 2016 12:46:53 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:53367 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752137AbcADRqv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jan 2016 12:46:51 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B57FC34028;
	Mon,  4 Jan 2016 12:46:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=E5WwaOzjJK5h3lWVDDritUqpFzI=; b=HWRq5H
	/lL/iJlTWDqeOF0Vmc7YjgFR8Jjo02uQ0x5Mu3kwg8oR4jJyoQeBd8lKDbcn7U47
	pL5d6+HipQpNz2+9MKxm0nTd2WVGYrSqhnHUFsUJHe62xmeM2uMy6dNbAOjr8sTY
	0AjYHwqEHs3z7UyxRq2VtlfL5a6TmQQm/opqc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fOINwd1oW0GmR3zhVpLI27h7S6Yt50Db
	S2D5SQd9HH12ZwQy5Tr7GpxXjAfPa3vQqQSJFqHMLdUO61o3mnOtOyugD3N/e9ea
	AF1MFw1RVmltjBc6a27lfNf1NcZ08U88rCvly/TQfmGK4WNIC2mzEKPKEexs6jr1
	IngaqzvapYU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AD0D334027;
	Mon,  4 Jan 2016 12:46:44 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 1644234026;
	Mon,  4 Jan 2016 12:46:44 -0500 (EST)
In-Reply-To: <5684FE61.4010701@opera.com> (Mostyn Bramley-Moore's message of
	"Thu, 31 Dec 2015 11:07:29 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1E75F788-B30B-11E5-8CBF-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283309>

Mostyn Bramley-Moore <mostynb@opera.com> writes:

> On 12/31/2015 01:23 AM, Junio C Hamano wrote:
> ...
>> Swapping the option key and value may not be a bad idea, but one
>> problem that the above does not solve, which I outlined in the
>> message you are responding to, is that "match-pattern-type" does not
>> give any hint that this is about affecting the match that is done to
>> "refs", e.g. you cannot tell in
>>
>>    $ git mgrep --match-pattern-type=perl-regexp -e foo --refs 'release_*'
>>
>> if the perl-regexp is to be used for matching branch names or for
>> matching the strings the command looks for in the trees of the
>> matching branches.
>
> There is a hint: --foo-pattern-type applies only to --foo.

Hmph.

> In your mgrep example --match-pattern-type would apply to --match
> patterns only, and if we choose to implement it then
> --refs-pattern-type would apply to --refs patterns only.
> eg:
> $ git mgrep --match '^foo' --match-pattern-type=perl-regexp --refs
> release_*' --refs-pattern-type=glob

Most likely the hypothetical "mgrep" would not use "--match" but use
"-e" to retain similarity to "grep", and "--e-pattern-type" would be
confusing.  But I agree that "--refs-pattern-type" uniformly used
where we take pattern parameter on the command line to match with
refs may make it clear that you are only affecting the matches
against refs.

>> Magic pattern annotation like we do for pathspecs Duy raised may not
>> be a bad idea, either, and would probably be easier to teach people.
>> Just like in Perl "(?i)$any_pattern" is a way to introduce the case
>> insensitive match with $any_pattern, we may be able to pick an
>> extensible magic syntax and decorate the pattern you would specify
>> for matching refnames to tell Git what kind of pattern it is, e.g.
>>
>>    $ git mgrep -P -e foo --refs '/?glob/release_*'
>>
>> I am not suggesting that we must use /?<pattern type name>/ prefix
>> as the "extensible magic syntax" here--I am just illustrating what
>> I mean by "extensible magic syntax".
>
> I hadn't seen the pathspec magic patterns before- interesting.  We
> could possibly share syntax with pathspecs, ie
> :(?pattern-options...)pattern

Even though we have DWIM between revisions and paths on the command
line when the user omits "--" for disambiguation, I do not think we
look at the shape of the string to DWIM/decide that it is a pattern,
so as long as the magic syntax cannot be a valid pattern to match
against refs right now (and your ":(?...)"  qualifies as such, as a
refname would not contain a component that begins with a colon), it
would be possible to introduce it as the magic syntax for matching
refs.

Or did you mean to use this syntax also for patterns that match
strings in contents, e.g.

    $ git grep -e ':(?perl-regexp)...'

I am not bold enough to say that it would be a good idea, but I
offhand do not think of a reason why we shouldn't go that route,
either.

> Would this be confusing for commands that already have --perl-regexp
> etc?  What should happen if you specify both --perl-regexp and and a
> different type of pattern like :(glob)foo (error out, I suppose)?

If we were to go that route, ideally, I would say that

    $ git grep --perl-regexp -e 'A' -e ':(?basic-regexp)B' -e ':(?fixed-string)C'

should match with A as pcre, B as BRE and C as a fixed string.

I do not offhand remember if we built the underlying grep machinery
in such a way that it is easy to extend it to allow such mixture,
though.
