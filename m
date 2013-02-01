From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH] mergetools: Enable tortoisemerge to handle filenames with
Date: Fri, 1 Feb 2013 21:07:07 +0100
Message-ID: <CAHGBnuNpHtfnD6D+sji6e1yp2x6iLxjAbawwO6USF2iWW17nuQ@mail.gmail.com>
References: <50FBD4AD.2060208@tu-clausthal.de>
	<7v4nibjrg0.fsf@alter.siamese.dyndns.org>
	<50FCFBBB.2080305@tu-clausthal.de>
	<7vfw1qbbr4.fsf@alter.siamese.dyndns.org>
	<5101B0A5.1020308@tu-clausthal.de>
	<51024B02.9020400@tu-clausthal.de>
	<CAJDDKr7eNyJp1ffBYEJaZkmnVWqd0AMpnm1kdjnrrhPtuGNL_w@mail.gmail.com>
	<5102837C.9000608@tu-clausthal.de>
	<7v622l5d87.fsf@alter.siamese.dyndns.org>
	<51032E96.2040209@tu-clausthal.de>
	<CAJDDKr6OhZOitTdDkHWnhVhdAis0U+95xUtaNn6nwkQ-k+bA+w@mail.gmail.com>
	<5104F009.5020606@tu-clausthal.de>
	<7vzjzuwm7s.fsf@alter.siamese.dyndns.org>
	<510C1872.3090304@tu-clausthal.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	David Aguilar <davvid@gmail.com>, Jeff King <peff@peff.net>
To: Sven Strickroth <sven.strickroth@tu-clausthal.de>
X-From: git-owner@vger.kernel.org Fri Feb 01 21:07:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U1MtZ-0001mF-2z
	for gcvg-git-2@plane.gmane.org; Fri, 01 Feb 2013 21:07:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756458Ab3BAUHL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2013 15:07:11 -0500
Received: from mail-lb0-f182.google.com ([209.85.217.182]:43206 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754891Ab3BAUHI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Feb 2013 15:07:08 -0500
Received: by mail-lb0-f182.google.com with SMTP id gg6so4819218lbb.41
        for <git@vger.kernel.org>; Fri, 01 Feb 2013 12:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=so5zJ7P6XzRXsu8MVh6y36umOgBVDAG2Nlp19Ts0Ywg=;
        b=N3dDVbiM5ZR1i41LaubatZ3qBGvNzA+15uBm6wb/swmpFCYfoXe3PgkcU3f/fRv1my
         AHtezdF08bn0GxORTcwuh8Qn6zyBmtrSrq/1SsiLEDI5s6kMdQgKVL4Wfi8VhvZSdKJk
         MFFE7etExYaNE0NULYkSaxhY/q8K2QuA2SouX2fTqqMfz6NJgJxlSc7eN4aFTumn4kun
         SrcC4sXIZjEydFQf5zYx00OmZio2I/njl4tk/epv+EEpnUSa6ZQ0/yPsQ25QV9AHDQQy
         0/sTgfb6q9IboTZ/OVUBNUraWq4COUtEaVG15YRx+n8IIFs+qoifh6Dt26X0wY9ztHZf
         y8yg==
X-Received: by 10.112.100.195 with SMTP id fa3mr5356679lbb.38.1359749227479;
 Fri, 01 Feb 2013 12:07:07 -0800 (PST)
Received: by 10.114.22.73 with HTTP; Fri, 1 Feb 2013 12:07:07 -0800 (PST)
In-Reply-To: <510C1872.3090304@tu-clausthal.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215264>

On Fri, Feb 1, 2013 at 8:33 PM, Sven Strickroth
<sven.strickroth@tu-clausthal.de> wrote:

> TortoiseGitMerge, unlike TortoiseMerge, can be told to handle paths
> with spaces in them by using -option "$FILE" (not -option:"$FILE",
> which does not work for such paths) syntax. Both do not have a fully
> posix compatible cli parameter parser, however, TortoiseGitMerge was
> modified in order to handle filenames with spaces correctly. The
> "-key value" form was choosen because this way no escaping for
> quotes within quotes is necessary; see
> https://github.com/msysgit/msysgit/issues/57

The commit message still does not mention MSYS path mangling at all,
which probably is why the reasoning of this patch was not yet fully
understood. I'd recommend something like the following:

mergetools: Teach tortoisemerge about TortoiseGitMerge

TortoiseGitMerge is an improved version of TortoiseMerge specifically
for use with Git on Windows. Due to MSYS path mangling [1], the ":"
after the "base" etc. arguments to TortoiseMerge caused to whole
argument instead of just the file name to be quoted in case of file
names with spaces. So TortoiseMerge was passed

    "-base:new file.txt"

instead of

    -base:"new file.txt"

(including the quotes). To work around this, TortoiseGitMerge does not
require the ":" after the arguments anymore which fixes handling file
names with spaces.

[1] http://www.mingw.org/wiki/Posix_path_conversion

-- 
Sebastian Schuberth
