From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCHv2 10/19] git-submodule.sh: convert test -a/-o to && and ||
Date: Thu, 22 May 2014 08:49:30 +0200
Message-ID: <vpqha4is3yd.fsf@anie.imag.fr>
References: <1400682255-17616-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, j.sixt@viscovery.net
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 22 08:49:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnMoy-0003If-Cw
	for gcvg-git-2@plane.gmane.org; Thu, 22 May 2014 08:49:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751966AbaEVGti (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2014 02:49:38 -0400
Received: from mx2.imag.fr ([129.88.30.17]:59195 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750909AbaEVGtg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2014 02:49:36 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s4M6nUpa009777
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 22 May 2014 08:49:30 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s4M6nUTR008468;
	Thu, 22 May 2014 08:49:30 +0200
In-Reply-To: <1400682255-17616-1-git-send-email-gitter.spiros@gmail.com> (Elia
	Pinto's message of "Wed, 21 May 2014 07:24:15 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 22 May 2014 08:49:30 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s4M6nUpa009777
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1401346172.86968@M13c6fHKsJjE9xtgslJnHQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249877>

Elia Pinto <gitter.spiros@gmail.com> writes:

> This is version 2 of the patch to git-submodule of the 
> patch series "convert  test -a/-o to && and ||". 
> It contains the fixes identified by Johannes and
> Matthieu. 

This version of the patch (not the whole series) is

Reviewed-by: Matthieu Moy <Matthieu.Moy@imag.fr>

Some comments for next time:

* I agree with Johannes that splitting the series with one patch per
  file is not the right way to split. As a reviewer, I want to

  - check that -a trivially translates to &&
  - check that -o trivially translates to ||
  - check non-trivial cases

  Interleaving these cases (especially the trivial and non-trivial
  cases) makes the review much harder. For this kind of series, the
  change is trivial, but the review is not (Johannes caught a || Vs &&
  inversion that I didn't find for example, which is quite serious), so
  the "optimize your patches for review" is even more important than
  usual.

* Again, to avoid mixing trivial and non-trivial changes, ...

> @@ -1059,13 +1059,17 @@ cmd_summary() {
>  		while read mod_src mod_dst sha1_src sha1_dst status sm_path
>  		do
>  			# Always show modules deleted or type-changed (blob<->module)
> -			test $status = D -o $status = T && echo "$sm_path" && continue
> +			case "$status" in
> +			[DT])
> +				printf '%s\n' "$sm_path" &&
> +				continue
> +			esac

turning a echo into a printf is good, but would be better done
separately.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
