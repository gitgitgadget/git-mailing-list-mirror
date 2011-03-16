From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 1/3] make_absolute_path: Don't try to copy a string to itself
Date: Wed, 16 Mar 2011 21:16:35 +0700
Message-ID: <AANLkTimQ81mwYhWLzGunimQzapEUkMmvKj47PuPWPgm0@mail.gmail.com>
References: <1300130318-11279-1-git-send-email-cmn@elego.de>
 <1300130318-11279-2-git-send-email-cmn@elego.de> <7v39mpcuv9.fsf@alter.siamese.dyndns.org>
 <1300140128.4320.39.camel@bee.lab.cmartin.tk> <7vpqptb976.fsf@alter.siamese.dyndns.org>
 <1300190396.19100.31.camel@bee.lab.cmartin.tk> <1300192832.19100.35.camel@bee.lab.cmartin.tk>
 <7vd3lsb9m3.fsf@alter.siamese.dyndns.org> <1300210062.19100.46.camel@bee.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?UTF-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@elego.de>
X-From: git-owner@vger.kernel.org Wed Mar 16 15:17:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzrXG-0003xt-Ni
	for gcvg-git-2@lo.gmane.org; Wed, 16 Mar 2011 15:17:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752834Ab1CPORK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Mar 2011 10:17:10 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:45628 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752791Ab1CPORI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Mar 2011 10:17:08 -0400
Received: by wya21 with SMTP id 21so1672979wya.19
        for <git@vger.kernel.org>; Wed, 16 Mar 2011 07:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=KA+A35Ddab1mOdzNTJs/4aXc7TLbuVhY3wSaYX+KJgQ=;
        b=Ti/4YFtxeQZCCVTViIqmPwLfkDTCToniCB0L/PS2QmWniPGILs0yWUAtGKHjJfbpt9
         ZqM6Bk7zxfs2fOrqa8UC/uurNtGzDTrdv4ZT8i4Jx1Scw9yLz9AmboJEcYi5TXeddV7e
         ryhr1XdfjlvVJcQstJfJ4gdKSCwUq85csgodk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=hcOwhTbuPnOtlV8qd9omQiUndbH2xjOQaZE+PKc7PtucVVU7P4mgLpPtDTjFtlQaor
         Wd/yEBRBg9LOzG4C9XrR4DO2neMficdLhHDGdEPkNvoHHwqjJVrhL/UURUy8NwFodD5v
         Ff8EgaREA98Ro8ih21wVVoz8+sld/NyBpg5JA=
Received: by 10.216.120.129 with SMTP id p1mr14652weh.81.1300285026693; Wed,
 16 Mar 2011 07:17:06 -0700 (PDT)
Received: by 10.216.163.202 with HTTP; Wed, 16 Mar 2011 07:16:35 -0700 (PDT)
In-Reply-To: <1300210062.19100.46.camel@bee.lab.cmartin.tk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169154>

2011/3/16 Carlos Mart=C3=ADn Nieto <cmn@elego.de>:
> I've been changing this a bit, trying to make all the paths normalize=
d,
> but it'll take a bit longer. I'll send a partial patch when I've
> finished something worth seeing (for the moment, the test fail if the=
re
> is a symlink somewhere in the tree, as I've mixed
> real_path/make_absolute_path and absolute_path/make_nonrelative_path =
a
> bit).
>
> =C2=A0Is it a good idea to normalize the paths? Otherwise, everything=
 could
> be replaced by real_path/make_absolute_path (as most calls already ar=
e).
> As it's transitive and these paths aren't stored permanently (other t=
han
> with clone), as long as we agree on one representation, it should be
> fine.

I think the question is whether it's _necessary_ to do that. Any gain?
make_absolute_path() calls are not in critical path, I don't think we
should bother much, unless there are bugs like one you fixed in your
patch.

> =C2=A0Is there a performance hit if we resolve links all the time? If=
 we run
> everything through normalize_path(_copy), is it slower than resolving
> links?

What paths are you talking about? If they are inside $GIT_DIR, we
touch them quite often. But there are not many of them (unless you
spread loose objects all over the place), resolving links should not
be an issue.

If they are inside worktree, maybe. Though I'm not sure if we want to
normalize all of them.
--=20
Duy
