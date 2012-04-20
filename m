From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] Fixed compilation with Visual Studio by including poll.h
Date: Fri, 20 Apr 2012 23:58:30 +0200
Message-ID: <CABPQNSb7NeHOnOy-zmNMA3Jp143oCYqsGjK=+uatsS9bYaN5hA@mail.gmail.com>
References: <4F91C8FF.7070402@tu-clausthal.de> <20120420204722.GD13103@sigill.intra.peff.net>
 <4F91D489.8050402@tu-clausthal.de>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Sven Strickroth <sven.strickroth@tu-clausthal.de>
X-From: git-owner@vger.kernel.org Fri Apr 20 23:59:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SLLre-00013l-3S
	for gcvg-git-2@plane.gmane.org; Fri, 20 Apr 2012 23:59:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756104Ab2DTV7P convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Apr 2012 17:59:15 -0400
Received: from mail-pz0-f52.google.com ([209.85.210.52]:43487 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932095Ab2DTV7L convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Apr 2012 17:59:11 -0400
Received: by dake40 with SMTP id e40so13508017dak.11
        for <git@vger.kernel.org>; Fri, 20 Apr 2012 14:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=+zNVxS74lrDUU+//TJa2MIoyr7yqFQIhn0nfc1DzHLI=;
        b=t4wMm4hZH7TQKR4mvy1ocr6dnHogGVyK1vp3r2dKUYDm/KsGdI5JjDDIJcK3Afx0k3
         dsyNailZnyAAwkxgOaLwnO2b2LivViHaUmuNIf74bN3ZEvMbhNGJwEJlhiDxA9nbIWne
         ABU3CsHytcNc4rCHCvPiMbw2ZUPqg4ryD6nKgirNvhkiVWt4W19pH0KxGwgKqzYUdH0y
         +IsgG9Dm+kseEomRDmMj60vZ1NdWIG79QpmiyUylv6OVeooviNDr0QcH1dp+qDoLvHqV
         QsuTKgbAA2gLPJezgibPL90+a4rogTiLFNQjjHoHxCZXcS1guGbCsS8Tf7yz4FkETGC4
         ylNw==
Received: by 10.68.220.161 with SMTP id px1mr1239314pbc.12.1334959151132; Fri,
 20 Apr 2012 14:59:11 -0700 (PDT)
Received: by 10.68.236.105 with HTTP; Fri, 20 Apr 2012 14:58:30 -0700 (PDT)
In-Reply-To: <4F91D489.8050402@tu-clausthal.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196029>

On Fri, Apr 20, 2012 at 11:26 PM, Sven Strickroth
<sven.strickroth@tu-clausthal.de> wrote:
> Windows does not have sys/poll.h. I have to use the one from compat/w=
in32.
>
> The problem is that
> =A0 =A0NO_SYS_POLL_H
> is defined in compat/msvc.h in my environment.
> And in git-compat-util.h
> =A0 =A0#ifndef NO_SYS_POLL_H
> =A0 =A0#include <sys/poll.h>
> =A0 =A0#else
> =A0 =A0#include <poll.h>
> =A0 =A0#endif
> is before
> =A0 =A0#elif defined(_MSC_VER)
> =A0 =A0#include "compat/msvc.h"
> . Moving it down, solves the issue for me. (Suppose this is a fix for=
 my
> scenario only).
>

NO_SYS_POLL_H shouldn't be defined in compat/msvc.h, it should be
defined by the build-system. Our Makefile already does this inside the
"ifeq ($(uname_S),Windows)"-block.

How are you building Git?
