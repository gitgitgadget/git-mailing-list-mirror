From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] cherry-pick: allow "-" as abbreviation of '@{-1}'
Date: Thu, 05 Sep 2013 15:30:03 -0700
Message-ID: <xmqq4n9yhpg4.fsf@gitster.dls.corp.google.com>
References: <1378393043-55403-1-git-send-email-hiroshige88@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Thomas Rast <trast@inf.ethz.ch>
To: Hiroshige Umino <hiroshige88@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 06 00:30:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHi4O-0004zD-G8
	for gcvg-git-2@plane.gmane.org; Fri, 06 Sep 2013 00:30:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753310Ab3IEWaZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Sep 2013 18:30:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62022 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753252Ab3IEWaY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Sep 2013 18:30:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B09BC3F8DD;
	Thu,  5 Sep 2013 22:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=Rhjnsdg20mbyBW4Y18fqOGhgq5Q=; b=xYnx7hV74ObeXhwyW7uV
	qZiKTMcB82sk7STH0kcLsV0O7hH/PS5QRRm0eQLD4AQQEfAeJpc8Qa78/LTfxbEa
	HhGaDLprGn3XsVKUqPbjjn/kWuaQkbKQ/eN0RI62nA/Lq/W1U6TbHpB4p8tVsqjd
	rZ8I0ClZHOzJWTbL9CsfzM4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=El+ln+DuHFi9nI4pF7G+81bI0BoyjvcZSF84SqXZ7Rvc2M
	iOW4llhTTj9/L6qDeJCmcJeitWwJemk6k/yV9ANvgaBJLFCyacxQbP+xMiTNQz2V
	IKYbUWlhSiTxhsU5wr3X0EHvnlO+oy4XUq4TK7p309w/px2ONi1HJwD1sXx2Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 704823F8C3;
	Thu,  5 Sep 2013 22:30:20 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 306673F89B;
	Thu,  5 Sep 2013 22:30:17 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: BD7CF9A6-167A-11E3-95E4-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233999>

Hiroshige Umino <hiroshige88@gmail.com> writes:

> "-" abbreviation is handy for "cherry-pick" like "checkout" and "merge".
>
> It's also good for uniformity that a "-" stands as
> the name of the previous branch where a branch name is
> accepted and it could not mean any other things like stdin.
>
> Signed-off-by: Hiroshige Umino <hiroshige88@gmail.com>
> ---

This makes sense to me.

The test t3500 is about "git cherry" command, so I came up with a
tweak to move it to t3501, which is about cherry-pick, on top of
this patch.  Will tentatively queue this patch with that tweak to
'pu'.

Thanks.

>  builtin/revert.c  |  2 ++
>  t/t3500-cherry.sh | 15 +++++++++++++++
>  2 files changed, 17 insertions(+)
>
> diff --git a/builtin/revert.c b/builtin/revert.c
> index 8e87acd..52c35e7 100644
> --- a/builtin/revert.c
> +++ b/builtin/revert.c
> @@ -202,6 +202,8 @@ int cmd_cherry_pick(int argc, const char **argv, const char *prefix)
>  	memset(&opts, 0, sizeof(opts));
>  	opts.action = REPLAY_PICK;
>  	git_config(git_default_config, NULL);
> +	if (!strcmp(argv[1], "-"))
> +		argv[1] = "@{-1}";
>  	parse_args(argc, argv, &opts);
>  	res = sequencer_pick_revisions(&opts);
>  	if (res < 0)
> diff --git a/t/t3500-cherry.sh b/t/t3500-cherry.sh
> index f038f34..547dbf8 100755
> --- a/t/t3500-cherry.sh
> +++ b/t/t3500-cherry.sh
> @@ -55,4 +55,19 @@ test_expect_success \
>       expr "$(echo $(git cherry master my-topic-branch) )" : "+ [^ ]* - .*"
>  '
>  
> +test_expect_success \
> +    '"cherry-pick -" does not work initially' \
> +    'test_must_fail git cherry-pick -
> +'
> +
> +test_expect_success \
> +    'cherry-pick the commit in the previous branch' \
> +    'git branch other &&
> +     test_commit commit-to-pick newfile content &&
> +     echo content >expected &&
> +     git checkout other &&
> +     git cherry-pick - &&
> +     test_cmp expected newfile
> +'
> +
>  test_done
