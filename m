From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 03/10] update-index: add --test-untracked-cache
Date: Tue, 29 Dec 2015 14:28:23 -0800
Message-ID: <xmqqy4ccga9k.fsf@gitster.mtv.corp.google.com>
References: <1451372974-16266-1-git-send-email-chriscool@tuxfamily.org>
	<1451372974-16266-4-git-send-email-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Torsten =?utf-8?Q?B=C3=B6gersh?= =?utf-8?Q?ausen?= 
	<tboegi@web.de>, Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 29 23:28:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aE2kr-00014g-9G
	for gcvg-git-2@plane.gmane.org; Tue, 29 Dec 2015 23:28:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754029AbbL2W23 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2015 17:28:29 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:53600 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753792AbbL2W2Z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2015 17:28:25 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3273038057;
	Tue, 29 Dec 2015 17:28:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FprqoghGi2+C+sKM4D6j+2I3xyY=; b=E6TFXe
	HaZTCTIovvNbC4HnWDj3PwaRxLoq/UqzVK2bmkLraSOwLtymYnPAazbnpbS+A/41
	r7lXTWW1NZU9FBXoAOyPduhqwR/Z+9Z/yvIozuo74IGienCGmvBbzGR8T9MYI41R
	OuysIwjUXMGIOTNeq/3FbilYO3/11/CeJkcOs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FiAcwsqzd/L08scYyd5ue0MlEN57wdvQ
	tnSLvUJ+yfJ3jw84dgz3gdzfLNIlPm91GhYdld7g6gZ7LHoaFkNnAKTwd+r1Mfg6
	/KJDiTUwHX7PO9TMcJLsanF+ChkYl+ps2pOgVWJoEljeMXB3tM6O6cKuE1DkDBgM
	zQlcWjj8SJo=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 27CA438056;
	Tue, 29 Dec 2015 17:28:25 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 916C438055;
	Tue, 29 Dec 2015 17:28:24 -0500 (EST)
In-Reply-To: <1451372974-16266-4-git-send-email-chriscool@tuxfamily.org>
	(Christian Couder's message of "Tue, 29 Dec 2015 08:09:27 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 79781790-AE7B-11E5-81AE-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283153>

Christian Couder <christian.couder@gmail.com> writes:

> It is nice to just be able to test if untracked cache is
> supported without enabling it.
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  Documentation/git-update-index.txt | 12 +++++++++++-
>  builtin/update-index.c             |  5 +++++
>  2 files changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
> index f4e5a85..a0afe17 100644
> --- a/Documentation/git-update-index.txt
> +++ b/Documentation/git-update-index.txt
> @@ -18,7 +18,7 @@ SYNOPSIS
>  	     [--[no-]skip-worktree]
>  	     [--ignore-submodules]
>  	     [--[no-]split-index]
> -	     [--[no-|force-]untracked-cache]
> +	     [--[no-|test-|force-]untracked-cache]
>  	     [--really-refresh] [--unresolve] [--again | -g]
>  	     [--info-only] [--index-info]
>  	     [-z] [--stdin] [--index-version <n>]
> @@ -180,6 +180,16 @@ may not support it yet.
>  	system must change `st_mtime` field of a directory if files
>  	are added or deleted in that directory.
>  
> +--test-untracked-cache::
> +	Only perform tests on the working directory to make sure
> +	untracked cache can be used. You have to manually enable
> +	untracked cache using `--force-untracked-cache` (or
> +	`--untracked-cache` but this will run the tests again)
> +	afterwards if you really want to use it. If a test fails
> +	the exit code is 1 and a message explains what is not
> +	working as needed, otherwise the exit code is 0 and OK is
> +	printed.
> +

Looks good.

>  --force-untracked-cache::
>  	For safety, `--untracked-cache` performs tests on the working
>  	directory to make sure untracked cache can be used. These
> diff --git a/builtin/update-index.c b/builtin/update-index.c
> index 1e546a3..62222dd 100644
> --- a/builtin/update-index.c
> +++ b/builtin/update-index.c
> @@ -40,6 +40,7 @@ enum uc_mode {
>  	UC_UNSPECIFIED = -1,
>  	UC_DISABLE = 0,
>  	UC_ENABLE,
> +	UC_TEST,
>  	UC_FORCE
>  };
>  
> @@ -1004,6 +1005,8 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
>  			N_("enable or disable split index")),
>  		OPT_BOOL(0, "untracked-cache", &untracked_cache,
>  			N_("enable/disable untracked cache")),
> +		OPT_SET_INT(0, "test-untracked-cache", &untracked_cache,
> +			    N_("test if the filesystem supports untracked cache"), UC_TEST),
>  		OPT_SET_INT(0, "force-untracked-cache", &untracked_cache,
>  			    N_("enable untracked cache without testing the filesystem"), UC_FORCE),
>  		OPT_END()
> @@ -1119,6 +1122,8 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
>  			setup_work_tree();
>  			if (!test_if_untracked_cache_is_supported())
>  				return 1;
> +			if (untracked_cache == UC_TEST)
> +				return 0;
>  		}
>  		if (!the_index.untracked) {
>  			uc = xcalloc(1, sizeof(*uc));
