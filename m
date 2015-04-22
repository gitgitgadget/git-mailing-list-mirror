From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin/merge.c: add the merge.verifysignatures config option
Date: Wed, 22 Apr 2015 10:55:20 -0700
Message-ID: <xmqqsibsdp4n.fsf@gitster.dls.corp.google.com>
References: <1429661634-45033-1-git-send-email-mail@bmpvieira.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Bruno Vieira <mail@bmpvieira.com>
X-From: git-owner@vger.kernel.org Wed Apr 22 19:55:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ykyrv-0005mE-VQ
	for gcvg-git-2@plane.gmane.org; Wed, 22 Apr 2015 19:55:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751072AbbDVRzX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2015 13:55:23 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54377 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750980AbbDVRzW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2015 13:55:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BCD724B4EE;
	Wed, 22 Apr 2015 13:55:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DugB/ZZAChJ59FgozbLZVjgYvsI=; b=IpKsPy
	TTQ69JBbVyzM7e8poHAbzlm6tPXruJunySGt0iNGYglew84fO6w+yZbiJnJ6SamG
	Xx/KxTO5jRKhZ1CG9NX1h9AxgbzwXTwZlLJAK6tsn+0OerI37zyXTYs/aj51Lk9V
	+8DNlGZSwGCkfodRiEkliFQxaAIxgHlceyVzg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Es1VOuXrO6tFeuV9c4zx5PKamlMtydrU
	WAcdMiGP750Ii6hrKKTF2miO3Pno3kvDvw6viVhHldiZlLIoBU7xhQmQaAn8xaul
	GaiYY6i8eZk7M9+oBfsiio19ad6tOjqYE/U0AOmLfr2N35uUdzs3SGHyo3yx/g1+
	FgZPjFrHhpU=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B62AE4B4EC;
	Wed, 22 Apr 2015 13:55:21 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2DA754B4EA;
	Wed, 22 Apr 2015 13:55:21 -0400 (EDT)
In-Reply-To: <1429661634-45033-1-git-send-email-mail@bmpvieira.com> (Bruno
	Vieira's message of "Wed, 22 Apr 2015 01:13:54 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: BE78307E-E918-11E4-849C-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267603>

Bruno Vieira <mail@bmpvieira.com> writes:

This space before your Signed-off-by: line is a place to justify why
this is a good idea.

> Signed-off-by: Bruno Vieira <mail@bmpvieira.com>
> ---
> This seemed to be missing. Sorry if otherwise or if I'm doing something wrong (first time contributing).
>
>  builtin/merge.c | 3 +++
>  1 file changed, 3 insertions(+)

Missing are documentation updates and tests.  Tests musth at least
cover these cases, I think:

 - having configuration set to true without --verify-signatures on
   the command line triggers the check.

 - having configuration set to false without the command line option
   does not trigger the check.

 - having configuration set to true with --no-verify-signatures on
   the command line does not trigger the check.

 - having configuration set to false with --verify-signatures on the
   command line triggers the check.

Thanks.


> diff --git a/builtin/merge.c b/builtin/merge.c
> index 3b0f8f9..5dbc10f 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -598,6 +598,9 @@ static int git_merge_config(const char *k, const char *v, void *cb)
>  	} else if (!strcmp(k, "merge.defaulttoupstream")) {
>  		default_to_upstream = git_config_bool(k, v);
>  		return 0;
> +	} else if (!strcmp(k, "merge.verifysignatures")) {
> +		verify_signatures = git_config_bool(k, v);
> +		return 0;
>  	} else if (!strcmp(k, "commit.gpgsign")) {
>  		sign_commit = git_config_bool(k, v) ? "" : NULL;
>  		return 0;
