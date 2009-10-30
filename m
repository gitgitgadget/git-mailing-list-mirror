From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [RFC PATCH v4 11/26] Move WebDAV HTTP push under remote-curl
Date: Sat, 31 Oct 2009 00:10:29 +0800
Message-ID: <be6fef0d0910300910me43c77fue6dcb6034dd0ea5b@mail.gmail.com>
References: <1256774448-7625-1-git-send-email-spearce@spearce.org>
	 <1256774448-7625-12-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Mike Hommey <mh@glandium.org>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Fri Oct 30 17:10:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3u3h-0007RU-2Z
	for gcvg-git-2@lo.gmane.org; Fri, 30 Oct 2009 17:10:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932518AbZJ3QKZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Oct 2009 12:10:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932473AbZJ3QKZ
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 12:10:25 -0400
Received: from mail-iw0-f180.google.com ([209.85.223.180]:58024 "EHLO
	mail-iw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932336AbZJ3QKZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Oct 2009 12:10:25 -0400
Received: by iwn10 with SMTP id 10so2230238iwn.4
        for <git@vger.kernel.org>; Fri, 30 Oct 2009 09:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Z091CSYkQXgSsh/K71ZuBDRJ2IQHn++AHwhucARTQVs=;
        b=qJBMATFQRY7+khrZdkVMYHtwoHQ+6X2sj8sRQ08NEhAJFg+eH7GMy+np+4xP87TFdJ
         S4dcbDjcGI/P0NuCGBDoy5d2YSdhHBlFr78DzK/a7G05VgJoj5TeUHurtyRk+TfsI2WF
         qNFy1h9455fFQiUDKTOrvVNTMR/aGBeYkCZcc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=E+JrdP8LVllHxodQSAWHjh/gBvF5Yl1JKiNO6ITreDvRj9VuKrmNAzQ7DlKvT8VTdG
         en8IYC3Xpc/N0Z8Jqlsr2oZ9YfInMTQJ02EmWQw67e5NG7qmIY/XT5pgW+XAPtxwwXpz
         d53d1K/gasvrW1iCkGM1U3gv17gisI268A7fo=
Received: by 10.231.10.16 with SMTP id n16mr567016ibn.24.1256919029490; Fri, 
	30 Oct 2009 09:10:29 -0700 (PDT)
In-Reply-To: <1256774448-7625-12-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131713>

Hi,

On Thu, Oct 29, 2009 at 8:00 AM, Shawn O. Pearce <spearce@spearce.org> =
wrote:
> diff --git a/t/t5540-http-push.sh b/t/t5540-http-push.sh
>[snip]
> @@ -57,11 +58,15 @@ test_expect_failure 'push to remote repository wi=
th packed refs' '
> =A0 =A0 =A0 =A0 test $HEAD =3D $(git rev-parse --verify HEAD))
> =A0'
>
> -test_expect_success ' push to remote repository with unpacked refs' =
'
> +test_expect_failure 'push already up-to-date' '
> + =A0 =A0 =A0 git push
> +'
> +
> +test_expect_success 'push to remote repository with unpacked refs' '
> =A0 =A0 =A0 =A0(cd "$HTTPD_DOCUMENT_ROOT_PATH"/test_repo.git &&
> =A0 =A0 =A0 =A0 rm packed-refs &&
> - =A0 =A0 =A0 =A0git update-ref refs/heads/master \
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 0c973ae9bd51902a28466f3850b543fa66a6aaf=
4) &&
> + =A0 =A0 =A0 =A0git update-ref refs/heads/master $ORIG_HEAD &&
> + =A0 =A0 =A0 =A0git --bare update-server-info) &&
> =A0 =A0 =A0 =A0git push &&
> =A0 =A0 =A0 =A0(cd "$HTTPD_DOCUMENT_ROOT_PATH"/test_repo.git &&
> =A0 =A0 =A0 =A0 test $HEAD =3D $(git rev-parse --verify HEAD))

Clemens, the following addresses your non-desire to remove the
"unpacked refs" test in your earlier email
<20091025161630.GB8532@localhost>.

Now that the first push in "push to remote repository with packed
refs" succeeds, the "unpacked refs" test is redundant. Since http-push
in that first test already updated /refs/heads/master and /info/refs,
'git update-ref' incorrectly reverts the earlier push, and 'git
update-server-info' is redundant.

--=20
Cheers,
Ray Chuan
