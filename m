From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make git-mailinfo strip whitespace from the start of the mail file.
Date: Fri, 02 Nov 2007 01:53:24 -0700
Message-ID: <7v8x5h58qj.fsf@gitster.siamese.dyndns.org>
References: <1193951139-2312-1-git-send-email-Simon.Sasburg@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Simon Sasburg <simon.sasburg@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 02 09:53:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InsHh-000380-1Q
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 09:53:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752555AbXKBIxb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2007 04:53:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752476AbXKBIxb
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 04:53:31 -0400
Received: from sceptre.pobox.com ([207.106.133.20]:33164 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751795AbXKBIxa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 04:53:30 -0400
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 495F22EF;
	Fri,  2 Nov 2007 04:53:52 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id D6CEE9055C;
	Fri,  2 Nov 2007 04:53:47 -0400 (EDT)
In-Reply-To: <1193951139-2312-1-git-send-email-Simon.Sasburg@gmail.com> (Simon
	Sasburg's message of "Thu, 1 Nov 2007 22:05:39 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63076>

Simon Sasburg <simon.sasburg@gmail.com> writes:

> @@ -935,6 +936,11 @@ static int mailinfo(FILE *in, FILE *out, int ks, const char *encoding,
>  	p_hdr_data = xcalloc(MAX_HDR_PARSED, sizeof(char *));
>  	s_hdr_data = xcalloc(MAX_HDR_PARSED, sizeof(char *));
>  
> +	do {
> +		peek = fgetc(in);
> +	} while (peek == ' ' || peek == '\r' || peek == '\n');
> +	ungetc(peek, in);
> +

I wonder why this is not using isspace(peek).
