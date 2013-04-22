From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] t4202 (log): add failing test for log with subtree
Date: Mon, 22 Apr 2013 18:24:29 +0530
Message-ID: <CALkWK0kS4Y-ERMn54J7O+kiQwNNGxqx1a_31y2JAO9UjeVZ7MQ@mail.gmail.com>
References: <1366632487-28153-1-git-send-email-artagnon@gmail.com>
 <vpqa9oqpxx7.fsf@grenoble-inp.fr> <87r4i2pxo5.fsf@linux-k42r.v.cablecom.net> <CALkWK0kaYeOt3pdjae8rXPiPBWnfrAPOoOaQ73m2qktVxvoeTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>,
	Avery Pennarun <apenwarr@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Apr 22 14:55:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUGH7-00012m-IO
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 14:55:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753855Ab3DVMzL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 08:55:11 -0400
Received: from mail-ia0-f177.google.com ([209.85.210.177]:55481 "EHLO
	mail-ia0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753492Ab3DVMzK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Apr 2013 08:55:10 -0400
Received: by mail-ia0-f177.google.com with SMTP id y26so2650097iab.8
        for <git@vger.kernel.org>; Mon, 22 Apr 2013 05:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=d1/FbCvN+do597uueDKwxCj97M84vzzut88nn+dvm9Y=;
        b=wkPZbNKN4fa72Tpv+gjq05qxXdC1ZZVpZqOJerXGNcG3Mwrv78LYlXb2i2hMlPE6re
         cLpIdNkk6eqARM19eM+fd09cIBr5nFjDqF7C/xpBya+3e3vRxIqKc6lAJZBmIbaebp/6
         cCAKhtlpi96WDlMDAEo/N0p0VQ2zYnt45tB3yELzQ6KPlaXxhKRkRP2plydjUXVH6cii
         zBxoEdTlvdzXVmh9KQmDA9nghBGPvjFKo3uOVTsoPdx/y2LCmFPnn87A7tn2W/AdtsRD
         i7OblNZQ0o/biJPZIk8d1Gb6WzypjrA/3nv5VvlOjTPl4BvzgB8mjR6XG3aGzUeXYjt+
         PyvQ==
X-Received: by 10.50.50.71 with SMTP id a7mr21180294igo.14.1366635309502; Mon,
 22 Apr 2013 05:55:09 -0700 (PDT)
Received: by 10.64.63.48 with HTTP; Mon, 22 Apr 2013 05:54:29 -0700 (PDT)
In-Reply-To: <CALkWK0kaYeOt3pdjae8rXPiPBWnfrAPOoOaQ73m2qktVxvoeTw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222012>

Ramkumar Ramachandra wrote:
> Unless there is a commit with the following diff
> (with heuristically similar content), I don't see how --follow can
> work:
>
>     diff --git a/README b/README
>     deleted file mode 100644
>
>     diff --git a/subproject/README b/subproject/README
>     new file mode 100644

In other words, git diff-tree HEAD^2 HEAD is absolute nonsense in the
subtree case.

Let me outline how I think --follow works:
A 'git log --follow foo' executes a diff-tree with historical trees
until it finds one that removes (or adds, depending on which way you
look at it) the 'foo' entry.  It then inspects all the trees in the
corresponding commit for a blob that is heuristically similar to the
HEAD:foo blob, and follows it.

How can you logically extend this concept to handle my case?
