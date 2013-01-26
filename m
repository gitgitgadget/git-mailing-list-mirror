From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] lazily load commit->buffer
Date: Sat, 26 Jan 2013 13:26:53 -0800
Message-ID: <7v8v7f1vqa.fsf@alter.siamese.dyndns.org>
References: <510124F5.9090505@atlas-elektronik.com>
 <CACsJy8B9O=A26_=sv1JEYdtazsWa4khZkqpTgFSSTs_RGGPZqQ@mail.gmail.com>
 <51013FDD.5030004@atlas-elektronik.com>
 <CACsJy8CEofqi9S8-SDx_O+Ko0i56aRZ4KEJrVnbFum6zzsJrJg@mail.gmail.com>
 <20130124232721.GA16036@sigill.intra.peff.net>
 <7va9ry87a0.fsf@alter.siamese.dyndns.org>
 <7vzjzx7w01.fsf@alter.siamese.dyndns.org>
 <20130125055331.GC26524@elie.Belkin>
 <FE6CC927-1915-4486-BBB8-4C109F7B5295@me.com>
 <7vip6l5l71.fsf@alter.siamese.dyndns.org>
 <20130126094026.GA9646@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathon Mah <jmah@me.com>, Jonathan Nieder <jrnieder@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Stefan =?utf-8?Q?N=C3=A4we?= <stefan.naewe@atlas-elektronik.com>,
	Armin <netzverweigerer@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jan 26 22:27:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzDHV-00076v-1m
	for gcvg-git-2@plane.gmane.org; Sat, 26 Jan 2013 22:27:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754619Ab3AZV06 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jan 2013 16:26:58 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58132 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754320Ab3AZV05 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jan 2013 16:26:57 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3B1F1CF7E;
	Sat, 26 Jan 2013 16:26:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IqQ6nBGKl//rLHJp6yX6oPqmH1Y=; b=lEeaFX
	h9DrWj/l2uIk1rYkXxh+Nqb6iY4vgrC10k26ImLm2WxhYi6pyq9mrpr3r1CFSX7x
	KpH0myc+s2NLXsmOXoTTqIJL3T1I+nBZ+J91+z+pz0cubJFsXl0tGpzdBnewK57Z
	ItFsIlcLOTNgvF9EZdtUcTwpmXJuDkEe5XAPE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kWUINZKBtSDMOO4YKRhd6mAe5jWnZo95
	OHJkxqy/kHwCMXvnBFlc9uq/rf7tuEL/iCpMHb8exZOvbRltLPxEvOTepzAdWSRI
	8UWIHediZU09ufWgZD3jInMH2DFXZp1HUdsW8QBuhNRgZv1a+z/+Ho8OgBwU6+jl
	pHIyze1vIQo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2F1B6CF7D;
	Sat, 26 Jan 2013 16:26:56 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 890AECF7C; Sat, 26 Jan 2013
 16:26:55 -0500 (EST)
Proposes-Reverting: a6c730644b7e1d35bd0d26962dbc978aa47d1863
In-Reply-To: <20130126094026.GA9646@sigill.intra.peff.net> (Jeff King's
 message of "Sat, 26 Jan 2013 04:40:28 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1BD71A70-67FF-11E2-9D17-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214637>

Jeff King <peff@peff.net> writes:

> Yeah, agreed. I started to fix this up with a use/unuse pattern and
> realized something: all of the call sites are calling logmsg_reencode
> anyway, because that is the next logical step in doing anything with the
> buffer that is not just parsing out the parent/timestamp/tree info. And
> since that function already might allocate (for the re-encoded copy),
> callers have to handle the maybe-borrowed-maybe-free situation already.
>
> So I came up with this patch series, which I think should fix the
> problem, and actually makes the call-sites easier to read, rather than
> harder.
>
>   [1/3]: commit: drop useless xstrdup of commit message
>   [2/3]: logmsg_reencode: never return NULL
>   [3/3]: logmsg_reencode: lazily load missing commit buffers
>
> Here's the diffstat:
>
>  builtin/blame.c                  | 22 ++-------
>  builtin/commit.c                 | 14 +-----
>  commit.h                         |  1 +
>  pretty.c                         | 93 ++++++++++++++++++++++++++---------
>  t/t4042-diff-textconv-caching.sh |  8 +++
>  5 files changed, 85 insertions(+), 53 deletions(-)
>
> Not too bad, and 27 of the lines added in pretty.c are new comments
> explaining the flow of logmsg_reencode. So even if this doesn't get
> every case, I think it's a nice cleanup.

This looks very good.

I wonder if this lets us get rid of the hack in cmd_log_walk() that
does this:

        while ((commit = get_revision(rev)) != NULL) {
                if (!log_tree_commit(rev, commit) &&
                    rev->max_count >= 0)
                        rev->max_count++;
!               if (!rev->reflog_info) {
!                       /* we allow cycles in reflog ancestry */
                        free(commit->buffer);
                        commit->buffer = NULL;
!               }
                free_commit_list(commit->parents);
                commit->parents = NULL;

After log_tree_commit() handles the commit, using the buffer, we
discard the memory associated to it because we know we no longer
will use it in normal cases.

The "do not do that if rev->reflog_info is true" was added in
a6c7306 (--walk-reflogs: do not crash with cyclic reflog ancestry,
2007-01-20) because the second and subsequent display of "commit"
(which happens to occur only when walking reflogs) needs to look at
commit->buffer again, and this hack forces us to retain the buffer
for _all_ commit objects.

But your patches could be seen as a different (and more correct) way
to fix the same issue.  Once the display side learns how to re-read
the log text of the commit object, the above becomes unnecessary, no?

We may still be helped if majority of commit objects that appear in
the reflog appear more than once, in which case retaining the buffer
for _all_ commits could be an overall win.  Not having to read the
buffer for the same commit each time it is shown for majority of
multiply-appearing commits, in exchange for having to keep the
buffer for commits that appears only once that are minority and
suffering increasted page cache pressure.  That could be seen as an
optimization.

But that is a performance thing, not a correctness issue, so "we
allow cycles" implying "therefore if we discard the buffer, we will
show wrong output" becomes an incorrect justification.

I happen to have HEAD reflog that is 30k entries long; more than 26k
represent a checkout of unique commit.  So I suspect that the above
hack to excessive retain commit->buffer for already used commits will
not help us performance-wise, either.
