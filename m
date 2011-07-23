From: John Szakmeister <john@szakmeister.net>
Subject: Re: [PATCH] Stop hiding the error message within 'git submodule add'
Date: Sat, 23 Jul 2011 07:59:17 -0400
Message-ID: <CAEBDL5VmY-BY9+q2b6pz=rxJKF6HghrbtmamaCzee7xDGf1h-A@mail.gmail.com>
References: <1311419848-79652-1-git-send-email-john@szakmeister.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: John Szakmeister <john@szakmeister.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 23 13:59:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qkarc-0005Xs-3Q
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jul 2011 13:59:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752227Ab1GWL7T convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 23 Jul 2011 07:59:19 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:42675 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751986Ab1GWL7R convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Jul 2011 07:59:17 -0400
Received: by iyb12 with SMTP id 12so2721521iyb.19
        for <git@vger.kernel.org>; Sat, 23 Jul 2011 04:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=R0D5uCHlQpeTSudDJnKTzdbKP4vYdMkqic2QnKABuDc=;
        b=c8PaYqi43F9wHRc5uhfTMugiK3J3i9UAXoJeNNxi0X9VnRWgP/Lo3w84/Q2KDKZLNe
         YS1pwJ1JQliNtycys5IuoTOzC1+huUq2ghXYDnU04BvdGpoupKokfV9slKOquO5pSjDO
         73fE/A2WDF/2n11b1gxxudxGoRq5qdM4xWUk8=
Received: by 10.231.67.18 with SMTP id p18mr2487577ibi.48.1311422357195; Sat,
 23 Jul 2011 04:59:17 -0700 (PDT)
Received: by 10.43.51.1 with HTTP; Sat, 23 Jul 2011 04:59:17 -0700 (PDT)
In-Reply-To: <1311419848-79652-1-git-send-email-john@szakmeister.net>
X-Google-Sender-Auth: ciZ-05LLfJOveg9LyqeHDK1Qllw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177689>

Bah, this broke a test (I must have missed that fact somehow).  I'll
see if it can be fixed.

-John

On Sat, Jul 23, 2011 at 7:17 AM, John Szakmeister <john@szakmeister.net=
> wrote:
> git-submodule.sh was incorrectly assuming that the only reason
> 'git add --dry-run' would fail was due to ignored paths. =C2=A0Howeve=
r,
> when trying add a submodule inside of another, the original error
> message was being lost, and leaves a user confused. =C2=A0Simply
> re-run 'git add --dry-run' and allow the error message emitted.
>
> Signed-off-by: John Szakmeister <john@szakmeister.net>
> ---
> =C2=A0git-submodule.sh | =C2=A0 =C2=A07 +------
> =C2=A01 files changed, 1 insertions(+), 6 deletions(-)
>
> diff --git a/git-submodule.sh b/git-submodule.sh
> index bc1d3fa..056abd4 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -223,12 +223,7 @@ cmd_add()
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if test -z "$force" && ! git add --dry-run=
 --ignore-missing "$path" > /dev/null 2>&1
> =C2=A0 =C2=A0 =C2=A0 =C2=A0then
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 eval_gettext "The following path is ignored by one of your .git=
ignore files:
> -\$path
> -Use -f if you really want to add it." &&
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 echo
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ) >&2
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git add --dry-run =
--ignore-missing "$path"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit 1
> =C2=A0 =C2=A0 =C2=A0 =C2=A0fi
>
> --
> 1.7.6.134.gcf13f6.dirty
>
>
