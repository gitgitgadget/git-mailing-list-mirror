From: Robert Dailey <rcdailey.lists@gmail.com>
Subject: Re: Re: Relative submodule URLs
Date: Tue, 19 Aug 2014 15:23:36 -0500
Message-ID: <CAHd499BvBBymACfHVZyuSXuNSFbT+M8my4uATOsn30w90Zb0QQ@mail.gmail.com>
References: <CAHd499CRNjp-UzXiTt=xgDJWGOEqew+AuPFmrF3-VsEGefXiuA@mail.gmail.com>
	<20140818205505.GA20185@google.com>
	<20140819102421.GA5012@book.hvoigt.net>
	<CAHd499CJfX_n_KnQScTFueCSkj6i0x0ozwwD8Oe_2a-VH2oq1w@mail.gmail.com>
	<xmqqiolowi1f.fsf@gitster.dls.corp.google.com>
	<CAHd499B9Wa=Y6P+OD8Ea-6dA4yZSkGZZSR9CwZAM45evDL_Qiw@mail.gmail.com>
	<20140819193010.GA64203@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git <git@vger.kernel.org>, Jens Lehmann <Jens.Lehmann@web.de>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Tue Aug 19 22:23:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJpwd-0002tA-Bn
	for gcvg-git-2@plane.gmane.org; Tue, 19 Aug 2014 22:23:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751891AbaHSUXi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2014 16:23:38 -0400
Received: from mail-vc0-f178.google.com ([209.85.220.178]:59295 "EHLO
	mail-vc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751190AbaHSUXh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2014 16:23:37 -0400
Received: by mail-vc0-f178.google.com with SMTP id la4so7967066vcb.23
        for <git@vger.kernel.org>; Tue, 19 Aug 2014 13:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=nFE3vthGslvLZPM6sGzZQH8/1cn12e05cWTUzc0D4rg=;
        b=OeVhIOE9G7va93ApSuoU+oljHneGSGqFdvG8ogYY3PyUrkA5ZbUuwG5pDIUJTkrzn6
         gk3owAENdOnmtE1LLGT0aFyCsYf9cBvO5tZlRPxlp2J4asSTYy0gOjmtEVwIfwCtIamV
         mD1wVhyqqcHMqO2DqrjtmFtUpbgevxGFqOOUABG5eS5pMwImJk9vMDA8Yv0O1Y7R7+dP
         3gFed7T8eZlkKkddsz3trb45szNtycio7WMqemHCj+HysY56c6d9RooVzrQ/DXUndqu0
         EKZtvjBD2SOVYmn+O5tJ9g0/qYvkiqHeSKQLne3BNreeAvzpZKDmnDpUSbfTF8TPxws0
         Ch9A==
X-Received: by 10.221.24.135 with SMTP id re7mr2583489vcb.53.1408479816693;
 Tue, 19 Aug 2014 13:23:36 -0700 (PDT)
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.220.102.201 with HTTP; Tue, 19 Aug 2014 13:23:36 -0700 (PDT)
In-Reply-To: <20140819193010.GA64203@book.hvoigt.net>
X-Google-Sender-Auth: Zn8YohzqQL1BY1GSxWRZmqa-5FE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255516>

On Tue, Aug 19, 2014 at 2:30 PM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> Well the remote for the submodule is currently only calculated once,
> when you do the initial
>
>         git submodule update --init
>
> that clones the submodule. Afterwards the fixed url is configured under
> the name 'origin' in the submodule like in a normal git repository that
> you have freshly cloned. Which remote is used for cloning depends on the
> configured remote for the current branch or 'origin'.
>
> When you do a fetch or push with --recurse-submodules it only executes a
> 'git fetch' or 'git push' without any specific remote. For fetch the
> same commandline options (but only the options) are passed on.
>
> Here it might make sense to guess the remote in the submodule somehow
> and not do what fetch without remotes would do.
>
> For the triangular workflow not much work has been done in regards to
> submodule support.
>
> But since a submodule behaves like a normal git repository maybe there
> is not much work needed and we can just point to the workflow without
> submodules most times. We still have to figure that out properly.

Maybe then the only thing we need is a --with-remote option for git
submodule? ::

git submodule update --init --with-remote myremote

The --with-remote option would be a NOOP if it's already initialized,
as you say. But I could create an alias for this as needed to make
sure it is always specified.

That way, just in case someone cloned with their fork (in which case
'origin' would not be pointing in the right place), they could tell it
to use `myremote`. This is really the only strange case to handle
right now (people that clone their forks instead of the actual
upstream/central repository).
