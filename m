From: Tor Arntsen <tor@spacetec.no>
Subject: Re: Minimum Perl version?
Date: Fri, 24 Sep 2010 14:42:32 +0200
Message-ID: <AANLkTi=Q-xCu4TND877YBNOZXL3rBeU9fY6YY_9rA9j=@mail.gmail.com>
References: <20100924100019.GT23563@ece.pdx.edu>
	<AANLkTi=3xNSV0y-i=0KUSDRBJ8HmfSfGO7TBHTPiv_KM@mail.gmail.com>
	<AANLkTimUE=hyJ-y_XzpvCokb77KvRGw3gnM+9Xxui9tG@mail.gmail.com>
	<AANLkTiknAw5DwEDHQVJs96gEShky3rLYjyqpQy3MY=8Z@mail.gmail.com>
	<AANLkTimjMkJGw+Dh_x+TQUscC1tOV6kW=a6_57f2snnB@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Tait <git.git@t41t.com>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 24 14:42:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oz7br-0002el-MV
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 14:42:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755117Ab0IXMme (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 08:42:34 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:44433 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752218Ab0IXMmd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 08:42:33 -0400
Received: by qwh6 with SMTP id 6so1805165qwh.19
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 05:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:sender:received
         :in-reply-to:references:date:x-google-sender-auth:message-id:subject
         :from:to:cc:content-type;
        bh=KzxrV4Wi6q+l8rXwL11DKe+Be2Nuao18DMQgr9MiBQc=;
        b=Wyv/m6kKA1hWHAru8gSmqcrD1rlSeoIZZ6beRc4+54GUaAuJ8avWkSkDmCtjVRQtBc
         KeXNN4pwAsqQ6yJCFgo/ELgf6Rp0qOYIFYxkC86Pw3qSJQAha6VVBCpqTl7o6yDOxN0m
         AzdWFZwL1XON34x2SNTHbPKWcP6jLu2cealqE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        b=BWW5dVxxwrYqmNrLHD0lgNWHHRsxZ7M7mw9kfknPcJqnsxFMv/aO5ChU3mELqLs7FV
         HH5hlUClxCT3SDllPxB/NCwGhVSrDsMn033qpKSr6DggpqFaTqVAK9SBmGGg29nmtC8/
         X4fHEzBEQB5K1jXkM7Wz8EIMSVmUagu5ns9OI=
Received: by 10.229.213.199 with SMTP id gx7mr2491717qcb.141.1285332152737;
 Fri, 24 Sep 2010 05:42:32 -0700 (PDT)
Received: by 10.229.62.98 with HTTP; Fri, 24 Sep 2010 05:42:32 -0700 (PDT)
In-Reply-To: <AANLkTimjMkJGw+Dh_x+TQUscC1tOV6kW=a6_57f2snnB@mail.gmail.com>
X-Google-Sender-Auth: eoM773gRQRQvt0GwLVfy-mgqr0Y
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156982>

On Fri, Sep 24, 2010 at 14:30, Alex Riesen <raa.lkml@gmail.com> wrote:

> Maybe it is not the syntax (the separate argument for open mode
> in this case), but the initialization of $fh to 'undef' which is the
> problem here?

That's correct, I believe, but I also think the underlying problem here
is having support for dynamic filehandles which can be exported.
You could assign something to $fh and then call open(), but that
won't give you what the code asks for.

It should in principle be possible to replace
 my $fh = undef;
 open ($fh..)
with
 use FileHandle;
 my $fh = new FileHandle (...)
etc.
which works also on Perl 5.6.

When I first ran into this I did a little bit of hacking in that
direction, but I didn't make a full effort and didn't get it to work -
in the meantime the customer system which required perl 5.6 (for
performance reasons) migrated to a later version of AIX and I was then
free to upgrade the perl version to 5.8 on this (my maintance copy of
their system), in other words I wasn't affected by the problem anymore
and abandoned what I had started working on.

-Tor
