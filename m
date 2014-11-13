From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [RFC] On watchman support
Date: Thu, 13 Nov 2014 19:22:48 +0700
Message-ID: <CACsJy8AKsvL2XcBMGG1Jy_W2KaOCuYm16Ffk529KDOARr68XNQ@mail.gmail.com>
References: <20141111124901.GA6011@lanh> <54643C30.6010204@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	David Turner <dturner@twopensource.com>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu Nov 13 13:23:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XotQq-0007iT-8Z
	for gcvg-git-2@plane.gmane.org; Thu, 13 Nov 2014 13:23:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932757AbaKMMXW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Nov 2014 07:23:22 -0500
Received: from mail-ie0-f179.google.com ([209.85.223.179]:41997 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932703AbaKMMXT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Nov 2014 07:23:19 -0500
Received: by mail-ie0-f179.google.com with SMTP id rl12so15693612iec.38
        for <git@vger.kernel.org>; Thu, 13 Nov 2014 04:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=cfB+Bjm/j9slGLXeb3qoehPbrKyxAcWhpz4qMUxfuOY=;
        b=fSZPG2Ylqf67TAuYauHcHSqzE6uEUCuKBwFwnzrFwVv3YzwfRK2gmQWSJeDnUDVn+S
         rbZrHfqMu+MPKofnEmN83v8LdPMOKnenGkGfYTGjeyUHU/l0GrnWPPqWs0yBxUGLVfos
         x/V9PxqURaxXdA2vWbNpJAVd7QYgzzcuwo2Z4mLtwISt69eqZPTwnijkiJGXTkcX/RI6
         Udy3FQ5hQfWdjXUDCx+rld6drl5EZgvZvLwLdRUpRCOl9m8VcP5E0raNzQ5vqUys+L1J
         2i/sTTebb1mADuAM1+GN0xjlGHcKAOkqFsO4169Ko5apSAdPni7H0br2rBS2SSWtxEdu
         6vgQ==
X-Received: by 10.50.66.179 with SMTP id g19mr2354916igt.40.1415881398392;
 Thu, 13 Nov 2014 04:23:18 -0800 (PST)
Received: by 10.107.176.8 with HTTP; Thu, 13 Nov 2014 04:22:48 -0800 (PST)
In-Reply-To: <54643C30.6010204@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 13, 2014 at 12:05 PM, Torsten B=C3=B6gershausen <tboegi@web=
=2Ede> wrote:
> From a Git user perspective it could be good to have something like t=
his:
>
> a) git status -u
> b) git status -uno
> c) git status -umtime
> d) git status -uwatchman
>
> We know that a) and b) already exist.
> c) Can be convenient to have, in order to do benchmarking and testing=
=2E
>   When the UNTR extension is not found, Git can give an error,
>   saying something like this:
>   No mtime information found, use "git update-index --untracked-cache=
"
> d) does not yet exist
>
> Of course we may want to configure the default for "git status" in a =
default variable,
> like status.findUntrackedFiles, which can be empty "", "mtime" or "wa=
tchman",
> and we may add other backends later.

While "git status" is in the spotlight, these optimizations have wider
impact. Faster index read/refresh/write helps the majority of
commands. Faster untracked listing hits git-status, git-add,
git-commit -A... This is why I go with environment variable for
temporarily disabling something, or we'll need many config and command
line options, one per command.

> A short test showed that watchman compiles under Mac OS.
> The patch did not compile out of the box (both Git and watchman decla=
re
> there own version of usage(), some C99 complaints from the compiler i=
n watchman,
> nothing that can not be fixed easily)

Yeah it's not perfect. It's mainly to show speeding up refresh with
watchman could be done easily and with low impact

> I will test the mtime patch under networked file systems the next wee=
ks.

Hmm.. you remind me mtime series may have this as an advantage over wat=
chman..
--=20
Duy
