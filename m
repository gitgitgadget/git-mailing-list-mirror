From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 13/13] remote-hg: push to the appropriate branch
Date: Thu, 04 Apr 2013 09:50:16 -0700
Message-ID: <7veheqjl4n.fsf@alter.siamese.dyndns.org>
References: <1365089422-8250-1-git-send-email-felipe.contreras@gmail.com>
 <1365089422-8250-14-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Max Horn <max@quendi.de>, Dusty Phillips <dusty@linux.ca>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 04 18:50:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNnND-00036I-Sz
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 18:50:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763328Ab3DDQuU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 12:50:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43083 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763197Ab3DDQuS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 12:50:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7951813A3E;
	Thu,  4 Apr 2013 16:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wluVntusyIBPMH5OAjAi0qEby9s=; b=wCzs5O
	UOTV2tU9bzK13Oi5Nk5O6AmYw+7fxMdJHP7mmbEoXR4mWkBzsNiNBApIPZWqfi4/
	d0b5maWCr38aPLZ0Kbodotr2s+u+AHBrCqF5tnSVHV4s9i3MvZONcztoxQR7tu04
	RLWby0/N+2l5tzxoXvd78YLgMTHdivh548hY8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=V8V5G3USwlNjNzCUt1A5lgWe492sfXaH
	hZrZ4pFLNCXuknsamZLFHqZ0HuJu38uauaQ5hQYvAbjFz34wC/WbYZd03Wc+WYsR
	PLBpBPppw4ovNrEavCDZDHfjlUpamuJe0ewMg9XgZI9816hEaQILOXz+49TvzM4B
	lAyAPwLblV4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7138813A3C;
	Thu,  4 Apr 2013 16:50:18 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E716413A3B; Thu,  4 Apr
 2013 16:50:17 +0000 (UTC)
In-Reply-To: <1365089422-8250-14-git-send-email-felipe.contreras@gmail.com>
 (Felipe Contreras's message of "Thu, 4 Apr 2013 09:30:22 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BAF73CB6-9D47-11E2-B93F-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220034>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> From: Dusty Phillips <dusty@linux.ca>
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  contrib/remote-helpers/git-remote-hg | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
> index 56b3641..d82eb2d 100755
> --- a/contrib/remote-helpers/git-remote-hg
> +++ b/contrib/remote-helpers/git-remote-hg
> @@ -625,6 +625,10 @@ def parse_commit(parser):
>      if merge_mark:
>          get_merge_files(repo, p1, p2, files)
>  
> +    # Check if the ref is supposed to be a named branch
> +    if ref.startswith('refs/heads/branches/'):
> +        extra['branch'] = ref.rpartition('/')[2]
> +

Is this meant to cut everything after "refs/heads/branches/", or cut
at the last slash?  I know rpartition does the latter, but I was
wondering if we see "refs/heads/branches/foo/bar" as its input here.

>      if mode == 'hg':
>          i = data.find('\n--HG--\n')
>          if i >= 0:
