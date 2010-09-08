From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: NO_REGEX defaults on obscure platforms
Date: Wed, 8 Sep 2010 15:12:35 +0000
Message-ID: <AANLkTimYY_KHwqWWXTxFqW67FHYtJJkLuA-6WVc6wzO5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, "Gary V. Vaughan" <gary@thewrittenword.com>,
	Boyd Lynn Gerber <gerberb@zenez.com>,
	Brandon Casey <drafnel@gmail.com>,
	Jason Riedy <ejr@EECS.Berkeley.EDU>,
	Robert Schiele <rschiele@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 08 17:12:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtMKJ-0001Jc-1M
	for gcvg-git-2@lo.gmane.org; Wed, 08 Sep 2010 17:12:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751815Ab0IHPMi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Sep 2010 11:12:38 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:37372 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751493Ab0IHPMg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Sep 2010 11:12:36 -0400
Received: by gwj17 with SMTP id 17so71007gwj.19
        for <git@vger.kernel.org>; Wed, 08 Sep 2010 08:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:cc:content-type;
        bh=/xExqtyjhaMJQkgdScxPXp9DnFJP6BsFh8yQkeplZ+I=;
        b=THu9D4BUpdqMIHg8R4kuj8DY9B1jm7/4zMmT5Y56QQC1gDTynEv60Usa5okLBKwFvU
         1r4oga+Av2549CVNSjZ9P0BT841kHyacV4WHce5FJsEzckmkUvMw3RQyvbL6O+pDpto2
         NPXhppRCaYhfG6IqAI71/GX2TwcV48yrScILQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=RNznIfJzcYiewlTH89khNpVR77UXyfAiajCAflrqxhfCy92lZ4BP9DYVG2lHiTCPbT
         YMSFRK5zdMmiDcNqI6ZhHbt2imUVwiGG+GeNxqlgjb69xtekMXKCikr8VWZ1txjRH4TV
         ZlFdLwKnhkrWjEYzbDQzL7Ziq7A72H8hemD7g=
Received: by 10.151.26.3 with SMTP id d3mr56278ybj.291.1283958755873; Wed, 08
 Sep 2010 08:12:35 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Wed, 8 Sep 2010 08:12:35 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155792>

On Mon, Sep 6, 2010 at 07:41, Junio C Hamano <gitster@pobox.com> wrote:

> There are a few leftover bits in 'next' that need to be merged to 'master'
> before we declare a real -rc cycle, so tonight's pushout is -rc0.

One thing that's almost certainly wrong in v1.7.3-rc0 is the NO_REGEX
defaults. It's a non-issue for people who run the configure script,
but the Makefile probably has the wrong defaults on some obscure
platforms.

I've CC'd people involved in Tru64, UnixWare, SCO, HP/UX, IRIX etc. It
would be really useful if you could:

  1. Get v1.7.3-rc0
  2. Compile with the defaults, and NO_REGEX=YesPlease
  3. Run `cd t && ./t7008-grep-binary.sh` and report the results.

That test is probably failing on some of these platforms.

Alternatively, just check for REG_STARTEND in regex.h (or the includes
it pulls in):

    $ grep REG_STARTEND /usr/include/regex.h
    #define REG_STARTEND (1 << 2)
