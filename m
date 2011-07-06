From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 2/5] svn-fe: allow svnadmin instead of svnrdump in svn helper
Date: Wed, 6 Jul 2011 15:42:48 +0530
Message-ID: <CALkWK0=Lqg4vMOdD8zah5RM3GOkBorJ80kBfs4BHEjZrG+rNVg@mail.gmail.com>
References: <1309884350-13415-1-git-send-email-divanorama@gmail.com> <1309884350-13415-3-git-send-email-divanorama@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	David Barr <davidbarr@google.com>
To: Dmitry Ivankov <divanorama@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 06 12:13:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QeP6b-0004KA-7R
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jul 2011 12:13:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752136Ab1GFKNK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Jul 2011 06:13:10 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:36339 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751927Ab1GFKNJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Jul 2011 06:13:09 -0400
Received: by wyg8 with SMTP id 8so4555391wyg.19
        for <git@vger.kernel.org>; Wed, 06 Jul 2011 03:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=aioxindDhjNSBB36+5aBl6RtHCfHfkpLxG3BZxP5OTo=;
        b=CmIUD31YgHyQFU8KzP+KpmyazNcPACMJRFFUwbZmmQE4gCCk4tUl73PpNkhGNJPRUK
         hoPAQOivrwGo0Xu2uogPJPwDtaJBDCbq1cRNouzBA5R9ih74hTyc+W8jD3MaMzUQp+SU
         I677cVVEXZo59zDttOCEOs3KxK3iQNuJ3SsVk=
Received: by 10.217.3.17 with SMTP id q17mr5223641wes.107.1309947188126; Wed,
 06 Jul 2011 03:13:08 -0700 (PDT)
Received: by 10.216.175.198 with HTTP; Wed, 6 Jul 2011 03:12:48 -0700 (PDT)
In-Reply-To: <1309884350-13415-3-git-send-email-divanorama@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176678>

Hi,

Dmitry Ivankov writes:
> svnrdump produces the same stream as svnadmin dump. svnrdump is able
> to do it via any svn remote protocol while svnadmin needs access to
> the repository filesystem and can't produce subdirectory dumps.
> But svnrdump is a newer tool and may be unavailable on some systems.
>
> Try to use svnadmin dump for file:// repository urls if there is no
> svnrdump in the PATH. First of all this is to be used in tests, where
> the repository is indeed local most of the time.

svnrdump's output is not identical to svnadmin's output.  You'd
perhaps want to document the differences, and the impact they might
have?

> diff --git a/contrib/svn-fe/git-remote-svn-alpha b/contrib/svn-fe/git=
-remote-svn-alpha
> index 61c9b07..84d841e 100755
> --- a/contrib/svn-fe/git-remote-svn-alpha
> +++ b/contrib/svn-fe/git-remote-svn-alpha
> @@ -12,10 +12,32 @@ usage () {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0exit 129
> =C2=A0}
>
> +try_svnrdump () {
> + =C2=A0 =C2=A0 =C2=A0 command -v svnrdump >/dev/null &&
> + =C2=A0 =C2=A0 =C2=A0 echo "svnrdump dump --non-interactive --userna=
me=3DGuest --password=3D \
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 --quiet --incremen=
tal" ||
> + =C2=A0 =C2=A0 =C2=A0 true
> +}

I saw this '--username', '--password' in other patches too.  I'm
probably missing context, but I'm curious to know why this is required
and what you're planning to do to fix it in the future.

Thanks.

-- Ram
