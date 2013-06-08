From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 2/2] Move sequencer to builtin
Date: Sat, 8 Jun 2013 19:04:17 +0530
Message-ID: <CALkWK0mw8=CMuyw5-E0fzh+c6Om_NCgHohqa_p=J_kw3UfJCJQ@mail.gmail.com>
References: <1370643409-3431-1-git-send-email-felipe.contreras@gmail.com>
 <1370643409-3431-3-git-send-email-felipe.contreras@gmail.com>
 <CACsJy8AMMCWSFC6EUHAgZdDA7E1kSPE3ZO6qGvS+WGji-di=Rw@mail.gmail.com>
 <CAMP44s29GiGJq3wyXAzJNo0FJY+Vbgd18bpBJMYQ47h-3M6sWA@mail.gmail.com>
 <CACsJy8A-qc0tHcsp5=syxv_7FjixahU7fGcZuUV=cGn_-qyWwg@mail.gmail.com>
 <CAMP44s2fP4_=HtOsuwmxXG8qmp8CmpgEhz=BJFOFZxsTf_3gcQ@mail.gmail.com>
 <CACsJy8CQRWU0mFLVD6RrpzJiHBH=9zFwf5xDo7UhGW6A-OAzuw@mail.gmail.com>
 <CALkWK0mLoeO5fKezE5S1LEC2LNH9qCwxHnNi_ZJpYzC7rVTqmg@mail.gmail.com> <CACsJy8B=m95mpRn1dAwQZAvHRUeJVjKy1hKXv43EKX08ZODsDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <drafnel@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Shawn Pearce <sop@google.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 08 15:35:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlJIM-0002xF-Ry
	for gcvg-git-2@plane.gmane.org; Sat, 08 Jun 2013 15:35:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751673Ab3FHNe6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Jun 2013 09:34:58 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:35043 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751541Ab3FHNe5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jun 2013 09:34:57 -0400
Received: by mail-ie0-f171.google.com with SMTP id s9so13085775iec.16
        for <git@vger.kernel.org>; Sat, 08 Jun 2013 06:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=24qBGVMkb8IttLNasLNaIWgSX1DFzLGDSa1daR+HvQ4=;
        b=R/t7vhZVGCdF7fcpyHWsJ98O+aXeFggsFHBLeF9S+dSoMD+hrogq6mNHhAyQPa6JXU
         eCKvf0GeXPMsinlG/EtJvMym9Ikrcv5Y1sCPH/Jr9wkFT77zJr5Jonbi7+snVKjLjBFn
         Uy9mx6cbBVUKaNMEtzQMHmo/1VOj2+Kt1Mw1ty2xtbvvbvg0+qO64sRCXhH34AMAr38M
         /tc0r3gxqH0JEPLTUXgsLVP4K6MHoa+JnWqqEyuGmJ9fR8f+W/O7R1NCYUnhxNLYU7RW
         9NksucBIEvO7iVCJM0NRtPzm6k/tFYp0pHdf0PFA33r9sbcNhZiG93Mxmo8gmgFsntz+
         j7sQ==
X-Received: by 10.42.135.5 with SMTP id n5mr1188256ict.14.1370698497441; Sat,
 08 Jun 2013 06:34:57 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Sat, 8 Jun 2013 06:34:17 -0700 (PDT)
In-Reply-To: <CACsJy8B=m95mpRn1dAwQZAvHRUeJVjKy1hKXv43EKX08ZODsDw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226821>

Duy Nguyen wrote:
> I _think_ the reason is because git was never written as a reusable
> library in mind from the beginning.

We cannot reverse-engineer intents, but I tend to agree with this.  My
question is: so what?  Is it impossible to do now?

> So global states and die() exist.
> Worse, "run once and let the OS clean eveything up at process exit"
> leads to some deliberate memory leak if it's made a library. See
> alloc.c for example. The internal API is not really designed to be
> usuable/stable as a library. All of these made it very hard to convert
> the current code base into a true library. So the effort was put into
> creating a new library instead, copying code from git code base over
> when possible.

I'm not saying that we can convert libgit.a into something that's
usable as a long-running process by production servers tomorrow.  All
I'm saying is that it might be possible to get ruby (and possibly
other languages) to call into git-core, to make scripting more sane
than shell-spawning everything like brutes.  I think this is what fc
is aiming at, atleast in the foreseeable future.

As far as long-running server-side implementations go, I think jgit is
the way forward (sop is more interested in that now, I believe).
libgit2 might work for GitHub now, but I don't know if they will be
forced to move to the jvm in the future.

> So instead of redoing it again, I think it's better that you help
> libgit2 guys improve it to the extend that git commands can be easily
> reimplemented. Then bring up the discussion about using libgit2 in C
> Git again.

Please look at the code in libgit2.git briefly.  It's _very_ different
from git.git, and the amount of glue code that would be needed to
piece them together is unfathomable.

There are no git.git contributors committing to libgit2.git, or
vice-versa.  libgit2 is primarily developed by vmg, cmn, and (more
recently) rb.  It's quite an active project that's diverging from the
git.git design with every passing day.
