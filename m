From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 3/5] diff: acknowledge --submodule=short command-line option
Date: Sun, 7 Oct 2012 20:52:05 +0530
Message-ID: <CALkWK0mbQZjYUR73rdFP2BtOzdL9gQqxnC5fjtsCYq2F29=8qg@mail.gmail.com>
References: <1349196670-2844-1-git-send-email-artagnon@gmail.com>
 <1349196670-2844-4-git-send-email-artagnon@gmail.com> <506B3F74.3020208@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sun Oct 07 17:29:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TKsms-0007yu-M6
	for gcvg-git-2@plane.gmane.org; Sun, 07 Oct 2012 17:29:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753326Ab2JGPW1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2012 11:22:27 -0400
Received: from mail-qc0-f180.google.com ([209.85.216.180]:39578 "EHLO
	mail-qc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753308Ab2JGPW0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2012 11:22:26 -0400
Received: by mail-qc0-f180.google.com with SMTP id v28so2253410qcm.11
        for <git@vger.kernel.org>; Sun, 07 Oct 2012 08:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=T06lB+fQSv71DR7rR10yOKF5rNbr5g+/yaQ+dKbQNlY=;
        b=tR1ezjl36e01Qx+bt4In/gcLZGfF0zFjxc7pmOAoIoKiu1oLsvLwKzfeMrPWOvW8LK
         5jS4eI4KALOZGmHrws4wC3wKfk/xs5emjNjXRiZWZ05DRARMFlTcTX1xlEX6vm+HzoOb
         GisskCYxTjQE5wVwhU3XD/nzUE+SCR2nXaVBGq9STmZslsWROMXzAfZXvphbdS3Vf29N
         mpfhN8/Jm1cgXneqEzHkfBtq5d6kDbMOGkdy9n16bDiw06ZR2mf5t96+WEF8iaU3xYMh
         IsSDvTZbQeIRy4iYCix5kUSs/2T2Dc01V09w0ueiGkvUheCtZoW3pVbdBuV1tnRDi4MI
         2hDQ==
Received: by 10.49.48.111 with SMTP id k15mr36439084qen.28.1349623345685; Sun,
 07 Oct 2012 08:22:25 -0700 (PDT)
Received: by 10.49.84.105 with HTTP; Sun, 7 Oct 2012 08:22:05 -0700 (PDT)
In-Reply-To: <506B3F74.3020208@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207181>

Jens Lehmann wrote:
> Am 02.10.2012 18:51, schrieb Ramkumar Ramachandra:
>> Currently, the diff code does not differentiate between an explicit
>> '--submodule=short' being passed, and no submodule option being passed
>> on the command line.  Making this differentiation will be important
>> when the command-line option can be used to override a
>> "diff.submoduleFormat" configuration variable introduced in the next
>> patch.
>
> Wouldn't it be sufficient here to simply reset the log flag by using
> "DIFF_OPT_CLR(options, SUBMODULE_LOG)"? This would avoid having to
> use the last bit of the diffopt flags. And if I read the code correctly,
> diff_opt_parse() is called by setup_revisions() which is called after
> git_config(), so that should be safe. (And "textconv" uses the same
> approach)

How is it sufficient?  In git_diff_ui_config(), I set
submodule_format_cfg, which has nothing to do with SUBMODULE_LOG.  In
builtin_diff(), I'll have to check SUBMODULE_LOG and
submodule_format_cfg.  The tricky bit is that I should check
submodule_format_cfg if and only if "--submodule=short" was NOT passed
on the command line-  now, that's not the same thing is checking if
SUBMODULE_LOG is unset, because SUBMODULE_LOG is unset (or cleared) if
no argument was passed or if "--submodule=short" is passed.
Therefore, I need a SUBMODULE_SHORT to differentiate between the two
cases.

What am I missing?

Ram
