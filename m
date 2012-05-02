From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 0/2] [GIT PULL] ktest: A couple of fixes
Date: Tue, 1 May 2012 19:58:46 -0700
Message-ID: <CA+55aFy02d13HkfwY-TEGwu=2cd8en+_rnrnwcwixGKRmdJRtA@mail.gmail.com>
References: <20120502004439.965120020@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-kernel@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
X-From: linux-kernel-owner@vger.kernel.org Wed May 02 05:00:03 2012
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1SPPnO-0000Os-V4
	for glk-linux-kernel-3@plane.gmane.org; Wed, 02 May 2012 05:00:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758582Ab2EBC7K (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Tue, 1 May 2012 22:59:10 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:57212 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758408Ab2EBC7I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 May 2012 22:59:08 -0400
Received: by wibhr17 with SMTP id hr17so3615104wib.1
        for <multiple recipients>; Tue, 01 May 2012 19:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=c63m45+fEx5X0epCXxQjbmLOSxfu7+5GpuNnT3WbHCs=;
        b=aV4B0xY0OGrrmmRTANgM37MLN8ggGI3fbLdTjn3aM806tTpPzBRura3BXqRB5lcrMk
         qiaHzAdAEwtr5PvrKZW7D0KmKmydHuJ+Zig6gaapWfz0hsExEYyvbDiWFwrqXgfZuvSU
         6ZhaDeKCi0HaWWz1cXGzD/kps6BKUnqZtnBF0h2wtRWzVxWV8B9Y21h/4BfYyo58h9h9
         rRHfpUtK3ZbLAhrieSABREXb7lF3WppgyHFYAQlvOc60EKKfDmH5jTSPEq/3Ia5srrg/
         pgkPL1A1p7kodnfa1bzLJ15Q+DuUBV9LjjxPF/wdq0wY6h9+SYC6iYnT5llVHmaSVnbn
         x5MQ==
Received: by 10.181.12.82 with SMTP id eo18mr10067367wid.2.1335927546760; Tue,
 01 May 2012 19:59:06 -0700 (PDT)
Received: by 10.223.158.140 with HTTP; Tue, 1 May 2012 19:58:46 -0700 (PDT)
In-Reply-To: <20120502004439.965120020@goodmis.org>
X-Google-Sender-Auth: 68BXbPYeAstPQ1F_CQEPunfWZK4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196780>

On Tue, May 1, 2012 at 5:44 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Is git set up to not fast forward by default? (I need to give it another try)

Git will fast-forward by default if you do a pull and there is no
development of your own in your tree.

There are two exceptions:

 - you explicitly say that you don't want to fast-forward (--no-ff or
"[merge] ff=false" in the git config file)

 - if you pull a signed tag with a modern version of git.

That second case may be what you hit.

If you do a

  git pull linus v3.4-rc5

in order to just update to the state of my latest tag, then git will
assume you want to do a new commit (and thus a non-fast-forward) just
so that git can record the tag signature in the commit.

The sad part is that I don't think you can even override the second
case. IOW, I think even "git pull --ff linus v3.4-rc5" will still do a
non-fast-forward merge.

That's inconvenient, and an unintended consequence of the behavior I
wanted as a top-level maintainer. But I really do think it's wrong for
normal developers who might validly just want to update to some
particular tagged release.

Junio? Any ideas?

                           Linus
