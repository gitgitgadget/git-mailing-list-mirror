From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC v2 15/16] update-index.c: add a force-rewrite option
Date: Sun, 05 Aug 2012 18:58:27 -0700
Message-ID: <7vfw80233w.fsf@alter.siamese.dyndns.org>
References: <1344203353-2819-1-git-send-email-t.gummerer@gmail.com>
 <1344203353-2819-16-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, trast@student.ethz.ch, mhagger@alum.mit.edu,
	pcouds@gmail.com, robin.rosenberg@dewire.com
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 06 03:58:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SyCaZ-0001wF-Mo
	for gcvg-git-2@plane.gmane.org; Mon, 06 Aug 2012 03:58:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755443Ab2HFB6b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Aug 2012 21:58:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37750 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755364Ab2HFB6a (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2012 21:58:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 10FB3916A;
	Sun,  5 Aug 2012 21:58:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YbQOceDn6Ftkq8QHCp40JKd/Q7o=; b=SGbwqD
	FDU26MrH1Zv6E0hvT+zSU6PppUtaDuO8RGAQd2Sj1wpnSFiLu0O69waPe8pNXJfv
	HIps8ca4Tx5/4XAqLoPoe7XRNVXKqQ7hARmmhBtTx3qpJWG0D3PdQ53KOC7zDb7Z
	lBREVdeXH8rkJvxV8DhLhA9taQlK3TMwROGD8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GpmJ96c14fHcJeHfQT7xn5VFak2dbQ1H
	VG6ETtKbHz/ayOymkY+wpVNNno+pPhGewgFOtaLNO0zcrsa/eNizKCWQ7mdXI2Q/
	yD+Us+RLtuotFR4m25x4l37C5jV/2saXW3sZgPbBsiTvcu8hEEEeLT1yYDMISp3B
	9Lmlt+342SI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F0C1E9166;
	Sun,  5 Aug 2012 21:58:29 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 64FFC9165; Sun,  5 Aug 2012
 21:58:29 -0400 (EDT)
In-Reply-To: <1344203353-2819-16-git-send-email-t.gummerer@gmail.com> (Thomas
 Gummerer's message of "Sun, 5 Aug 2012 23:49:12 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 37DDADA6-DF6A-11E1-BB88-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202951>

Thomas Gummerer <t.gummerer@gmail.com> writes:

> Add a force-rewrite option to update-index, which allows the user
> to rewrite the index, even if there are no changes. This can be used
> to do performance tests of both the reader and the writer.
>
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---
>  builtin/update-index.c |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

I do not think this is wrong per-se, but is a new command that needs
to be documented?  If it is only for benchmarking and debugging, it
might be sufficient to make "--index-version <n>" always rewrite the
index.

> diff --git a/builtin/update-index.c b/builtin/update-index.c
> index 4ce341c..7fedc8f 100644
> --- a/builtin/update-index.c
> +++ b/builtin/update-index.c
> @@ -24,6 +24,7 @@ static int allow_remove;
>  static int allow_replace;
>  static int info_only;
>  static int force_remove;
> +static int force_rewrite;
>  static int verbose;
>  static int mark_valid_only;
>  static int mark_skip_worktree_only;
> @@ -728,6 +729,8 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
>  		OPT_BIT(0, "unmerged", &refresh_args.flags,
>  			"refresh even if index contains unmerged entries",
>  			REFRESH_UNMERGED),
> +		OPT_SET_INT(0, "force-rewrite", &force_rewrite,
> +			"force a index rewrite even if there is no change", 1),
>  		{OPTION_CALLBACK, 0, "refresh", &refresh_args, NULL,
>  			"refresh stat information",
>  			PARSE_OPT_NOARG | PARSE_OPT_NONEG,
> @@ -886,7 +889,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
>  		strbuf_release(&buf);
>  	}
>  
> -	if (active_cache_changed) {
> +	if (active_cache_changed || force_rewrite) {
>  		if (newfd < 0) {
>  			if (refresh_args.flags & REFRESH_QUIET)
>  				exit(128);
