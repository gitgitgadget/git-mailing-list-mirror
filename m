From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/2] Documentation/githooks: mention pwd, $GIT_PREFIX
Date: Mon, 12 Jan 2015 11:56:50 -0800
Message-ID: <xmqqzj9n7oxp.fsf@gitster.dls.corp.google.com>
References: <54B0E1EE.2020301@kdbg.org>
	<1420931503-22857-1-git-send-email-rhansen@bbn.com>
	<1420931503-22857-2-git-send-email-rhansen@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: j6t@kdbg.org, git@vger.kernel.org
To: Richard Hansen <rhansen@bbn.com>
X-From: git-owner@vger.kernel.org Mon Jan 12 20:57:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YAl6h-0003OY-04
	for gcvg-git-2@plane.gmane.org; Mon, 12 Jan 2015 20:56:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753705AbbALT4y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2015 14:56:54 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57701 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750788AbbALT4x (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2015 14:56:53 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 99CC42F3D6;
	Mon, 12 Jan 2015 14:56:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zEWRA6wRwjt1ugIcW1Esd4mOgtc=; b=hfyOlL
	N7I0as6vZc6eExR9SP6RrNjUuxnHIE7B04Wtp+mM5JhOnsH1EmDn3B6f1dgxqLjC
	sfcovAWwlQZqnF4b2y2QPVdwRipAt2iRkoWCWHGfzlu+2qhfQn73sdO7sDSdvVkc
	zEa3RjdwMJNqT+yBX1a4USVBGcNoXvDyB3Un8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lglMVep5ABTjTrh8Selava2B9r6VTHcG
	L/JtU8Hq/X6O/4q4qVxYxIP6VJB/fDsaeqE6y5qElPYYq9uAAIImxdpLX5jKPZ49
	aJIoRjm9l9794I6cKr+g6Cm5lMVqqtRUBTufgB0jS+Bm6D9XjxTiOY8QVZVk7/Dm
	C6Diu8eNr1M=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 90C762F3D5;
	Mon, 12 Jan 2015 14:56:52 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0EEFA2F3D1;
	Mon, 12 Jan 2015 14:56:51 -0500 (EST)
In-Reply-To: <1420931503-22857-2-git-send-email-rhansen@bbn.com> (Richard
	Hansen's message of "Sat, 10 Jan 2015 18:11:42 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 26DC1DD8-9A95-11E4-ABC1-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262290>

Richard Hansen <rhansen@bbn.com> writes:

> Document that hooks are run from the top-level directory and that
> GIT_PREFIX is set to the name of the original subdirectory (relative
> to the top-level directory).
>
> Signed-off-by: Richard Hansen <rhansen@bbn.com>
> ---
>  Documentation/githooks.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
> index 9ef2469..c08f4fd 100644
> --- a/Documentation/githooks.txt
> +++ b/Documentation/githooks.txt
> @@ -26,6 +26,12 @@ executable by default.
>  
>  This document describes the currently defined hooks.
>  
> +Hooks are executed from the top-level directory of a repository, which
> +may not necessarily be the current directory.

I agree that it is a good idea to describe how the hook writers can
go to the top-level directory and how the hook writers can discover
where the hooked operation started, but these two lines cannot be
the whole story---what happens when there is no top-level directory
(i.e. a bare repository)?

Is this universal to all hooks, or just the ones you examined?  I
ask this because I know we do not go through a single interface to
call out to hooks that says "cd to the root and then run the hook
given as an argument".

> +The 'GIT_PREFIX' environment variable is set as returned by running
> +'git rev-parse --show-prefix' from the original current directory.

Is this also universal, or is it set only for some but not all
hooks?  What happens in a bare repository?  What is given if you are
in a non-bare repository and are already at the root level?

> +See linkgit:git-rev-parse[1].
> +
>  HOOKS
>  -----
