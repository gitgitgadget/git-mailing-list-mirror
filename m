From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] notes: allow merging from arbitrary references
Date: Mon, 28 Dec 2015 15:42:50 -0800
Message-ID: <xmqqbn9ajg1x.fsf@gitster.mtv.corp.google.com>
References: <1451326763-8447-1-git-send-email-jacob.e.keller@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Mike Hommey <mh@glandium.org>,
	Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jacob Keller <jacob.keller@gmail.com>
To: Jacob Keller <jacob.e.keller@intel.com>
X-From: git-owner@vger.kernel.org Tue Dec 29 00:42:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDhRL-0005xI-2n
	for gcvg-git-2@plane.gmane.org; Tue, 29 Dec 2015 00:42:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752788AbbL1Xmz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Dec 2015 18:42:55 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:63769 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752631AbbL1Xmx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Dec 2015 18:42:53 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B36423955F;
	Mon, 28 Dec 2015 18:42:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VYqiKiOCaAJmNrgtGBZV4aUOkDU=; b=vUHKp4
	ancokQxVG+ebqP5CjJKUpbJDDV4C74sNPAWnl8hhXbl7HbQC0Fp57QcBVqTU4ioe
	LI2mZr/yojKMMnCjom3nZZSURVw9Z+LfL3VPQrHDaciJQyFwoJHbfmpu3qkzO3pp
	gnAMCRb1t7tzYJXIWQ06EbdeOIOxL9Coo4lIg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wxiQC2ZP68GogkmDpAeLtblNUcj2dBwj
	ilx/FWqr5goDwH+VyBm56RtmFuWDs5WtHf+ZZmSWtNaS2up+j/qk1G+iZl862oad
	KodnYn8vESgrNJHI2H0aWExTSVE2D62Ds7NbzsO1dyVy2lbdyq+tMKrjw9PMTDvq
	jkwuYEaL2VE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AB7AD3955E;
	Mon, 28 Dec 2015 18:42:52 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id F00F13955B;
	Mon, 28 Dec 2015 18:42:51 -0500 (EST)
