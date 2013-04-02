From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: ZSH segmentation fault while completing "git mv dir/"
Date: Tue, 02 Apr 2013 16:32:52 +0200
Message-ID: <vpqwqslgfzf.fsf@grenoble-inp.fr>
References: <vpqd2v686fi.fsf@grenoble-inp.fr> <513DF4D1.6000500@gmail.com>
	<vpq8v5uueug.fsf@grenoble-inp.fr> <513E3190.20100@gmail.com>
	<20130312013736.GB7105@unpythonic.net>
	<vpqwqtdkq9z.fsf@grenoble-inp.fr>
	<CAMP44s3ocY7qpESHCDRdHJBsH1DV+k1Z5OwSqsWndMZd_s6oBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff Epler <jepler@unpythonic.net>,
	Manlio Perillo <manlio.perillo@gmail.com>,
	git <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 02 16:33:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN2HG-0006iY-Q3
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 16:33:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761363Ab3DBOdD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 10:33:03 -0400
Received: from mx1.imag.fr ([129.88.30.5]:40200 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761360Ab3DBOdB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 10:33:01 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r32EWpSq015716
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 2 Apr 2013 16:32:51 +0200
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UN2Ga-0002ix-Jw; Tue, 02 Apr 2013 16:32:52 +0200
In-Reply-To: <CAMP44s3ocY7qpESHCDRdHJBsH1DV+k1Z5OwSqsWndMZd_s6oBQ@mail.gmail.com>
	(Felipe Contreras's message of "Mon, 1 Apr 2013 04:11:34 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 02 Apr 2013 16:32:51 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r32EWpSq015716
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1365517972.27266@q4jomVf6rlVSOcORmEnVyg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219775>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> And this is a workaround:
>
> --- a/contrib/completion/git-completion.zsh
> +++ b/contrib/completion/git-completion.zsh
> @@ -66,7 +66,7 @@ __gitcomp_file ()
>
>         local IFS=$'\n'
>         compset -P '*[=:]'
> -       compadd -Q -p "${2-}" -f -- ${=1} && _ret=0
> +       compadd -Q -p "${2-}" -- ${=1} && _ret=0
>  }

OK, not something we want to apply to git.git, but this means a
workaround for users is to create a _git file with this content instead
instead of copying/symlinking git-completion.zsh as _git (replace
$GIT_ROOT_PATH with the appropriate value):

. $GIT_ROOT_PATH/contrib/completion/git-completion.zsh

# Work around ZSH bug on zsh 4.3.10-dev-1-cvs0720, which segfaults
# when completing "git mv subdir/<tab>" by redefining __gitcomp_file
__gitcomp_file ()
{
	emulate -L zsh

	local IFS=$'\n'
	compset -P '*[=:]'
	# The original had a -f here to indicate file completion.
	compadd -Q -p "${2-}" -- ${=1} && _ret=0
}

(Hope this helps in case someone has the same problem and finds this
thread ...)

Thanks,

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
