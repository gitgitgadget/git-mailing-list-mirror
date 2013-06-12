From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 1/2] rm: better error message on failure for multiple files
Date: Wed, 12 Jun 2013 15:13:41 -0700
Message-ID: <7v4nd30yga.fsf@alter.siamese.dyndns.org>
References: <1371024404-22468-1-git-send-email-Mathieu.Lienard--Mayor@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Jorge Juan Garcia Garcia 
	<Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Thu Jun 13 00:13:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmtIc-0003Xa-9Y
	for gcvg-git-2@plane.gmane.org; Thu, 13 Jun 2013 00:13:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757289Ab3FLWNq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Jun 2013 18:13:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37674 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756876Ab3FLWNp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jun 2013 18:13:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 25D9627F74;
	Wed, 12 Jun 2013 22:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=A4tcrTQ8lVYW1okxHtrzfdUmo9o=; b=ktF1gQ
	iiYZsT6Yp009/rTOy6Pgh7qWP8z8JqzzFcmuJ+LaBy7SZDSiEfiXoogPfRtlRthx
	F6WSoU6TSk/CoHeCcErK6/c98tb4lHSfwOD7+yn2+pbNshB8lHSRB36OnrkWKCjv
	+Dj6qT13wWPutt4Qq/iOqJtK5+U+KYr6qon5M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=C3KmEdr3cIjTAeZFFsk1OVUlg0IvP6+t
	/Ich2ohhrW67SHblwKYqnuCShb5xLR2hzmhZhFvZ8jX63Dc3zRNLghh3yVdhSmF/
	v3b9x0Z3iYt2tm1+kaADTytlj7+J/01wHCuwloxZKzz6My3+iq6Wn9vaqVKpVRzO
	/FsvSar0sjo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 17D7D27F73;
	Wed, 12 Jun 2013 22:13:45 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5EAB727F70;
	Wed, 12 Jun 2013 22:13:43 +0000 (UTC)
In-Reply-To: <1371024404-22468-1-git-send-email-Mathieu.Lienard--Mayor@ensimag.imag.fr>
	(Mathieu Lienard--Mayor's message of "Wed, 12 Jun 2013 10:06:43
	+0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5803EA40-D3AD-11E2-A6CD-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227686>

Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>
writes:

> When 'git rm' fails, it now displays a single message
> with the list of files involved, instead of displaying
> a list of messages with one file each.
>
> As an example, the old message:
> 	error: 'foo.txt' has changes staged in the index
> 	(use --cached to keep the file, or -f to force removal)
> 	error: 'bar.txt' has changes staged in the index
> 	(use --cached to keep the file, or -f to force removal)
>
> would now be displayed as:
> 	error: the following files have changes staged in the index:
> 	    foo.txt
> 	    bar.txt
> 	(use --cached to keep the file, or -f to force removal)
>
> Signed-off-by: Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>
> Signed-off-by: Jorge Juan Garcia Garcia <Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
> ---
>
> Changes since v4:
>  -removal of useless blanks after variable declarations
>  -use of string_list_clear

Thanks.  Will queue.
