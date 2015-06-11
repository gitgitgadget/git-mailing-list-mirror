From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2 7/7] bisect: allows any terms set by user
Date: Thu, 11 Jun 2015 17:28:08 +0200
Message-ID: <vpqy4jq2rjr.fsf@anie.imag.fr>
References: <1433962918-6536-1-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
	<1433962918-6536-3-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, remi.lespinet@ensimag.grenoble-inp.fr,
	louis--alexandre.stuber@ensimag.grenoble-inp.fr,
	remi.galan-alfonso@ensimag.grenoble-inp.fr,
	guillaume.pages@ensimag.grenoble-inp.fr, chriscool@tuxfamily.org,
	thomasxnguy@gmail.com, valentinduperray@gmail.com
To: Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Jun 11 17:28:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z34Oy-0005uZ-KV
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jun 2015 17:28:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752282AbbFKP2P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2015 11:28:15 -0400
Received: from mx2.imag.fr ([129.88.30.17]:60307 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751387AbbFKP2P (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2015 11:28:15 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t5BFS6T7019018
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 11 Jun 2015 17:28:06 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t5BFS834014736;
	Thu, 11 Jun 2015 17:28:08 +0200
In-Reply-To: <1433962918-6536-3-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
	(Antoine Delaite's message of "Wed, 10 Jun 2015 21:01:58 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 11 Jun 2015 17:28:06 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t5BFS6T7019018
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1434641290.25743@Zwt6n8w0gLw7ytjFY2oNlw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271418>

Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr> writes:

> -	# start_bad_good is used to detect if we did a 
> -	# 'git bisect start bad_rev good_rev'
> -	start_bad_good=0
> +	# terms_defined is used to detect if we did a
> +	# 'git bisect start bad_rev good_rev' or if the user
> +	# defined his own terms with git bisect terms
> +	terms_defined=0

Modifying in PATCH 7 some code that you introduced in PATCH 3 is
suspicious. Is there any reason you did not name the variable
"terms_defined" in the first place? (i.e. squash this hunk and the other
instance of start_bad_good into PATCH 3)

(Whether this is a rethorical question is up to you ;-) )

> +	if test -s "$GIT_DIR/TERMS_DEFINED"
> +	then
> +		terms_defined=1
> +		get_terms
> +		rm -rf "$GIT_DIR/TERMS_DEFINED"

I don't understand why you need to delete this file. I did not review
thoroughly so there may be a reason, but you can help the reader with a
comment here.

> +bisect_terms () {
> +	test $# -eq 2 ||
> +	die "You need to give me at least two arguments"
> +
> +	if ! test -s "$GIT_DIR/BISECT_START"
> +	then
> +		echo $1 >"$GIT_DIR/BISECT_TERMS" &&
> +		echo $2 >>"$GIT_DIR/BISECT_TERMS" &&
> +		echo "1" > "$GIT_DIR/TERMS_DEFINED"

Space after >.

> @@ -574,7 +600,7 @@ case "$#" in
>  		git bisect -h ;;
>  	start)
>  		bisect_start "$@" ;;
> -	bad|good|new|old)
> +	bad|good|new|old|$NAME_BAD|$NAME_GOOD)

See my other message about quoting.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
