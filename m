From: "rae l" <crquan@gmail.com>
Subject: Re: [PATCH] pretty format now configurable
Date: Sat, 1 Mar 2008 14:07:23 +0800
Message-ID: <91b13c310802292207j1b130077we11859bd20187226@mail.gmail.com>
References: <1204314263-8072-1-git-send-email-crquan@gmail.com>
	 <alpine.LFD.1.00.0802291155550.17889@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Mar 01 07:08:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVKt8-0003hg-Vg
	for gcvg-git-2@gmane.org; Sat, 01 Mar 2008 07:08:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753128AbYCAGH0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2008 01:07:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754342AbYCAGH0
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Mar 2008 01:07:26 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:47481 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752879AbYCAGHZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2008 01:07:25 -0500
Received: by ug-out-1314.google.com with SMTP id z38so705461ugc.16
        for <git@vger.kernel.org>; Fri, 29 Feb 2008 22:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=QQVLOG2DQvYbk2kIU+PKxYpiAJfNyZw5hZDwhxy5VQA=;
        b=G6FBi3xRGzkkphA1RevEdf5SQmnEL+NEp7wklfuYw64T1mhx8pJKP4wyU5lOOu9sR/lz1YbfWvF5w1mCq4hQxHiPS23RCL70bBI4TY2t1CaMNmhBkxTUHNO41GPbx7nqiKm24AoTdSSeJJTQ/cC5ZSPJO7cQfC4BNv14ryMI184=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YcILfjHzZIrZNyDVPdbTUIaRqSjT5jMxB9KEfmZs9Bc9RzZXqOjUwgMAbres+KZxfVDAYY2I252yTcSsXwme4rlWx5DxL5JQShQ8QWLIBLHHF7Uxl2XaGGKCIlSgYa5IGuDAgzdcBik3bwR36zEVNPWtnx0HxF7N+PScdW4qpYA=
Received: by 10.78.133.2 with SMTP id g2mr11235292hud.33.1204351643939;
        Fri, 29 Feb 2008 22:07:23 -0800 (PST)
Received: by 10.78.156.14 with HTTP; Fri, 29 Feb 2008 22:07:23 -0800 (PST)
In-Reply-To: <alpine.LFD.1.00.0802291155550.17889@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75623>

On Sat, Mar 1, 2008 at 4:00 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
>  On Sat, 1 Mar 2008, Denis Cheng wrote:
>  >
>  >       rev->abbrev = DEFAULT_ABBREV;
>  > -     rev->commit_format = CMIT_FMT_DEFAULT;
>  > +     if (fmt_pretty)
>  > +             rev->commit_format = get_commit_format(fmt_pretty);
>
>  Umm. Now it looks like commit_format isn't initialized at all if
>  fmt_pretty hasn't been set.
>
>  Now, it looks like it will have been initialized properly in
>  "init_revisions()", but your commit log doesn't mention that, so it was
>  harder to review this patch than necessary.
>
>  Also, can you describe what the background for this is? The reason I ask
>  is that if anybody ever sets that default commit format to anythign else,
>  it will now *seriously* confuse not just users but potentially other git
>  tools too (at least gitk uses "--pretty=raw", but who knows what other
>  tools/scripts are around that just expected the default format).
yes, rev->commit_format has been initialized to CMIT_FMT_DEFAULT in
"init_revisions()", so the code of this patch has been working well in
my local repo,

the "format.pretty" configuration's background is that I often use
"--pretty=fuller" on my command line, and different "format:..." on my
different local repos, I hope there is a configuration to store this
to gitconfig.

now git log/show/whathappened accept pretty format in the following sort:
1. rev->commit_format set to CMIT_FMT_DEFAULT in init_revisions;
2. call to gitconfig will set fmt_pretty properly;
3. set rev->commit_format according to fmt_pretty;
4. setup_revisions will accept "--pretty=" from the command line;

so the "--pretty=" precedence is:
1. the command line "--pretty=";
2. "format.pretty" from the gitconfig;
3. default CMIT_FMT_DEFAULT;

and indeed I need to  generate a new patch including comments of this
in the source and in Documentation/*.txt; I will soon send a new
patch.

>
>                 Linus
>

--
Denis Cheng
