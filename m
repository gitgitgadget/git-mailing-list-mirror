From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 5/6] remote: read $GIT_DIR/branches/* with strbuf_getline()
Date: Mon, 22 Feb 2016 11:09:18 -0800
Message-ID: <xmqqa8ms7eap.fsf@gitster.mtv.corp.google.com>
References: <56CA5DBB.8040006@moritzneeb.de> <56CA62D3.7060808@moritzneeb.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Moritz Neeb <lists@moritzneeb.de>
X-From: git-owner@vger.kernel.org Mon Feb 22 20:09:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXvrJ-00075K-AU
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 20:09:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752598AbcBVTJW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2016 14:09:22 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:61540 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752098AbcBVTJV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2016 14:09:21 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5DF5D4748F;
	Mon, 22 Feb 2016 14:09:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3HUGz+AOYGV7f9qaZ65TgcLX8Kk=; b=ofyxn+
	8akVxEMhrWJLx7WfpvzExCLPFnvlo/2YGrYD9WK/itR7GWmUx+njVfyalISVbjWy
	1GOKBgjWGEfGABApW0VW3usGBTj0ZgVhJb/eAjDCvgbZLH4Hs61q6Z8YdFWSGfEY
	YDoaz3+ftLmJriRdfHmUR8hAawehpQ0PqdlIw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FBqB8Mn2kfpAvhaPZjBunf2mYSJFQG7m
	Ea12O93N3FgC1C1R1dAWkysN4y6gddlcuyPxA/fgrrYDPR9owTp1rD/1mb73X6fJ
	BsY/V4oD2XSvSU0GkuAdHQLteB7zYWxLkkA0JBrL6W54Za0fGKT++GLrrdlNp590
	8IOSljrpOlk=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 53F804748D;
	Mon, 22 Feb 2016 14:09:20 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id BC60C4748C;
	Mon, 22 Feb 2016 14:09:19 -0500 (EST)
In-Reply-To: <56CA62D3.7060808@moritzneeb.de> (Moritz Neeb's message of "Mon,
	22 Feb 2016 02:22:27 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C67A3720-D997-11E5-83D0-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286944>

Moritz Neeb <lists@moritzneeb.de> writes:

> The line read from the branch file is directly trimmed after reading with
> strbuf_trim(). There is thus no logic expecting CR, so strbuf_getline_lf()
> can be replaced by its CRLF counterpart.
>
> Signed-off-by: Moritz Neeb <lists@moritzneeb.de>
> ---
> To be honest, I did not yet fully understand the purpose of this branches/ file.
> What I'd expect is that it is some intermediary file while fetching?
> Or is it edited directly by the user and thus it's necessary to strip spaces
> that could be added accidentally?

[Documentation/gitrepository-layout.txt]

branches::
	A slightly deprecated way to store shorthands to be used
	to specify a URL to 'git fetch', 'git pull' and 'git push'.
	A file can be stored as `branches/<name>` and then
	'name' can be given to these commands in place of
	'repository' argument.  See the REMOTES section in
	linkgit:git-fetch[1] for details.  This mechanism is legacy
	and not likely to be found in modern repositories. This
	directory is ignored if $GIT_COMMON_DIR is set and
	"$GIT_COMMON_DIR/branches" will be used instead.
