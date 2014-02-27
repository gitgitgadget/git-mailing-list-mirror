From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] branch: change install_branch_config() to use skip_prefix()
Date: Thu, 27 Feb 2014 11:42:32 -0800
Message-ID: <xmqq4n3kz6jb.fsf@gitster.dls.corp.google.com>
References: <530F5B41.1050900@yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Dmitry S. Dolzhenko" <dmitrys.dolzhenko@yandex.ru>
X-From: git-owner@vger.kernel.org Thu Feb 27 20:42:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJ6qw-000548-Jj
	for gcvg-git-2@plane.gmane.org; Thu, 27 Feb 2014 20:42:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751773AbaB0Tmi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Feb 2014 14:42:38 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54397 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751051AbaB0Tmh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Feb 2014 14:42:37 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E7A30708C3;
	Thu, 27 Feb 2014 14:42:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gr0shtaJtgpXf40AOSddUH9yRjU=; b=VFIYTk
	nxctv5IHGyppRgjsyy4+p5HXzFdl2HK+UJCbVW9qitdpQ/04v88RhZ9kPw1t73FQ
	SHD1xr7sySPGSkZkaYHCeMl9YroGXxONhQv4epK57WywpnPRzrTQgfhH2FO7JlIy
	PWYFt7ZJhGQWsZx0B+Jy8KO4KtIW7BbPnMGaI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=i+qARhDxn0JEojyRyXUXHojxRqUqV4j3
	BnhC4IXNXBAJ7PYvbo0vcS4o3baKR6UHLj/j50euFcWfPKsFNdLicsGbhSPnSzta
	6es6TYDlXMwFtR4eZNLXHIpt6UAdvzueOG2gP7RJi2fsaEKiv4/6IKKwJ03yoBRM
	hYOJbkw+KUk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C072C708C2;
	Thu, 27 Feb 2014 14:42:36 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DB0FA708C0;
	Thu, 27 Feb 2014 14:42:35 -0500 (EST)
In-Reply-To: <530F5B41.1050900@yandex.ru> (Dmitry S. Dolzhenko's message of
	"Thu, 27 Feb 2014 19:35:29 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 4EC5391E-9FE7-11E3-8854-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242844>

"Dmitry S. Dolzhenko" <dmitrys.dolzhenko@yandex.ru> writes:

> Change install_branch_config() to use skip_prefix()
> for getting the short name of the remote branch.
>
> Signed-off-by: Dmitry S. Dolzhenko <dmitrys.dolzhenko@yandex.ru>
> ---
>  branch.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/branch.c b/branch.c
> index 723a36b..9382e02 100644
> --- a/branch.c
> +++ b/branch.c
> @@ -49,8 +49,8 @@ static int should_setup_rebase(const char *origin)
>  
>  void install_branch_config(int flag, const char *local, const char *origin, const char *remote)
>  {
> -	const char *shortname = remote + 11;
> -	int remote_is_branch = starts_with(remote, "refs/heads/");
> +	const char *shortname = skip_prefix(remote, "refs/heads/");
> +	int remote_is_branch = shortname != NULL;

That sounds more reasonable, compared to the previous round.
I'd probably say this

	int remote_is_branch = !shortname;

instead, if I were doing this patch myself, though.

>  	struct strbuf key = STRBUF_INIT;
>  	int rebasing = should_setup_rebase(origin);
