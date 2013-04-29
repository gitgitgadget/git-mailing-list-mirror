From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add new @ shortcut for HEAD
Date: Mon, 29 Apr 2013 15:38:59 -0700
Message-ID: <7vwqrlezcs.fsf@alter.siamese.dyndns.org>
References: <1367264106-2351-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jon Seymour <jon.seymour@gmail.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 30 00:39:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWwiy-0002dh-Te
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 00:39:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932221Ab3D2WjE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 18:39:04 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52296 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759040Ab3D2WjC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 18:39:02 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CE1BF1A447;
	Mon, 29 Apr 2013 22:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nuB8NlEqWFD6SQwGL+lwjDfzCA4=; b=H+nnCJ
	vPA16odjIhTv2l8XV4jo6mg6Fl0sV4LaTifYaWccjKwRNjOwCFRh/SXPz/+kMiV0
	2HHhUmpM9P4kTnpvPBYZDsstsuek45ruqob871xzRCC54FklmPHJG+7bPMqOWS10
	UIhLzIgzmLEx8GcWr1rQqWtGAnkZcotx+1fbE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NZS7OwDe9HFul2hIj8lcYYBELTt4el6D
	aiNQVH5HUQd8evjrjMqMuAXChgulmOQBnsPeSYysN6WoksKohooTTHu3LiZ2j9o0
	eIARjZ5OFC7F8le4dwLt/HrZbRMjg7p1U2vcQoJBhT9/ARtcA9abAFpZc77KWt6p
	Fel4CUurou4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C133F1A446;
	Mon, 29 Apr 2013 22:39:01 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 307261A444;
	Mon, 29 Apr 2013 22:39:01 +0000 (UTC)
In-Reply-To: <1367264106-2351-1-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Mon, 29 Apr 2013 14:35:06 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9692D12A-B11D-11E2-81FE-8D009ADAE8A5-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222872>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> diff --git a/t/t1503-rev-parse-verify.sh b/t/t1503-rev-parse-verify.sh
> index 813cc1b..426c63f 100755
> --- a/t/t1503-rev-parse-verify.sh
> +++ b/t/t1503-rev-parse-verify.sh
> @@ -115,4 +115,13 @@ test_expect_success 'master@{n} for various n' '
>  	test_must_fail git rev-parse --verify master@{$Np1}
>  '
>  
> +test_expect_success 'empty @' '
> +	rev_hash=$(git rev-parse --verify @) &&
> +	test "$rev_hash" = "$HASH4" &&
> +	rev_hash=$(git rev-parse --verify HEAD@) &&
> +	test "$rev_hash" = "$HASH4" &&
> +	rev_hash=$(git rev-parse --verify master@) &&
> +	test "$rev_hash" = "$HASH4"
> +'

Don't we have different refs that resolve to something other than
$HASH4 at this point in the test?  Otherwise we wouldn't notice a
breakage because we cannot tell if HEAD@ and master@ are interpreted
correctly or all of these happen to yield $HASH4 because a version
somebody else patches to break the implementation in this patch
discards any string before @ that is not followed by {stuff}.
