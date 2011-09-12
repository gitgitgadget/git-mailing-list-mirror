From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFCv2 2/2] format-patch: produce non colorized patches
 when ui.color=always
Date: Mon, 12 Sep 2011 11:08:19 -0700
Message-ID: <7vsjo17hws.fsf@alter.siamese.dyndns.org>
References: <1315849601-26497-1-git-send-email-pangyanhan@gmail.com>
 <1315849601-26497-3-git-send-email-pangyanhan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, peff@peff.net,
	martin.von.zweigbergk@gmail.com, sdaoden@googlemail.com,
	ib@wupperonline.de
To: Pang Yan Han <pangyanhan@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 12 20:08:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3Avj-000728-Bb
	for gcvg-git-2@lo.gmane.org; Mon, 12 Sep 2011 20:08:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753117Ab1ILSIW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Sep 2011 14:08:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63670 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752867Ab1ILSIW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Sep 2011 14:08:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A0BD737C5;
	Mon, 12 Sep 2011 14:08:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=deDnVOvmf5AhP4DN1ujVTPUzt2w=; b=Hd/MoC
	tJ2oIuLLTlQ5nKK5QwS+S6v7oClequ7G3sq8QDO/B1B6Nb2aBwE3u+k3NfLqlokz
	CkxbGN5a7cGk24/qFLOc5q2pinhm57g/kV/1prqw8FvXxN6ls2NjUqR4rqRxxPpK
	nx1HrbAvbSxEkfpnoCA7ywJge1imsCmbSVe2o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cjFwkMriNDBlU3XuyUXyzuTr7MGlW4o5
	cG80Tv0ZYNZ/rNLg0se7snL2WeMwdF4td7fhSsm88EmLjxlSBeMCbHUO8RTMqAUT
	wRG047Tt5JOMpcQdd8cN3H3X3Fejapnrde1xkpzZCyXwbJ+TvLwXrUAyT+VvLgNt
	0anRUlT2SD0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 97C4237C4;
	Mon, 12 Sep 2011 14:08:21 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1FE0437C3; Mon, 12 Sep 2011
 14:08:21 -0400 (EDT)
In-Reply-To: <1315849601-26497-3-git-send-email-pangyanhan@gmail.com> (Pang
 Yan Han's message of "Tue, 13 Sep 2011 01:46:41 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 32EDAFCE-DD6A-11E0-A4D7-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181232>

Pang Yan Han <pangyanhan@gmail.com> writes:

> commit c9bfb953 (want_color: automatically fallback to color.ui,
> 2011-08-17) introduced a regression where format-patch produces colorized
> patches when color.ui is set to "always".
>
> In f3aafa4 (Disable color detection during format-patch, 2006-07-09),
> git_format_config was taught to intercept diff.color to avoid passing it
> down to git_log_config and later, git_diff_ui_config.
>
> Teach git_format_config to intercept color.ui in the same way.
>
> Helped-by: Jeff King <peff@peff.net>
> Signed-off-by: Pang Yan Han <pangyanhan@gmail.com>
> ---
>  builtin/log.c                  |    3 ++-
>  t/t4051-format-patch-config.sh |    2 +-
>  2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/log.c b/builtin/log.c
> index d760ee0..99f8c4c 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -608,7 +608,8 @@ static int git_format_config(const char *var, const char *value, void *cb)
>  		string_list_append(&extra_cc, value);
>  		return 0;
>  	}
> -	if (!strcmp(var, "diff.color") || !strcmp(var, "color.diff")) {
> +	if (!strcmp(var, "diff.color") || !strcmp(var, "color.diff") ||
> +		!strcmp(var, "color.ui")) {
>  		return 0;

Looks sensible. Thanks.
