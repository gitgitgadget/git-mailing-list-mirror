From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [WIP PATCH 1/3] git bisect old/new
Date: Thu, 04 Jun 2015 10:20:22 +0200
Message-ID: <vpqiob3yjeh.fsf@anie.imag.fr>
References: <1433404753-12039-1-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, thomasxnguy@gmail.com,
	valentinduperray@gmail.com, remi.lespinet@ensimag.grenoble-inp.fr,
	louis--alexandre@ensimag.grenoble-inp.fr,
	remi.galan-alfonso@ensimag.grenoble-inp.fr,
	guillaume.pages@ensimag.grenoble-inp.fr,
	Christian Couder <chriscool@tuxfamily.org>,
	Louis Stuber <stuberl@ensimag.grenoble-inp.fr>,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Lucien Kong <Lucien.Kong@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
To: Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Jun 04 10:20:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0QOC-0001L4-Li
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jun 2015 10:20:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752573AbbFDIUc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jun 2015 04:20:32 -0400
Received: from mx1.imag.fr ([129.88.30.5]:47222 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752391AbbFDIU2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jun 2015 04:20:28 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t548KMQW028336
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 4 Jun 2015 10:20:22 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t548KMsN022856;
	Thu, 4 Jun 2015 10:20:22 +0200
In-Reply-To: <1433404753-12039-1-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
	(Antoine Delaite's message of "Thu, 4 Jun 2015 09:59:11 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 04 Jun 2015 10:20:22 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t548KMQW028336
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1434010824.73288@y508k3+FsyluQG+aw5kDgA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270757>

Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr> writes:

> @@ -732,18 +736,25 @@ static void handle_bad_merge_base(void)
>  	if (is_expected_rev(current_bad_oid)) {
>  		char *bad_hex = oid_to_hex(current_bad_oid);
>  		char *good_hex = join_sha1_array_hex(&good_revs, ' ');
> -
> -		fprintf(stderr, "The merge base %s is bad.\n"
> -			"This means the bug has been fixed "
> -			"between %s and [%s].\n",
> -			bad_hex, bad_hex, good_hex);
> -
> +		if (!strcmp(bisect_bad,"bad")) {

space after comma.

> @@ -954,6 +994,9 @@ int bisect_next_all(const char *prefix, int no_checkout)
>  	       "(roughly %d step%s)\n", nr, (nr == 1 ? "" : "s"),
>  	       steps, (steps == 1 ? "" : "s"));
>  
> +	free((char*)bisect_bad);
> +	free((char*)bisect_good);

Already noted last time I think: these must not be freed as they are
pointing to static strings.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
