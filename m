From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/PATCH] lockfile: improve error message when lockfile exists
Date: Mon, 29 Feb 2016 08:25:06 +0100
Message-ID: <vpqh9gskmgd.fsf@anie.imag.fr>
References: <1456690276-13914-1-git-send-email-Matthieu.Moy@imag.fr>
	<56D37B8D.9090001@moritzneeb.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Gregory.Mounie@grenoble-inp.fr
To: Moritz Neeb <lists@moritzneeb.de>
X-From: git-owner@vger.kernel.org Mon Feb 29 08:25:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaICl-00031v-Nr
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 08:25:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751213AbcB2HZP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 02:25:15 -0500
Received: from mx2.imag.fr ([129.88.30.17]:35403 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751017AbcB2HZO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 02:25:14 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id u1T7P6sj000519
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 29 Feb 2016 08:25:06 +0100
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u1T7P6KS011064;
	Mon, 29 Feb 2016 08:25:06 +0100
In-Reply-To: <56D37B8D.9090001@moritzneeb.de> (Moritz Neeb's message of "Sun,
	28 Feb 2016 23:58:21 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 29 Feb 2016 08:25:06 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u1T7P6sj000519
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1457335507.16653@1+vKWyQvtwgGI7WV35Vv7A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287802>

Moritz Neeb <lists@moritzneeb.de> writes:

> On 02/28/2016 09:11 PM, Matthieu Moy wrote:
>
>> This patch was written after seen one more time a student panicked
>> because he had a "git commit" backgrounded.
>
> I think git commit is almost the only case where this would happen.

Right. It's not the only case when Git launches an editor, but probably
the only one when it does so keeping a lock.

> If the goal is have it shorter, then the editor example could be boiled down to
> something like "e.g. a commit". But then it is less clear on what the
> necessary action would be.

Maybe just ""e.g. an editor opened by git" -> ""e.g. an editor opened by
git commit"?

> --- a/lockfile.c
> +++ b/lockfile.c
> @@ -150,9 +150,11 @@ void unable_to_lock_message(const char *path, int err, struct strbuf *buf)
>  {
>      if (err == EEXIST) {
>          strbuf_addf(buf, "Unable to create '%s.lock': %s.\n\n"
> -            "If no other git process is currently running, this probably means a\n"
> -            "git process crashed in this repository earlier. Make sure no other git\n"
> -            "process is running and remove the file manually to continue.",
> +            "Another git process seems to be running in this repository,\n"
> +            "e.g. an editor opened by git. Please make sure all processes\n"
> +            "are terminated then try again. If it still fails, a git process\n"
> +            "may have crashed in this repository earlier:\n"
> +            "remove the file manually to continue.",

I like your version better than mine indeed.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
