From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 06/20] rename_tmp_log(): improve error reporting
Date: Thu, 18 Feb 2016 14:14:19 -0800
Message-ID: <xmqq8u2hfyys.fsf@gitster.mtv.corp.google.com>
References: <cover.1455626201.git.mhagger@alum.mit.edu>
	<e4505a7bde58518dfe968e7e3dc0dadcb7a6ba6b.1455626201.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Karl Moskowski <kmoskowski@me.com>,
	Jeff King <peff@peff.net>, Mike Hommey <mh@glandium.org>,
	David Turner <dturner@twopensource.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Feb 18 23:14:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWWqJ-0001MD-D8
	for gcvg-git-2@plane.gmane.org; Thu, 18 Feb 2016 23:14:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1426509AbcBRWOX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2016 17:14:23 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:53650 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1424744AbcBRWOW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2016 17:14:22 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 63E0F45116;
	Thu, 18 Feb 2016 17:14:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=F6aW5w2qmw44G8IFdxCnL7+3Le8=; b=m4ybPF
	GqsKZ+B6MYPTFyDotu1YTUhZxTEDzVwyZCp7NhxgQvoVZBX4RAUtaQe5D3FGLZeA
	APQlG8759wiDWapip5N4SZhHirDvqg8lW90oyYZGocAwf8SOuJsfwggm6tlFRHAD
	bQBE/Vl8+pUwhgtyyhyVbsZHODGzSuM4UrdE0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ehdk9IFNWvLAPZQx92a8irvVTfb/gCK4
	mF+DWa9EUUDJ5tH3kKazrcmzFWyfcHhgW8brSddnix4weKwBOZ9vhuosMTEqrHh+
	Dqog7Mhx3Ir6WZ8bVf84YA8w8UhuLgrwWOIEM6ts7ydNIga2ufOjw7yscLssAVBD
	D94PWoYq5o0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5B50145115;
	Thu, 18 Feb 2016 17:14:21 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id BD9C645111;
	Thu, 18 Feb 2016 17:14:20 -0500 (EST)
In-Reply-To: <e4505a7bde58518dfe968e7e3dc0dadcb7a6ba6b.1455626201.git.mhagger@alum.mit.edu>
	(Michael Haggerty's message of "Tue, 16 Feb 2016 14:22:19 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F594A8C8-D68C-11E5-B024-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286623>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> * Don't capitalize error strings
> * Report true paths of affected files

Obvious improvements.  Good.

> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
> Maybe these error strings should be internationalized? If so, there
> are a bunch of similar error strings in related functions that should
> be changed at the same time.
>
>  refs/files-backend.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index e5f964c..4266da9 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -2430,10 +2430,11 @@ static int rename_tmp_log(const char *newrefname)
>  	ret = raceproof_create_file(path, rename_tmp_log_callback, &true_errno);
>  	if (ret) {
>  		if (true_errno==EISDIR)
> -			error("Directory not empty: %s", path);
> +			error("directory not empty: %s", path);
>  		else
> -			error("unable to move logfile "TMP_RENAMED_LOG" to logs/%s: %s",
> -				newrefname, strerror(true_errno));
> +			error("unable to move logfile %s to %s: %s",
> +			      git_path(TMP_RENAMED_LOG), path,
> +			      strerror(true_errno));
>  	}
>  
>  	free(path);
