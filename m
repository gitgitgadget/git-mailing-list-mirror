From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] build: get rid of the notion of a git library
Date: Mon, 10 Jun 2013 18:51:42 -0500
Message-ID: <CAMP44s1HM0zFvkGmaHrX2Wq2JSzDNk8uwNSz3bNo12eWxDcL8A@mail.gmail.com>
References: <1370712574-27688-1-git-send-email-felipe.contreras@gmail.com>
	<CALkWK0mA7MXQv1k5bFpZLARDOHxU5kzKFXzcyUfb6NLZZY-=FA@mail.gmail.com>
	<CAMP44s0cozMsTo7KQAjnqkqmvMwMw9D3SZrVxg48MOXkH9UQJQ@mail.gmail.com>
	<CALkWK0=7PRndNc7XQ-PCPbVCp9vck909bA561JhQG6uXXj1n4g@mail.gmail.com>
	<20130609151235.GA22905@serenity.lan>
	<CAMP44s0L9nQxp5OeK8uT4Ls5WUerCjVpR9uONUcOwvTD6k7Jfg@mail.gmail.com>
	<51B4BBB7.8060807@lyx.org>
	<20130610214504.GG13333@sigill.intra.peff.net>
	<CAMP44s2-94LTu54oX1_m14tnE3KfwK+N=pPxgUSqGCgd51EA5A@mail.gmail.com>
	<20130610220627.GB28345@sigill.intra.peff.net>
	<7vk3m1efda.fsf@alter.siamese.dyndns.org>
	<7v8v2hedou.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Vincent van Ravesteijn <vfr@lyx.org>,
	John Keeping <john@keeping.me.uk>,
	Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 11 01:51:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmBsL-0000wR-6l
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 01:51:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753437Ab3FJXvo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 19:51:44 -0400
Received: from mail-lb0-f170.google.com ([209.85.217.170]:61511 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752626Ab3FJXvo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 19:51:44 -0400
Received: by mail-lb0-f170.google.com with SMTP id t13so1969008lbd.15
        for <git@vger.kernel.org>; Mon, 10 Jun 2013 16:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Bk2vwVrcK4VWFPArjuCuBJlmDmHeP4/gIud4Ytu9RSQ=;
        b=AExcZk2YMvSULva88gFCjucAXgRaj0ZfcO70YNxSIFkQTScauDOImObO+88vXWdm0x
         84X4hLEXTo2yxHnmSazbpog3eIp4wKyxFshIWSf5jaAQ+o3g95Tb4xeMgl9+ZSOflSNo
         PMt8IZFTEbVWlcL5RHOldUgWNb0wy+GpjSfVaIHrgTXHSDJZyXlJZ3BrXUjfp9qHNt4i
         4T4YcwPWoJtW1kPCRsdxYBDNr1kdTd+4nC6lR9RuQudUqz5iz4T9bsZzYoYT9O5IOGBq
         tfh4kRuGAZ6p8eONDs+KKzpUVVAPdw4Jtqu7eZOF5rDdL6BlGmHvwcWHnNQudKHo4nSx
         w8Ow==
X-Received: by 10.152.27.102 with SMTP id s6mr6131760lag.47.1370908302684;
 Mon, 10 Jun 2013 16:51:42 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Mon, 10 Jun 2013 16:51:42 -0700 (PDT)
In-Reply-To: <7v8v2hedou.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227405>

On Mon, Jun 10, 2013 at 6:41 PM, Junio C Hamano <gitster@pobox.com> wrote:

> For the particular case of trying to make sequencer.o, which does
> not currently have dependencies on builtin/*.o, depend on something
> that is in builtin/notes.o, the link phase of standalone that wants
> anything from revision.o (which is pretty much everything ;-) goes
> like this:
>
>         upload-pack.c   wants handle_revision_opt etc.
>         revision.c      provides handle_revision_opt
>                         wants name_decoration etc.
>         log-tree.c      provides name_decoration
>                         wants append_signoff
>         sequencer.c     provides append_signoff
>
> So sequencer.o _is_ meant to be usable from standalone and belongs
> to libgit.a

Not after my patch. It moves append_signoff *out* of sequencer, which
in fact has nothing to do with the sequencer in the first place.

> If sequencer.o wants to call init_copy_notes_for_rewrite() and its
> friends [*1*] that are currently in builtin/notes.o, first the
> called function(s) should be moved outside builtin/notes.o to
> notes.o or somewhere more library-ish place to be included in
> libgit.a, which is meant to be usable from standalone.
>
>
> [Footnote]
>
> *1* ... which is a very reasonable thing to do.  But moving
>     sequencer.o to builtin/sequencer.o is *not* the way to do this.

By now we all know what is the *CURRENT* way to do this; in other
words, the status quo, which is BTW all messed up, because builtin/*.o
objects depend on each other already.

We are discussing the way it *SHOULD* be. Why aren't you leaning on that?

-- 
Felipe Contreras
