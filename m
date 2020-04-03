Return-Path: <SRS0=9X1Y=5T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12012C43331
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 05:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C85BA20787
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 05:13:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="nurvlx6i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730698AbgDCFNq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Apr 2020 01:13:46 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56741 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728856AbgDCFNq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Apr 2020 01:13:46 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 36C2A45356;
        Fri,  3 Apr 2020 01:13:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1ujowr4Yx1TDNlrUZLn0eqIDHU0=; b=nurvlx
        6i553sy8X5o3N/x0zKSuQ8vYo9Vj1gqRWyp3UyqcHvXKCHDAnPdtGRB4zMpZguY9
        L+vaB66CExZPyxiHwgqIgv5e3MvueVe0LPNqHg/kg8T8WGLdaYZsQSLZJvddrjvY
        HQTAbv80XkeB76lhMxuWFZu4SxgtUNGmiR4tQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=anNCOJcUlE2pUtVUra75TQbWb9QqhbTc
        WXoB9ZDUSfdkbfkJ0KZ8oIOK5h65ztcv5XxK6LIRSwgzkrysEQu+YJMhOyAXZUy8
        rKFwGLHEyfsBo3vn2JqKA0yM/vgAeDqKT76Uf5i7OCm/rd5vrM8T9rttPdverybC
        9fzoX0wp+cY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1B21C45352;
        Fri,  3 Apr 2020 01:13:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8039845351;
        Fri,  3 Apr 2020 01:13:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Miriam Rubio <mirucam@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 02/11] bisect--helper: introduce new `write_in_file()` function
References: <20200321161020.22817-1-mirucam@gmail.com>
        <20200321161020.22817-3-mirucam@gmail.com>
Date:   Thu, 02 Apr 2020 22:13:43 -0700
In-Reply-To: <20200321161020.22817-3-mirucam@gmail.com> (Miriam Rubio's
        message of "Sat, 21 Mar 2020 17:10:11 +0100")
Message-ID: <xmqqeet51794.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E3FF8CBA-7569-11EA-BB71-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Miriam Rubio <mirucam@gmail.com> writes:

> Let's refactor code adding a new `write_in_file()` function
> that opens a file for writing a message and closes it.
>
> This helper will be used in later steps and makes the code
> simpler and easier to understand.
>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Signed-off-by: Miriam Rubio <mirucam@gmail.com>
> ---
>  builtin/bisect--helper.c | 27 +++++++++++++++++++++------
>  1 file changed, 21 insertions(+), 6 deletions(-)
>
> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> index 1f81cff1d8..e949ea74e2 100644
> --- a/builtin/bisect--helper.c
> +++ b/builtin/bisect--helper.c
> @@ -74,6 +74,26 @@ static int one_of(const char *term, ...)
>  	return res;
>  }
>  
> +static int write_in_file(const char *filepath, const char *mode, const char *format,...)
> +{
> +	FILE *fp = NULL;

It is crystal clear in this concise helper function that fp will
never be used without getting assigned the returned value from
fopen(), so I do not think there is any need to initialize it to
NULL.

I'd use "path", not "filepath" (which I do not think we use anywhere
in our codebase), if I were writing this function, by the way.

> +	va_list args;
> +	int res = 0;
> +
> +	if (!strcmp(mode, "a") && !strcmp(mode, "w"))
> +		return error_errno(_("wrong writing mode '%s'"), mode);

I do not see where you saw a failure from a call to system library
function, which would make 'errno' variable valid at this point, so
I am puzzled.  By using error_errno(), whose error status are you
trying to show?

Puzzled.  Shouldn't it be just error(_("..."), mode)?

> +	fp = fopen(filepath, mode);
> +	if (!fp)
> +		return error_errno(_("could not open file '%s'"), filepath);

This one would show why fopen() failed, so error_errno() would be good.
Does it help us help the users if they can tell us which mode we failed
to write to the file?   Something like

	cannot open file '%s' in mode '%s'

perhaps?

> +	va_start(args, format);
> +	res = vfprintf(fp, format, args);
> +	va_end(args);
> +	if (!res)
> +		return error_errno(_("could not write to file '%s'"), filepath);

This would show errors from vfprintf(), which is good.  However, you
fail to fclose the FILE when this return is hit, which is not good.

> +	return fclose(fp);
> +}
> +
>  static int check_term_format(const char *term, const char *orig_term)
>  {
>  	int res;
> @@ -104,7 +124,6 @@ static int check_term_format(const char *term, const char *orig_term)
>  
>  static int write_terms(const char *bad, const char *good)
>  {
> -	FILE *fp = NULL;
>  	int res;
>  
>  	if (!strcmp(bad, good))
> @@ -113,12 +132,8 @@ static int write_terms(const char *bad, const char *good)
>  	if (check_term_format(bad, "bad") || check_term_format(good, "good"))
>  		return -1;
>  
> -	fp = fopen(git_path_bisect_terms(), "w");
> -	if (!fp)
> -		return error_errno(_("could not open the file BISECT_TERMS"));
> +	res = write_in_file(git_path_bisect_terms(), "w", "%s\n%s\n", bad, good);
>  
> -	res = fprintf(fp, "%s\n%s\n", bad, good);
> -	res |= fclose(fp);
>  	return (res < 0) ? -1 : 0;
>  }
