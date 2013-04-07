From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC/PATCH 0/7] Rework git core for native submodules
Date: Sun, 7 Apr 2013 23:52:02 +0530
Message-ID: <CALkWK0nj2+PH47OhHmq89Tzi4tdwaJTKaEneAt_k2rwpWbCnuA@mail.gmail.com>
References: <1365100243-13676-1-git-send-email-artagnon@gmail.com>
 <CALkWK0mM9HBUvHGHPEw4Vdosp_qfu_1L49TaZrzdC5n3soWkYg@mail.gmail.com>
 <7v61zz9fu3.fsf@alter.siamese.dyndns.org> <CALkWK0n64BW8zQXweR38T6DjT+iYBbsZDPCLZ-4igqGJHoFwKw@mail.gmail.com>
 <7vr4im7m1y.fsf@alter.siamese.dyndns.org> <CALkWK0=jrO9MQotB+anAn-5YtG1RBTLWEnGL5=K4wy=yi7E-CQ@mail.gmail.com>
 <20130407161209.GG2222@serenity.lan> <CALkWK0kSF_q0o1V6BhO6X2jKAJQxNQ0c6MCi5o=jZdMwrba48g@mail.gmail.com>
 <20130407170201.GH2222@serenity.lan> <CALkWK0nSxfEzP7KHZxGjmBYD7pX5aa3CbMt1qAGrz4tonrtHhA@mail.gmail.com>
 <20130407175210.GI2222@serenity.lan> <CALkWK0n=vtPT7aFn9+T+bRxUpfXG+mYvV29YKC=_OAampQXJSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sun Apr 07 20:22:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOuEq-00021v-3q
	for gcvg-git-2@plane.gmane.org; Sun, 07 Apr 2013 20:22:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934232Ab3DGSWo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Apr 2013 14:22:44 -0400
Received: from mail-ie0-f172.google.com ([209.85.223.172]:39626 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934221Ab3DGSWn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Apr 2013 14:22:43 -0400
Received: by mail-ie0-f172.google.com with SMTP id c10so6003739ieb.17
        for <git@vger.kernel.org>; Sun, 07 Apr 2013 11:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=JVCtvewIF6+pJXLHMU55kKRTrSWTebrfm0q3ZGb7MA4=;
        b=cYO3AsH60UmXMYMHaOuA+3OWQZMkAY7Si8pchguCk0B4EA3elNcAsCUtH2hHjoH0jo
         X0bd0TwR37qX2BACdu9/Z5JD0hgHQKaemKQ0qVxxGD/tCVVSUjzDl9enjk/hOPwRxu9Q
         m6hgfvTnMHf33t/4otFy2CC7eHFYHgUW4LlLSbdByjHJkMZ8uMngBsRU8fLHi1AIZyV9
         KSA/YgrO0VfM3Pvsu98P7dkpr/DNS5nPylvmX0K+COZ2RzX88D4scOtIoXhRYQ8BykK0
         N4m+EwHlMlaNQqIKMXgmN7y5Sv66GrVNJ6nl1xcwYwFIMjCTrVKoQsYrbklaZ2HXqAy4
         JI0w==
X-Received: by 10.50.108.235 with SMTP id hn11mr4575466igb.107.1365358963319;
 Sun, 07 Apr 2013 11:22:43 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Sun, 7 Apr 2013 11:22:02 -0700 (PDT)
In-Reply-To: <CALkWK0n=vtPT7aFn9+T+bRxUpfXG+mYvV29YKC=_OAampQXJSA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220355>

Ramkumar Ramachandra wrote:
> You can't control the most fundamental thing, stat(): this is the
> primary killer of performance on a large worktree.  There is currently
> no way to block stat(): new-style submodules offers a way to configure
> which submodules to block the stat() on.

Let me try to put this in simpler language.  When you run 'git status'
on your toplevel repository, old-style submodules runs git status on
each of the submodule repositories also: this is because submodules
were traditionally fixed; therefore, if you forget to commit some
changes in submodules before you make the superproject commit, you
might break the build.  In new-style submodules, you can prevent this
from happening on a link-specific basis.
