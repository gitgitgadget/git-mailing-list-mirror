From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/3] mergetool: don't require a work tree for --tool-help
Date: Mon, 13 Oct 2014 12:16:55 -0700
Message-ID: <xmqqsiir3hlk.fsf@gitster.dls.corp.google.com>
References: <1413016778-94829-1-git-send-email-davvid@gmail.com>
	<1413016778-94829-2-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Charles Bailey <charles@hashpling.org>,
	Charles Bailey <cbailey32@bloomberg.net>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 13 21:17:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xdl78-00026b-BS
	for gcvg-git-2@plane.gmane.org; Mon, 13 Oct 2014 21:17:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754605AbaJMTQ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2014 15:16:58 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52879 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751304AbaJMTQ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2014 15:16:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 39B9C15BD7;
	Mon, 13 Oct 2014 15:16:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LObs2fhVRlFChSqTqRd5dAAjvJg=; b=JipU+X
	C1ZoI+kZn17AsYvawvlwtyJIZNQ1u+iSUEh1W72rmIpyNhyo/YXLWe6XBm7+G7zl
	J9wEO+oA6+yJQ2gac+YgW1gLe6hzUSimM5ui2sA7LFfn8w4Kw7XCM32dX+hfnVDw
	i7/EKNUbQok9/MGZLzCSzQgX4uE9QGrK6ML6w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bnqlgoIP8rk04kv2w/kFJFT5IJQj0qgZ
	7wA8k+RZI8bMDGkjo44OjMZkJzfIpkVy3JCnq4hTQE9VOKCvfBRbm5yd5T8nr9+J
	jZlBBtKFNtDgWcEq+Q1Ngx7WZnb5BXEnvRlCgO9E/ckcSUBYwBQZYsl7P8QVaz15
	o8VMhMaZzes=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 30FA415BD6;
	Mon, 13 Oct 2014 15:16:57 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8951A15BD4;
	Mon, 13 Oct 2014 15:16:56 -0400 (EDT)
In-Reply-To: <1413016778-94829-2-git-send-email-davvid@gmail.com> (David
	Aguilar's message of "Sat, 11 Oct 2014 01:39:37 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7F706B4A-530D-11E4-8AD7-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Aguilar <davvid@gmail.com> writes:

> From: Charles Bailey <cbailey32@bloomberg.net>
>
> Signed-off-by: Charles Bailey <cbailey32@bloomberg.net>
> Signed-off-by: David Aguilar <davvid@gmail.com>
> ---
> Changes since v2:
>
> This now uses the new git_dir_init function.
>
>  git-mergetool.sh | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/git-mergetool.sh b/git-mergetool.sh
> index 96a61ba..cddb533 100755
> --- a/git-mergetool.sh
> +++ b/git-mergetool.sh
> @@ -10,11 +10,11 @@
>  
>  USAGE='[--tool=tool] [--tool-help] [-y|--no-prompt|--prompt] [file to merge] ...'
>  SUBDIRECTORY_OK=Yes
> +NONGIT_OK=Yes
>  OPTIONS_SPEC=
>  TOOL_MODE=merge
>  . git-sh-setup
>  . git-mergetool--lib
> -require_work_tree
>  
>  # Returns true if the mode reflects a symlink
>  is_symlink () {
> @@ -378,6 +378,9 @@ prompt_after_failed_merge () {
>  	done
>  }
>  
> +require_work_tree
> +git_dir_init

This is somewhat curious.  Shouldn't the order of these swapped?

> +
>  if test -z "$merge_tool"
>  then
>  	# Check if a merge tool has been configured
