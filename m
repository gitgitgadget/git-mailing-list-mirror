From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/5] diff: activate diff.renames by default
Date: Tue, 23 Feb 2016 13:01:50 -0800
Message-ID: <xmqqk2lvywch.fsf@gitster.mtv.corp.google.com>
References: <1456249498-3232-1-git-send-email-Matthieu.Moy@imag.fr>
	<1456249498-3232-6-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Tue Feb 23 22:02:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYK5m-0001TS-1U
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 22:01:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755330AbcBWVBy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2016 16:01:54 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:62348 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755279AbcBWVBx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2016 16:01:53 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8881447F97;
	Tue, 23 Feb 2016 16:01:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aUkVyl0CRiwoB5YtAn6AYA2sBI0=; b=Nt7HDB
	L9oyyg9KODAj+mwSD/wP7ZpSSvl+MkJ+zPNCQf5uvB93Vva1iL3Gkk2qT2VnQgfm
	0WRFpiw+kK3lRe6ygTmdJszzMqFk9kRKyXox8pj+pMo9Xlet5apPMKH+sTqDR/B9
	ui7S8C2BVM1Yy7b0V1mK71On5xB6gnJoNW/vY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GY2/v6JiXOBdaxaFminqwVnLJDMgrq/y
	sl+xcMf3eU+pq/SsXYcjbSMTy3GqjI72N7gz+9SKT4TSyvdSowqN6oygoghPmhC8
	QoVFtU5UWyvU+5VOtdFmyQujj7JkIYUN+7syTcCHzfjh80gywz45TSi/HrZwwqNy
	aZMhTnYOyVs=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7E52E47F96;
	Tue, 23 Feb 2016 16:01:52 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E7E9247F94;
	Tue, 23 Feb 2016 16:01:51 -0500 (EST)
In-Reply-To: <1456249498-3232-6-git-send-email-Matthieu.Moy@imag.fr> (Matthieu
	Moy's message of "Tue, 23 Feb 2016 18:44:58 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A9808BC2-DA70-11E5-BE62-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287118>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> diff --git a/builtin/log.c b/builtin/log.c
> index 7f96c64..6e34df3 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -103,6 +103,7 @@ static int log_line_range_callback(const struct option *option, const char *arg,
>  static void init_log_defaults()
>  {
>  	init_grep_defaults();
> +	git_diff_ui_default_config();
>  }

Why isn't the new function called init_diff_ui_defaults()?

> diff --git a/diff.c b/diff.c
> index 2136b69..d5db898 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -168,6 +168,11 @@ long parse_algorithm_value(const char *value)
>   * never be affected by the setting of diff.renames
>   * the user happens to have in the configuration file.
>   */
> +void git_diff_ui_default_config()

s/()/(void)/;  same for the declaration in the header file.
