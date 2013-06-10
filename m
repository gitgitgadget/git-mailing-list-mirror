From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] build: get rid of the notion of a git library
Date: Mon, 10 Jun 2013 17:22:00 -0500
Message-ID: <CAMP44s0H4ET_Bfc0tFuxSagFO+ycq_U3RY65fqGsqh=0Y-YKPw@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Vincent van Ravesteijn <vfr@lyx.org>,
	John Keeping <john@keeping.me.uk>,
	Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 11 00:23:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmAUv-0005yq-Ag
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 00:23:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754466Ab3FJWX3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 18:23:29 -0400
Received: from mail-lb0-f177.google.com ([209.85.217.177]:49196 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754161Ab3FJWWD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 18:22:03 -0400
Received: by mail-lb0-f177.google.com with SMTP id 10so6301027lbf.22
        for <git@vger.kernel.org>; Mon, 10 Jun 2013 15:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=rGTCjoSb403K3tvXL5wcoHKbaN862DINhpZwB1gNvq4=;
        b=mgyU5joZZzrwD2ybGBCZ/cfEToUVGoQXEeNqddPy6eYO98wfM1QQbO0NQKK5syHUIW
         LzyjeAeUwvPILEBeZYqW9vHzMkjLSLka7RdStzNRkktRO4pu4o9flE7QqZ5h6v9sv5r/
         HAk7imtNgssr1P7V1NPk1zmxesutfwSjkFiWYXMS3Rmi+cKi9ltYPwvSUp9StvHqO6ok
         P+d4oTG9kzPocvbv0qAafMtrmaCOdk9JgRFVdjG0N259xRkuKAcGD99gTyeH/vv34AYf
         uyLVdOfctKENl4AZpN7Gv6sRQMlxMIfHNB7QcEnk4232EKa9TUpqOUBkHmuFrvKyUGLD
         emMg==
X-Received: by 10.112.166.67 with SMTP id ze3mr7541178lbb.25.1370902920810;
 Mon, 10 Jun 2013 15:22:00 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Mon, 10 Jun 2013 15:22:00 -0700 (PDT)
In-Reply-To: <20130610220627.GB28345@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227396>

On Mon, Jun 10, 2013 at 5:06 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Jun 10, 2013 at 04:52:57PM -0500, Felipe Contreras wrote:
>
>> On Mon, Jun 10, 2013 at 4:45 PM, Jeff King <peff@peff.net> wrote:
>>
>> > That is what libgit.a _is_ now.  I do not mean to imply any additional
>> > judgement on what it could be. But if the goal is to make libgit.a
>> > "functions that programs outside git.git would want, and nothing else",
>> > we may want to additionally split out a "libgit-internal.a" consisting
>> > of code that is used by multiple externals in git, but which would not
>> > be appropriate for clients to use.
>>
>> That might make sense, but that still doesn't clarify what belongs in
>> ./*.o, and what belongs in ./builtin/*.o. And right now that creates a
>> mess where you have code shared between ./builtin/*.o that is defined
>> in cache.h (overlay_tree_on_cache), and some in builtin.h
>> (init_copy_notes_for_rewrite). And it's not clear what should be done
>> when code in ./*.o needs to access functionality in ./builtin/*.o,
>> specially if that code is only useful for git builtins, and nothing
>> else.
>
> My general impression of the goal of our current code organization is:
>
>   1. builtin/*.c should each contain a single builtin command and its
>      supporting static functions. Each file gets linked into git.o to
>      make the "main" git executable.

We already know this is not the case. Maybe this should be fixed by
moving all the shared code between builtins to libgit.a, but maybe we
already know at some level this is not wise, and that's why we haven't
done so.

> If we want to start caring, then we probably need to create a separate
> "kitchen sink"-like library, with the rule that things in libgit.a
> cannot depend on it. In other words, a support library for Git's
> commands, for the parts that are not appropriate to expose as part of a
> library API.

Yes, that's clearly what we should be doing, which is precisely what
my patch that creates builtin/lib.a does.

So we have two options:

a) Do what we clearly should do; create builtin/lib.a, and move code
there that is specific to builtin commands.

b) Do what we think we have been doing; and move _all_ shared code to
libgit.a (which shouldn't be called libgit, because it's not really a
library), and cleanup builtin/*.c so they don't share anything among
themselves directly.

I vote for a), not only because we already know that's what we
_should_ do, but because we are basically already there.

Leaving things as they are is not really an option; that's a mess.

-- 
Felipe Contreras
