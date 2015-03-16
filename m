From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: What is XDG_CONFIG_HOME for exactly?
Date: Mon, 16 Mar 2015 10:31:55 +0100
Message-ID: <vpqvbi1qodw.fsf@anie.imag.fr>
References: <CAHd499CmxwGJeW6gMARhc+cT+r3TK98m+LyyS+eCFXz8qKHrFw@mail.gmail.com>
	<CAHd499AGHgBECH9t_EtkwLx7VCx3yVnDS27PteF3zF1xSAG8Yg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git <git@vger.kernel.org>
To: Robert Dailey <rcdailey.lists@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 16 10:32:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXRNW-0003bQ-Ad
	for gcvg-git-2@plane.gmane.org; Mon, 16 Mar 2015 10:32:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753464AbbCPJcB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2015 05:32:01 -0400
Received: from mx1.imag.fr ([129.88.30.5]:37210 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752784AbbCPJcA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Mar 2015 05:32:00 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t2G9Vt7D012060
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 16 Mar 2015 10:31:55 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t2G9Vt2d025966;
	Mon, 16 Mar 2015 10:31:55 +0100
In-Reply-To: <CAHd499AGHgBECH9t_EtkwLx7VCx3yVnDS27PteF3zF1xSAG8Yg@mail.gmail.com>
	(Robert Dailey's message of "Sun, 15 Mar 2015 18:50:34 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 16 Mar 2015 10:31:55 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t2G9Vt7D012060
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1427103116.57858@TGgdpOPVgidiknFnL/iVMg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265553>

> On Sun, Mar 15, 2015 at 6:37 PM, Robert Dailey <rcdailey.lists@gmail.com> wrote:
>> My understanding is that git reads the priority of configuration as follows:
>>
>> 1. <local_repo>/.git/config
>> 2. $HOME/.gitconfig
>> 3. $XDG_CONFIG_HOME/git/config

$HOME/.gitconfig is the traditional Unix location for config files. It
was the only per-user config files in early versions of Git.

$XDG_CONFIG_HOME/git/config is the location following freedesktop's XDG
standard. It has several advantages (you can version and/or share
individual $XDG_CONFIG_HOME/git/ as a whole directory, while it's much
harder to version all ~/.git* files individually for example).

You typically want to use either one or the other.

>> 4. system level git config (not sure exactly where this is; not
>> relevant to me on Windows)

This is relevant if you use a shared machine and your sysadmin wants to
have the same configuration for all users.

> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Robert Dailey <rcdailey.lists@gmail.com> writes:

> As a follow-up, I tested the following in my .bashrc:
>
>
> # Utilize different GIT settings based on platform
> if [[ $OSTYPE == 'msys' || $OSTYPE == 'cygwin' ]]; then
>     echo 'Using WINDOWS specific git settings'
>     export XDG_CONFIG_HOME=.config-windows

You need an absolute directory here:

export XDG_CONFIG_HOME=$HOME/.config-windows

Then, I'd suggest that $XDG_CONFIG_HOME/git/config contains a

[include]
    path = ../../.config-shared/git/config

so that you can factor out common portions of your config file into
.config-shared/git/config and keep machine-specific portions in
~/.config-{windows,linux}.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
