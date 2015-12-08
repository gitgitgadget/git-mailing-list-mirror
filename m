From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/8] update-index: use enum for untracked cache options
Date: Tue, 08 Dec 2015 11:11:35 -0800
Message-ID: <xmqq1tawlpqw.fsf@gitster.mtv.corp.google.com>
References: <1449594916-21167-1-git-send-email-chriscool@tuxfamily.org>
	<1449594916-21167-3-git-send-email-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Torsten =?utf-8?Q?B=C3=B6gersh?= =?utf-8?Q?ausen?= 
	<tboegi@web.de>, Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 08 20:11:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a6Nfp-0003f9-PA
	for gcvg-git-2@plane.gmane.org; Tue, 08 Dec 2015 20:11:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752091AbbLHTLi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Dec 2015 14:11:38 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:56742 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751952AbbLHTLh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Dec 2015 14:11:37 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D188530855;
	Tue,  8 Dec 2015 14:11:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jIq6U2N5MpuNKRBA0XR1QQqI3jc=; b=B7GuUV
	Rx9cz/6VjihUxgl/Vlvt0IhEgQSFuU7v+PBH4GzeCy3dctRY6XaxoBooNQz8KKgZ
	g6Lizr7qoEhZsDIxXFacKv1xu/nfGw+vOI8jPfOIx4k67TeXftqo622twMsB0Rki
	3C8Aa7MMw4XBWbBT/rEdj+17g8psFYVlZtrc4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cZF3iHdSjivKgXMmP34gtxQtP1M2tznT
	lw87QVEHEDYybSnj6Mya+5qOtACHHrxQ15E59obA7zUOyOps89N/SrkBxcG+iJFi
	iIW/oUy4UjutEZwuvg8N6Jjr20RYqW5F1l1JJpfLPw7sQElc/p3khMrD5DIPAVQP
	nCG1t2Ow2Zw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C761F30854;
	Tue,  8 Dec 2015 14:11:36 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 41CB830853;
	Tue,  8 Dec 2015 14:11:36 -0500 (EST)
In-Reply-To: <1449594916-21167-3-git-send-email-chriscool@tuxfamily.org>
	(Christian Couder's message of "Tue, 8 Dec 2015 18:15:10 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 807B8196-9DDF-11E5-8381-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282173>

Christian Couder <christian.couder@gmail.com> writes:

> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  builtin/update-index.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/builtin/update-index.c b/builtin/update-index.c
> index 6f6b289..246b3d3 100644
> --- a/builtin/update-index.c
> +++ b/builtin/update-index.c
> @@ -35,6 +35,14 @@ static int mark_skip_worktree_only;
>  #define UNMARK_FLAG 2
>  static struct strbuf mtime_dir = STRBUF_INIT;
>  
> +/* Untracked cache mode */
> +enum uc_mode {
> +	UNDEF_UC = -1,
> +	NO_UC = 0,
> +	UC,
> +	FORCE_UC
> +};
> +

With these, the code is much easier to read than with the mystery
constants, but did you consider making UC_ a common prefix for
further ease-of-reading?  E.g.

    UC_UNSPECIFIED
    UC_DONTUSE
    UC_USE
    UC_FORCE

or something?

>  __attribute__((format (printf, 1, 2)))
>  static void report(const char *fmt, ...)
>  {
> @@ -902,7 +910,7 @@ static int reupdate_callback(struct parse_opt_ctx_t *ctx,
>  int cmd_update_index(int argc, const char **argv, const char *prefix)
>  {
>  	int newfd, entries, has_errors = 0, line_termination = '\n';
> -	int untracked_cache = -1;
> +	enum uc_mode untracked_cache = UNDEF_UC;
>  	int read_from_stdin = 0;
>  	int prefix_length = prefix ? strlen(prefix) : 0;
>  	int preferred_index_format = 0;
> @@ -997,7 +1005,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
>  		OPT_BOOL(0, "untracked-cache", &untracked_cache,
>  			N_("enable/disable untracked cache")),
>  		OPT_SET_INT(0, "force-untracked-cache", &untracked_cache,
> -			    N_("enable untracked cache without testing the filesystem"), 2),
> +			    N_("enable untracked cache without testing the filesystem"), FORCE_UC),
>  		OPT_END()
>  	};
>  
> @@ -1104,10 +1112,10 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
>  		the_index.split_index = NULL;
>  		the_index.cache_changed |= SOMETHING_CHANGED;
>  	}
> -	if (untracked_cache > 0) {
> +	if (untracked_cache > NO_UC) {
>  		struct untracked_cache *uc;
>  
> -		if (untracked_cache < 2) {
> +		if (untracked_cache < FORCE_UC) {
>  			setup_work_tree();
>  			if (!test_if_untracked_cache_is_supported())
>  				return 1;
> @@ -1123,7 +1131,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
>  		add_untracked_ident(the_index.untracked);
>  		the_index.cache_changed |= UNTRACKED_CHANGED;
>  		fprintf(stderr, _("Untracked cache enabled for '%s'\n"), get_git_work_tree());
> -	} else if (!untracked_cache && the_index.untracked) {
> +	} else if (untracked_cache == NO_UC && the_index.untracked) {
>  		the_index.untracked = NULL;
>  		the_index.cache_changed |= UNTRACKED_CHANGED;
>  		fprintf(stderr, _("Untracked cache disabled\n"));
