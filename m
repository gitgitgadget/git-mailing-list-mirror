From: Brian Riehman <briehman@gmail.com>
Subject: Re: git stash syntax error under AIX 5.3
Date: Wed, 3 Nov 2010 10:29:09 -0500
Message-ID: <AANLkTi=V7nu98xHVrVJuZqt_3hajMPvkk=AKB0HnOD-_@mail.gmail.com>
References: <AANLkTimSpPLfqv07+Tmcj-iM0W+p86V2-HRrq71Umdtr@mail.gmail.com>
	<20101103150718.GA12733@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 03 16:29:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDfHV-00077B-A8
	for gcvg-git-2@lo.gmane.org; Wed, 03 Nov 2010 16:29:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932107Ab0KCP3f convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Nov 2010 11:29:35 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:56230 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755788Ab0KCP3K convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Nov 2010 11:29:10 -0400
Received: by yxk8 with SMTP id 8so538018yxk.19
        for <git@vger.kernel.org>; Wed, 03 Nov 2010 08:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=3oQjyTTeiiKDZ8Or9KbiA8JluqSR3NIanx7zQkNQfPM=;
        b=PsJGcy++iX76BKU9Tc1JaTIEgJgEegKojJzd90MnC1gmihK6FszYh2sB0gLCYr8Muz
         mTMsxRZdlBzFnU86jTN24m9BPpNGX17ydJsIHTwiFs4CY2u9LGUXZWHycdgcQ1SUrv1y
         dloht53ycwOfCYcnWQKD9J+RORsg0V9Rj0mcQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ZxNfTWmqtp3jTDhr1+fbF/gkY4LwcyaDHaZ/MAdu816e5JHgGdWODNPINjKraYBaal
         4BtqgDrvvnmSLC6Tn+T4uMui373sVqVEsy9pApDnilwdDpHzpf7SM5JicSC7uwLi/s20
         8ngFeEM1kDh4gIDkvY6Qs2cuYRGLhsaqyGI8I=
Received: by 10.151.51.9 with SMTP id d9mr1434599ybk.89.1288798149487; Wed, 03
 Nov 2010 08:29:09 -0700 (PDT)
Received: by 10.150.95.8 with HTTP; Wed, 3 Nov 2010 08:29:09 -0700 (PDT)
In-Reply-To: <20101103150718.GA12733@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160601>

Thanks, Jonathan.  That did indeed fix it. Thanks for your help and
clarification that it does indeed work in my shell when escaped
properly.

On Wed, Nov 3, 2010 at 10:07 AM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Hi Brian,
>
> Brian Riehman wrote:
>
>> The stash command relies on bash-specific shell scripting techniques
>
> Git actually uses the ${var%glob} syntax pretty widely, and it is
> fairly portable (see http://unix.org/2008edition/ and search for "sh =
-"
> for details). =A0I suspect the problem is rather the seemingly-unbala=
nced
> braces:
>
>> < =A0 =A0 =A0 if test "${REV}" !=3D "${REV%{*\}}"
>
> How about this patch?
>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> diff --git a/git-stash.sh b/git-stash.sh
> index 5fb1245..0a41226 100755
> --- a/git-stash.sh
> +++ b/git-stash.sh
> @@ -311,7 +311,7 @@ parse_flags_and_rev()
> =A0 =A0 =A0 =A0test "$ref_stash" =3D "$(git rev-parse --symbolic-full=
-name "${REV%@*}")" &&
> =A0 =A0 =A0 =A0IS_STASH_REF=3Dt
>
> - =A0 =A0 =A0 if test "${REV}" !=3D "${REV%{*\}}"
> + =A0 =A0 =A0 if test "${REV}" !=3D "${REV%\{*\}}"
> =A0 =A0 =A0 =A0then
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0# maintainers: it would be better if g=
it rev-parse indicated
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0# this condition with a non-zero statu=
s code but as of 1.7.2.1 it
>
