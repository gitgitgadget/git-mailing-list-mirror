From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH v3 14/14] daemon: only use posix features on posix systems
Date: Sun, 10 Oct 2010 19:40:28 +0000
Message-ID: <AANLkTimn3XWDXhqrZm+VS1Ouy8tzmCAVOyMN7KjQ7dFt@mail.gmail.com>
References: <1286716854-5744-1-git-send-email-kusmabite@gmail.com>
	<1286716854-5744-15-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, msysgit@googlegroups.com, j6t@kdbg.org
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 10 21:40:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P51lB-0000Rf-7M
	for gcvg-git-2@lo.gmane.org; Sun, 10 Oct 2010 21:40:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212Ab0JJTkc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Oct 2010 15:40:32 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:59886 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751193Ab0JJTkc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Oct 2010 15:40:32 -0400
Received: by iwn6 with SMTP id 6so2507036iwn.19
        for <git@vger.kernel.org>; Sun, 10 Oct 2010 12:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=JhRbiq/3JI4YzNBGAhv+LooJOz0i3EITcz5mLp0R6cE=;
        b=U2lpICyVT8Soie8qiYCb6RUaBvfu9mEFSWZPng5OM9BE+FINIaAYBKl+r6GIdt8x7U
         CU6+26009zP9mNgJm47O4BlUZRWfzrVIvI3nJ5kmFHOqExYhwxw/YGoSjCsb74VViLB3
         D+symNfDbN91dq7X4EyDbPbij5KaERbjyLaLU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=g3iAvWiFnXbc5R93mrCE2B9KecZJrgMwNtVeYlifIYVQQn9QSff3/U02yMLwgKpRz1
         agCGj0wC2ltF+JvrQEghVqH/LeDMJwE9dENpQsma6p50+HQ368M4vG/wGDIaBHohKcMi
         Rout8anQsj3IcZ6CQSF0SmUBzesGC8jrNEelM=
Received: by 10.231.147.202 with SMTP id m10mr4107364ibv.2.1286739628616; Sun,
 10 Oct 2010 12:40:28 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Sun, 10 Oct 2010 12:40:28 -0700 (PDT)
In-Reply-To: <1286716854-5744-15-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158689>

On Sun, Oct 10, 2010 at 13:20, Erik Faye-Lund <kusmabite@gmail.com> wrote:
> Windows does not supply the POSIX-functions fork(), setuuid(), setgid(),
> setsid() and initgroups(). Disable support for --user, --group and
> --detach on platforms lacking _POSIX_VERSION.

FWIW I checked if Perl's fork() emulation with threads on Windows
could emulate this, but no:

    perl -E '
    if (my $pid = fork()) {
      say "$$: child running as $pid"
    } else {
      sleep 1;
      say "$$: running in the background"
    }'

On Unix that would detach the process from the terminal, but on
Windows with threads the original process only returns after the child
has finished.

I didn't expect it to act differently, but I thought I'd note it here
in case anyone had it in mind to implement --detach on Windows.

> This might be a bit controversial; does anyone know of any systems that
> implements fork(), setuuid(), setgid() and setsid() but does not define
> _POSIX_VERSION? Perhaps we should have a separate makefile-switch instead?

Even if it's defined it's more self-documenting to have our own
HAVE_POSIX_GOODIES (or something like that) instead.
