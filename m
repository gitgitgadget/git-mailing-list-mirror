From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pathspec: remove check_path_for_gitlink
Date: Thu, 05 May 2016 16:09:25 -0700
Message-ID: <xmqqbn4k85lm.fsf@gitster.mtv.corp.google.com>
References: <1462487497-28394-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: pclouds@gmail.com, git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri May 06 01:09:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aySOj-0008Gb-NG
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 01:09:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754344AbcEEXJa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2016 19:09:30 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62194 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753293AbcEEXJ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2016 19:09:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 357CA19D58;
	Thu,  5 May 2016 19:09:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fgP41B9X5HxQkYS4vDyXXtBW8Kw=; b=v5A8i6
	lbtWBe7v+SZAs26HMDigG7AEXB1kv1XQidKKdDA9p0coFipUI/4H4OyAYGkKJIwC
	4T9Wd6tdrAiduPi/hN/xpgJ+0AIQjRdpjCwHIjO0ZYiclfJvo3Eq5KM1V5zTb0NE
	qtplZ+S8cEwUVp+XvsKFaxCR/DDX1GqbYhHSI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gr0erIrrK4Iti9tuhZJr6NhZMBsnVIZh
	2KOkn6aPhARp+TdLk4ZdXztj0FjgR+kUqpK8c4DAEmpc09jO8/ElchiteZPpstV1
	OdlThl2OziTO9HJGwi0Q2F/GAxZvz6BxFoTv9yK2Z6+bk9IYjL7ZWwPX601bE+6F
	SAlwYnh4FDg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2909B19D57;
	Thu,  5 May 2016 19:09:28 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A187B19D53;
	Thu,  5 May 2016 19:09:27 -0400 (EDT)
In-Reply-To: <1462487497-28394-1-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Thu, 5 May 2016 15:31:37 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6A674B2C-1316-11E6-ABCF-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293722>

Stefan Beller <sbeller@google.com> writes:

> `check_path_for_gitlink` was introduced in 9d67b61f739a (2013-01-06,
> add.c: extract check_path_for_gitlink() from treat_gitlinks() for reuse)
> but the implementation was removed in 5a76aff1a6 (2013-07-14, add:
> convert to use parse_pathspec).
>
> Remove the declaration from the header as well.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  pathspec.h | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/pathspec.h b/pathspec.h
> index 0c11262..b596aed 100644
> --- a/pathspec.h
> +++ b/pathspec.h
> @@ -96,7 +96,6 @@ static inline int ps_strcmp(const struct pathspec_item *item,
>  
>  extern char *find_pathspecs_matching_against_index(const struct pathspec *pathspec);
>  extern void add_pathspec_matches_against_index(const struct pathspec *pathspec, char *seen);
> -extern const char *check_path_for_gitlink(const char *path);
>  extern void die_if_path_beyond_symlink(const char *path, const char *prefix);
>  
>  #endif /* PATHSPEC_H */

Interesting.

I wonder if the patches mentioned have something to do with the "git
add deep/in/the/tree" that fails to notice deep/in/ is an unrelated
repository in some way?
