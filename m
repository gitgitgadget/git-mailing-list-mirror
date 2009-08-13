From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/5] fix "git add --ignore-errors" to ignore pathspec
 errors
Date: Thu, 13 Aug 2009 12:38:57 -0700
Message-ID: <7vr5vfa4ha.fsf@alter.siamese.dyndns.org>
References: <200908121726.52121.luke-jr@utopios.org>
 <1250133624-2272-1-git-send-email-luke-jr+git@utopios.org>
 <1250133624-2272-2-git-send-email-luke-jr+git@utopios.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Luke Dashjr <luke-jr+git@utopios.org>
X-From: git-owner@vger.kernel.org Thu Aug 13 21:39:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mbg8m-0005mn-0C
	for gcvg-git-2@gmane.org; Thu, 13 Aug 2009 21:39:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755498AbZHMTjD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2009 15:39:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754768AbZHMTjD
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Aug 2009 15:39:03 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:53128 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754747AbZHMTjC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2009 15:39:02 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 356B9288CC;
	Thu, 13 Aug 2009 15:39:03 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0F7EE288CB; Thu, 13 Aug 2009
 15:38:58 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F4A86266-8840-11DE-BCAB-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125861>

Luke Dashjr <luke-jr+git@utopios.org> writes:

> Unmatched files are errors, and should be ignored with the rest of them.

Why is this a "fix"?

I would understand if it were "Make --ignore-errors imply --ignore-unmatch
unconditionally".  But then I do not think I would necessarily agree it is
a good change.

The user may know that some files in the work tree are unreadable and
cannot be indexed (hence he gives --ignore-errors) but he still may want
to catch a typo on the command line.

I do not think it is wise to make --ignore-errors imply --ignore-unmatch
unconditionally like this patch does without any escape hatch.

> Signed-off-by: Luke Dashjr <luke-jr+git@utopios.org>
> ---
>  builtin-add.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/builtin-add.c b/builtin-add.c
> index 0597fb9..e3132c8 100644
> --- a/builtin-add.c
> +++ b/builtin-add.c
> @@ -280,6 +280,8 @@ int cmd_add(int argc, const char **argv, const char *prefix)
>  		add_interactive = 1;
>  	if (add_interactive)
>  		exit(interactive_add(argc - 1, argv + 1, prefix));
> +	if (ignore_add_errors)
> +		ignore_unmatch = 1;
>  
>  	if (edit_interactive)
>  		return(edit_patch(argc, argv, prefix));
> -- 
> 1.6.3.3