In-Reply-To: <1451326763-8447-1-git-send-email-jacob.e.keller@intel.com>
	(Jacob Keller's message of "Mon, 28 Dec 2015 10:19:23 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B5C8F6F2-ADBC-11E5-AA26-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283053>

Jacob Keller <jacob.e.keller@intel.com> writes:

> From: Jacob Keller <jacob.keller@gmail.com>
>
> Create a new expansion function, expand_loose_notes_ref which will first
> check whether the ref can be found using get_sha1. If it can't be found
> then it will fallback to using expand_notes_ref. The content of the
> strbuf will not be changed if the notes ref can be located using
> get_sha1. Otherwise, it may be updated as done by expand_notes_ref.
>
> Since we now support merging from non-notes refs, remove the test case
> associated with that behavior. Add a test case for merging from a
> non-notes ref.
>
> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
> ---
> Dropping the version number since this is a resend of a very old patch
> and Junio already said he had dropped it from queue.

OK, will try to queue again (but I am cutting an -rc today so it may
have to wait a bit).  Those who have been involved in the notes topics
need to review it before the patch can make progress, though.

Thanks.


>
>  builtin/notes.c        |  4 ++--
>  notes.c                | 10 ++++++++++
>  notes.h                |  7 +++++++
>  t/t3308-notes-merge.sh | 22 +++++++++++-----------
>  4 files changed, 30 insertions(+), 13 deletions(-)
>
> diff --git a/builtin/notes.c b/builtin/notes.c
> index 515cebbeb8a3..0d3e49ef66a8 100644
> --- a/builtin/notes.c
> +++ b/builtin/notes.c
> @@ -806,7 +806,7 @@ static int merge(int argc, const char **argv, const char *prefix)
>  
>  	o.local_ref = default_notes_ref();
>  	strbuf_addstr(&remote_ref, argv[0]);
> -	expand_notes_ref(&remote_ref);
> +	expand_loose_notes_ref(&remote_ref);
>  	o.remote_ref = remote_ref.buf;
>  
>  	t = init_notes_check("merge");
> @@ -833,7 +833,7 @@ static int merge(int argc, const char **argv, const char *prefix)
>  	}
>  
>  	strbuf_addf(&msg, "notes: Merged notes from %s into %s",
> -		    remote_ref.buf, default_notes_ref());
> +		    argv[0], default_notes_ref());
>  	strbuf_add(&(o.commit_msg), msg.buf + 7, msg.len - 7); /* skip "notes: " */
>  
>  	result = notes_merge(&o, t, result_sha1);
> diff --git a/notes.c b/notes.c
> index db77922130b4..086cc483e518 100644
> --- a/notes.c
> +++ b/notes.c
> @@ -1303,3 +1303,13 @@ void expand_notes_ref(struct strbuf *sb)
>  	else
>  		strbuf_insert(sb, 0, "refs/notes/", 11);
>  }
> +
> +void expand_loose_notes_ref(struct strbuf *sb)
> +{
> +	unsigned char object[20];
> +
> +	if (get_sha1(sb->buf, object)) {
> +		/* fallback to expand_notes_ref */
> +		expand_notes_ref(sb);
> +	}
> +}
> diff --git a/notes.h b/notes.h
> index 2a3f92338076..431f14378817 100644
> --- a/notes.h
> +++ b/notes.h
> @@ -294,4 +294,11 @@ void string_list_add_refs_from_colon_sep(struct string_list *list,
>  /* Expand inplace a note ref like "foo" or "notes/foo" into "refs/notes/foo" */
>  void expand_notes_ref(struct strbuf *sb);
>  
> +/*
> + * Similar to expand_notes_ref, but will check whether the ref can be located
> + * via get_sha1 first, and only falls back to expand_notes_ref in the case
> + * where get_sha1 fails.
> + */
> +void expand_loose_notes_ref(struct strbuf *sb);
> +
>  #endif
> diff --git a/t/t3308-notes-merge.sh b/t/t3308-notes-merge.sh
> index 24d82b49bbea..19aed7ec953b 100755
> --- a/t/t3308-notes-merge.sh
> +++ b/t/t3308-notes-merge.sh
> @@ -18,7 +18,9 @@ test_expect_success setup '
>  	git notes add -m "Notes on 1st commit" 1st &&
>  	git notes add -m "Notes on 2nd commit" 2nd &&
>  	git notes add -m "Notes on 3rd commit" 3rd &&
> -	git notes add -m "Notes on 4th commit" 4th
> +	git notes add -m "Notes on 4th commit" 4th &&
> +	# Copy notes to remote-notes
> +	git fetch . refs/notes/*:refs/remote-notes/origin/*
>  '
>  
>  commit_sha1=$(git rev-parse 1st^{commit})
> @@ -66,7 +68,9 @@ test_expect_success 'verify initial notes (x)' '
>  '
>  
>  cp expect_notes_x expect_notes_y
> +cp expect_notes_x expect_notes_v
>  cp expect_log_x expect_log_y
> +cp expect_log_x expect_log_v
>  
>  test_expect_success 'fail to merge empty notes ref into empty notes ref (z => y)' '
>  	test_must_fail git -c "core.notesRef=refs/notes/y" notes merge z
> @@ -84,16 +88,12 @@ test_expect_success 'fail to merge into various non-notes refs' '
>  	test_must_fail git -c "core.notesRef=refs/notes/foo^{bar" notes merge x
>  '
>  
> -test_expect_success 'fail to merge various non-note-trees' '
> -	git config core.notesRef refs/notes/y &&
> -	test_must_fail git notes merge refs/notes &&
> -	test_must_fail git notes merge refs/notes/ &&
> -	test_must_fail git notes merge refs/notes/dir &&
> -	test_must_fail git notes merge refs/notes/dir/ &&
> -	test_must_fail git notes merge refs/heads/master &&
> -	test_must_fail git notes merge x: &&
> -	test_must_fail git notes merge x:foo &&
> -	test_must_fail git notes merge foo^{bar
> +test_expect_success 'merge non-notes ref into empty notes ref (remote-notes/origin/x => v)' '
> +	git config core.notesRef refs/notes/v &&
> +	git notes merge refs/remote-notes/origin/x &&
> +	verify_notes v &&
> +	# refs/remote-notes/origin/x and v should point to the same notes commit
> +	test "$(git rev-parse refs/remote-notes/origin/x)" = "$(git rev-parse refs/notes/v)"
>  '
>  
>  test_expect_success 'merge notes into empty notes ref (x => y)' '
