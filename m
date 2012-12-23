From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] learn to pick/revert into unborn branch
Date: Sat, 22 Dec 2012 20:02:51 -0800
Message-ID: <7vlicppg9g.fsf@alter.siamese.dyndns.org>
References: <1356117013-20613-1-git-send-email-martinvonz@gmail.com>
 <1356117013-20613-2-git-send-email-martinvonz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Martin von Zweigbergk <martinvonz@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 23 05:03:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tmcml-0005en-HX
	for gcvg-git-2@plane.gmane.org; Sun, 23 Dec 2012 05:03:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751983Ab2LWECz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Dec 2012 23:02:55 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52609 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751847Ab2LWECy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Dec 2012 23:02:54 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 54CC2A1A6;
	Sat, 22 Dec 2012 23:02:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+eyfDLDIpx/KiPeEZooafQKmUCI=; b=QfCcem
	ldnunlBEFt2N78FNl/YApz+8iXMjCB5F3WP0QZgPSy+ffIBcbrw28A2lyGv5GMS5
	RDnKOoYB9lSOKXFDyeYbFxasj85ebQkIWlE2psZVtthWf7xAZUf0euq5/yurMMHQ
	hnIA6H675piwsytqdbqVzJ8la9efyvosPDyQU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WKsIKhyCy5Rz52VqKWaObZ7AWiIs1PU+
	sYxIg/kOo2pEhzx/7Q2GfQob64FEyuSpMZqkJx0Rb265ArnItfOsciToM7Ox1Zoj
	wzA1TjU4FQ5Ir4Tb8LILe4yNneF9MoVttykJexxsMuqjBX7aGA/xQckIBqJDJWzh
	eV53vRsx7Q0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 423ECA1A5;
	Sat, 22 Dec 2012 23:02:53 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AF5A5A1A3; Sat, 22 Dec 2012
 23:02:52 -0500 (EST)
In-Reply-To: <1356117013-20613-2-git-send-email-martinvonz@gmail.com> (Martin
 von Zweigbergk's message of "Fri, 21 Dec 2012 11:10:11 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9FBC6F94-4CB5-11E2-A077-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212079>

Martin von Zweigbergk <martinvonz@gmail.com> writes:

> @@ -435,8 +437,9 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
>  	else
>  		parent = commit->parents->item;
>  
> -	if (opts->allow_ff && parent && !hashcmp(parent->object.sha1, head))
> -		return fast_forward_to(commit->object.sha1, head);
> +	if (opts->allow_ff &&
> +	    (parent && !hashcmp(parent->object.sha1, head) || !parent && unborn))

Style (from GNU); please avoid (A && B || C) and spell the
precedence between && and || explicitly, i.e.

	((A && B) || C)

> +	git rm --cached -r . &&
> +	rm -rf * &&

Not "git rm -rf ." and as two separate steps?
