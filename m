From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Extend sample pre-commit hook to check for non ascii
   filenames
Date: Mon, 18 May 2009 12:40:09 +0200
Message-ID: <4A113B09.6040301@viscovery.net>
References: <419AD153-53B4-4DAB-AF72-4127C17B1CA0@gmail.com> <m3r5yukv6g.fsf@localhost.localdomain> <20090512214250.GA22974@macbook.lan> <200905122356.00659.jnareb@gmail.com> <20090514175850.GA26267@macbook.lan> <7vbpputewv.fsf@alter.siamese.dyndns.org> <419AD153-53B4-4DAB-AF72-4127C17B1CA0@gmail.com> <200905122356.00659.jnareb@gmail.com> <20090514175850.GA26267@macbook.lan> <200905151657.47225.jnareb@gmail.com> <20090518095044.GB910@heiko-voigts-macbook.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Esko Luontola <esko.luontola@gmail.com>, git@vger.kernel.org
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Mon May 18 12:40:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M60Gh-0007x2-Rw
	for gcvg-git-2@gmane.org; Mon, 18 May 2009 12:40:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754526AbZERKkT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2009 06:40:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754248AbZERKkR
	(ORCPT <rfc822;git-outgoing>); Mon, 18 May 2009 06:40:17 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:40728 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754161AbZERKkQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2009 06:40:16 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1M60GT-0007jx-24; Mon, 18 May 2009 12:40:13 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id D21A3FCD2; Mon, 18 May 2009 12:40:09 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <20090518095044.GB910@heiko-voigts-macbook.local>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119436>

Heiko Voigt schrieb:
> +# is_ascii() Tests the string given given on standard input for
> +# printable ascii conformance. We exploit the fact that the printable
> +# range starts at the space character and ends with tilde.
> +is_ascii() {
> +    test -z "$(LC_ALL=C tr -d \ -~)"
> +}
> +
> +if [ "$allownonascii" != "true" ]
> +then
> +	# until git can handle non-ascii filenames gracefully
> +	# prevent them to be added into the repository
> +	if ! git diff --cached --name-only --diff-filter=A -z \
> +	   | tr "\0" "\n" | is_ascii; then

Will this not fail to add more than one file with allowed names? The \n is
not removed in is_ascii(), and so the resulting string will not be empty.

BTW, not all tr work well with NULs. See the commit message of e85fe4d8,
for example. Otherwise, I would have suggested to convert the NUL to some
allowed ASCII character, e.g. 'A'. BTW, you should really use '\0' and
'\n' (single-quotes) to guarantee that the shell does not ignore the
backslash.

-- Hannes
