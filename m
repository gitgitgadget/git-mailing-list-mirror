From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Feature Request: provide cmdline args to git hooks
Date: Tue, 14 Apr 2015 16:46:44 -0700
Message-ID: <xmqq4moi1dej.fsf@gitster.dls.corp.google.com>
References: <CAM-hpQcgOgrAJBAZrH4icDtJMiHUYOz1tynYkoj7qzyVMZ0eVQ@mail.gmail.com>
	<xmqqwq1e3fy4.fsf@gitster.dls.corp.google.com>
	<CAM-hpQcowcRaRMnYcZD8oUDep-nSw1e4Sy3CHjCojpQd=238Ug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: "Chris O'Kelly" <chris@mapcreative.com.au>
X-From: git-owner@vger.kernel.org Wed Apr 15 01:46:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YiAXf-0006fN-Db
	for gcvg-git-2@plane.gmane.org; Wed, 15 Apr 2015 01:46:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751591AbbDNXqs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Apr 2015 19:46:48 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:62688 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751200AbbDNXqq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Apr 2015 19:46:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E83494ABAC;
	Tue, 14 Apr 2015 19:46:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KiSLQyB2tmArk56i3sJyxPTuYsQ=; b=DnuHel
	L346OPBWi8Q/7S8ZRWDF2FDHfZKNffJ4XEB60Khvorggx9Lhmm6biDELbB4Tw5v+
	JJS6vrGSWv1Gz0FcBzsIFJDzLGBCM4rDpZrkKP/XTz5zINcmoORIwUTiQUdmD5cA
	Q/ZoW0O91uixxaz3yZdmOkwXmiiKP6MOYobgM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=w4Z8vWyBKSHXuLu7aqGgoXc41Gdfh5FY
	QzqcpvoaDgdJqx+3aQyMCCtnKQito68fBCFL8Cqs+szlIB+BUAKAyQCI87i/Cpja
	KB9xcgd7sI8XDUDZ3kt4YDLQciH7jyb1pjTAaEpvpxY62JOta9CCOwMCvvt/7aQm
	q58olVnRtco=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DFEC64ABAB;
	Tue, 14 Apr 2015 19:46:45 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4B2D04ABAA;
	Tue, 14 Apr 2015 19:46:45 -0400 (EDT)
In-Reply-To: <CAM-hpQcowcRaRMnYcZD8oUDep-nSw1e4Sy3CHjCojpQd=238Ug@mail.gmail.com>
	(Chris O'Kelly's message of "Wed, 15 Apr 2015 08:28:39 +1000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 82482000-E300-11E4-ACCC-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267175>

"Chris O'Kelly" <chris@mapcreative.com.au> writes:

[administrivia: people read from top to bottom; please do not top
post]

> On Wed, Apr 15, 2015 at 1:08 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> "Chris O'Kelly" <chris@mapcreative.com.au> writes:
>>
>>> A brief background of my use case:
>>> I am wanting to write a pre-push hook to prevent tags being pushed to
>>> our production servers. The production servers in our case are --bare
>>> endpoints, and when we push a tag at them, they always checkout the
>>> commit that tag is attached to via some post-receive magic (WPEngine,
>>> FWIW). This behavior is even present when the tag was already pushed
>>> to the repo previously, if for instance a normal push is made with the
>>> --tags argument.
>>
>> Do you mean that you want to forbid some people from pushing tags
>> into that repository while allowing others (i.e. those who manage
>> production deployment)?  If that is the goal, it sounds like that
>> the right place to do this is at the receiving end via pre-receive,
>> not at the sending end via pre-push.
>>

> Unfortunately in this case we don't have control over the hooks at the
> receiving end - we want to prevent tags from being pushed by all users
> to these repo's.

Well, if you refuse to or are unable to use the mechanism that was
specifically designed to solve your problem, then there is no way we
can offer you a good solution.

Let's set the baseline of the discussion first.

We agree that any client-side mechanism (like the hook) is *not* a
good way to enforce policy or ensure security. It is merely a way to
avoid mistakes---prevent the users to avoid doing something they are
allowed to do (at the mechanical level) that is not desirable to the
project.  After all, the user's hook can be misconfigured (or
disabled) by mistake, or the user's workstation may have an older
version of Git that does not know about the hook, thereby bypassing
whategver you try to do on the client side.  The user can even say
"git push --no-verify".  That is why a true policy-enforcement and
security must be done on the receiving end.

So our conversation must start from the shared understanding that
you are seeking a client-side "convention" that helps users avoid
mistakes.  You do not have anything more than "convention" to force
certain behaviour on users.  Are we in agreement?

Now, if a "convention," is an acceptaible solution, you do not even
necessarily need a hook. You can give "git mypush" to the users,
tell them to use it instead of "git push" and do whatever check in
"git mypush" and you are done.  If your users can be told not to run
"git push" with --no-verify, they can certainly taught not to use
"git push" but to use "git mypush". Cf. 5 valid reasons to have hook
(http://thread.gmane.org/gmane.comp.version-control.git/71069).

The reason why we added pre-push is primarily because parsing the
command line is too brittle a way to guess what will be pushed.
When the user says "git push" and your "hook" sees "ah, there is no
argument", that does not mean the user did not try to push any
tags.  The user may have "remote.origin.push" refspec to always push
things without typing from the command line, for example.  The
approach to inspect the command line, whether it is done in "hook"
or "git mypush", is unworkable, and that is why pre-push is told
what "git push" decided to update on the remote end.

Having said all that, I am not sure if ec55559f (push: Add support
for pre-push hooks, 2013-01-13) implemented the pre-push hook
correctly.

I do not offhand know (I am on a bus with terrible connection so I
won't bother checking the source now) if we send "this ref has to
point at that object" even for STATUS_UPTODATE cases, to cause your
remote to trigger the receive hook in the frist place, but if that
is the case, then the code in run_pre_push_hook() that omits such
refs from the hook input looks just *wrong*.  On the other hand, I
do not offhand think of a valid reason for the push codepath (with
or without the pre-push hook) to send "this ref has to point at that
object" when we know the ref is already pointing at that object, so
I am not sure if your claim (i.e. "when ... was already pushed
previously") is true for a correctly built receiving side of Git.

On the other side, if we are telling the other end "I know your
refs/tags/v1.0 is pointing at this object, but I am telling you to
point at it again anyway", then we should be feeding pre-push that,
too.  The code here in transport.c omits UPTODATE ones, and it may
need to be disabled to be consistent.

	for (r = remote_refs; r; r = r->next) {
		if (!r->peer_ref) continue;
		if (r->status == REF_STATUS_REJECT_NONFASTFORWARD) continue;
		if (r->status == REF_STATUS_REJECT_STALE) continue;
		if (r->status == REF_STATUS_UPTODATE) continue;

		strbuf_reset(&buf);
		strbuf_addf( &buf, "%s %s %s %s\n",
			 r->peer_ref->name, sha1_to_hex(r->new_sha1),
			 r->name, sha1_to_hex(r->old_sha1));

		if (write_in_full(proc.in, buf.buf, buf.len) != buf.len) {
			ret = -1;
			break;
		}
