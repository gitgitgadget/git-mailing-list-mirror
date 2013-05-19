From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] for-each-ref: introduce color format
Date: Sun, 19 May 2013 19:05:08 +0700
Message-ID: <CACsJy8CthvpJh6QM+umxY_Gq7nc-rGZ+Tcp7zAkadez-g+FFjQ@mail.gmail.com>
References: <1368802552-16024-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 19 14:05:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ue2Mx-0007O8-ST
	for gcvg-git-2@plane.gmane.org; Sun, 19 May 2013 14:05:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754526Ab3ESMFk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 May 2013 08:05:40 -0400
Received: from mail-oa0-f44.google.com ([209.85.219.44]:57441 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754191Ab3ESMFj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 May 2013 08:05:39 -0400
Received: by mail-oa0-f44.google.com with SMTP id n12so6767091oag.3
        for <git@vger.kernel.org>; Sun, 19 May 2013 05:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=6+R1vWtaytNHVMAC0M1+K4suIM0YQP1cREnJLTcPV44=;
        b=Hu4GlN4sxRHUlZedoiQxx7YvqY7b8rPlReRo6k3vv4jp3bNptqaKwRbNA4rBerHMKa
         dC8cIy/kY6WlR+eIEgUnUdGvvJbBaeheprrCNdvm6BLbDa5aMvshvAOXIoA755OjmfzN
         khpH6/s7umixJ0RLdnyKBhpeMIxGulDEfIeO63XQGHyUf0tZfdY0t+MCsZg6TzPaqHl/
         QiE+h9y0WfFPP4Kjgn9LhT5XeN19/mgBPHDyqxKGlxw2WC/EFsYGnRuQ3fiSScqZ0XqS
         qZ4ARqXF1Ps9kRtr32Qj9OViJFfhxzZtHOCGcMPSalddY28OeRp9OHVwHmTRK1Da17U1
         A/Sg==
X-Received: by 10.182.80.201 with SMTP id t9mr24969876obx.52.1368965138870;
 Sun, 19 May 2013 05:05:38 -0700 (PDT)
Received: by 10.76.180.138 with HTTP; Sun, 19 May 2013 05:05:08 -0700 (PDT)
In-Reply-To: <1368802552-16024-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224878>

On Fri, May 17, 2013 at 9:55 PM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> You can now do something like
>
> $ git for-each-ref --format='%C(red)%(refname:short)%C(reset)
> %C(blue)%(upstream:diff)%C(reset)' --count 5 --sort='-committerdate'
> refs/heads
>
> To get output that's much more customizable 'git branch' output.  Future
> patches will attempt unify the semantics of 'git branch' and 'git
> for-each-ref'.
>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  So my evil plan is to keep extending this format until it's on par
>  with pretty-formats.  Then, we can move towards unifying 'git branch'
>  and 'git for-each-ref'.  This will involve deprecating badly
>  thought-out options like '-v', and replacing it with the more
>  powerful '--format'.
>
>  I just have one major doubt: in the above output, how do I align all
>  the upstream branches to the same column?  How can I achieve it with
>  pretty-formats?  Something like %*d?  But * is already taken to mean
>  deref in for-each-ref's --format.
>
>  By the way, the main motivation for all this comes from the fact that
>  git for-each-ref is very nicely written :) Look at how it breaks
>  everything up into atoms and lazily gets the information it needs to
>  display.

If you can put energy into this, I suggest you improve pretty.c a bit,
adding new format_ref_message(), similar to format_commit_message(),
except that it takes a ref. You can extend "struct
format_commit_context" to contain what "struct refinfo" does. I think
pretty.c only lacks a few specifiers that for-each-ref has. I think I
mentioned it in my for-each-ref series already, but we need to think
how to specify "align to the left with the best width" and how
format_ref_message() can figure the width out. A callback function
might do.
--
Duy
