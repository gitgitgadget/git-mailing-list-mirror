From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 07/13] remote-hg: redirect buggy mercurial output
Date: Thu, 04 Apr 2013 09:40:49 -0700
Message-ID: <7vmwtejlke.fsf@alter.siamese.dyndns.org>
References: <1365089422-8250-1-git-send-email-felipe.contreras@gmail.com>
 <1365089422-8250-8-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Max Horn <max@quendi.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 04 18:42:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNnEe-0003sN-T6
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 18:42:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763173Ab3DDQla (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 12:41:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:32783 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762933Ab3DDQlH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 12:41:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C80C413621;
	Thu,  4 Apr 2013 16:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tW5RRBEgxVknkKbFs+ATcmfaBFQ=; b=taYgML
	pvf+IUM+QI8X/IKZiXbMItM1kpd14y5dRL/9wioCFcpfsNP7ZkyUpZoZZxoWhZdE
	JcfJ+Mn3CMVBG8Y8mgByr+YgXc+Pj3KNwTEjKL+jtk6Bd/zrIwrG+PPUehfE0nbi
	f4wk5cScKtN0cTRrs7NA3lZCGZTE4Xy66lXM8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=X9H/UVBEX84moEpZAP+Kup/Wh0Y8I3VB
	FEBl5emGb1yUNRQcCdlRqItXYHXvkQR8P/IOhz7T8uHPoVPf9V1jnNI8+7b9ZMsY
	JQ92ahLgdjZPToLkf5Ty2lv75ir9/+XPWER8jaa1Ua2BwGUJ+x761v+syNzt4a0r
	q2uH1PQBJfE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BF69513620;
	Thu,  4 Apr 2013 16:40:51 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2CCB41361F; Thu,  4 Apr
 2013 16:40:51 +0000 (UTC)
In-Reply-To: <1365089422-8250-8-git-send-email-felipe.contreras@gmail.com>
 (Felipe Contreras's message of "Thu, 4 Apr 2013 09:30:16 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6926AB70-9D46-11E2-B4E0-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220031>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Mercurial emits messages like "searching for changes", "no changes
> found", etc. meant for the use of its own UI layer, which break the pipe
> between transport helper and remote helper.
>
> Since there's no way to silence Mercurial, let's redirect to standard
> error.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---

Thanks.

Let me suggest retitling it with s/buggy/unwanted/, because it is
not a "bug" to have these output from Hg's point of view.  It is
just that this reading process does not want it.

>  contrib/remote-helpers/git-remote-hg | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
> index b200e60..874ccd4 100755
> --- a/contrib/remote-helpers/git-remote-hg
> +++ b/contrib/remote-helpers/git-remote-hg
> @@ -271,6 +271,7 @@ def get_repo(url, alias):
>  
>      myui = ui.ui()
>      myui.setconfig('ui', 'interactive', 'off')
> +    myui.fout = sys.stderr
>  
>      if hg.islocal(url):
>          repo = hg.repository(myui, url)
