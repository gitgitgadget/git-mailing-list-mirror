From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Bump core.deltaBaseCacheLimit to 128MiB
Date: Wed, 19 Mar 2014 14:09:43 -0700
Message-ID: <xmqq38id3nfs.fsf@gitster.dls.corp.google.com>
References: <1395232712-6412-1-git-send-email-dak@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Wed Mar 19 22:11:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQNlU-00026C-7V
	for gcvg-git-2@plane.gmane.org; Wed, 19 Mar 2014 22:11:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753827AbaCSVLD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2014 17:11:03 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50692 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751295AbaCSVLB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2014 17:11:01 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3B27675CB5;
	Wed, 19 Mar 2014 17:11:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QyOOLqVuFvoWDaZhkLOmV/Xqf3I=; b=r1tGH8
	RvZj9BLbOPl+cAfhvssZBgQDfbmzyZBNtce5bgMP4IyJR5nkhyBIDRmyzJV8/jFm
	nYEXGOn9GZPjjPxDnxpt3OWRIfW+AYV3h+oNXyWkJJzhEgYiWwvQJ94txiSuK09M
	q/AbpvnX6FqXdJCsv3SN6j860mUwR541SCGDo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aHRDpnh4yEbx+ulPNkhbjC1OH0SfceFW
	Y+j5C3CWUKo8JyPjDa+BjfeDn8KJuj7YNzibS1LhXsZfVxavRAR9xAU6DvieMcIb
	G/XQRNoJd5SpVAfMGPj3qh7X+a95X0ZTY8Hxekkvx6A1n8ggAp5PQxRtubl2VsHw
	SmZlME29YY8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 286E675CB4;
	Wed, 19 Mar 2014 17:11:01 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 117D475BE5;
	Wed, 19 Mar 2014 17:09:45 -0400 (EDT)
In-Reply-To: <1395232712-6412-1-git-send-email-dak@gnu.org> (David Kastrup's
	message of "Wed, 19 Mar 2014 13:38:32 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: CC75F13C-AFAA-11E3-8120-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244492>

David Kastrup <dak@gnu.org> writes:

> The default of 16MiB causes serious thrashing for large delta chains
> combined with large files.
>
> Signed-off-by: David Kastrup <dak@gnu.org>
> ---

Is that a good argument?  Wouldn't the default of 128MiB burden
smaller machines with bloated processes?

> Forgot the signoff.  For the rationale of this patch and the 128MiB
> choice, see the original patch.

"See the original patch", especially written after three-dash lines
without a reference, will not help future readers of "git log" who
later bisects to find that this change hurt their usage and want to
see why it was done unconditionally (as opposed to encouraging those
who benefit from this change to configure their Git to use larger
value for them, without hurting others).

While I can personally afford 128MiB, I do *not* think 16MiB was
chosen more scientifically than the choice of 128MiB this change
proposes to make, and my gut feeling is that this would not have too
big a negative impact to anybody, I would prefer to have a reason
better than gut feeling before accepting a default change.

Thanks.


> Documentation/config.txt | 2 +-
>  environment.c            | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 73c8973..1b6950a 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -484,7 +484,7 @@ core.deltaBaseCacheLimit::
>  	to avoid unpacking and decompressing frequently used base
>  	objects multiple times.
>  +
> -Default is 16 MiB on all platforms.  This should be reasonable
> +Default is 128 MiB on all platforms.  This should be reasonable
>  for all users/operating systems, except on the largest projects.
>  You probably do not need to adjust this value.
>  +
> diff --git a/environment.c b/environment.c
> index c3c8606..73ed670 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -37,7 +37,7 @@ int core_compression_seen;
>  int fsync_object_files;
>  size_t packed_git_window_size = DEFAULT_PACKED_GIT_WINDOW_SIZE;
>  size_t packed_git_limit = DEFAULT_PACKED_GIT_LIMIT;
> -size_t delta_base_cache_limit = 16 * 1024 * 1024;
> +size_t delta_base_cache_limit = 128 * 1024 * 1024;
>  unsigned long big_file_threshold = 512 * 1024 * 1024;
>  const char *pager_program;
>  int pager_use_color = 1;
