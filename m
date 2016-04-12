From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fetch-pack: Add missing line-feed character when sending depth-request packet line
Date: Tue, 12 Apr 2016 15:31:50 -0700
Message-ID: <xmqqpotuo3vt.fsf@gitster.mtv.corp.google.com>
References: <1460360928-95956-1-git-send-email-stanhu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Stan Hu <stanhu@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 13 00:32:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aq6ql-0007LJ-IK
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 00:31:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966059AbcDLWby (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2016 18:31:54 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:52996 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S965013AbcDLWbx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2016 18:31:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 385E6553B7;
	Tue, 12 Apr 2016 18:31:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=C1g1uU0sFyNLXZma7VoRkJbQxjc=; b=BitzJv
	QCJVqIUUlI+9CDqXmeOEXQRx0opiDpvMp1altkujN4GKm9gEUuugQAFOA0gZLEhf
	csuUYmuxlQWleha4aZ3deGZwR2OsGT83Eu/q1vbhjV9toeUPyf4i+X6d3dmj/67S
	+aFA5mrPqrb1Umt/0PnRf7xWGYTtsWYeNQXRg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XhjyjO8yDNOGJFJxHtYGo3eX96YgjqpZ
	VJS2IAWKK3cbIKiA29daVdkUQLpJcQaom4mPCMg+S6DD3iL+9w3w6khz04qd2e2l
	e/DXuknOEbUka1x6dTVntUHwtkXj0v1HsLvFqHFQt0lUiA0D/LqY6eZwm2IYJ818
	vwQLhDW4B7Q=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 30377553B5;
	Tue, 12 Apr 2016 18:31:52 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A87A9553B4;
	Tue, 12 Apr 2016 18:31:51 -0400 (EDT)
In-Reply-To: <1460360928-95956-1-git-send-email-stanhu@gmail.com> (Stan Hu's
	message of "Mon, 11 Apr 2016 00:48:48 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5A3CF8CA-00FE-11E6-A769-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291304>

Stan Hu <stanhu@gmail.com> writes:

> The pkt-line format mandates: "a sender should include a LF, but the
> receive MUST NOT complain if it is not present." This patch
> is not absolutely necessary since receivers handle the missing the LF,
> but this patch adds it for good measure.

s/since receivers handle/since receivers are expected to handle/;

Have you checked various re-implementations of upload-pack to see
which one will break with this change, and made them aware about
their non-compliance?

>
> Signed-off-by: Stan Hu <stanhu@gmail.com>
> ---
>  fetch-pack.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fetch-pack.c b/fetch-pack.c
> index f96f6df..77299d9 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -330,7 +330,7 @@ static int find_common(struct fetch_pack_args *args,
>  	if (is_repository_shallow())
>  		write_shallow_commits(&req_buf, 1, NULL);
>  	if (args->depth > 0)
> -		packet_buf_write(&req_buf, "deepen %d", args->depth);
> +		packet_buf_write(&req_buf, "deepen %d\n", args->depth);
>  	packet_buf_flush(&req_buf);
>  	state_len = req_buf.len;
