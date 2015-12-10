From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase: add --verify-signatures
Date: Thu, 10 Dec 2015 11:11:36 -0800
Message-ID: <xmqq37vai0ev.fsf@gitster.mtv.corp.google.com>
References: <20151210130228.GA22641@netblarch.tu-darmstadt.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	"brian m. carlson" <sandals@crustytoothpaste.net>
To: Alexander 'z33ky' Hirsch <1zeeky@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 10 20:11:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a76cy-0007et-4l
	for gcvg-git-2@plane.gmane.org; Thu, 10 Dec 2015 20:11:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751259AbbLJTLk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Dec 2015 14:11:40 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:62112 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751001AbbLJTLj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Dec 2015 14:11:39 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DEE7332FE4;
	Thu, 10 Dec 2015 14:11:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yUduUY3nz76ksf3QpW+9CYDdvlI=; b=TnEGf0
	v5adD9vgHR1ISsa+PRYaI/lr7dYRnfYTJjcl27Y6T65RPO2SbfvM/q/1HG0vlU9C
	gFswidBorcbYZ6OMLxzA+8NgE9N9Ind3NLsMZY70V8A0Ij+I6MjbyVuUMKH4LO8i
	CTHt6XgkUfcDp/FsoEYcSeFTOPuvOOQfo9HJI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rMhKAjvt7f5krvp1SAuhVctjWcquMNEp
	69fI4LAZjp0/kis/wchTHrALzLvBh0y8ASGn/KJ4EX/DjI0PEnkm8AYA9PEA3ezg
	Tk9LC2FfCe51k1EGE9lexZo3MM6mVbArbtcnwdsG2KJwRBlHgdiXklP+W3ptLMEH
	qWaMTfpQYI8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D51ED32FE3;
	Thu, 10 Dec 2015 14:11:38 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4283932FE2;
	Thu, 10 Dec 2015 14:11:38 -0500 (EST)
In-Reply-To: <20151210130228.GA22641@netblarch.tu-darmstadt.de> (Alexander
	Hirsch's message of "Thu, 10 Dec 2015 14:03:48 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D675E49A-9F71-11E5-96E7-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282226>

Alexander 'z33ky' Hirsch <1zeeky@gmail.com> writes:

> +	if test -n "$rebase_root"
> +	then
> +		foreign_revisions="$orig_head..$onto"
> +	else
> +		foreign_revisions="$orig_head..${restrict_revision-$upstream}"
> +	fi
> +
> +	for cmt in $(git rev-list --reverse "$foreign_revisions")
> +	do
> +		if ! git log -1 --pretty=format:'%G?%n%GS' "$cmt" |

I do not think this matches what the corresponding option in "git
merge" does, where the only tips of the histories being merged are
checked.
