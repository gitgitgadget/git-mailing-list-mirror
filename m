From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] git-svn: un-break "git svn rebase" when
 log.abbrevCommit=true
Date: Sat, 28 Jan 2012 20:59:14 -0600
Message-ID: <20120129025914.GA5981@burratino>
References: <1327803073-7000-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 29 03:59:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RrKzP-0007ZE-BD
	for gcvg-git-2@plane.gmane.org; Sun, 29 Jan 2012 03:59:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752122Ab2A2C7b convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 28 Jan 2012 21:59:31 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:34107 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751430Ab2A2C7a convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 Jan 2012 21:59:30 -0500
Received: by iacb35 with SMTP id b35so3680923iac.19
        for <git@vger.kernel.org>; Sat, 28 Jan 2012 18:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=aq74P0IhLCvVveA6sb4tLdLqQK2/RhO71PtJTooonmI=;
        b=Mp6si3aCxDawY0QnvYtsSGXJMzU9BctrRdgHeWN74vTVz13P7+3IUbJphL9ufI+c1A
         eh2N1X2A7qSxb9cxCn+jpExkA9H5f3+uecLs1C2dOqrxqe0fQltmi5Db1Bssx4OlksHM
         sRGogwC19UMNIyzemjxEz1NyIukyZrLNBp8jM=
Received: by 10.50.87.132 with SMTP id ay4mr12635647igb.2.1327805969899;
        Sat, 28 Jan 2012 18:59:29 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id vg9sm6835254igb.4.2012.01.28.18.59.28
        (version=SSLv3 cipher=OTHER);
        Sat, 28 Jan 2012 18:59:29 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1327803073-7000-1-git-send-email-avarab@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189274>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -1879,7 +1879,8 @@ sub cmt_sha2rev_batch {
>  sub working_head_info {
>  	my ($head, $refs) =3D @_;
>  	my @args =3D qw/log --no-color --no-decorate --first-parent
> -	              --pretty=3Dmedium/;
> +	              --pretty=3Dmedium --no-abbrev-commit --no-decorate/;
> +

Oh, dear.  Wouldn't

	my @args =3D qw/rev-list --first-parent --pretty=3Dmedium/;

be simpler and more robust as a quick fix?

Of course something that takes plain rev-list --first-parent output
and pipes it through to cat-file --batch might be more intuitive, but
rev-list --pretty should at least work. ;-)
