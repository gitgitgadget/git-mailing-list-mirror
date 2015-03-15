From: Robert Dailey <rcdailey.lists@gmail.com>
Subject: Re: What is XDG_CONFIG_HOME for exactly?
Date: Sun, 15 Mar 2015 18:50:34 -0500
Message-ID: <CAHd499AGHgBECH9t_EtkwLx7VCx3yVnDS27PteF3zF1xSAG8Yg@mail.gmail.com>
References: <CAHd499CmxwGJeW6gMARhc+cT+r3TK98m+LyyS+eCFXz8qKHrFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 16 00:50:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXIIr-0005ZH-HV
	for gcvg-git-2@plane.gmane.org; Mon, 16 Mar 2015 00:50:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751889AbbCOXuf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Mar 2015 19:50:35 -0400
Received: from mail-ie0-f181.google.com ([209.85.223.181]:32892 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751477AbbCOXue (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Mar 2015 19:50:34 -0400
Received: by iecvj10 with SMTP id vj10so153762391iec.0
        for <git@vger.kernel.org>; Sun, 15 Mar 2015 16:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:content-type;
        bh=1081Zro5VRGCLK3IrwZ37iYxkg/7rydOTbQgwoBrlls=;
        b=gn/cEeuKoKxIKk3FvGTcBVoIPHskoqmKRtHh2m2W7kGtfj6TEKrzI6Tau9AH0aE5wJ
         C9VD+Gw+JJzAmdrImSS5sdxXJs8G+IgtIl/hV2ulTpDIbYkB/tMYI8fJCBMr8tHuv89Z
         f7NGPL3Afix9Z14jPoMuKTYnHcRiqBPC5yM/mNSOxL1WDUSVAMYBDZ3CSB4eDPwXMIjf
         iQAlupZBAGLFRyjvaUnRe1MlS2vEWtUXeiF2CwTfA8yJpkVIut9TFi/BFJC+Iw83Z0xG
         9vJeGKjd5iSw/9GmsHmFaUklGQYMuYx/z9NYo026hvVEGdhuit+rkac+zaILS4H36APJ
         vuWg==
X-Received: by 10.50.43.167 with SMTP id x7mr77899363igl.28.1426463434222;
 Sun, 15 Mar 2015 16:50:34 -0700 (PDT)
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.36.49.138 with HTTP; Sun, 15 Mar 2015 16:50:34 -0700 (PDT)
In-Reply-To: <CAHd499CmxwGJeW6gMARhc+cT+r3TK98m+LyyS+eCFXz8qKHrFw@mail.gmail.com>
X-Google-Sender-Auth: k1q10NnJ80aUGHzoYq0EssaO5ns
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265535>

As a follow-up, I tested the following in my .bashrc:


# Utilize different GIT settings based on platform
if [[ $OSTYPE == 'msys' || $OSTYPE == 'cygwin' ]]; then
    echo 'Using WINDOWS specific git settings'
    export XDG_CONFIG_HOME=.config-windows
else
    echo 'Using LINUX specific git settings'
    export XDG_CONFIG_HOME=.config-linux
fi


This seems to work nicely!! I share my $HOME directory (located in
dropbox) across all platforms so this helps me keep a consistent
environment across all my machines with zero effort.

On Sun, Mar 15, 2015 at 6:37 PM, Robert Dailey <rcdailey.lists@gmail.com> wrote:
> My understanding is that git reads the priority of configuration as follows:
>
> 1. <local_repo>/.git/config
> 2. $HOME/.gitconfig
> 3. $XDG_CONFIG_HOME/git/config
> 4. system level git config (not sure exactly where this is; not
> relevant to me on Windows)
>
> I have a .gitconfig in Dropbox that I symlink to my home directory on
> different platforms. Specifically, I share this gitconfig across
> Cygwin/msys on Windows and Ubuntu.
>
> If I can use XDG_CONFIG_HOME to leverage platform-specific settings,
> I'd be able to keep platform-agnostic settings in my $HOME/.gitconfig
> and put platform-specific settings in $XDG_CONFIG_HOME/git/config and
> simply give XDG_CONFIG_HOME a different name on different platforms.
>
> Is this what it was designed for? If not, what would be the best
> approach for this? I was thinking of contributing a patch that would
> let you specify the name of your git config in the home directory, but
> I'm not sure if that is necessary. Something like this:
>
> $HOME/$GIT_CONFIG_FILENAME, where GIT_CONFIG_FILENAME defaults to
> ".gitconfig" if it is not set or empty.
