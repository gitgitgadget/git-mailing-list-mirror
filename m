From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] mailinfo: ensure handle_filter gets only one line at
 a time
Date: Fri, 15 Feb 2008 15:24:27 -0800
Message-ID: <7vodahg5w4.fsf@gitster.siamese.dyndns.org>
References: <1203112418-25199-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 16 00:25:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQ9vk-0005gM-KG
	for gcvg-git-2@gmane.org; Sat, 16 Feb 2008 00:25:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756044AbYBOXYq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Feb 2008 18:24:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754228AbYBOXYq
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Feb 2008 18:24:46 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:38187 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754036AbYBOXYp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Feb 2008 18:24:45 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id B004A4AF5;
	Fri, 15 Feb 2008 18:24:40 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 AB9794AF4; Fri, 15 Feb 2008 18:24:34 -0500 (EST)
In-Reply-To: <1203112418-25199-1-git-send-email-jaysoffian@gmail.com> (Jay
 Soffian's message of "Fri, 15 Feb 2008 16:53:36 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73996>

Jay Soffian <jaysoffian@gmail.com> writes:

> handle_filter() is only supposed to get one line at a time.
> handle_body() already ensures this after decoding BASE64 messages per
> this comment:
>
> /* this is a decoded line that may contain
>  * multiple new lines.  Pass only one chunk
>  * at a time to handle_filter()
>

Good eyes.  Although I do not think we need to quote in-code
comments here ;-)

> QP messages need to be similarly processed since decoding QP can also
> add newlines.
>
> Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
> ---
> I broke this change out into it's own patch since it's independent of
> the format=flowed additions.
>
>  builtin-mailinfo.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
> index 2600847..11f154b 100644
> --- a/builtin-mailinfo.c
> +++ b/builtin-mailinfo.c
> @@ -818,6 +818,7 @@ static void handle_body(void)
>  
>  		switch (transfer_encoding) {
>  		case TE_BASE64:
> +		case TE_QP:
>  		{
>  			char *op = line;
>  

And it appears to be an obvious fix that should even go to
'maint' where no new features will land.

Care to provide a test case for this one?
