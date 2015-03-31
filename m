From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/6] remote.c: drop default_remote_name variable
Date: Tue, 31 Mar 2015 13:37:35 -0700
Message-ID: <xmqqzj6sq4xc.fsf@gitster.dls.corp.google.com>
References: <20150331173339.GA17732@peff.net>
	<20150331173437.GA18912@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 31 22:38:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yd2ux-0007BF-IU
	for gcvg-git-2@plane.gmane.org; Tue, 31 Mar 2015 22:37:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753495AbbCaUhn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2015 16:37:43 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:56670 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753443AbbCaUhm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2015 16:37:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0639C4597F;
	Tue, 31 Mar 2015 16:37:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=n0550GmAKIi8inZ9EBLjIlFQhP8=; b=cjLPej
	8sVlFHdmWI2rTNutjeQv6BHoJKYf1FFCFuRAWgIJNdl8gsn3OFGCqqM721q7ghlo
	DmfHSiNZurVUcSOzFpn0uTgI8t/u5EMHHbt6aAk9Hvph4No5SQAmUYQUG2GSX3YV
	wepn2ppMHJPi5qrexQQP0yZ1+9FhR60fXgsz0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=c1HIDHNN+JKpiqbHX0sZF5uzNjxr0wEG
	X0r3JAk+g7y8a++YdohAO6c9P2clLYytkWVvE/HlLN2jEc2hnluJ4ue0eyLg4KQ5
	sUGO9qp4AANIQZ85qnXlP+/FO/g+61kndNTKs6XqsQjPiYEzl/D6ehN/ZAzXRJIP
	sk8y3JAHsZA=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F27E54597E;
	Tue, 31 Mar 2015 16:37:41 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 058AA45977;
	Tue, 31 Mar 2015 16:37:36 -0400 (EDT)
In-Reply-To: <20150331173437.GA18912@peff.net> (Jeff King's message of "Tue,
	31 Mar 2015 13:34:38 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C4648C24-D7E5-11E4-A790-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266554>

Jeff King <peff@peff.net> writes:

> When we read the remote config from disk, we update a
> default_remote_name variable if we see branch.*.remote
> config for the current branch. This isn't wrong, or even all
> that complicated, but it is a bit simpler (because it
> reduces our overall state) to just lazily compute the
> default when we need it.
>
> The ulterior motive here is that the push config uses a
> similar structure, and _is_ much more complicated as a
> result. That will be simplified in a future patch, and it's
> more readable if the logic remotes and push-remotes matches.

I cannot quite parse the part after "if..."; "the logic used by
remotes and push-remotes matches"?

> Note that we also used default_remote_name as a signal that
> the remote config has been loaded; after this patch, we now
> use an explicit flag.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  remote.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/remote.c b/remote.c
> index 68901b0..fcd868d 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -39,6 +39,8 @@ struct rewrites {
>  	int rewrite_nr;
>  };
>  
> +static int loaded_remotes_config;
> +

I expect that the reason why this is not a function scope static in
read_config() will be revealed in the later patch in this series...
