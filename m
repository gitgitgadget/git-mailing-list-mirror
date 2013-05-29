From: David Aguilar <davvid@gmail.com>
Subject: Re: 1.8.3 - gitignore not being parsed correctly on OS X; regex
 support is broken?
Date: Wed, 29 May 2013 00:43:14 -0700
Message-ID: <CAJDDKr5VXvbQ8Ww7P=R2Abgr93jQ0r2Lq1GNTdZKfByjSqZWrQ@mail.gmail.com>
References: <CAGLuM14_MQffwQWrB2YCQXzhkGaxdaYBuY74y7=pfb-hB6LskA@mail.gmail.com>
	<CACsJy8BqCUKhc8vhjhNz0OedBngk7zcSOk70ekRm3EiruHfNxA@mail.gmail.com>
	<CACsJy8DD=LxAKh_fUELJ5Mj0xS_gZE88N_rJFkKGer=YAOqsMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Karsten Blees <karsten.blees@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Misty De Meo <misty@brew.sh>,
	=?UTF-8?Q?=C3=98ystein_Walle?= <oystwa@gmail.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 29 09:43:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uhb2b-00052S-M3
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 09:43:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964990Ab3E2HnS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 May 2013 03:43:18 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:52989 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935105Ab3E2HnO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 May 2013 03:43:14 -0400
Received: by mail-pa0-f53.google.com with SMTP id kq13so1668490pab.26
        for <git@vger.kernel.org>; Wed, 29 May 2013 00:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=6RtlxjGSx3HGLOx5zKjRhGmuQ+jW+2leFSgJPCW+tsw=;
        b=aANez01lNExLOvVurrB3M/rsYPdSgk4OUQ7dYVXT1yezjSGL6lzgn2nSo8t1Bv37Gq
         nnJ8m/c6HynWAlR8W7nXL6cPBC78YvHs0z0EJqDUdzJviFTvEDWQ1WIWWds5t2KxTh+I
         m0qYr94oBOh+GOsqok5QmKa2tDQ5gVRQ8tzZ+TpkD/cuwhItCqSkYsGD53AMAFBH7O79
         bnjphMwguLu1lOGaMt8inwz7P5heS4xxXg7dnfHRPA4/07lXXU0jITKAvbm+wjeBNbiq
         Xy+dSpp69nQnNJjpA37hlBhwpWgxKeyLsIo3RtAcyuEhQT+E2Kl4CPbnIvbe1rHuFki9
         f9Pw==
X-Received: by 10.67.5.131 with SMTP id cm3mr2145572pad.80.1369813394240; Wed,
 29 May 2013 00:43:14 -0700 (PDT)
Received: by 10.70.20.161 with HTTP; Wed, 29 May 2013 00:43:14 -0700 (PDT)
In-Reply-To: <CACsJy8DD=LxAKh_fUELJ5Mj0xS_gZE88N_rJFkKGer=YAOqsMg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225768>

On Tue, May 28, 2013 at 9:19 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Wed, May 29, 2013 at 10:41 AM, Duy Nguyen <pclouds@gmail.com> wrot=
e:
>> The changes in this area since 1.8.2.3 seem to be Karsten's (I'm not
>> blaming, just wanted to narrow down the problem). The patterns of
>> interest seem to be
>>
>> !/bin
>> /bin/*
>> !/bin/brew
>>
>> Without "!/bin" v1.8.3 seems to behave the same as v1.8.2.3.
>
> Karsten, the block "/* Abort if the directory is excluded */" in
> prep_exclude() seems to cause this. I think it goes through the
> exclude patterns, hits "!/bin", believes the patterns do not make
> sense in this context and throws all away. I think =C3=98ystein's cas=
e
> falls into the same path. Commenting out the block seems to gain the
> old behavior back (and probably breaks other stuff). Contrary to what
> Junio said, I'm clueless about this. I wanted to read your series
> through and eventually gave up. I think I now have the motivation to
> look at it again this weekend.

The very first patch in the da/darwin series in "next" is one possible =
fix.

See 29de20504e9790785fe1698300755323f74972aa

    Makefile: fix default regex settings on Darwin

    t0070-fundamental.sh fails on Mac OS X 10.8:

        $ uname -a
        Darwin lustrous 12.2.0 Darwin Kernel Version 12.2.0:
        Sat Aug 25 00:48:52 PDT 2012;
        root:xnu-2050.18.24~1/RELEASE_X86_64 x86_64

        $ ./t0070-fundamental.sh -v
        fatal: regex bug confirmed: re-build git with NO_REGEX=3D1

    Fix it by using Git's regex library.

Does that patch also fix this issue?

Karsten, you mentioned that compiling without regex support fixes it fo=
r you.
Does the above commit in git.git's "next" branch fix it too?

If so, I think it would be worth merging this early part into a "maint"=
 release.
--
David
