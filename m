From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 03/18] Add the basic data structure for line level
 history
Date: Fri, 06 Aug 2010 12:42:47 -0700
Message-ID: <7vvd7n7cjs.fsf@alter.siamese.dyndns.org>
References: <1281024717-7855-1-git-send-email-struggleyb.nku@gmail.com>
 <1281024717-7855-4-git-send-email-struggleyb.nku@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, trast@student.ethz.ch, Jens.Lehmann@web.de
To: Bo Yang <struggleyb.nku@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 06 21:43:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhSos-00073Y-TO
	for gcvg-git-2@lo.gmane.org; Fri, 06 Aug 2010 21:43:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935298Ab0HFTnA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Aug 2010 15:43:00 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:32812 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935135Ab0HFTm6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Aug 2010 15:42:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0E999CBC27;
	Fri,  6 Aug 2010 15:42:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=nCzcljLnkVCgcOeZIS5EV2wif9Y=; b=nFeUNnWwHo/G92IdgesM2Pl
	XjdXlkabR+X2z1ER1mWtIwUIpcpWY3HPI1xoUShspWut0G2kBCn0oAhUrsbkkPzm
	DkuxBXQPsItHYhkXBVYem5F6vaomU0wn+DWg6Dgv4ZbprEdtH4ynlYiKEdbGVWe7
	eZY2w8M1n+bvP+MYdk8A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=ATD+HU3INinKZ6CNMKTdRWNy/WjkEPH6Kf7HR0oghaHv3jaVu
	mra1o4gplHGoziIZRAZG+8lY8OtIYmWTHI1YzcZe34yg5DKu56eXqkNtu4fRrHr4
	T9WldlkaTd9AcQFjkrQ8k3GG4E5BUnZawWpUqOTyppjTlkjgGCaZ5ZM3Ic=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BED0ACBC25;
	Fri,  6 Aug 2010 15:42:53 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A5676CBC24; Fri,  6 Aug
 2010 15:42:48 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CDFC046C-A192-11DF-9CC6-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152806>

Bo Yang <struggleyb.nku@gmail.com> writes:

> diff --git a/diffcore.h b/diffcore.h
> index 491bea0..13d8e93 100644
> --- a/diffcore.h
> +++ b/diffcore.h
> @@ -23,6 +23,7 @@
>  #define MINIMUM_BREAK_SIZE     400 /* do not break a file smaller than this */
>  
>  struct userdiff_driver;
> +struct diff_options;

Hmm...  I do not see anything you added to this header file that needs
such a forward declaration.  Other files you added that include diffcore.h
may want to have that declaration, but I do not think this header file does.

>  
>  struct diff_filespec {
>  	unsigned char sha1[20];

> diff --git a/line.h b/line.h
> new file mode 100644
> index 0000000..caf84c7
> --- /dev/null
> +++ b/line.h
> @@ -0,0 +1,128 @@
> ...
> +struct print_range {
> +	int start, end;
> +	int pstart, pend;

Please describe what these fields mean.

> +struct range {

Isn't "range" too generic a term?  Unless you make this as a static
declaration only visible to functions where "range" can only mean "line
ranges" in their context, that is.
