From: Michael Witten <mfwitten@gmail.com>
Subject: Re: Merge after directory rename ?
Date: Sun, 21 Aug 2011 23:45:19 +0000
Message-ID: <CAMOZ1BukGPZt8gJh0J4EHRrPHv5teAdnkNT+gZJa9mX=2ohFOw@mail.gmail.com>
References: <j2ru2h$cd$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?Q?Marcin_Wi=C5=9Bnicki?= <mwisnicki@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 22 01:45:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvHiE-0003ju-Tg
	for gcvg-git-2@lo.gmane.org; Mon, 22 Aug 2011 01:45:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756085Ab1HUXpu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 21 Aug 2011 19:45:50 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:42958 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751996Ab1HUXpu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Aug 2011 19:45:50 -0400
Received: by gwaa12 with SMTP id a12so2662477gwa.19
        for <git@vger.kernel.org>; Sun, 21 Aug 2011 16:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=4otNGQ7+1/tS7f/BtrVF4hyBWK9bH1UJ7Qv6Dmuky3k=;
        b=pcXAxIYGneiDblRT4EZfo63PsRXvYThqA6sP74Mnx/4P/M96udaosg4Q2+RCnTnSuz
         gKx86h9zg5Prb6q52wfVTqNxsA0Hr+4CTmXvm/OCcx+IIUzgEUv5+3gxOY239oIGif/T
         p6AqRRiM0mJO3orGuydvuioh/AhCbyGZCDiY4=
Received: by 10.42.75.194 with SMTP id b2mr1987187ick.62.1313970349031; Sun,
 21 Aug 2011 16:45:49 -0700 (PDT)
Received: by 10.42.174.129 with HTTP; Sun, 21 Aug 2011 16:45:19 -0700 (PDT)
In-Reply-To: <j2ru2h$cd$1@dough.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179824>

2011/8/21 Marcin Wi=C5=9Bnicki <mwisnicki@gmail.com>:
> Is it possible to merge files after performing directory renames in s=
uch
> way that new files will end up in renamed directories ?
>
> For example:
> 1. [master] =C2=A0add dir1/file1
> 2. [branch1] branch from master
> 3. [branch1] add dir1/file2
> 4. [master] =C2=A0rename dir1 to dir2
> 5. [master] =C2=A0merge branch1
>
> Where it should notice that dir1=3D>dir2 and therefore {dir1=3D>dir2}=
/file2.
>
> Currently I end up with dir1/file2 which is undesirable as it breaks
> refactorings and requires a lot of manual effort to clean-up.

Part of the assumption for someone working on `branch1' might be that
`dir1/file2' is in fact in `dir1'. The rename via `master' conflicts
with that assumption. In this case, a full-blown conflict might be
useful.

However, suppose that the author who is working with `master' doesn't
need `dir1', but the author who is working with `branch1' does need it
INDEPENDENTLY:

  1. [master]  add dir2/file1
  2. [branch1] branch from master
  3. [branch1] add dir1/file2
  4. [master]  add dir1/file3
  5. [master]  rename dir1/file3 to dir3/file3
  6. [master]  merge branch1

In that case, you'd want `dir1/file2' from the `branch1' work to be
silently created rather than automatically renamed to `dir3/file3'.
This should not result in a conflict or a rename.

So, from your grievance, I suppose that git currently assumes the
latter case (and hence, gives no indication of a possible conflict).
Perhaps git could be improved here at least in terms of a warning.
Perhaps the merger could request that directory renames be considered
conflicts or enforced, but this would have to involve the intent of
the merger me thinks (using command line flags).
