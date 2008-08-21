From: "Imran M Yousuf" <imyousuf@gmail.com>
Subject: Re: [JGIT PATCH] Allow make_jgit.sh compilation under Cygwin or Mingw (MsysGit) with Windows JDK
Date: Thu, 21 Aug 2008 15:35:19 +0600
Message-ID: <7bfdc29a0808210235r53976f9ai4ddb42e19fd318be@mail.gmail.com>
References: <1219311191-10984-1-git-send-email-mike@abacus.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	"Mike Ralphson" <mike.ralphson@gmail.com>
To: "Mike Ralphson" <mike@abacus.co.uk>
X-From: git-owner@vger.kernel.org Thu Aug 21 11:36:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KW6af-00026M-D9
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 11:36:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752187AbYHUJfW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 05:35:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752091AbYHUJfV
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 05:35:21 -0400
Received: from yx-out-2324.google.com ([74.125.44.29]:63734 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751866AbYHUJfU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 05:35:20 -0400
Received: by yx-out-2324.google.com with SMTP id 8so443916yxm.1
        for <git@vger.kernel.org>; Thu, 21 Aug 2008 02:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=4BH+BNMuS1CQhksEIE4orP5IDZeyQdmc+LGkEJFmARw=;
        b=XLUTSZESvm7shSSJvUWf3MD0aTCxjCvBat743aXb1hCv5VOMWtf7tIyW928U10Ga+M
         ogVOlvKnUYHvgqNBlxZMGGfdBijcyKEdSOD4xLHMBzJHM8t3DRjImwj6oKBlfwsLRzm7
         cxCYTHt/e3p0CeMKbKrA1I4vPjGX+bxCcN/hk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=gkK7VwRmOsHjLV9wjl1f1BU4MH3T51CNnv7cSwLCTE4u6bOADbt1zmTCtDisQqJDLS
         z5TDpNy/cW56BA+IZDvqyHcronHeCKXkasXjcddW3jrgqYzytA9sRsISS5gUemQtvX0C
         MgBYujP/lbbdJba+ONetX5FP1gInGD3nlU5rs=
Received: by 10.150.146.1 with SMTP id t1mr1834860ybd.81.1219311319875;
        Thu, 21 Aug 2008 02:35:19 -0700 (PDT)
Received: by 10.150.225.1 with HTTP; Thu, 21 Aug 2008 02:35:19 -0700 (PDT)
In-Reply-To: <1219311191-10984-1-git-send-email-mike@abacus.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93130>

On Thu, Aug 21, 2008 at 3:33 PM, Mike Ralphson <mike@abacus.co.uk> wrote:
> Signed-off-by: Mike Ralphson <mike@abacus.co.uk>

You can also have a look at the Maven project for JGit (will have
JGit-pgm mavenized once JGit's process is accepted). It should build
JGit uniformly on Windows and Linux.

http://repo.or.cz/w/egit/imyousuf.git?a=shortlog;h=refs/heads/mavenize-jgit

Best regards,

Imran

> ---
>  make_jgit.sh |   24 +++++++++++++++++-------
>  1 files changed, 17 insertions(+), 7 deletions(-)
>
> diff --git a/make_jgit.sh b/make_jgit.sh
> index 13d0e32..c119202 100755
> --- a/make_jgit.sh
> +++ b/make_jgit.sh
> @@ -10,14 +10,24 @@ JARS="
>        org.spearce.jgit.pgm/lib/args4j-2.0.9.jar
>  "
>
> -if [ -n "$JAVA_HOME" ]
> -then
> -       PATH=$JAVA_HOME/bin:$PATH
> -fi
> -
> +PSEP=":"
>  T=".temp$$.$O"
>  T_MF="$T.MF"
>  R=`pwd`
> +if [ "$OSTYPE" = "cygwin" ]
> +then
> +       R=`cygpath -m $R`
> +       PSEP=";"
> +fi
> +if [ "$MSYSTEM" = "MINGW" ]
> +then
> +       PSEP=";"
> +fi
> +
> +if [ -n "$JAVA_HOME" ]
> +then
> +       PATH=${JAVA_HOME}/bin${PSEP}${PATH}
> +fi
>
>  cleanup_bin() {
>        rm -f $T $O+ $T_MF
> @@ -44,7 +54,7 @@ do
>        then
>                CLASSPATH="$R/$j"
>        else
> -               CLASSPATH="$CLASSPATH:$R/$j"
> +               CLASSPATH="${CLASSPATH}${PSEP}$R/$j"
>        fi
>  done
>  export CLASSPATH
> @@ -61,7 +71,7 @@ do
>                -encoding UTF-8 \
>                -g \
>                -d ../bin2) || die "Building $p failed."
> -       CLASSPATH="$CLASSPATH:$R/$p/bin2"
> +       CLASSPATH="${CLASSPATH}${PSEP}$R/$p/bin2"
>  done
>
>  echo Manifest-Version: 1.0 >$T_MF &&
> --
> 1.5.6.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



-- 
Imran M Yousuf
Email: imran@smartitengineering.com
Blog: http://imyousuf-tech.blogs.smartitengineering.com/
Mobile: +880-1711402557
