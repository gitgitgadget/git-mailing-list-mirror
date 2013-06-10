From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] build: get rid of the notion of a git library
Date: Mon, 10 Jun 2013 16:52:57 -0500
Message-ID: <CAMP44s2-94LTu54oX1_m14tnE3KfwK+N=pPxgUSqGCgd51EA5A@mail.gmail.com>
References: <1370712574-27688-1-git-send-email-felipe.contreras@gmail.com>
	<CALkWK0mA7MXQv1k5bFpZLARDOHxU5kzKFXzcyUfb6NLZZY-=FA@mail.gmail.com>
	<CAMP44s0cozMsTo7KQAjnqkqmvMwMw9D3SZrVxg48MOXkH9UQJQ@mail.gmail.com>
	<CALkWK0=7PRndNc7XQ-PCPbVCp9vck909bA561JhQG6uXXj1n4g@mail.gmail.com>
	<20130609151235.GA22905@serenity.lan>
	<CAMP44s0L9nQxp5OeK8uT4Ls5WUerCjVpR9uONUcOwvTD6k7Jfg@mail.gmail.com>
	<51B4BBB7.8060807@lyx.org>
	<20130610214504.GG13333@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Vincent van Ravesteijn <vfr@lyx.org>,
	John Keeping <john@keeping.me.uk>,
	Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 10 23:53:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmA1Q-0003bs-Gl
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 23:53:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752857Ab3FJVxA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 17:53:00 -0400
Received: from mail-la0-f43.google.com ([209.85.215.43]:50478 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751997Ab3FJVw7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 17:52:59 -0400
Received: by mail-la0-f43.google.com with SMTP id gw10so6277851lab.30
        for <git@vger.kernel.org>; Mon, 10 Jun 2013 14:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=heFMp3X2oZGD+TysYXlhldsFh+Cnj+rbVIy0tms+X0o=;
        b=DnCQzPsnKazmU7nmGG9ARIuxVn0H9h+0uML7pYETQj+eBR3xb1oQKVzfdjp9+ITIDn
         oct96AYRY+MZ7DHcONNx4ApPRMrQ/x/sQspOe6zgZCNzSzF3oHCtm+V1JTTZcK4DsE0g
         ZTa7HK2ZgTlTjJVZvK2NFaMTUqIsZ2rNf0WqfNu6UcogIZJlnVubXgODP4yVW/YzrnRp
         zRP8PCu3kkY5xyfg3aRx21xBtcTK2wwGz8bSIxapR111nBGCp9WgxeJhOrwyv7DtYPtk
         VP38R3IFMk2bmliCgb/80MtaZST9FJ5VdJezgQLQQaK3KD3A2gtFAoOaZaGmLDUZuVqG
         ARrg==
X-Received: by 10.152.43.136 with SMTP id w8mr5888580lal.63.1370901177487;
 Mon, 10 Jun 2013 14:52:57 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Mon, 10 Jun 2013 14:52:57 -0700 (PDT)
In-Reply-To: <20130610214504.GG13333@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227393>

On Mon, Jun 10, 2013 at 4:45 PM, Jeff King <peff@peff.net> wrote:

> That is what libgit.a _is_ now.  I do not mean to imply any additional
> judgement on what it could be. But if the goal is to make libgit.a
> "functions that programs outside git.git would want, and nothing else",
> we may want to additionally split out a "libgit-internal.a" consisting
> of code that is used by multiple externals in git, but which would not
> be appropriate for clients to use.

That might make sense, but that still doesn't clarify what belongs in
./*.o, and what belongs in ./builtin/*.o. And right now that creates a
mess where you have code shared between ./builtin/*.o that is defined
in cache.h (overlay_tree_on_cache), and some in builtin.h
(init_copy_notes_for_rewrite). And it's not clear what should be done
when code in ./*.o needs to access functionality in ./builtin/*.o,
specially if that code is only useful for git builtins, and nothing
else.

-- 
Felipe Contreras
