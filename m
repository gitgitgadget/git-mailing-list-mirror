From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2] diff-no-index.c : rewrite read_directory() to use is_dot_or_dotdot().
Date: Wed, 19 Mar 2014 14:44:54 +0100
Message-ID: <vpqpplii9pl.fsf@anie.imag.fr>
References: <1395235753-3285-1-git-send-email-mandrei.dinu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Andrei Dinu <mandrei.dinu@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 19 14:45:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQGny-0004R9-Su
	for gcvg-git-2@plane.gmane.org; Wed, 19 Mar 2014 14:45:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933862AbaCSNpI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2014 09:45:08 -0400
Received: from mx1.imag.fr ([129.88.30.5]:52345 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933817AbaCSNpH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2014 09:45:07 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s2JDiqYe025798
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 19 Mar 2014 14:44:52 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s2JDise9001482;
	Wed, 19 Mar 2014 14:44:54 +0100
In-Reply-To: <1395235753-3285-1-git-send-email-mandrei.dinu@gmail.com> (Andrei
	Dinu's message of "Wed, 19 Mar 2014 15:29:13 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 19 Mar 2014 14:44:53 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s2JDiqYe025798
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1395841496.21523@pG7SKqC8aEGCIPHLAIa3Mg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244447>

Andrei Dinu <mandrei.dinu@gmail.com> writes:

> replace manual "."/".." check with is_dot_or_dotdot().

This is not what the patch below does.

> choose to implement my own function because did't find the defined one.

That does not seem to be a good reason to me. Run

  git grep is_dot_or_dotdot

in Git's source code to find it (or use your favorite code navigation
tool like ctags/etags/...).

> [1]: http://article.gmane.org/gmane.comp.version-control.git/244420

>  diff-no-index.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/diff-no-index.c b/diff-no-index.c
> index 83cdbf7..d91ea3b 100644
> --- a/diff-no-index.c
> +++ b/diff-no-index.c
> @@ -19,10 +19,10 @@
>  static int is_dot_or_dotdot(const char *path)
>  {
>      if (path[0] == '.' && path[1] == '\0')
> -        return 0;
> +        return 1;
>      else if (path[0] == '.' && path[1] == '.' && path[2] == '\0')
> -        return 0;
> -    return 1;
> +        return 1;
> +    return 0;
>  }
>  
>  static int read_directory(const char *path, struct string_list *list)
> @@ -34,7 +34,7 @@ static int read_directory(const char *path, struct string_list *list)
>  		return error("Could not open directory %s", path);
>  
>  	while ((e = readdir(dir)))
> -		if (is_dot_or_dotdot(e->d_name))
> +		if (!is_dot_or_dotdot(e->d_name))
>  			string_list_insert(list, e->d_name);

This could come on top of your previous patch, but when you resend,
please sent a new patch, not a "fixup patch" like this. Git's history
should be clean, and the patch that will eventually be applied should
not reflect the trial and error iterations that led to the result.

Read about "git rebase -i" and "git commit --amend" for more information
about this.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
