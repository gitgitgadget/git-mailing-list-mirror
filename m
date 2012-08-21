From: Junio C Hamano <gitster@pobox.com>
Subject: Re: receive.denyNonNonFastForwards not denying force update
Date: Tue, 21 Aug 2012 09:50:27 -0700
Message-ID: <7v1uj0fauk.fsf@alter.siamese.dyndns.org>
References: <CAHgXSop42qWcAEGn6=og8Pistv_Jrwhgcnv3B_ORVtSMi1fCHA@mail.gmail.com>
 <CAHgXSooFj2PJtcOWqsVNHUzMBQnH0cYzPjfs1CkzVuufwRVrog@mail.gmail.com>
 <7vzk5pjxy3.fsf@alter.siamese.dyndns.org>
 <CAMK1S_hMTGhiKDow3x-UZ7eNnTtpLd2=QUf6-YoQF1-O1ywi2w@mail.gmail.com>
 <7v628dght9.fsf@alter.siamese.dyndns.org>
 <20120821015738.GA20271@sigill.intra.peff.net>
 <7vpq6kgazt.fsf@alter.siamese.dyndns.org>
 <20120821061059.GA26516@sigill.intra.peff.net>
 <20120821062219.GB26516@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sitaram Chamarty <sitaramc@gmail.com>,
	John Arthorne <arthorne.eclipse@gmail.com>,
	git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 21 18:50:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3rf7-0002eo-Aa
	for gcvg-git-2@plane.gmane.org; Tue, 21 Aug 2012 18:50:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758177Ab2HUQug (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Aug 2012 12:50:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39148 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758133Ab2HUQua (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Aug 2012 12:50:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D8F8D6914;
	Tue, 21 Aug 2012 12:50:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ydhOjnAoReSgKpAzQeYe+WmZk0U=; b=dQJT6l
	dCvKpB8/qBQ3DHk0wtfRXiHZ0+ylbnq8P5t2g1fwnWkFGQr1DybENQKekytOaU38
	gmufaoxSvAa3/90YgPicJa0cSmL3MoqWgODprmJQhLoew583Jycho2SLq5vTm0Sm
	aH/JRhfXTj0Ob2/5BZg45Kotl+kiFW2UltnBQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XY3M6e2WuPN2MzGpr9WKX+laZvlNjbcG
	ABLxoYabci5oP73vJsKoKU7bUnw2ezNw3qkXRVvzn2fwHtxdB0ehzExw7YHlNDMq
	PngrH3R8b1cE0FlHlCZAF+siw5PRQDOG5yQVkUkTgZEi08lBOlzzsKZLvC/pz9hf
	PpgWx3JcH6k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C4B9D6913;
	Tue, 21 Aug 2012 12:50:29 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E2E636912; Tue, 21 Aug 2012
 12:50:28 -0400 (EDT)
In-Reply-To: <20120821062219.GB26516@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 21 Aug 2012 02:22:19 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5027B88C-EBB0-11E1-ABC7-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203971>

Jeff King <peff@peff.net> writes:

> On Tue, Aug 21, 2012 at 02:10:59AM -0400, Jeff King wrote:
>
>> I think that makes sense. Like this patch?
>> 
>> -- >8 --
>> Subject: [PATCH] config: warn on inaccessible files
>> 
>> Before reading a config file, we check "!access(path, R_OK)"
>> to make sure that the file exists and is readable. If it's
>> not, then we silently ignore it.
>> 
>> For the case of ENOENT, this is fine, as the presence of the
>> file is optional. For other cases, though, it may indicate a
>> configuration error (e.g., not having permissions to read
>> the file). Let's print a warning in these cases to let the
>> user know.
>
> And this might be a good follow-on:
>
> -- >8 --
> Subject: [PATCH] gitignore: report access errors of exclude files
>
> When we try to access gitignore files, we check for their
> existence with a call to "access". We silently ignore
> missing files. However, if a file is not readable, this may
> be a configuration error; let's warn the user.
>
> For $GIT_DIR/info/excludes or core.excludesfile, we can just
> use access_or_warn. However, for per-directory files we
> actually try to open them, so we must add a custom warning.

There are a couple of users of add_excludes_from_file() that is
outside the per-directory walking in ls-files and unpack-trees; I
think both are OK with this change, but the one in ls-files may want
to issue a warning or even an error upon ENOENT.

Not a regression with this patch; just something we may want to do
while we are in the vicinity.

> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  dir.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/dir.c b/dir.c
> index 240bf0c..4ee16b5 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -397,6 +397,8 @@ int add_excludes_from_file_to_list(const char *fname,
>  
>  	fd = open(fname, O_RDONLY);
>  	if (fd < 0 || fstat(fd, &st) < 0) {
> +		if (errno != ENOENT)
> +			warn(_("unable to access '%s': %s"), fname, strerror(errno));
>  		if (0 <= fd)
>  			close(fd);
>  		if (!check_index ||
> @@ -1311,9 +1313,9 @@ void setup_standard_excludes(struct dir_struct *dir)
>  		home_config_paths(NULL, &xdg_path, "ignore");
>  		excludes_file = xdg_path;
>  	}
> -	if (!access(path, R_OK))
> +	if (!access_or_warn(path, R_OK))
>  		add_excludes_from_file(dir, path);
> -	if (excludes_file && !access(excludes_file, R_OK))
> +	if (excludes_file && !access_or_warn(excludes_file, R_OK))
>  		add_excludes_from_file(dir, excludes_file);
>  }
