From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH/RFC v3 2/4] git-am.txt: add configuration section in git am documentation
Date: Wed, 03 Jun 2015 18:21:29 +0200
Message-ID: <vpq4mmoep9y.fsf@anie.imag.fr>
References: <1433266446-2845-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
	<1433266446-2845-2-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
To: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jun 03 18:21:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0BQC-0003Ya-FG
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 18:21:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755760AbbFCQVg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2015 12:21:36 -0400
Received: from mx1.imag.fr ([129.88.30.5]:59973 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753762AbbFCQVe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2015 12:21:34 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t53GLR1I003255
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 3 Jun 2015 18:21:27 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t53GLTBB010157;
	Wed, 3 Jun 2015 18:21:29 +0200
In-Reply-To: <1433266446-2845-2-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
	(Remi Lespinet's message of "Tue, 2 Jun 2015 19:34:04 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 03 Jun 2015 18:21:28 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t53GLR1I003255
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1433953290.91178@yqCURaTQJRvu8Crb2SGgRg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270693>

Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr> writes:

> Prepare a configuration section for the git am documentation.

Most git-*.txt do not have this CONFIGURATION section.

In an ideal world, we would have such section automatically generated
(i.e. the description for each variable would exist in one place, and we
would make sure that both "man git-config" and "man git-<command>" show
it). In a really ideal world, it would also be propagated to the code
and we would have a "git config --describe am.keepcr" or so that would
return the doc.

I'm a bit worried to see documentation cut-and-pasted from config.txt to
git-*.txt for maintainability: if the text on one side is modified,
we're likely to forget the other and the text will diverge with time.

Not a strong objection, but I have the feeling that the more we do this
kind of patches, the harder it will be if ever we decide to do the above.

> +CONFIGURATION
> +-------------
> +
> +am.keepcr::
> +	If true, git-am will call git-mailsplit for patches in mbox format

`git am`
`git mailsplit`

> +	with parameter '--keep-cr'. In this case git-mailsplit will

Likewise

> +	not remove `\r` from lines ending with `\r\n`. Can be overridden
> +	by giving '--no-keep-cr' from the command line.

That should be backquote, not forward-quote, right?

I know it's not your code since it's a cut-and-paste from config.txt,
but that illustrates my point above: we used to have one place with
wrong quotes, and we'd have two after the patch.

>  OPTIONS
>  -------
>  (<mbox>|<Maildir>)...::
> @@ -43,11 +53,11 @@ OPTIONS
>  --keep-non-patch::
>  	Pass `-b` flag to 'git mailinfo' (see linkgit:git-mailinfo[1]).
>  
> ---[no-]keep-cr::
> +--keep-cr::
> +--no-keep-cr::
>  	With `--keep-cr`, call 'git mailsplit' (see linkgit:git-mailsplit[1])
>  	with the same option, to prevent it from stripping CR at the end of
> -	lines. `am.keepcr` configuration variable can be used to specify the
> -	default behaviour.

I don't think it's a good idea to remove this part. If I look for a way
to make --keep-cr the default, the first place I'd look would be the doc
for --keep-cr, and I'd appreciate a link to am.keepcr.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
