From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv4] git-log --format: Add %B tag with %B(n) option
Date: Fri, 09 Oct 2009 17:57:20 -0700
Message-ID: <7vzl80dq1b.fsf@alter.siamese.dyndns.org>
References: <7vfxaercma.fsf@alter.siamese.dyndns.org>
 <1253655038-20335-1-git-send-email-heipei@hackvalue.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Johannes Gilger <heipei@hackvalue.de>
X-From: git-owner@vger.kernel.org Sat Oct 10 03:02:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwQLe-0005GI-Ov
	for gcvg-git-2@lo.gmane.org; Sat, 10 Oct 2009 03:02:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934739AbZJJA6M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Oct 2009 20:58:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934737AbZJJA6L
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 20:58:11 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:62048 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934734AbZJJA6K (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Oct 2009 20:58:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8EF0E71E4C;
	Fri,  9 Oct 2009 20:57:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=59xiG8vJGCrGUOKN01sBUihgvAA=; b=V1tr0JclyNiDwDE6yLb/VJx
	Ny15WwQio0V/MxoHOn83IrTj7W6alSCZgqTU0at9b3yal/ehX5gJekf7BTw0x6gu
	EJcSSG3G8zsxYSjqm8u56NolfEATgueadofr0H/XIaIXopWUF18bP4lmg+2RmftB
	1SdwXAjdIHJIJsRzV/9Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=JIj1p9KXrTL7tkiIlwLxAyl45I21tCr4P21LQjNSE+8m1R+Rg
	CqRsBtbyNbmDWaU3MGVnbiVrag2TMiOHaLFuybWRxkVULmLSfcDVmYI95Jlws2nW
	3P1iZeSSFdfw9vWb0qxUotv4EpWxSTeaLKiriqTHjk6wgriElTc9nrtNKk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 67FA171E4B;
	Fri,  9 Oct 2009 20:57:26 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 2533571E4A; Fri,  9 Oct 2009
 20:57:21 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E09BEAEE-B537-11DE-B55A-1000076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129862>

Johannes Gilger <heipei@hackvalue.de> writes:

> diff --git a/pretty.c b/pretty.c
> index f5983f8..dafa8e0 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -605,13 +605,17 @@ static size_t format_commit_item(struct strbuf *sb, const char *placeholder,
>  	int h1, h2;
>  
>  	/* these are independent of the commit */
> +
> +	const char *body = msg + c->body_off;
> +	const char *end = NULL;

Unfortunately, c->body_off is not valid until you make a call to
parse_commit_message().  Obviously, body is used only after such a call is
made in the original, so I fixed this initialization into an explicit
assignment after the call.
