From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 02/14] submodules: Add the lib-submodule-update.sh test library
Date: Fri, 20 Jun 2014 10:31:08 -0700
Message-ID: <xmqqk3847k4r.fsf@gitster.dls.corp.google.com>
References: <539DD029.4030506@web.de> <539DD09A.7010200@web.de>
	<53A3443D.9020000@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Jun 25 23:30:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wzulh-0005LF-IJ
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jun 2014 23:30:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755951AbaFYVaH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2014 17:30:07 -0400
Received: from smtp.pobox.com ([208.72.237.35]:52017 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755734AbaFYVaF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2014 17:30:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7B38B21E17;
	Wed, 25 Jun 2014 17:29:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=7Bx6qVaeHk1AWgVtI+qtEiJVnl4=; b=p2/TS9sBQOK+eGWhtPg3
	huFSxIRfVojAgLGIDRPS7deTH2FaKrFDNRod6qIfe9yWKyH6gzdFXJzvvF9VT8mO
	wTm+ewgWSFsTLKMMo5Iu/WXkzGMKp5dXtff255iQEhw8cFCSVSeobp10dT0xr53k
	oRziPwJycBDXVpH450DINuE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=Lq7dIr+jZCcHR1ar6gldeGY+mCAGsFHru7OOuWSLvu8ixi
	TahHQNEsvnZCFP0Q0o5hSi1ZHHREoN2zBZuI8WXhpQalO+qwHnguPDhPhXLCSirJ
	98RttXK6JF+UvlG8BCxKHsDzwarNeBLbWrvLq9lfADQQR75DjbPU4lqvorOQs=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6EB6B21E16;
	Wed, 25 Jun 2014 17:29:58 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 275E121E14;
	Wed, 25 Jun 2014 17:29:51 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D7455826-FCAF-11E3-B300-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252465>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> +		rm -rf sub1 &&
> +		git checkout -f "$1" &&
> +		git status -u -s >actual &&
> +		test_must_be_empty actual &&
> +		sha1=$(git rev-parse HEAD:sub1 || true) &&

	$ xx=; xx=$(git rev-parse HEAD:no-such-path || true) ; echo $? ; echo "<$xx>"
        fatal: Path 'no-such-path' does not exist in 'HEAD'
        0
        <HEAD:no-such-path>

Perhaps you want --verify (or --revs-only) there, i.e.

	sha1=$(git rev-parse --verify HEAD:sub1 || :) &&

or

	sha1=$(git rev-parse --revs-only HEAD:sub1) &&

> +		if test -n "$sha1" &&
> ...
> +	sha1=$(git rev-parse "$commit:$submodule") &&

And here too.

> +	if test -z "$sha1"
