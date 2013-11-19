From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 ] commit -v: strip diffs and submodule shortlogs from the commit message
Date: Tue, 19 Nov 2013 11:07:06 -0800
Message-ID: <xmqqsius8b39.fsf@gitster.dls.corp.google.com>
References: <loom.20131110T222043-57@post.gmane.org> <528140F5.6090700@web.de>
	<loom.20131111T214646-550@post.gmane.org> <52814C35.6040205@web.de>
	<5281DCC5.2000209@kdbg.org> <5282A90A.4030900@web.de>
	<xmqqy54tfeje.fsf@gitster.dls.corp.google.com>
	<5283C701.8090400@web.de>
	<xmqq7gccdq67.fsf@gitster.dls.corp.google.com>
	<5287F735.3030306@web.de>
	<20131117090935.GC17016@sigill.intra.peff.net>
	<xmqqk3g5d7gy.fsf@gitster.dls.corp.google.com>
	<528BB23D.4020001@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Ari Pollak <ari@debian.org>, git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Nov 19 20:07:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Viqdx-0002Fi-5K
	for gcvg-git-2@plane.gmane.org; Tue, 19 Nov 2013 20:07:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752060Ab3KSTHP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Nov 2013 14:07:15 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42033 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751821Ab3KSTHL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Nov 2013 14:07:11 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7141452335;
	Tue, 19 Nov 2013 14:07:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6fkau4THfJJxVLALEoDzGbDUHYI=; b=PgFX7r
	tWeb1W0unyXsJgeWGEDqQMyGwysf+XBjfVdFXux5jlSOhAFru9nNifZAqrbYI1Dl
	2EtSHlMmxcYS+iG1yQj97V69B8cozzZcQPRGgm1W5G5ZUeFP6R4HaUE3Tztrvoja
	m6Fw5mGDTV3G4QWu8mtPEWzARoKTEG5Iro7jE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=meFruLEeZZegKflxYfMVBglqxRmEe6g7
	lnX+nGXYhCveI7Kva/Gb7UUceYuTw24neYP6m16s5zYOA6+dEKcrdl3gi9DyJXOw
	8235kF3VyA6tI2y9SI+E+/s0hekGXTgpF/b6OWHReDS4syJnvaTvlgqEG6l9772x
	evmBM2xW74w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4812752334;
	Tue, 19 Nov 2013 14:07:10 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3FA965232F;
	Tue, 19 Nov 2013 14:07:09 -0500 (EST)
In-Reply-To: <528BB23D.4020001@web.de> (Jens Lehmann's message of "Tue, 19 Nov
	2013 19:47:25 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C9EF0482-514D-11E3-BBB9-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238036>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> When using the '-v' option of "git commit" the diff added to the commit
> message temporarily for editing is stripped off after the user exited the
> editor by searching for "\ndiff --git " and truncating the commmit message
> there if it is found. But this approach has two problems: when the commit
> message itself contains a line starting with "diff --git" it will be
> truncated there prematurely. And when the "diff.submodule" setting is set
> to "log", the diff may start with "Submodule <hash1>..<hash2>", which will
> be left in the commit message while it shouldn't.
>
> Fix that by introducing a special scissor separator line starting with the
> comment character '#' followed by a line describing what it is for. The
> scissor line - which will not be translated - is used to reliably detect
> the start of the diff so it can be chopped off from the commit message, no
> matter what the user enters there. Turn a known test failure fixed by this
> change into a successful test and add another one for a diff starting with
> a submodule log.
>
> Reported-by: Ari Pollak <ari@debian.org>
> Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
> ---
>
> Am 18.11.2013 17:01, schrieb Junio C Hamano:
>> Jeff King <peff@peff.net> writes:
>> 
>>> I found this hard to parse, I think because of the "keeping" (why would
>>> I not keep it?), and because you are talking about lines above and
>>> below. It is not as accurate to say:
>>>
>>>   # ------------------ >8 --------------------
>>>   # Everything below this line will be removed.
>>>
>>> because it is technically the line above that is the cutoff. But I think
>>> the meaning is clear, and it is simpler to parse.
>
> Ok, changed in this version.
>
>> I agree with your rewording suggestion.  It might make it even more
>> robust to do something like
>> 
>>     const char cut_here[] = "# --- cut here --- >8 --- cut here ---";
>> 
>>     fprintf(fh, "%s\n", cut_here);
>>     fputs(_("# Everything below this line will be removed\n"), fh);
>>     ...
>>     p = strstr(cut_here);
>> 
>> i.e. a real marker line that will never be translated, with an
>> explanation immediately below that can be translated.
>
> Which is what my last version already did :-)  But it didn't mention
> that in the commit message, which it does now).
>
> Also the too strict check for the scissor line is fixed according to
> Peff's proposal, it will now handle an empty commit message correctly
> too.

