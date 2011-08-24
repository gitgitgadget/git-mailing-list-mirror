From: Vitor Antunes <vitor.hda@gmail.com>
Subject: Re: [PATCH/RFC 2/2] git-p4: Add complex test case for branch import
Date: Wed, 24 Aug 2011 11:46:53 +0100
Message-ID: <CAOpHH-V9nm2NRD47gdUj6sLJSTypjABjE-JGCkADE=fxh2nSWg@mail.gmail.com>
References: <1313712590-26876-1-git-send-email-vitor.hda@gmail.com>
 <1313712590-26876-3-git-send-email-vitor.hda@gmail.com> <20110820191203.GC7135@arf.padd.com>
 <20110822011319.0a013117@fenix.utopia.dhis.org> <20110823022713.GA6005@arf.padd.com>
 <CAOpHH-V92CcWm1tCwvb=pJux5PKbYQoG=E8M_Pc2JGu00wnR8Q@mail.gmail.com> <20110823231034.GA11918@arf.padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Tor Arvid Lund <torarvid@gmail.com>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Wed Aug 24 12:47:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwAzZ-0004N5-9f
	for gcvg-git-2@lo.gmane.org; Wed, 24 Aug 2011 12:47:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756036Ab1HXKrZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Aug 2011 06:47:25 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:53517 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752147Ab1HXKrX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Aug 2011 06:47:23 -0400
Received: by iye16 with SMTP id 16so1883795iye.1
        for <git@vger.kernel.org>; Wed, 24 Aug 2011 03:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=Ii2tdCmhccROSRILd4tEoKgzxHFLTFdTzEh+2oSa8tY=;
        b=wZo4g4XsL6Ypzo08Us5CrO6FgeKV8FIxNw3W6aCZA9XzF+UjynjsOgxPmZA1lmwudd
         hue6F2KKaIDB/s+jSDvjCu1wY5+jpJB2Nh4lNAOMdfp+holW6izLOKvflYqldwJTnhqh
         FqPzBVFCLI5Hnd+BHY1Xjxu9N3oBPindOFsQY=
Received: by 10.231.21.194 with SMTP id k2mr10262245ibb.2.1314182843093; Wed,
 24 Aug 2011 03:47:23 -0700 (PDT)
Received: by 10.231.10.140 with HTTP; Wed, 24 Aug 2011 03:46:53 -0700 (PDT)
In-Reply-To: <20110823231034.GA11918@arf.padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179994>

On Wed, Aug 24, 2011 at 12:10 AM, Pete Wyckoff <pw@padd.com> wrote:
> Nice analysis. =A0P4 can indeed be the bottleneck, even on near
> servers if there are lots of files. =A0Diff-tree seems like the
> better choice to find the branch point. =A0I don't understand fully
> why the way we are using fast-import causes these problems. =A0Will
> look at that next.

I came up with some ideas during sleep:

1. When doing a "checkpoint" it would make sense to have some kind of
   feedback loop to know when fast-import completes it. In fact, I've
   just looked at fast-import man page and the "progress" command seems
   to do exactly that! Myabe we should crease a specific function for
   "checkpoint" that would call also "progress" instead of calling
   os.sleep().

2. In order to avoid needing to use "--force" it would be nice to have
   some form of "drop" command in fast-import that would allows us to
   actively drop an older commit after calling "reset" (this could even
   be an option of "reset"). This way fast-import would not find
   dangling commits in the end of the import.  Maybe there's already
   some sort of command to achieve this in fast-import...? We could
   probably ask to one of its maintainers.

--=20
Vitor Antunes
