From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v1] travis-ci: build documentation
Date: Fri, 22 Apr 2016 11:07:31 +0200
Message-ID: <vpq37qeovu4.fsf@anie.imag.fr>
References: <1461314042-3132-1-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, gitster@pobox.com
To: larsxschneider@gmail.com
X-From: git-owner@vger.kernel.org Fri Apr 22 11:08:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atX4I-0004Ao-09
	for gcvg-git-2@plane.gmane.org; Fri, 22 Apr 2016 11:08:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754171AbcDVJH6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Apr 2016 05:07:58 -0400
Received: from mx2.imag.fr ([129.88.30.17]:40340 "EHLO mx2.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754161AbcDVJHx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2016 05:07:53 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx2.imag.fr (8.13.8/8.13.8) with ESMTP id u3M97Ueh021773
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Fri, 22 Apr 2016 11:07:30 +0200
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u3M97Vq1025383;
	Fri, 22 Apr 2016 11:07:31 +0200
In-Reply-To: <1461314042-3132-1-git-send-email-larsxschneider@gmail.com>
	(larsxschneider@gmail.com's message of "Fri, 22 Apr 2016 10:34:02
	+0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (mx2.imag.fr [129.88.30.17]); Fri, 22 Apr 2016 11:07:31 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u3M97Ueh021773
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1461920852.23052@zKcuI68iw71u36P56KaB1w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292182>

larsxschneider@gmail.com writes:

> +      if [[ "$TRAVIS_OS_NAME" = linux ]] && [[ "$CC" = gcc ]];

[[ is a bashism, and doesn't bring anything here compared to the POSIX
[ ... ], or "test" which is prefered in Git's source code.

The ; or the newline is not needed either.

I'd write

if test "$TRAVIS_OS_NAME" = linux && test "$CC" = gcc; then

> +          then
> +          echo ""
> +          echo "------------------------------------------------------------------------" &&

I usualy avoid "echo <something-starting-with-dash>" as I'm not sure how
portable it is across variants of "echo". Maybe this one is portable
enough, I don't know. Perhaps printf, or cat << EOF ...?

> +          echo "$(tput setaf 2)Building documentation...$(tput sgr0)" &&
> +          make --quiet doc
> +      fi;

Nit: useless ;

I think it makes sense to do some lightweight checks after "make doc",
rather than just check the return code. For example, check that a few
generated files exist and are non-empty, like

test -s Documentation/git.html &&
test -s Documentation/git.1

Thanks,

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
