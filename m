From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3][GSOC] diff: rename read_directory() to get_directory_list()
Date: Mon, 17 Mar 2014 15:37:18 -0700
Message-ID: <xmqqy508a1up.fsf@gitster.dls.corp.google.com>
References: <1395091825-8330-1-git-send-email-sh19910711@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Hiroyuki Sano <sh19910711@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 17 23:37:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPgA5-0004Iz-MD
	for gcvg-git-2@plane.gmane.org; Mon, 17 Mar 2014 23:37:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752989AbaCQWh2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2014 18:37:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62567 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752976AbaCQWhW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2014 18:37:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 487FE7689C;
	Mon, 17 Mar 2014 18:37:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=f7Kksp3bggasnKBzND03J+EITzE=; b=aSMpgZ
	skPOItt/897PsmXSPTFHXhITL3VmG2allMLVpnm05VWz9cUCYRKrX9zKPeWgNlUq
	UQ7DYm0HEh9XHPgJiPngTnxmZ4o3GqXnZ+0iIJtXXmB65UaJbAfV+TznKnNb5+ai
	W1P5A4Uba/y2CCP4LIZ2QiN9/BSDRHuweAhwk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=f5WZ70yP7wgbPcXPckxjwRxJXex57/jm
	Lk1mtBtwsOtoqCpSs0jBkabMKeAWriyYkYcRdBwqDc78J68HQarQKFDGso+dU2Uz
	DOXJOFZtbxYTTF7yiZIPqf185qFBSxiZt2dyfYdf+Mg6Mr9F60/Ff3h/O/HnICbd
	MBosZvTignA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 30AA67689B;
	Mon, 17 Mar 2014 18:37:21 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 89E2376898;
	Mon, 17 Mar 2014 18:37:20 -0400 (EDT)
In-Reply-To: <1395091825-8330-1-git-send-email-sh19910711@gmail.com> (Hiroyuki
	Sano's message of "Tue, 18 Mar 2014 06:30:23 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B38DEFA8-AE24-11E3-AD30-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244302>

Hiroyuki Sano <sh19910711@gmail.com> writes:

> Including "dir.h" in "diff-no-index.c", it causes a compile error, because
> the same name function read_directory() is declared globally in "dir.h".
>
> This change is to avoid conflicts as above.
>
> Signed-off-by: Hiroyuki Sano <sh19910711@gmail.com>
> ---
>  diff-no-index.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/diff-no-index.c b/diff-no-index.c
> index 8e10bff..1ed5c9d 100644
> --- a/diff-no-index.c
> +++ b/diff-no-index.c
> @@ -16,7 +16,7 @@
>  #include "builtin.h"
>  #include "string-list.h"
>  
> -static int read_directory(const char *path, struct string_list *list)
> +static int get_directory_list(const char *path, struct string_list *list)

Renaming is a good idea but the new name sounds like you are
grabbing the names of directories, ignoring all the files, no?

>  {
>  	DIR *dir;
>  	struct dirent *e;
> @@ -107,9 +107,9 @@ static int queue_diff(struct diff_options *o,
>  		int i1, i2, ret = 0;
>  		size_t len1 = 0, len2 = 0;
>  
> -		if (name1 && read_directory(name1, &p1))
> +		if (name1 && get_directory_list(name1, &p1))
>  			return -1;
> -		if (name2 && read_directory(name2, &p2)) {
> +		if (name2 && get_directory_list(name2, &p2)) {
>  			string_list_clear(&p1, 0);
>  			return -1;
>  		}
