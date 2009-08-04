From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Please make git-am handle \r\n-damaged patches
Date: Mon, 03 Aug 2009 23:46:53 -0700
Message-ID: <7v7hxk5b4y.fsf@alter.siamese.dyndns.org>
References: <4A7735B0.2040703@zytor.com>
 <81b0412b0908032335s3363849aj32a0e93efa15c012@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 04 08:47:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYDnk-000877-Gy
	for gcvg-git-2@gmane.org; Tue, 04 Aug 2009 08:47:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932464AbZHDGrE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2009 02:47:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755005AbZHDGrE
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Aug 2009 02:47:04 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:43800 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754664AbZHDGrD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2009 02:47:03 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3E9021CEEA;
	Tue,  4 Aug 2009 02:47:02 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id DC0821CEE9; Tue,  4 Aug 2009
 02:46:54 -0400 (EDT)
In-Reply-To: <81b0412b0908032335s3363849aj32a0e93efa15c012@mail.gmail.com>
 (Alex Riesen's message of "Tue\, 4 Aug 2009 08\:35\:24 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 9D81FC84-80C2-11DE-8196-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124760>

Alex Riesen <raa.lkml@gmail.com> writes:

> Maybe it is as simple as that (not tested yet,
> and sent through gmail, so please be careful):

I thought about this approach, but it made me worried about a case where
an otherwise sane piece of e-mail has \r at the end of one line as the
real payload.  But as long as we are talking about a text e-mail (and we
are talking about mailsplit here and a binary payload with a CTE applied
counts as text), I think we can safely use an approach like this.

>
> diff --git a/builtin-mailsplit.c b/builtin-mailsplit.c
> index ad5f6b5..02c1c92 100644
> --- a/builtin-mailsplit.c
> +++ b/builtin-mailsplit.c
> @@ -58,6 +58,8 @@ int read_line_with_nul(char *buf, int size, FILE *in)
>  		if (c == '\n' || len + 1 >= size)
>  			break;
>  	}
> +	if (len && buf[len - 1] == '\r')
> +		--len;
>  	buf[len] = '\0';
>
>  	return len;
