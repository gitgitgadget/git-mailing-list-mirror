From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] remote-hg: support for notes
Date: Thu, 29 Aug 2013 15:49:04 -0700
Message-ID: <xmqqr4dc15b3.fsf@gitster.dls.corp.google.com>
References: <xmqqzjs016zx.fsf@gitster.dls.corp.google.com>
	<1377815390-1480-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 30 00:49:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFB1d-0003vJ-Vj
	for gcvg-git-2@plane.gmane.org; Fri, 30 Aug 2013 00:49:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756032Ab3H2WtI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 18:49:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38924 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752381Ab3H2WtH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 18:49:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B31FB3DAF9;
	Thu, 29 Aug 2013 22:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lzfb9rxb5L381EiPK2cvDdYv+YY=; b=Zd9Gr9
	/jw9epaXV8LAX2eLVHpZ69JzgOaN7QMNSt0RTdwScyYe3Dhve4aUSnPN8MGXFy1Y
	Wi1Vmoa12BHgMTNC3XmAjCdUV1JOHVs3UWFAC5E1T4triN2uxE9pzFy/kgAvoV/G
	tZ6aYtCjG09YkRTEiqNZGtWVtNzcZjC81KOHA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RbxnBysoqp62xRI+qEQ5ujDTRoLQ96aF
	WR/2vi4FP7TJcqeDAlLyllrDpcPcTu27chCczgvqcIFQ9kG4w0LpiX4IKyajozBD
	Cir3SZNgqHcw070KAc1oJpy9O8SZtzI3R011eaWrREs0x3fDQUe2jI+DtsqaHtkf
	7kHVmXiUATk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A5B103DAF8;
	Thu, 29 Aug 2013 22:49:06 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0271B3DAF6;
	Thu, 29 Aug 2013 22:49:05 +0000 (UTC)
In-Reply-To: <1377815390-1480-1-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Thu, 29 Aug 2013 17:29:50 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 356A8ACE-10FD-11E3-B536-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233380>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Keep track of Mercurial revisions as Git notes under the 'refs/notes/hg'
> ref, this way, the user can easily see which Mercurial revision
> correspond to certain Git commit.
>
> Unfortunately, there's no way to efficiently update the notes after
> doing an export (push), so they'll have to be updated when importing
> (fetching).
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  contrib/remote-helpers/git-remote-hg | 35 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 34 insertions(+), 1 deletion(-)
>
> diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
> index 307d82c..7f50b40 100755
> --- a/contrib/remote-helpers/git-remote-hg
> +++ b/contrib/remote-helpers/git-remote-hg
> @@ -23,8 +23,12 @@ import subprocess
>  import urllib
>  import atexit
>  import urlparse, hashlib
> +import time as ptime
>  
>  #
> +# If you want to see Mercurial revisions as Git commit notes:
> +# git config core.notesRef refs/notes/hg
> +#

Yup.  This is better.  Will queue.
