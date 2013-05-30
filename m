From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Should "git help" respect the 'pager' setting?
Date: Thu, 30 May 2013 22:26:36 +0530
Message-ID: <CALkWK0=RUy6=4k9uGpy2efdL8DhOnNO52rHZWSmHP3C=2a4SUw@mail.gmail.com>
References: <CAKtB=OCyoN8ECYiAzXc3UiCrLfWn7Pq7_5CSQUjJ2dhbzQ2RsQ@mail.gmail.com>
 <vpqtxlko1vn.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Campbell <michael.campbell@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu May 30 18:57:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ui6AD-0008W6-Gj
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 18:57:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758368Ab3E3Q5R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 May 2013 12:57:17 -0400
Received: from mail-ie0-f178.google.com ([209.85.223.178]:51318 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756144Ab3E3Q5Q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 May 2013 12:57:16 -0400
Received: by mail-ie0-f178.google.com with SMTP id f4so1224485iea.9
        for <git@vger.kernel.org>; Thu, 30 May 2013 09:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=+raO8VuE9HazsfklJSxYGDhb5vN4MaPCcOUiDLmx9F8=;
        b=Qf/nahqzbWuvaaagNsQi/7fMuzd2eX5WHIEez6QiYTpIX+L/X91M5WWVXECYuEA4xQ
         lPSUNiYBkVMIzHJimsCFu+OVuNiiWv2nngqKzqF5uQ9j1qrRmT0NsHbJdWY+ORMnlz3h
         7cXy3Jw0OvENboERzOHqO4W0rvZshG769gxG8t1XdTsFAo80fm1kdhTgxZWJmGfstOfe
         OS3E36gPCKFOFYKNGbqI7ikI7bLnVRqpS3L5410NXiO2KX3OXj8DQD9RvT7/SEhVP0h7
         2X5DY+fzMeJSWF0/3BdEuBjDyxebLr1zjFM8rIUCTSs2VJG2bDcR7bTCyvicF6UNNISp
         8pCg==
X-Received: by 10.42.76.132 with SMTP id e4mr3487971ick.11.1369933036440; Thu,
 30 May 2013 09:57:16 -0700 (PDT)
Received: by 10.64.226.135 with HTTP; Thu, 30 May 2013 09:56:36 -0700 (PDT)
In-Reply-To: <vpqtxlko1vn.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226023>

Matthieu Moy wrote:
> Michael Campbell <michael.campbell@gmail.com> writes:
>> I have my global git config pager set to 'cat', but when I do a "git
>> help <command>", it still uses a pager.  This is especially irksome in
>> emacs shell buffers, where I am most of the time.  I know I can do a
>> M-x man -> git-<whatever>, but wondered if this was a bug or user
>> error.  ("git --no-pager help <command>" does the same.)
>
> "git help foo" just calls "man git-foo" by default, so what happens is
> the same as if you called "man git-foo" by hand. Git does not have
> much control over what man will do, it could probably call "man -P
> $pager" when the Git pager is set, but I'd find it a bit weird.

It just needs to set $PAGER or $MANPAGER before the exec(), no?  I
would argue that it should do this.  $GIT_PAGER works everywhere else,
but obviously man has no knowledge about it.

> If you're an Emacs user, you can read about man.viewer and set it to
> woman, or set PAGER=cat when inside Emacs.

I just learnt about man.viewer.  There's a small problem with it
though: why is there no option for Emacs man corresponding to Emacs
woman?

> I personally run M-x git-foo RET, and never run "git help".

M-x man git-foo RET, you mean?  My style is slightly different: I love
typing out 'man git log' on the terminal (dashless); I get it to open
in an Emacs buffer using this hack:

function man_ () {
	emacsclient -e "(man \"$*\")" 2>&1 >/dev/null || man "$*"
}

alias man=man_
