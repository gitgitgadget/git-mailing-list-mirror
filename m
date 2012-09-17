From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-jump: ignore (custom) prefix in diff mode
Date: Sun, 16 Sep 2012 22:22:14 -0700
Message-ID: <7vy5k9w7eh.fsf@alter.siamese.dyndns.org>
References: <1347844915-4130-1-git-send-email-git@shiar.nl>
 <20120917030143.GA19986@pearl.mediadesign.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Mischa POSLAWSKY <git@shiar.nl>
X-From: git-owner@vger.kernel.org Mon Sep 17 07:22:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDTmw-0001sk-0R
	for gcvg-git-2@plane.gmane.org; Mon, 17 Sep 2012 07:22:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752603Ab2IQFWS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 01:22:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35873 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751784Ab2IQFWR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 01:22:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C42D39EDA;
	Mon, 17 Sep 2012 01:22:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1JIjWww1VPhYEzDRfD7AU++L3yM=; b=WnvXk2
	ontZt3vAeF9BbldSzk0800ihhg9ovV5PeCk1HddiVMuPNcMfjaW0C88i6Lw0o592
	/y66iyyHc74r0YvZYqdzaAE0XcJ/S5kQA+sSwqdL9i7ey2s3hH+STgfanvwC4jcv
	LSOIQMN3aIE2okYSS6MD2h1uHEOSXhLvCr1/Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KKeWPiqBYo6ttgE2ay1LtIyG8NvIRZfr
	h6ZGw62dVwxpeOiNkRoqgdsGqPV8LDv8i5/Qo8wJSzewhXmxohvmmJfr7O7C9fB8
	zYoDL4PMFBBoxg2d2Ve6rawXf9wvBB5nlmR9SdKuQpnmqQy7C7Wvx0h628ulDbQV
	kyPXGkzLZ9g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B0B1F9ED9;
	Mon, 17 Sep 2012 01:22:16 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1662F9ED8; Mon, 17 Sep 2012
 01:22:15 -0400 (EDT)
In-Reply-To: <20120917030143.GA19986@pearl.mediadesign.nl> (Mischa
 POSLAWSKY's message of "Mon, 17 Sep 2012 05:01:43 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A4DBEF92-0087-11E2-B462-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205646>

Mischa POSLAWSKY <git@shiar.nl> writes:

>> diff --git contrib/git-jump/git-jump contrib/git-jump/git-jump
>> index a33674e..dc90cd6 100755
>> --- contrib/git-jump/git-jump
>> +++ contrib/git-jump/git-jump
>
> Apparently diff.noprefix also applies to git format-patch.  Even though
> git am does explicitly support -p0, I would argue against diff options
> creating non-standard patches.
>
> -- >8 --
> Subject: [PATCH/RFC] format-patch: force default file prefixes in diff
>
> Override user configuration (eg. diff.noprefix) in patches intended for
> external consumption to match the default prefixes expected by git-am.
>
> Signed-off-by: Mischa POSLAWSKY <git@shiar.nl>
> ---

Not all projects expect to see a/ & b/ prefix and these are
configurable for a reason.  Robbing the choice that has been
supported for quite a long time from them is an unacceptable
regression.

Why did you think this may be a good idea in the first place?

Perhaps you had configured your diff.noprefix in a wrong
configuration file?  This is primarily per-project choice, and your
clone of git.git should not have diff.noprefix set, neither your
$HOME/.gitconfig unless you always work on projects that want
diff.noprefix.

>  builtin/log.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/builtin/log.c b/builtin/log.c
> index dff7921..91ded25 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -1131,6 +1131,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>  	rev.diff = 1;
>  	rev.max_parents = 1;
>  	DIFF_OPT_SET(&rev.diffopt, RECURSIVE);
> +	rev.diffopt.a_prefix = "a/";
> +	rev.diffopt.b_prefix = "b/";
>  	rev.subject_prefix = fmt_patch_subject_prefix;
>  	memset(&s_r_opt, 0, sizeof(s_r_opt));
>  	s_r_opt.def = "HEAD";
