From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] completion: add completer for rev-parse
Date: Sun, 30 Jun 2013 12:03:30 -0700
Message-ID: <7vtxkfju9p.fsf@alter.siamese.dyndns.org>
References: <1372429088-385-1-git-send-email-artagnon@gmail.com>
	<1372429088-385-4-git-send-email-artagnon@gmail.com>
	<20130630111436.GB2294@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Sun Jun 30 21:03:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UtMuc-0005eb-K3
	for gcvg-git-2@plane.gmane.org; Sun, 30 Jun 2013 21:03:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752054Ab3F3TDe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Jun 2013 15:03:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39327 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751691Ab3F3TDd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 Jun 2013 15:03:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 968A62C09E;
	Sun, 30 Jun 2013 19:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=JwOCa8BzBpd9
	hUMxYx8Dp20xA2Y=; b=BHema6r2ViBJfGtVZrUegyKdHNsR8axM3rZjoh7LfSZV
	cORbBxHepTZRa4pgs2zMKZ6Wdg2//zI+0dYhKl5rcbiA2zlDfTSKSoOpKF2z+j++
	NX6cykbsC1BMkcQRxaXY8M3VWWxoN6ayJXJgF7wrzjJE59mRM9ylH69Bu11q/MM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=sqz5Xo
	Kh4+M17wg2abjNbesNf6mKyAd70/puiCgBU+y9Zt6KqbSTxL62+8skosmcVQfQBJ
	X6tnH0xnfv6gvmcnIO6D9nphs+6v18QCTnl6MHN5ofxL2XYunIXBlE2oRkGCALL7
	NFxJNguwUtH8DVaF4dFPMNJmI4RKtAGPXNi7Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8D83E2C09C;
	Sun, 30 Jun 2013 19:03:32 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CD7BD2C098;
	Sun, 30 Jun 2013 19:03:31 +0000 (UTC)
In-Reply-To: <20130630111436.GB2294@goldbirke> ("SZEDER =?utf-8?Q?G=C3=A1b?=
 =?utf-8?Q?or=22's?= message of
	"Sun, 30 Jun 2013 13:14:36 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C1A3773C-E1B7-11E2-8753-E636B1368C5F-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229281>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> On Fri, Jun 28, 2013 at 07:48:07PM +0530, Ramkumar Ramachandra wrote:
>> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
>> ---
>>  contrib/completion/git-completion.bash | 14 ++++++++++++++
>>  1 file changed, 14 insertions(+)
>>=20
>> diff --git a/contrib/completion/git-completion.bash b/contrib/comple=
tion/git-completion.bash
>> index 278018f..f2959a7 100644
>> --- a/contrib/completion/git-completion.bash
>> +++ b/contrib/completion/git-completion.bash
>> @@ -2247,6 +2247,20 @@ _git_reset ()
>>  	__gitcomp_nl "$(__git_refs)"
>>  }
>> =20
>> +_git_rev_parse ()
>> +{
>> +	case "$cur" in
>> +	--*)
>> +		__gitcomp "
>> +			--short --show-toplevel --is-inside-work-tree
>> +			--symbolic-full-name --verify
>> +			"
>
> In the completion script we support porcelain commands.  I'm not sure
> about 'git rev-parse', but I think it's more plumbing than porcelain.
> However, I think the same about 'git ls-tree' and 'git reflog', too,
> yet we have support for them in the completion script.
>
> Either way, why these five options?  'git rev-parse' has a lot more
> options than that.

I think most of the options not listed here are indeed very low
level plumbings that end users have no reason to type on the command
line, except when they are learning to see how they would use it in
their scripts, of course.

Adding a select few that current Git gives no other easy way to
achieve what the users may want to do is a good short-to-medium term
compromise for usability, and I think the above is a good starting
point.

But our goal should be _not_ to grow that set, but to shrink them by
making "rev-parse" less end-user facing.

A longer term direction should be to make sure that we do _not_ need
to run "rev-parse" from the command line by giving usability updates
to other commands and shell helpers, though.

=46or example, some subcommands of "git submodule" always required you
to run from the top-level, so you needed some way to find out where
the top level was, but the need to find the top-level is _not_ the
ultimate end-user _want_.  There was no other easy way to achieve
what the users wanted to do (i.e. run "git submodule foo" command)
without first finding out where the top-level is and to go there
before running it.  The user did not necessarily want to go there,
and giving an easy way to find the top may merely be a workaround.

The true solution for that particular issue may be to teach that
subcommand of "git submodule" to run from anywhere, which I think
has happened recently.

Another example on the same option.  Nobody should have to type

	$ cd $(git rev-parse --show-toplevel)

on the command line, even if there is a legitimate reason why it is
necessary to go to the top.  If it is common enough, just like we
ship completion and prompt in contrib/, we should ship a set of
common shell functions and aliases to let you do the above with:

	$ cdtop

which may be defined to be something like [*1*].

And these are illustrations of how we can lose needs to use that
option from the command line.  We should continue to go in that
direction.

=46or --short and --symbolic-full-name, I have a feeling that we
should make "describe" a front-end for these.

Just like "describe" already acts as a front-end for "name-rev" and
behaves differently, we treat the command as a way to transform an
object name into another form, and in addition to the current "do so
by expressing the given rev relative to an appropriate anchor point"
mode, teach it more ways to represent the given rev by doing
something different (e.g. these two are about expressing them as
themselves and not as relative to something else, so the "describe"
command in that mode would not walk the history to find nearby anchor
points).

As to completing "--verify", I can see how it may be useful for
people who interactively play with the command examples they find in
scripts, but otherwise I do not see much value for real end-users.

"rev-parse foobar" would say "foobar" if that does not refer to an
object and end users are more intelligent than a script to see the
difference without seeing the value of $? and error message when
running on the command line.


[Footnote]

*1* This is typed in my MUA for illustration purposes only, not
tested:

        cdtop () {
                local eh
                eh=3D$(git rev-parse --is-inside-work-tree) || return
                case "$eh" in
                true)
                        eh=3D$(git rev-parse --show-toplevel)
                        test -z "$eh" || cd "$eh"
                        ;;
                false)
                        eh=3D$(git rev-parse --git-dir) || return
                        cd "$eh" || return
                        eh=3D$(git rev-parse --is-bare-repository) || r=
eturn
                        test "z$eh" =3D ztrue || cd ..
                        ;;
                esac
        }
