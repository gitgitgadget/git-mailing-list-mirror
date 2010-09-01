From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Why isn't builtin.h used by all builtin/*.c files?
Date: Wed, 1 Sep 2010 14:17:29 +0000
Message-ID: <AANLkTinHtvHt0q=dK9KHtCX6JzymB5dx1NuaAZN_uu2R@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Sep 01 16:17:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oqo8D-00089Q-QE
	for gcvg-git-2@lo.gmane.org; Wed, 01 Sep 2010 16:17:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755076Ab0IAORb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Sep 2010 10:17:31 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:49148 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755044Ab0IAORa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Sep 2010 10:17:30 -0400
Received: by fxm13 with SMTP id 13so4709984fxm.19
        for <git@vger.kernel.org>; Wed, 01 Sep 2010 07:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=DTygtqSFZiqWN/4MZIerUVrc7eGAaZ2u3YGq9tFff94=;
        b=CVAwvdPfttjNYuWiiYdFhku4BK+ZWVd549M/+eeMKwRns0arDzD4vLOBqxJPQLdBkx
         FrCxOBO+G/7Xgc2CHbvsop6jx0/dJvTIP2SRvi548fivX0UnqoMSjNC7ndc2HpUcU440
         2isq8IQx4MiQ3GZ5bKu4Ef9Ha246DC7ZvQHTQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=uGnm7TgcK6Jc13L1c9Rj34Ovp7T5vLsbm8v+cu8Yxr2SdEYuUKHkPNNjBPri0jBn6N
         SNxg3BtR/1hq0vT7HE5C3xTdPgcxds+6d/VYrLGCgVTHMhxGvU5vw8OxK+r6xosqlIWF
         yg+hCxXcZfKT+tFy/4Rd6p83CliAbyMSi4ths=
Received: by 10.223.108.200 with SMTP id g8mr3346394fap.103.1283350649140;
 Wed, 01 Sep 2010 07:17:29 -0700 (PDT)
Received: by 10.223.120.14 with HTTP; Wed, 1 Sep 2010 07:17:29 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155044>

I'm working on gettextizing the 'mainporcelain common' commands now,
and I ran into this:

    $ perl -MArray::Diff -E 'chomp(my @hb = qx[ack -l builtin.h *.c]);
my @c = glob "*.c"; my $d = Array::Diff->diff( \@c, \@hb ); say for
@{$d->deleted}'
    fetch-pack.c
    hash-object.c
    index-pack.c
    merge-index.c
    merge-recursive.c
    merge-tree.c
    mktag.c
    pack-redundant.c
    pack-refs.c
    patch-id.c
    receive-pack.c
    remote-ext.c
    remote-fd.c
    remote.c
    reset.c
    send-pack.c
    skew.c
    unpack-file.c
    var.c

There seems to be no reason not to do this:

    --- a/builtin/clone.c
    +++ b/builtin/clone.c
    @@ -10,3 +10,3 @@

    -#include "cache.h"
    +#include "builtin.h"
     #include "parse-options.h"
    @@ -18,3 +18,2 @@
     #include "transport.h"
    -#include "strbuf.h"
     #include "dir.h"

builtin.h even includes the cmd_clone() prototype. I'm only asking
since clone.c was added *after* builtin.h, so this seems like an
omission.

Anyway, I'll convert these to builtin.h where appropriate as part of
the series unless someone can find a good reason not to.
