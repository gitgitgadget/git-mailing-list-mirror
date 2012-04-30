From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] log-tree: use custom line terminator in line termination
 mode
Date: Mon, 30 Apr 2012 12:36:07 -0700
Message-ID: <7vaa1tf1w8.fsf@alter.siamese.dyndns.org>
References: <86ty01qez7.fsf@red.stonehenge.com>
 <1335811555-23564-1-git-send-email-jk@jk.gs>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Randal L. Schwartz" <merlyn@stonehenge.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Andreas Schwab <schwab@linux-m68k.org>
To: Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>
X-From: git-owner@vger.kernel.org Mon Apr 30 21:36:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SOwOf-0005y9-Py
	for gcvg-git-2@plane.gmane.org; Mon, 30 Apr 2012 21:36:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756633Ab2D3TgV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Apr 2012 15:36:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49859 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756454Ab2D3TgK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Apr 2012 15:36:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 311B47934;
	Mon, 30 Apr 2012 15:36:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Zbgh+hGqsF8A
	q+q9Z1yYHTAoTck=; b=BklwAN0K8J0Co6m3ZuTKX/VgypfOu7Y0k+2aCm+VFDHm
	ptX7s8IsQ8kvtLikfEoDYSudAbWFVnVIbkNZ0DrYY7rDpy8kTALYNdJAUSTm7+MS
	uXi+REftGaNfdt9kXgp2Dfr6H6gP1EqT4LCDPyI/dnqW1LuhbCTxoICd4X384eM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=xWZw7w
	D/DdjqeGn6Pi+hakooh1S+8Wp7DtZrXCgWgDM69/lC7FUY6180tVkXXZZTnmfqZo
	AO9s79nQXzul+NHV3dkKuadHM4Xhs6SROdQWUxR3idgwQ9l72NL9iE/FSjBzTyVY
	S4bWS/t78XO6fgbMbJtf8WsrQmvjmXkS9gklQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 284DA7932;
	Mon, 30 Apr 2012 15:36:09 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ABE6A7931; Mon, 30 Apr 2012
 15:36:08 -0400 (EDT)
In-Reply-To: <1335811555-23564-1-git-send-email-jk@jk.gs> ("Jan
 =?utf-8?Q?Kr=C3=BCger=22's?= message of "Mon, 30 Apr 2012 20:45:55 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BC0BA5E4-92FB-11E1-995C-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196599>

Jan Kr=C3=BCger <jk@jk.gs> writes:

> When using a custom format in line termination mode (as opposed to li=
ne
> separation mode), the configured line terminator is not used, so thin=
gs
> like "git log --pretty=3Dtformat:%H -z" do not work properly.
>
> Make it use the line terminator the user ordered.
>
> Signed-off-by: Jan Kr=C3=BCger <jk@jk.gs>
> ---
>  log-tree.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/log-tree.c b/log-tree.c
> index 34c49e7..44f0268 100644
> --- a/log-tree.c
> +++ b/log-tree.c
> @@ -682,7 +682,7 @@ void show_log(struct rev_info *opt)
>  	if (opt->use_terminator) {
>  		if (!opt->missing_newline)
>  			graph_show_padding(opt->graph);
> -		putchar('\n');
> +		putchar(opt->diffopt.line_termination);
>  	}
> =20
>  	strbuf_release(&msgbuf);

Looks sensible.  Perhaps we would want to add a test?
