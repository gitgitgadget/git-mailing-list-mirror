From: Junio C Hamano <gitster@pobox.com>
Subject: Re: feature request - implement a "GIT_AUTHOR_EMAIL" equivalent, but processed BEFORE .gitconfig
Date: Fri, 30 May 2014 14:35:37 -0700
Message-ID: <xmqq1tvb7xw6.fsf@gitster.dls.corp.google.com>
References: <5388CBA5.9030403@neulinger.org>
	<20140530182746.GK12314@google.com> <5388D175.3060500@neulinger.org>
	<xmqqvbsn82u6.fsf@gitster.dls.corp.google.com>
	<5388E2F7.606@neulinger.org>
	<20140530200945.GB5513@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nathan Neulinger <nneul@neulinger.org>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 30 23:35:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WqUSs-0006dg-S1
	for gcvg-git-2@plane.gmane.org; Fri, 30 May 2014 23:35:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755971AbaE3Vfn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2014 17:35:43 -0400
Received: from smtp.pobox.com ([208.72.237.35]:60133 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751525AbaE3Vfm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2014 17:35:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2F5591B14C;
	Fri, 30 May 2014 17:35:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=j3eVhgQomxPIe0iFm5xfko/1c0M=; b=fIth9Y
	kxNobTLY+Q7vEsaVmHC6kIaMe6om5PlSsBMJm9lcLa/VwquYD7eG/Wwe087qBDqZ
	ngbP1cCZhYFQFu4+hkf5Hoq5zTeEnc66bHzQpsjP/6uFSgKjRExGz3Dvu0nrHlpN
	8X+TcCSgqiLIul/EqPL954+pD2CrH3kldOsXE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DXXUks6U1Rd35XkmfnlNd9k1p+iVh2l2
	NXPuMxvrBiSDKYgCVgou+DTXAgjkuYa1VYYrv3b38xuW3E4lqlMKbU5WO5mKgUva
	5VKVZBNXK/LBTzKSp2PrVyXZ/zlesgTVQI0pVe4189vUoG7bVTEUfdwGXmp0h7Wg
	Qgj63fyo/5Q=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 22CD01B14B;
	Fri, 30 May 2014 17:35:42 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A415D1B144;
	Fri, 30 May 2014 17:35:38 -0400 (EDT)
In-Reply-To: <20140530200945.GB5513@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 30 May 2014 16:09:45 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 579FCB82-E842-11E3-AE59-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250487>

Jeff King <peff@peff.net> writes:

> On Fri, May 30, 2014 at 02:58:47PM -0500, Nathan Neulinger wrote:
>
>> Not really, since there are lots of servers,...
>
> But I think anything you could set up in the environment could be set up
> in an on-the-fly $HOME. For example, instead of:
>
>   GIT_WEAK_AUTHOR_NAME=$name
>   GIT_WEAK_AUTHOR_EMAIL=$email
>
> do:
>
>   HOME=$(mktemp -d gitenv.XXXXXX")
>   trap 'rm -rf "$HOME"' 0
>   git config --global user.name "$name"
>   git config --global user.email "$email"
>
> You'd want to link in anything else you actually _want_ in $HOME, but
> that also gives an opportunity to set up application-specific options
> based on the user (e.g., if you could pull their .vimrc from some shared
> storage or something).

Yes.  I agree that "Not really, ..." was not very convincing to me.

Another thing that might be useful in general (i.e. I am not
particularly trying to help the "shared" configuration on the topic
of this thread) is to allow environment variable substitution in
expand_user_path().

Nathan's installation can set a "GIT_MYSELF" and then have something
like this in the shared $HOME/.gitconfig

	[include]
        	path = /usr/local/users/$GIT_MYSELF/ident

we could even make the whole thing fail when GIT_MYSELF is not set
but I haven't thought things through ;-)
