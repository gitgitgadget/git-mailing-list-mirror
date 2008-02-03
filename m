From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 04/11] Use new compress helpers in http-push.c
Date: Sun, 03 Feb 2008 14:53:57 -0800
Message-ID: <7vwsplr6re.fsf@gitster.siamese.dyndns.org>
References: <1201952156-6764-1-git-send-email-mcostalba@gmail.com>
	<1201952156-6764-2-git-send-email-mcostalba@gmail.com>
	<1201952156-6764-3-git-send-email-mcostalba@gmail.com>
	<1201952156-6764-4-git-send-email-mcostalba@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 03 23:54:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLnjg-00026M-8h
	for gcvg-git-2@gmane.org; Sun, 03 Feb 2008 23:54:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753249AbYBCWyT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2008 17:54:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753230AbYBCWyT
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Feb 2008 17:54:19 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:33297 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752848AbYBCWyS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2008 17:54:18 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id D3BE76800;
	Sun,  3 Feb 2008 17:54:16 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 624D367BF;
	Sun,  3 Feb 2008 17:54:14 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72418>

Marco Costalba <mcostalba@gmail.com> writes:

> A multistep compress is required here, so
> we need the full arsenal of compress helpers.
>
> Signed-off-by: Marco Costalba <mcostalba@gmail.com>
> ---
>  http-push.c |   22 ++++++++--------------
>  1 files changed, 8 insertions(+), 14 deletions(-)
>
> diff --git a/http-push.c b/http-push.c
> index b2b410d..a7997ec 100644
> --- a/http-push.c
> +++ b/http-push.c
> @@ -491,31 +492,24 @@ static void start_put(struct transfer_request *request)
> ...
> -	stream.next_in = (void *)hdr;
> -	stream.avail_in = hdrlen;
> -	while (deflate(&stream, 0) == Z_OK)
> -		/* nothing */;
> +	compress_next(&stream, Z_NO_FLUSH);

Although the original does not bother to, the return value from
compress_next() should be checked in later rounds.
