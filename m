From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 02/14] add_to_alternates_file: respect GIT_OBJECT_DIRECTORY
Date: Wed, 03 Dec 2014 10:53:16 -0800
Message-ID: <xmqq4mtcimzn.fsf@gitster.dls.corp.google.com>
References: <1416262453-30349-1-git-send-email-sbeller@google.com>
	<20141117233525.GC4336@google.com>
	<CAGZ79kYU1f1COjtv+4MzgbPLi42m1JQsXsuuCr3WXsuR8XrO7w@mail.gmail.com>
	<20141118004841.GE4336@google.com>
	<CAGZ79kbF6JjxgHX2KZFhSh9QyGOXeS=cVK0z=CM4n9-ErRDJ8A@mail.gmail.com>
	<20141203050217.GJ6527@google.com> <20141203051220.GL6527@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 03 19:53:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwF3F-00069V-Id
	for gcvg-git-2@plane.gmane.org; Wed, 03 Dec 2014 19:53:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751373AbaLCSxU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2014 13:53:20 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64635 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751255AbaLCSxT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2014 13:53:19 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CEB2E23582;
	Wed,  3 Dec 2014 13:53:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4tfn+XYANA7SQq8QjCxggoEONJE=; b=e2uViO
	9AgNPjQs49KU1Sfb4B4wfUwvqMDPRE4LcCL7U8pmBU0perXSFYCWCGiWbpatG+Qa
	RgMAVd21DasWuRtHYkcyZ21cTcYVtUXFtDZJvhjLBWO3dQCtpJIoK+lDlxI4qB0A
	ZggBlpewgw8EzMGjBfK4EpWfu8+NqcdQZ04Tg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=f6QYAcbkBgiX3IqBwzwd3tmZ2ySUjzkt
	APP6242kCnEJs/oqA/QZL4cHpvxad8eqp74+SiZ4A6CnOQ8yPhwc4YPj2tdI/PYf
	DApBQxbSM9C87aBsFzSbODjzEFE9tEFA+veuE3ZbuNfC7whoh+sbrCKYxNqhtiOD
	LLXvbEKqB2k=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C32C223581;
	Wed,  3 Dec 2014 13:53:18 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4E5FC23580;
	Wed,  3 Dec 2014 13:53:18 -0500 (EST)
In-Reply-To: <20141203051220.GL6527@google.com> (Jonathan Nieder's message of
	"Tue, 2 Dec 2014 21:12:20 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A52BAA2E-7B1D-11E4-9857-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260679>

Jonathan Nieder <jrnieder@gmail.com> writes:

> The objects directory is spelled as get_object_directory(), not
> git_path("objects").  Some other code still hard-codes the objects/
> directory name, so in the long term we may want to get rid of the
> pretense of support for GIT_OBJECT_DIRECTORY altogether, but this
> makes the code more consistent for now.
>
> While at it, split variable declarations from the rest of the
> function.  This makes the function a little easier to read, at the
> cost of some vertical space.
>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> This is mainly for consistency / cleanliness.  I wouldn't mind
> dropping it.

I think this is a worthwhile thing to do, but you probably would
want to Cc author of nd/multiple-work-trees topic which would need
to address similar concern.

> The rest of 'git clone' is not careful about paying attention to
> GIT_OBJECT_DIRECTORY either.  I suspect GIT_OBJECT_DIRECTORY was a bit
> of a failed experiment.

"clone" is a bit special in that it needs to be careful about the
"local" case.  Does GIT_OBJECT_DIRECTORY (or GIT_DIR for that matter)
refer to the source or to the destination?

>  sha1_file.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/sha1_file.c b/sha1_file.c
> index d7f1838..e1945e2 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -403,9 +403,15 @@ void read_info_alternates(const char * relative_base, int depth)
>  
>  void add_to_alternates_file(const char *reference)
>  {
> -	struct lock_file *lock = xcalloc(1, sizeof(struct lock_file));
> -	int fd = hold_lock_file_for_append(lock, git_path("objects/info/alternates"), LOCK_DIE_ON_ERROR);
> -	char *alt = mkpath("%s\n", reference);
> +	struct lock_file *lock;
> +	int fd;
> +	char *alt;
> +
> +	lock = xcalloc(1, sizeof(*lock));
> +	fd = hold_lock_file_for_append(lock, mkpath("%s/info/alternates",
> +						    get_object_directory()),
> +				       LOCK_DIE_ON_ERROR);
> +	alt = mkpath("%s\n", reference);
>  	write_or_die(fd, alt, strlen(alt));
>  	if (commit_lock_file(lock))
>  		die("could not close alternates file");
