From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 6/6] wt-status: read rebase todolist with strbuf_getline()
Date: Mon, 22 Feb 2016 11:30:58 -0800
Message-ID: <xmqqy4ac5yq5.fsf@gitster.mtv.corp.google.com>
References: <56CA5DBB.8040006@moritzneeb.de> <56CA61B2.2020904@moritzneeb.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Moritz Neeb <lists@moritzneeb.de>
X-From: git-owner@vger.kernel.org Mon Feb 22 20:31:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXwCK-00041Y-Fg
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 20:31:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752274AbcBVTbD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2016 14:31:03 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:54194 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751728AbcBVTbB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2016 14:31:01 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EA1FE47A59;
	Mon, 22 Feb 2016 14:30:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lFN80M5rsNj2zrnh3mdQU1gbw64=; b=AM6DE2
	X/z19vZrUc2ETXO74LBTk6hLN//Z+ZPCqWdP3Uto7At1BAjTY4+47QoS1Ggzuz1i
	f2Gb9j2s1Czn7YCqK016D50M5JHZardj8Gc30HPpUNEQIrFxb5lpuWs/UXV+tsAo
	IOQyfB3X+JVcwuqXrDVp4kzYU+VD3x0HbSYeY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=svHqbH0CJWqJ3woIy/u6iufDaKIMiNql
	HnIm3mBB/CHF+tPVEgUQvcPIZzIvI5SHNwteb3vr9/piGYJNz4BSn7H8bYwrrgWy
	jxCHvRlr7e6KoOLEuZd5u2Jhm4sfYPgZtkp7zql4l8GUUIe2bXhf8fkuypy+WMkC
	DwWh9xGxkq4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DFE0047A57;
	Mon, 22 Feb 2016 14:30:59 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6046947A55;
	Mon, 22 Feb 2016 14:30:59 -0500 (EST)
In-Reply-To: <56CA61B2.2020904@moritzneeb.de> (Moritz Neeb's message of "Mon,
	22 Feb 2016 02:17:38 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: CD1D5B68-D99A-11E5-83FF-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286947>

Moritz Neeb <lists@moritzneeb.de> writes:

> diff --git a/wt-status.c b/wt-status.c
> index ab4f80d..8047cf2 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -1076,10 +1076,9 @@ static void read_rebase_todolist(const char *fname, struct string_list *lines)
>  	if (!f)
>  		die_errno("Could not open file %s for reading",
>  			  git_path("%s", fname));
> -	while (!strbuf_getline_lf(&line, f)) {
> +	while (!strbuf_getline(&line, f)) {

Not related to the substance of the patch series at all, but all
except for this patch in the series seem to be corrupt in that the
very first line that is removed in each patch has an extra space
before the '-' deletion sign.  It is a very curious symptom.  Please
double check the way you send out patch e-mails (e.g. send them
first only to yourself and then try to apply them with "git am").

Thanks.
