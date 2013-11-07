From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 12/14] fix 'git update-index --verbose --again' output
Date: Thu, 07 Nov 2013 14:12:46 -0800
Message-ID: <xmqqiow3q2sh.fsf@gitster.dls.corp.google.com>
References: <527BA483.6040803@gmail.com> <527BA706.6010307@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Thomas Rast <tr@thomasrast.ch>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 07 23:12:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VeXos-0001Qy-VT
	for gcvg-git-2@plane.gmane.org; Thu, 07 Nov 2013 23:12:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753997Ab3KGWMv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Nov 2013 17:12:51 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63990 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752690Ab3KGWMu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Nov 2013 17:12:50 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 899F350E39;
	Thu,  7 Nov 2013 17:12:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Tr9Hku4Nkn5VdSJiVSKsg3Je/6M=; b=W3qRyw
	6ERKc0AkVD2Qno2tMjKtkNuxDxV793ph92Vn6UeEXcP91G/IFrHmSfUHe0blYOr/
	1IbCI9i0TbkduLa1CIKoV9StlFmMDxxv8XlURg5cJ3WNcPFXQShuk18cZK3EUTx1
	t+ZVXkRaos8CnWw14mp/95KymWIH4aUwQnYZw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VcQYyI7X37FvVySzmE3oNs3esHwka7WO
	LFeA5IIQUMjrzlf9pPw8sc1i8I+xHIkm0S/3Ax/dS1l8STFKvR93TW3dmYl80PA8
	X7y+kG3UwP83Dg+gwhjCcNo5SjQBGOGnUGw3k4LyaUgOphRak+7SVcO8B6Z2Bjzf
	McrDKl33yBg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 75E1250E38;
	Thu,  7 Nov 2013 17:12:49 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AF9F350E37;
	Thu,  7 Nov 2013 17:12:48 -0500 (EST)
In-Reply-To: <527BA706.6010307@gmail.com> (Karsten Blees's message of "Thu, 07
	Nov 2013 15:43:18 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: BC91A5AE-47F9-11E3-B1FA-1FFB7F2839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237434>

Karsten Blees <karsten.blees@gmail.com> writes:

> 'git update-index --verbose' consistently reports paths relative to the
> work-tree root. The only exception is the '--again' option, which reports
> paths relative to the current working directory.
>
> Change do_reupdate to use non-prefixed paths.

Interesting.

This looks like a genuine fix unrelated to the use of the new hashmap.

>
> Signed-off-by: Karsten Blees <blees@dcon.de>
> ---
>  builtin/update-index.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/update-index.c b/builtin/update-index.c
> index e3a10d7..d180d80 100644
> --- a/builtin/update-index.c
> +++ b/builtin/update-index.c
> @@ -579,7 +579,7 @@ static int do_reupdate(int ac, const char **av,
>  		 * or worse yet 'allow_replace', active_nr may decrease.
>  		 */
>  		save_nr = active_nr;
> -		update_one(ce->name + prefix_length, prefix, prefix_length);
> +		update_one(ce->name, NULL, 0);
>  		if (save_nr != active_nr)
>  			goto redo;
>  	}
