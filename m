From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Possible regression in ref advertisement
Date: Mon, 25 Feb 2013 10:31:01 -0800
Message-ID: <7vvc9gxn2y.fsf@alter.siamese.dyndns.org>
References: <1361811516.3212.14.camel@centaur.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Mon Feb 25 19:31:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UA2pn-0000nP-HY
	for gcvg-git-2@plane.gmane.org; Mon, 25 Feb 2013 19:31:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758825Ab3BYSbH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Feb 2013 13:31:07 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61270 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751347Ab3BYSbD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Feb 2013 13:31:03 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 32D66B7D8;
	Mon, 25 Feb 2013 13:31:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=PYjOoof8tCEA
	qH3AsAOpSkRUe7w=; b=SvjJMSwE2y4gM15hxdwV66jv92z2sepzJ4qKEYNDHrmX
	yiKbnWw88OvlP5OkFSWKPTK6QTqDz0cghpD6jEJwxNt4+bHiFr0xA+LHwXU+Jfob
	RizGg6HuFhdcMJ1edFO3z+H23+lH4hi53bC2Y/r2ki4LPY+fghk2C+HGMCC6aQ4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=m4onVm
	S00KCLesxGxbbVguGjMwlJdu0X8g9DzvF8yLGEHq4fDOxRPZX/pl2J+lxfqWbH+N
	jdWw34E/5ZJAFYyj5ZvY5+GUXZ8Zqqqs9JLJ640T19/qwmDDkxE1MxMeM9X6rSj2
	2YC1UJM1+t6BS/6Fm6vqCeSSCzrYx3lc2u5r8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 28567B7D7;
	Mon, 25 Feb 2013 13:31:03 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A0869B7D4; Mon, 25 Feb 2013
 13:31:02 -0500 (EST)
In-Reply-To: <1361811516.3212.14.camel@centaur.cmartin.tk> ("Carlos
 =?utf-8?Q?Mart=C3=ADn?= Nieto"'s message of "Mon, 25 Feb 2013 17:58:36
 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 82328DCC-7F79-11E2-9C1A-F3C82E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217075>

Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:

> Hi all,
>
> When testing to see if a different implementation was in shape, I cam=
e
> across something odd where newer git doesn't advertise one of the ref=
s
> in the git repo.
>
> Running `git ls-remote .` or `git-upload-pack` in my git repo, newer =
git
> versions omit peeling the v1.8.0-rc3 tag.
>
> The diff between the command above when ran with 1.7.10.4 (from Debia=
n)
> and current 'master'
>
> --- old 2013-02-25 17:31:29.583526606 +0100
> +++ new 2013-02-25 17:31:36.783526559 +0100
> @@ -1379,7 +1379,6 @@
>  c15295d7477ccec489953299bd03a8e62f86e611       refs/tags/v1.8.0-rc2
>  cd46259ebf2e624bcee2aaae05c36663d414e1a2       refs/tags/v1.8.0-rc2^=
{}
>  22ed067acc84eac8a0a72d20478a18aee4e25571       refs/tags/v1.8.0-rc3
> -87a5461fa7b30f7b7baf27204f10219d61500fbf       refs/tags/v1.8.0-rc3^=
{}
>  bfeb8b9ae0012cb61e026cbcd29664876abf5389       refs/tags/v1.8.0.1
>  ed9fe755130891fc878bb2433204faffb534697b       refs/tags/v1.8.0.1^{}
>  63add1fb45e1ab7a76bb38bbb9467c91fdfaaa7e       refs/tags/v1.8.0.2
>
> Diffing with the output from next, diff tells me it's binary for some
> reason, but looking manually, the peeled v1.8.0-rc3 tag isn't there
> either. I haven't had time to bisect this, so I'm putting it out ther=
e
> in case anybody wants to investigate before I have time to dig into i=
t.

Interesting.  "git ls-remote . | grep 1.8.0-" for maint, master,
next and pu produce identical results for me, all showing peeled
ones correctly.
