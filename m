From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jan 2010, #07; Fri, 22)
Date: Sat, 23 Jan 2010 18:11:26 -0800
Message-ID: <7veilg9rqp.fsf@alter.siamese.dyndns.org>
References: <7vtyudfqju.fsf@alter.siamese.dyndns.org> <4B5B25C6.70604@web.de>
 <7v7hr8d1xg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sun Jan 24 03:15:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYs0S-0004CG-U4
	for gcvg-git-2@lo.gmane.org; Sun, 24 Jan 2010 03:15:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751863Ab0AXCLf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Jan 2010 21:11:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751832Ab0AXCLf
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jan 2010 21:11:35 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:41891 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750773Ab0AXCLe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jan 2010 21:11:34 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B3CDB93D0F;
	Sat, 23 Jan 2010 21:11:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0xwmR4ZftzquXfKFQ3z2cqBj/TA=; b=hjbFvr
	AaIOWAX6C/nsRJvTiDEa1uy3bI3ed/mNhKPDmq88ZVl/kbQgVMX6Y8AcGhc1Kpcl
	GwRyKRrkPmc4woxfLJpIOpb9d5+Ji/RdrYDcBEhObWmIPGFczs1AqHt7MUnwgnwX
	W9wZH/DLnJpVa2zSFCGywuEViaZVh8aA3CsR4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=an1YAiMrJa+DK8CzNoFbIGhtJTIeJhPb
	bhzNpScUzIyeu0AtnEMcQiIIvQyiSrYT/UUA9riwDZ7dzJy2qGD9xLOYADY5Von/
	cuchNjYO09YjuTce19u0XvQKmrf5JPKMieKeGTRIOwaIJvHDdZYRLa/7eik7Rjzu
	JyXwUt1LoEM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8AF7393D0E;
	Sat, 23 Jan 2010 21:11:30 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AA68293D0C; Sat, 23 Jan
 2010 21:11:27 -0500 (EST)
In-Reply-To: <7v7hr8d1xg.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sat\, 23 Jan 2010 12\:03\:07 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C948A9A0-088D-11DF-9897-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137881>

Junio C Hamano <gitster@pobox.com> writes:

> Jens Lehmann <Jens.Lehmann@web.de> writes:
> ...
>> @@ -220,7 +224,7 @@ static int get_stat_data(struct cache_entry *ce,
>>  			 const unsigned char **sha1p,
>>  			 unsigned int *modep,
>>  			 int cached, int match_missing,
>> -			 unsigned *dirty_submodule, int output_format)
>> +			 unsigned *dirty_submodule, struct diff_options *diffopt)
>>  {
>>  	const unsigned char *sha1 = ce->sha1;
>>  	unsigned int mode = ce->ce_mode;
>
> Below the context of this hunk, we seem to do this:
>
> 	if (!cached && !ce_uptodate(ce)) {
>         	...
>                 if gitlink then call is_submodule_modified()
> 	}
>
> But isn't it inconsistent with hunk at the beginning of this patch (ll 161-170)
> that essentially says "entries that is ce_uptodate() is Ok, but if it is a
> gitlink we need to look deeper"?  Why isn't this function looking deeper
> even when we see that the submodule entry is ce_uptodate()?
>
>     Side note: the lack of ce_skip_worktree() check is Ok.  The callers of
>     get_stat_data() are show_new_file() and show_mododified() but they are
>     never called from their sole caller, do_oneway_diff(), on a skipped
>     worktree entry.

I think we need to clarify the rule for ce_uptodate(ce).

The rule has always been that an entry that is ce_uptodate(ce) is _known_
to be clean, and nobody should have to dig deeper to double check.  We
should keep it that way.

We at least need to fix preload_index() not to mark any gitlink entries
with ce_mark_uptodate(ce), as your series changes the definition of a
dirty submodule.  It used to be that if a submodule is checked out and its
HEAD matches what is recorded in the index of the superproject, then the
submodule is clean.  The checks made in preload_thread() is consistent
with this definition.

With the update, we consider that having local changes in the submodule
(either to the index or to the work tree files) makes it modified (which
by the way is a right definition, and prevents people from forgetting to
commit in the submodule and updating the superproject index with the new
submodule commit, before commiting the state in the superproject).

Because the checks in preload_thread() does not cover this kind of change
that is_submodule_modified() reports, it shouldn't mark a gitlink entry as
ce_uptodate(ce).

Another possibility is to run the is_submodule_modified() check inside
ie_match_stat(), but (1) I don't know if that function is thread-safe, and
(2) I don't think we would want to do it in preload-index time (it is
rather expensive).

The reason preload_index() passes CE_MATCH_RACY_IS_DIRTY to ie_match_stat() 
is to avoid doing a rather expensive ce_modified_check_fs() --- it avoids
the overhead and leaves the expensive check to the true callers that care
if the entry is really clean.  In the same sense, even if we were to run
is_submodule_modified() there, we would want to avoid doing so when we are
running ie_match_stat() from preload codepath.

We need to also see if there other codepaths that call
ce_mark_uptodate(ce) on a gitlink that hasn't been checked with
is_submodule_modified(), and eliminate them.

Then we can fix the "even though ce_uptodate(ce) says this entry is clean,
if it is gitlink, we need to double check" insanity around ll 164 of
diff-lib.c.  We should be able to trust ce_uptodate(ce) even for gitlinks.

What do you think?
