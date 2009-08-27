From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] import-tars: Allow per-tar author and commit message.
Date: Wed, 26 Aug 2009 21:57:16 -0700
Message-ID: <7viqg96ehf.fsf@alter.siamese.dyndns.org>
References: <20090826193015.962A7189B12@perkele>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Thu Aug 27 06:57:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgX3E-0003xC-Pj
	for gcvg-git-2@lo.gmane.org; Thu, 27 Aug 2009 06:57:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751958AbZH0E5V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2009 00:57:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751751AbZH0E5V
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Aug 2009 00:57:21 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:60770 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751694AbZH0E5V (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Aug 2009 00:57:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D28211A3B3;
	Thu, 27 Aug 2009 00:57:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=Ai4Gk9zHblb7rFyDAZAx6V1sLdY=; b=GGiBWbm1iibRR20q4w6qquw
	cF23VwRCKT/R3IFxq31k8ECadu5wVHgifOY3ki08VFjNfZu12GaJ5p+j6JU5WqYJ
	7Lpn21nU1Kgv6ZljlVC2KeI2l2Pg/TzxvgfGLGizYyH0P21AS7onk8fNXvCppYEI
	MCmCzKWwXxL+9VSt97i8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=bjUHmsRriAH6fNGw08jITyJ86YildSpmXWOXAbuJ5FialcrT7
	TyX3+v0A0jN1qLYilk25wMuoVjFFKC2bZrWntnnuXGnLO4MCKQzKL1/mW86AdJEA
	FqRVKUY1JmTh1BfIOV2YqenMAD6WotVDJh5It5Y5/k6hEhJwNCXt2+MYSk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B20C81A3B2;
	Thu, 27 Aug 2009 00:57:20 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 086181A3B1; Thu, 27 Aug
 2009 00:57:17 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1A1C84B6-92C6-11DE-B2CA-CA0F1FFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127140>

Peter Krefting <peter@softwolves.pp.se> writes:

> +			while (<MSG>)
> +			{
> +				if (/^Committer:\s+([^<>]*)\s+<(.*)>\s*$/i)
> +				{
> +					$this_committer_name = $1;
> +					$this_committer_email = $2;
> +				}
> +				elsif (/^Author:\s+([^<>]*)\s+<(.*)>\s*$/i)
> +				{
> +					$this_author_name = $1;
> +					$this_author_email = $2;
> +				}
> +				else
> +				{
> +					$commit_msg .= $_;
> +				}

Do you really want to slurp Committer:/Author: lines from _anywhere_ in
the file?  Wouldn't it make more sense to vaguely emulate e-mail message
format with headers, empty-line and then body that is free form?
