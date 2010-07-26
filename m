From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: git bundle bug?
Date: Mon, 26 Jul 2010 02:55:46 -0400
Message-ID: <AANLkTincXfdZehvVjVjtfvbuM-Jim5Tvtm9Yy=s8-fMR@mail.gmail.com>
References: <i2jaue$f7a$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: SungHyun Nam <goweol@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 26 08:56:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdHbq-0002qw-TY
	for gcvg-git-2@lo.gmane.org; Mon, 26 Jul 2010 08:56:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753009Ab0GZG4J convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Jul 2010 02:56:09 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:62733 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752832Ab0GZG4I convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Jul 2010 02:56:08 -0400
Received: by wyf19 with SMTP id 19so1823305wyf.19
        for <git@vger.kernel.org>; Sun, 25 Jul 2010 23:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=2JDsVSt5MN+9YmFXzIXpl4Bsj8QltE1qQh1ncGkHdgI=;
        b=eAG9rU0EfWudbvxd33VPKXx9YcPhDmhRihZ5AstPK/c5iv0lfKLArRKGlLW6LApE0k
         Xx9hWCaf8DXkz4aAn7ovIUHiFiX+hb29+LNgbkn2pLSAP5pS8QI4vDeZhplfsbEAcEQ/
         GEb00gBHVod7t+EUYEGtv5rVmvcqN04OgkSsk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=QXopU1AsPq81uSEe8lbBJXHkjGngLW3rEoFmwpyk6BJGwa3nCMi0fLfd3KyMSpT9+B
         1dys/EB7tZIWKxPmtJ2bM+n8HLKJiuU5BJZcyJlMmH73AcfqmA02i+XMzQjvhWC3zZHx
         kLDJvs7084J6ORkhelpvU961TfjxdeCCIqnSg=
Received: by 10.216.138.65 with SMTP id z43mr6990417wei.12.1280127366210; Sun, 
	25 Jul 2010 23:56:06 -0700 (PDT)
Received: by 10.216.235.202 with HTTP; Sun, 25 Jul 2010 23:55:46 -0700 (PDT)
In-Reply-To: <i2jaue$f7a$1@dough.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151811>

On Mon, Jul 26, 2010 at 2:45 AM, SungHyun Nam <goweol@gmail.com> wrote:
> In a current 'git' source tree, next command does not includes
> refs/tags/v1.7.2.
> =A0 =A0$ git bundle create ~/git.bundle v1.7.1..master
>
> After applying the git.bundle, now 'git version' does not
> show 1.7.2, but...
> =A0 =A0$ git version
> =A0 =A0git version 1.7.1.772.g64fdc

'git bundle' only includes the tags that you specifically tell it to.
It's kind of like 'git push' that way.  If you do:

   git tag -s mytag
   git push origin master

You don't expect origin to contain 'mytag' just because you pushed 'mas=
ter'.

> I hope the 'git bundle' includes all the tags when I use 'master'
> or 'HEAD'.
>
> Well, I could use v1.7.1..v1.7.2. =A0But want to use simple script li=
ke:
> =A0 =A0$ git bundle create ~/git.bundle lastbundle..master
> =A0 =A0$ git tag -f lastbundle master

That kind of magic would require 'git bundle' to look at all your tags
and see which ones lie in the range lastbundle..master.  And even that
isn't perfect, since you might have added a new tag that points before
lastbundle but was added *after* lastbundle.  So every bundle you
created would need to include *all* your previous tags.

Nevertheless, if you wanted to create a bundle that includes *all*
your tags, but not any of the objects leading up to lastbundle, this
works:

   git bundle create ~/git.bundle --tags lastbundle..master

Note however that it will include tags even if they *aren't* part of
master.  That is, if you have tags pointing at branch 'next', all the
objects for those tags will *also* be included.

Have fun,

Avery
