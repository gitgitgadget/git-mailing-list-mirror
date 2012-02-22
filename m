From: =?UTF-8?B?w5h5dmluZCBBLiBIb2xt?= <sunny@sunbase.org>
Subject: Re: Problems with unrecognized headers in git bundles
Date: Wed, 22 Feb 2012 21:25:36 +0100
Message-ID: <CAA787rm4c1zYgQJ3kP5=ujpEK1Dda9+h_P3BBmg2yX2eZca=TA@mail.gmail.com>
References: <4F451259.7010304@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jannis Pohlmann <jannis.pohlmann@codethink.co.uk>
X-From: git-owner@vger.kernel.org Wed Feb 22 21:25:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0Ikw-0004vT-ME
	for gcvg-git-2@plane.gmane.org; Wed, 22 Feb 2012 21:25:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753035Ab2BVUZi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Feb 2012 15:25:38 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:60919 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752199Ab2BVUZh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Feb 2012 15:25:37 -0500
Received: by qadc10 with SMTP id c10so5945488qad.19
        for <git@vger.kernel.org>; Wed, 22 Feb 2012 12:25:36 -0800 (PST)
Received-SPF: pass (google.com: domain of sunny256@gmail.com designates 10.229.136.19 as permitted sender) client-ip=10.229.136.19;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of sunny256@gmail.com designates 10.229.136.19 as permitted sender) smtp.mail=sunny256@gmail.com; dkim=pass header.i=sunny256@gmail.com
Received: from mr.google.com ([10.229.136.19])
        by 10.229.136.19 with SMTP id p19mr24193854qct.133.1329942336926 (num_hops = 1);
        Wed, 22 Feb 2012 12:25:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=8v0Hp5l2fXGOVEAeyDiZ8gNDjVrnEuvdYj133qlmGUI=;
        b=xZEi8lzQEcF5b1Xv+aLd3DjjPp6d3p+zWT+utzeCYTkaFSJhop3o6WPpyMG0dcFDS6
         nT2EOPBkeYjFmwcNoXvVFvkkI9Qwetd+QgKYnZITXcKbjfXFxfYb4wiNHjh2bshBKDec
         6E9KdA6dZIX/6f+MhBSNfhkNgvwHOZYHzJ64o=
Received: by 10.229.136.19 with SMTP id p19mr20460856qct.133.1329942336819;
 Wed, 22 Feb 2012 12:25:36 -0800 (PST)
Received: by 10.229.240.133 with HTTP; Wed, 22 Feb 2012 12:25:36 -0800 (PST)
In-Reply-To: <4F451259.7010304@codethink.co.uk>
X-Google-Sender-Auth: yfW2ZQ0rOO_5UpBQ7pkfNE1L48c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191279>

On 22 February 2012 17:05, Jannis Pohlmann wrote:
> Hi,
>
> creating bundles from some repositories seems to lead to bundles with
> incorrectly formatted headers, at least with git >=3D 1.7.2. When
> cloning from such bundles, git prints the following error/warning:
>
> =C2=A0$ git clone perl-clone.bundle perl-clone
> =C2=A0Cloning into 'perl-clone'...
> =C2=A0warning: unrecognized header: --work around mangled archname on=
=2E..
>
> This can be reproduced easily with git from any version >=3D 1.7.2 or
> from master, using the following steps:
>
> =C2=A0git clone git://perl5.git.perl.org/perl.git perl
> =C2=A0GIT_DIR=3Dperl/.git git bundle create perl-clone.bundle --all
> =C2=A0git clone perl-clone.bundle perl-clone
>
> The content of the bundle is:
>
> =C2=A0# v2 git bundle
> =C2=A0-- work around mangled archname on win32 while finding...
> =C2=A039ec54a59ce332fc44e553f4e5eeceef88e8369e refs/heads/blead
> =C2=A039ec54a59ce332fc44e553f4e5eeceef88e8369e refs/remotes/origin/HE=
AD

Have researched this a bit, and I've found that all git versions back t=
o
when git-bundle was introduced (around v1.5.4) produces the same invali=
d
line. The culprit is commit 3e8148feadabd0d0b1869fcc4d218a6475a5b0bc in
perl.git, branch 'maint-5.005'. The log message of that commit contains
email headers, maybe that's the reason git bundle gets confused?

        =C3=98yvind
