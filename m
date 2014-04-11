From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 1/3] rebase: avoid non-function use of "return" on FreeBSD
Date: Fri, 11 Apr 2014 10:48:17 +0200
Message-ID: <vpqsipkmeum.fsf@anie.imag.fr>
References: <438458da797bcab97449bfa931a9d1d@74d39fa044aa309eaea14b9f57fe79c>
	<0779303f7d2257a618b5bed00260a8a@74d39fa044aa309eaea14b9f57fe79c>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 11 10:48:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYX8X-0004Vn-3M
	for gcvg-git-2@plane.gmane.org; Fri, 11 Apr 2014 10:48:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755695AbaDKIsb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Apr 2014 04:48:31 -0400
Received: from mx2.imag.fr ([129.88.30.17]:60183 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750817AbaDKIs3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Apr 2014 04:48:29 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s3B8mGZW011199
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 11 Apr 2014 10:48:17 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s3B8mHak028353;
	Fri, 11 Apr 2014 10:48:17 +0200
In-Reply-To: <0779303f7d2257a618b5bed00260a8a@74d39fa044aa309eaea14b9f57fe79c>
	(Kyle J. McKay's message of "Fri, 11 Apr 2014 01:28:17 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 11 Apr 2014 10:48:17 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s3B8mGZW011199
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1397810900.85434@eq3P2m/SY5d3Top8BTuzog
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246074>

"Kyle J. McKay" <mackyle@gmail.com> writes:

> If script2.sh is changed to this:
>
> # script2.sh fixed
> main() {
>         if [ 5 -gt 3 ]; then
>                 return 5
>         fi
>         case bad in *)
>                 echo always shows
>         esac
>         echo should not get here
>         ! :
> }
> main

Wouldn't it be better to just stop using . within function?

The .-ed script could define the complete function, and then the
function would be used from the toplevel script.

If I understand correctly, your version uses nested functions with file
inclusion between both levels of nesting. That might work for the shells
you tested, but if the goal is to avoid using tricky features that may
trigger bugs on some shells, that seems backward.

IOW, why not move the whole run_specific_rebase_internal function to
git-rebase--$type?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
