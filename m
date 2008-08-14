From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Make xdiff_outf_{init,release} interface
Date: Wed, 13 Aug 2008 17:46:29 -0700
Message-ID: <7vljz0iftm.fsf@gitster.siamese.dyndns.org>
References: <20080813070508.GB4396@lavos.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Brian Downing <bdowning@lavos.net>
X-From: git-owner@vger.kernel.org Thu Aug 14 02:47:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTR07-0001Uk-HX
	for gcvg-git-2@gmane.org; Thu, 14 Aug 2008 02:47:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752437AbYHNAqf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2008 20:46:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752573AbYHNAqf
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 20:46:35 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:59881 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751565AbYHNAqf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2008 20:46:35 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 2D84458B36;
	Wed, 13 Aug 2008 20:46:34 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 67E8B58B35; Wed, 13 Aug 2008 20:46:31 -0400 (EDT)
In-Reply-To: <20080813070508.GB4396@lavos.net> (Brian Downing's message of
 "Wed, 13 Aug 2008 02:05:09 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 7187DBB6-699A-11DD-87B8-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92298>

Brian Downing <bdowning@lavos.net> writes:

> @@ -103,6 +110,10 @@ int xdiff_outf(void *priv_, mmbuffer_t *mb, int nbuf)
>  	return 0;
>  }
>  
> +void xdiff_outf_release(void *priv_)
> +{
> +}
> +

It might make it more clear to have this function take a pointer to
"struct xdiff_emit_state", which is always the first member of the
callback private data structure.

Although I wish xdi_diff() could do the necessary clean-up immediately
before it returns (so that the caller did not have to do anything
special), it is not possible to do so cleanly, because there are "outf"
implementations other than xdiff_outf that do not even use "struct
xdiff_emit_state" in their callbacks.  So I think your patch makes sense.

Thanks.
