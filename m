From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 2/2] git-svn: un-break "git svn rebase" when
 log.abbrevCommit=true
Date: Sat, 11 Feb 2012 18:31:31 -0600
Message-ID: <20120212003131.GG2719@burratino>
References: <CACBZZX5cwZ4Xz3-C8B3v4eEmyO0B-JiohfRATu1UhxzST0ar5w@mail.gmail.com>
 <1329006186-21346-1-git-send-email-avarab@gmail.com>
 <1329006186-21346-2-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>,
	Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 12 01:31:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RwNM1-0002z5-8Y
	for gcvg-git-2@plane.gmane.org; Sun, 12 Feb 2012 01:31:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755384Ab2BLAbi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 11 Feb 2012 19:31:38 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:61857 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752175Ab2BLAbf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Feb 2012 19:31:35 -0500
Received: by iacb35 with SMTP id b35so2199944iac.19
        for <git@vger.kernel.org>; Sat, 11 Feb 2012 16:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=yPBEr7q8P7aWt8nQU/Bp1AAik3of3Qy3jLWAr5SFevA=;
        b=kweZta+ofEYVPHmylyBTRxQ1DP7RH2CAO6rbU4Oed7DTSPki4VKL7if6NCcs7fUaVu
         AuV13Up1n9UwbzH+AWxr4010w1mmDz8a6nMCuQ9FmNEi1rDFgmXTEEgD8A+NfL7xdNPT
         Y7zoo5ZnCeNIoA8QRvd8fWtjSwj64XhpDj45A=
Received: by 10.50.159.161 with SMTP id xd1mr12136215igb.15.1329006694449;
        Sat, 11 Feb 2012 16:31:34 -0800 (PST)
Received: from burratino (adsl-99-35-41-178.dsl.chcgil.sbcglobal.net. [99.35.41.178])
        by mx.google.com with ESMTPS id vr4sm8096268igb.1.2012.02.11.16.31.33
        (version=SSLv3 cipher=OTHER);
        Sat, 11 Feb 2012 16:31:33 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1329006186-21346-2-git-send-email-avarab@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190553>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> Change git-svn to use git-rev-list(1) instead of git-log(1) since the
> latter is porcelain that'll cause "git svn rebase" to fail completely
> if log.abbrevCommit is set to true in the configuration.
[...]
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -1878,8 +1878,7 @@ sub cmt_sha2rev_batch {
> =20
>  sub working_head_info {
>  	my ($head, $refs) =3D @_;
> -	my @args =3D qw/log --no-color --no-decorate --first-parent
> -	              --pretty=3Dmedium/;
> +	my @args =3D qw/rev-list --first-parent --pretty=3Dmedium/;

Thanks!  The other caller to "git log" in this script uses
--pretty=3Draw and should be safe.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