Thanks.

I have a feeling that the translatable message has to say two
things, though.

 - Any junk below that cut marker will be removed;

 - Do not touch the cut marker, or you will mess up the commit log
   message.

Nobody seems to have brought up the latter in the discussion, but I
have a feeling that the users can do almost anything to break us and
it is better to be defensive for the users.

Perhaps phrase it something like this (the message is to be
translated, but not the marker)?

	# ------------------------ >8 ------------------------
        # Do not touch the cut-marker line above; everything below
        # will be removed.

>
>  builtin/commit.c          |  6 +++---
>  t/t7507-commit-verbose.sh | 15 ++++++++++++++-
>  wt-status.c               |  4 ++++
>  wt-status.h               |  2 ++
>  4 files changed, 23 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 6ab4605..b6d6655 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -1602,9 +1602,9 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>
>  	/* Truncate the message just before the diff, if any. */
>  	if (verbose) {
> -		p = strstr(sb.buf, "\ndiff --git ");
> -		if (p != NULL)
> -			strbuf_setlen(&sb, p - sb.buf + 1);
> +		p = strstr(sb.buf, wt_status_diff_divider);
> +		if (p && (p == sb.buf || p[-1] == '\n'))
> +			strbuf_setlen(&sb, p - sb.buf);
>  	}
>
>  	if (cleanup_mode != CLEANUP_NONE)
> diff --git a/t/t7507-commit-verbose.sh b/t/t7507-commit-verbose.sh
> index da5bd3b..09c1150 100755
> --- a/t/t7507-commit-verbose.sh
> +++ b/t/t7507-commit-verbose.sh
> @@ -65,9 +65,22 @@ test_expect_success 'diff in message is retained without -v' '
>  	check_message diff
>  '
>
> -test_expect_failure 'diff in message is retained with -v' '
> +test_expect_success 'diff in message is retained with -v' '
>  	git commit --amend -F diff -v &&
>  	check_message diff
>  '
>
> +test_expect_success 'submodule log is stripped out too with -v' '
> +	git config diff.submodule log &&
> +	git submodule add ./. sub &&
> +	git commit -m "sub added" &&
> +	(
> +		cd sub &&
> +		echo "more" >>file &&
> +		git commit -a -m "submodule commit"
> +	) &&
> +	GIT_EDITOR=cat test_must_fail git commit -a -v 2>err &&
> +	test_i18ngrep "Aborting commit due to empty commit message." err
> +'
> +
>  test_done
> diff --git a/wt-status.c b/wt-status.c
> index b4e44ba..a499bd2 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -16,6 +16,8 @@
>  #include "column.h"
>  #include "strbuf.h"
>
> +const char wt_status_diff_divider[] = "# -----------------------------------8<-----------------------------------\n";
> +
>  static char default_wt_status_colors[][COLOR_MAXLEN] = {
>  	GIT_COLOR_NORMAL, /* WT_STATUS_HEADER */
>  	GIT_COLOR_GREEN,  /* WT_STATUS_UPDATED */
> @@ -791,6 +793,8 @@ static void wt_status_print_verbose(struct wt_status *s)
>  	 */
>  	if (s->fp != stdout)
>  		rev.diffopt.use_color = 0;
> +	fprintf(s->fp, wt_status_diff_divider);
> +	fprintf(s->fp, _("# Everything below this line will be removed.\n"));
>  	run_diff_index(&rev, 1);
>  }
>
> diff --git a/wt-status.h b/wt-status.h
> index 6c29e6f..cd2709f 100644
> --- a/wt-status.h
> +++ b/wt-status.h
> @@ -91,6 +91,8 @@ struct wt_status_state {
>  	unsigned char cherry_pick_head_sha1[20];
>  };
>
> +const char wt_status_diff_divider[];
> +
>  void wt_status_prepare(struct wt_status *s);
>  void wt_status_print(struct wt_status *s);
>  void wt_status_collect(struct wt_status *s);
