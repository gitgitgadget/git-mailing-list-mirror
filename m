From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCHv1] git-p4: workaround p4 removal of client directory
Date: Fri, 29 Apr 2016 08:39:27 +0100
Message-ID: <CAE5ih78yvMe2MLqE6+KOnPUd+D_0-cO5-LY2WsbjfMmTMqBK9w@mail.gmail.com>
References: <1461915626-10250-1-git-send-email-luke@diamand.org>
	<1461915626-10250-2-git-send-email-luke@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Lars Schneider <larsxschneider@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Luke Diamand <luke@diamand.org>,
	Jacob Smith <jaroslov@gmail.com>
To: Git Users <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 29 09:39:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aw31W-0005Vx-1k
	for gcvg-git-2@plane.gmane.org; Fri, 29 Apr 2016 09:39:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752191AbcD2Hj3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 03:39:29 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:33658 "EHLO
	mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750760AbcD2Hj2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 03:39:28 -0400
Received: by mail-oi0-f67.google.com with SMTP id f63so17408750oig.0
        for <git@vger.kernel.org>; Fri, 29 Apr 2016 00:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=8xNcuoxAqIe4x0S4mhHrrNXOxiJKhDGYNmZjoPHx8rQ=;
        b=KGe7fpt133PyGKYff8nwul6xgEixgzSPmmnH9zz2TJmPW/5U85pqoOPROXlsJEqRyD
         b9b9Y/RYxmobXideCgPKgfYMv47pptsgLBb4SbMdM7XirMz/wNEp7YyZ7Sp7VrGiJSpe
         tKtXr2hZmW584RQpBjG5/0b3gNIGDWL395s2Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=8xNcuoxAqIe4x0S4mhHrrNXOxiJKhDGYNmZjoPHx8rQ=;
        b=LDxrqYQaObn0u/w+Yk4UxHNX82eP4FaaEoFvLM/jhdR9usOQ8QeKM3tnXJTbDLwBv5
         OeM3J5HmiMIzUbK3kv4Z2OF58QglC5u1YvW8xLlMxxgjaBHvWm2xGqEBzSPv9lRrxkWl
         qmOD3OgN3pMlXAmsd30iKyRz8499Aw5A+PFxyzAuENYMEITRAMNcuSqfDyxVc/bBYuqo
         rlNJzzjJLh9aJL+C5RToGf5mxn36FcaTvTORE1DkY37TkTYkem87y/2HbSO5YA7Vnf4h
         CxHUTZUSmaNv0VrZdNNmSv686NgC/Hu0zaZx0Vcxb0JsZhBE9ezYErLAjgIYlw4FjkUJ
         4w+A==
X-Gm-Message-State: AOPr4FUT1t/N6ZxW0ltMvv8MCJQN0oQxcEWympK+rc4Q/q0wUIrsx7wUF7U1VaMMyoPoVGQa7NhXoho3MtbGCQ==
X-Received: by 10.157.32.114 with SMTP id n105mr9127599ota.108.1461915567353;
 Fri, 29 Apr 2016 00:39:27 -0700 (PDT)
Received: by 10.157.37.88 with HTTP; Fri, 29 Apr 2016 00:39:27 -0700 (PDT)
In-Reply-To: <1461915626-10250-2-git-send-email-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292977>

Adding correct email for Jacob.

On 29 April 2016 at 08:40, Luke Diamand <luke@diamand.org> wrote:
> On some platforms, "p4 sync -f" will remove the workspace
> directory after we have just created it; on some it won't.
> This causes problems later when git finds itself in an
> orphaned directory.
>
> Workaround this by cd'ing back to the directory after
> the "p4 sync -f".
>
> Signed-off-by: Luke Diamand <luke@diamand.org>
> ---
>  git-p4.py | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/git-p4.py b/git-p4.py
> index 527d44b..2b75a61 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -1,4 +1,4 @@
> -#!/usr/bin/env python
> +#!/usr/bin/env python2
>  #
>  # git-p4.py -- A tool for bidirectional operation between a Perforce depot and git.
>  #
> @@ -1956,6 +1956,9 @@ class P4Submit(Command, P4UserMap):
>              if new_client_dir:
>                  # old one was destroyed, and maybe nobody told p4
>                  p4_sync("...", "-f")
> +
> +                # sometimes p4 will unlink the directory and recreate it
> +                chdir(self.clientPath, is_client_path=True)
>              else:
>                  p4_sync("...")
>          self.check()
> --
> 2.8.1.218.gd2cea43.dirty
>
