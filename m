From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 0/3] nd/clear-gitenv-upon-use-of-alias
Date: Thu, 24 Dec 2015 16:35:33 +0700
Message-ID: <CACsJy8Aqu9wTigWKC1-74qLUimV8PvmbDG1XeqYcbW0ZSMLSTg@mail.gmail.com>
References: <1449166676-30845-1-git-send-email-pclouds@gmail.com>
 <1450597819-26278-1-git-send-email-pclouds@gmail.com> <xmqq4mfbfqla.fsf@gitster.mtv.corp.google.com>
 <CACsJy8DFmZSa2x4y2fDwVsvwa5uAuMJn8v=utvYtAPTGFbdWPg@mail.gmail.com>
 <CACsJy8A5AcRj2HiLe3PQijhYcHMzJ6eEuMyeVTMvPtXvMg_Sug@mail.gmail.com>
 <xmqqd1tye4i8.fsf@gitster.mtv.corp.google.com> <20151223093700.GA13386@sigill.intra.peff.net>
 <567B05F0.5020604@kdbg.org> <20151223213140.GB21277@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Sixt <j6t@kdbg.org>, Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Stefan Beller <sbeller@google.com>,
	Anthony Sottile <asottile@umich.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 24 10:36:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aC2Jk-0005wd-0F
	for gcvg-git-2@plane.gmane.org; Thu, 24 Dec 2015 10:36:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752883AbbLXJgI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Dec 2015 04:36:08 -0500
Received: from mail-lb0-f177.google.com ([209.85.217.177]:35103 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750771AbbLXJgG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Dec 2015 04:36:06 -0500
Received: by mail-lb0-f177.google.com with SMTP id bc4so58132874lbc.2
        for <git@vger.kernel.org>; Thu, 24 Dec 2015 01:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=bLUSLQHh97xHGjcc9PY3l7YkZspvoVgLq/74F7oiMi0=;
        b=r4w/SvKLC6L8TXRNPmIW4G2sGtUypQrKQZbjgxj86SOQeKmHU+eXJyOwbAqEYa44J9
         PmYenWIWbBrBh69iln2OJFYekgvwg3L7rZU+z+t8E9PkqWaKo7Z6q8wsx7VS5xcVzAWh
         T3zAbMpr618QrUyuBwEh+tPfuQHuEEPiQCSIP/llVkz7WF/Xlwx37Hp6QGqWPJD2FiP3
         YgZlhy8vXjLOAo2ULyMn2lrmcXY805cJU7Ns43oTEW+p2v9lA5XS/DaudJdOoR0qXmt1
         +hWHucfYYoTlN4xdkb9Pt89rrxFJJ2QQewNHErkCevXbPcFpTOtxrcKD6dPyPuleYiPK
         eoyQ==
X-Received: by 10.112.16.135 with SMTP id g7mr12363135lbd.80.1450949763541;
 Thu, 24 Dec 2015 01:36:03 -0800 (PST)
Received: by 10.112.199.5 with HTTP; Thu, 24 Dec 2015 01:35:33 -0800 (PST)
In-Reply-To: <20151223213140.GB21277@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282976>

On Thu, Dec 24, 2015 at 4:31 AM, Jeff King <peff@peff.net> wrote:
>   2. I doubt anybody is actually seeing this in practice anymore. But
>      maybe I am misunderstanding something in Duy's series that changes
>      this.

There are two parts in your patch, one (that you two seemed to focus
on) about return code with "!" aliases. Another, suppressing SIGPIPE,
affects more than "!" aliases. In my case it's
execv_dashed_external(). Non-"!" aliases are now forced to use that
function.

This is the output with 'pu'. Notice git-log is executed separately

> ~/w/git $ GIT_TRACE=2 PAGER=true ./git --exec-path=. l
16:28:19.167040 git.c:567               trace: exec: 'git-l'
16:28:19.167088 run-command.c:345       trace: run_command: 'git-l'
16:28:19.168599 git.c:286               trace: alias expansion: l =>
'log' '--stat'
16:28:19.168633 git.c:567               trace: exec: 'git-log' '--stat'
16:28:19.168649 run-command.c:345       trace: run_command: 'git-log' '--stat'
16:28:19.170420 git.c:350               trace: built-in: git 'log' '--stat'
16:28:19.210074 run-command.c:345       trace: run_command: 'true'
16:28:19.210382 run-command.c:204       trace: exec: 'true'
error: git-log died of signal 13

With your patch on top, "git-log died of.." goes away. And this is
with 'master', where the builtin version of git-log is used

> ~/w/git $ GIT_TRACE=2 PAGER=true ./git --exec-path=. l
16:29:17.546382 git.c:561               trace: exec: 'git-l'
16:29:17.546428 run-command.c:343       trace: run_command: 'git-l'
16:29:17.547485 git.c:282               trace: alias expansion: l =>
'log' '--stat'
16:29:17.548482 git.c:348               trace: built-in: git 'log' '--stat'
16:29:17.586457 run-command.c:343       trace: run_command: 'true'
16:29:17.586770 run-command.c:202       trace: exec: 'true'

So, in practice, people will see "died of signal 13" a lot more often
if my series is merged and released (I assume that people often use
aliases for paged commands like git-log, git-diff...)
-- 
Duy
