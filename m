From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [BUG] git_path() returns relative paths
Date: Sat, 27 Jul 2013 21:35:40 +0530
Message-ID: <CALkWK0=xuNGM54=Kodfi9L8_yUOaXrWvqiMHbx2SRTH1CmZxLA@mail.gmail.com>
References: <CALkWK0m-4wtpTAcePPWFLT7iwXdcpp+nOy9oG2iFHLsp9XdKZQ@mail.gmail.com>
 <CALkWK0k-23rTohYvNWP_XbuUCSGUE+G_e_7cBbPP5C9OzsJ4XQ@mail.gmail.com>
 <CALkWK0kBesC2=kyygMCt61Fm5GGqX+yF6sbkCRcGYZ=ovgtTAQ@mail.gmail.com>
 <CACsJy8C5Du8zcqVeN7EGuyUxgSZaRq-X8y_hQvqQedYWfP8p+A@mail.gmail.com>
 <CALkWK0kWnge7fVtTXRgTiK1NbyN8X=bmqfPTc+Mp=BCssPc1og@mail.gmail.com> <CACsJy8CDg2ORKrpwiph=WdW5GPUYEwT1CSCttQ4fagQoMP4QGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Xin Jiang <worldhello.net@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 27 18:06:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V3711-0000RP-OI
	for gcvg-git-2@plane.gmane.org; Sat, 27 Jul 2013 18:06:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752297Ab3G0QGX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Jul 2013 12:06:23 -0400
Received: from mail-oa0-f52.google.com ([209.85.219.52]:44778 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752276Ab3G0QGW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jul 2013 12:06:22 -0400
Received: by mail-oa0-f52.google.com with SMTP id g12so9785837oah.39
        for <git@vger.kernel.org>; Sat, 27 Jul 2013 09:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=9py8CvodaFOAdT0gQYMVjBnqXm2xG7st1FOM2tarJqA=;
        b=aO64U2uyGsckVl9ipGVcbb5qRtR74e8II8f6z7qc4Ei1+2J1/fvRafLPLC7w0i5MWS
         tNTjjaI2lQZxlQM54oiseulifc25J+ykZZVO0GgiG4RzIYCFCYGC08G0aWuEIOXvDoHd
         8lklMhFViZw1ehQkN5FfC0CCLRiFXj4zG8XKT9bLSdg6hiJ0C9m9477q7ig3GL/HQt8C
         /w+DV1gFZM4PTvdCgqUvcizfD6xz0p+VT7uc8/UpkPF8PzMR7JjKlTaRR6D53hLsmWpV
         AXEjqFj11WIRnvIhs3ES1cFrEKbDGVSohuM/tB3eeFUKq/iSZ45QIg2kpEYgJuCOs0YN
         kcOQ==
X-Received: by 10.43.15.68 with SMTP id pt4mr21095374icb.35.1374941181604;
 Sat, 27 Jul 2013 09:06:21 -0700 (PDT)
Received: by 10.64.37.130 with HTTP; Sat, 27 Jul 2013 09:05:40 -0700 (PDT)
In-Reply-To: <CACsJy8CDg2ORKrpwiph=WdW5GPUYEwT1CSCttQ4fagQoMP4QGA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231249>

Duy Nguyen wrote:
> I was involved with this code (the gitdir setup code, not submodule)
> and am interested to know what's going on too. Could you produce a
> small script to reproduce it?

Here's your reduced testcase. Just point mygit to a HEAD build.

  #!/bin/sh

  mygit=~/src/git/git
  cd /tmp
  $mygit clone https://github.com/artagnon/clayoven
  cd clayoven
  $mygit submodule add https://github.com/lewang/flx .elisp/flx
  $mygit commit -a -m "Added submodule"
  cd /tmp
  ln -s clayoven/.elisp
  cd .elisp/flx
  EDITOR="emacs -Q" git commit --amend
  # buffer-file-name = "/tmp/.git/modules/.elisp/flx/COMMIT_EDITMSG"

Note that this is emacs 24.3. I used -Q to make sure that none of my
init magic (magit etc.) was responsible for changing directories or
doing something equally stupid. However, considering that it's
impossible to reproduce the problem with either cat or vim as the
EDITOR, you might be inclined to classify this as an Emacs bug. In
that case, why can't I reproduce it without submodules?

I'm going off to eat cake before I tear my hair out in frustration.
