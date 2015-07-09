From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] clone: Simplify string handling in guess_dir_name()
Date: Thu, 09 Jul 2015 11:05:04 -0700
Message-ID: <xmqq1tghw6jz.fsf@gitster.dls.corp.google.com>
References: <CAHGBnuPkia6UYeN4jekfGzypV2MpyiMs2W+O=SSJR3hR=K3g0A@mail.gmail.com>
	<0000014e73d7c3d8-413991dd-3907-430c-ab99-a0a3d93dcab0-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 09 20:05:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDGC9-0001iz-Cz
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jul 2015 20:05:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754144AbbGISFI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2015 14:05:08 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:37438 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753850AbbGISFH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2015 14:05:07 -0400
Received: by igpy18 with SMTP id y18so2412110igp.0
        for <git@vger.kernel.org>; Thu, 09 Jul 2015 11:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=xSoKnXF6pkIBLQsEd/IHThBNLdUwEvdeX2uLlqXHjXE=;
        b=IzPFCU4t3Ss9rHSDRHAIg3EqyKES94N+2Wju9Bt8jgw2OaFPTh3fqCZaSdijxNibEW
         7ug529PsYkL57/EpKCZE/YeJMKDAMi0I7+jED7jXVpeR9BXls2bFfohhyaRckRgyLWiV
         mm7936n/omNclcddV7FJ4WFosR5OYDeQ2PaMBYGHxSRqayJtuo5GUyUBihGylO7fPZ1w
         BFekMQ6epAzC1dzW2fp58CDR2zoQJHNg4AmVQYLE2F67y5GG5gUxoa0nb8a/6agFi61/
         sK9YXAnj2axxAKCNk2CXv5UL+L0lgp0Na+izt/oGCTY0S9tWW33E4Dhg0Jw+nj4mBQQ/
         bbjQ==
X-Received: by 10.107.164.22 with SMTP id n22mr27349489ioe.73.1436465107297;
        Thu, 09 Jul 2015 11:05:07 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:647a:d824:a8a3:7bb0])
        by smtp.gmail.com with ESMTPSA id a82sm4671697ioe.22.2015.07.09.11.05.06
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 09 Jul 2015 11:05:06 -0700 (PDT)
In-Reply-To: <0000014e73d7c3d8-413991dd-3907-430c-ab99-a0a3d93dcab0-000000@eu-west-1.amazonses.com>
	(Sebastian Schuberth's message of "Thu, 9 Jul 2015 17:23:17 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273766>

Sebastian Schuberth <sschuberth@gmail.com> writes:

> Subject: Re: [PATCH v2] clone: Simplify string handling in guess_dir_name()

We seem not to capitalize the first word on the subject line.

> Content-Type: multipart/mixed;  boundary="----=_Part_8_836493213.1436462597065"

Please don't.

> Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
> ---
>  builtin/clone.c | 16 +++-------------
>  1 file changed, 3 insertions(+), 13 deletions(-)
>
> diff --git a/builtin/clone.c b/builtin/clone.c
> index 00535d0..afdc004 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -147,6 +147,7 @@ static char *get_repo_path(const char *repo, int *is_bundle)
>  static char *guess_dir_name(const char *repo, int is_bundle, int is_bare)
>  {
>  	const char *end = repo + strlen(repo), *start;
> +	size_t len;
>  	char *dir;
>  
>  	/*
> @@ -173,20 +174,9 @@ static char *guess_dir_name(const char *repo, int is_bundle, int is_bare)
>  	/*
>  	 * Strip .{bundle,git}.
>  	 */
> -	if (is_bundle) {
> -		if (end - start > 7 && !strncmp(end - 7, ".bundle", 7))
> -			end -= 7;
> -	} else {
> -		if (end - start > 4 && !strncmp(end - 4, ".git", 4))
> -			end -= 4;
> -	}
> +	strip_suffix(start, is_bundle ? ".bundle" : ".git" , &len);

This looks vastly nicer than the original.

> -	if (is_bare) {
> -		struct strbuf result = STRBUF_INIT;
> -		strbuf_addf(&result, "%.*s.git", (int)(end - start), start);
> -		dir = strbuf_detach(&result, NULL);
> -	} else
> -		dir = xstrndup(start, end - start);
> +	dir = is_bare ? xstrfmt("%.*s.git", (int)len, start) : xstrndup(start, len);

This however I had to read twice.  I'd say

	if (is_bare)
        	dir = xstrfmt(...);
	else
        	dir = xstrndup(...);

is much easier to read.
