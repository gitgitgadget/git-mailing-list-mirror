From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: encoding bug in git.el
Date: Sun, 25 May 2008 15:42:00 +0200
Message-ID: <20080525134200.GA31990@diana.vm.bytemark.co.uk>
References: <20080520220900.GA20570@diana.vm.bytemark.co.uk> <87mymkbo9x.fsf@lysator.liu.se> <1f748ec60805210708q34a26bebh915037713caa9a87@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>,
	git@vger.kernel.org, "Junio C. Hamano" <gitster@pobox.com>
To: Clifford Caoile <piyo@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Sun May 25 15:43:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0GVM-0005dm-0f
	for gcvg-git-2@gmane.org; Sun, 25 May 2008 15:43:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753305AbYEYNma convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 May 2008 09:42:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750910AbYEYNma
	(ORCPT <rfc822;git-outgoing>); Sun, 25 May 2008 09:42:30 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2112 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750984AbYEYNm3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 May 2008 09:42:29 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1K0GU4-0000qU-00; Sun, 25 May 2008 14:42:00 +0100
Content-Disposition: inline
In-Reply-To: <1f748ec60805210708q34a26bebh915037713caa9a87@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82862>

On 2008-05-21 23:08:09 +0900, Clifford Caoile wrote:

> Here is a proposed fix. I suggest that process-environment should be
> given these envvars already encoded as shown in this code sample:
>
> ------------------ git.el ------------------
> [not a proper git-diff]
> @@ -216,6 +216,11 @@ and `git-diff-setup-hook'."
>    "Build a list of NAME=3DVALUE strings from a list of environment s=
trings."
>    (mapcar (lambda (entry) (concat (car entry) "=3D" (cdr entry))) en=
v))
>
> +(defun git-get-env-strings-encoded (env encoding)
> +  "Build a list of NAME=3DVALUE strings from a list of environment s=
trings,
> +converting from mule-encoding to ENCODING (e.g. mule-utf-8, latin-1,=
 etc)."
> +  (mapcar (lambda (entry) (concat (car entry) "=3D"
> (encode-coding-string (cdr entry) encoding))) env))
> +
>  (defun git-call-process-env (buffer env &rest args)
>    "Wrapper for call-process that sets environment strings."
>    (let ((process-environment (append (git-get-env-strings env)
> @@ -265,7 +270,7 @@ and returns the process output as a string, or ni=
l
> if the git failed."
>
>  (defun git-run-command-region (buffer start end env &rest args)
>    "Run a git command with specified buffer region as input."
> -  (unless (eq 0 (let ((process-environment (append (git-get-env-stri=
ngs env)
> +  (unless (eq 0 (let ((process-environment (append
> (git-get-env-strings-encoded env coding-system-for-write)
>                                                     process-environme=
nt)))
>                    (git-run-process-region
>                     buffer start end "git" args)))
>
> The buffer text is saved with the encoding coding-system-for-write,
> while the GIT_* envvars were not encoded, so when appending to
> process-environment variable, use the same encoding.

I don't claim to understand any of the design issues around this, but
your patch certainly fixes my problem (once I managed to apply it,
which involved working around the lack of headers, non-matching
offsets, and whitespace damage -- luckily it was just two hunks). So:

Tested-by: Karl Hasselstr=F6m <kha@treskal.com>

Thanks for taking the time.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
