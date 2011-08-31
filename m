From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Clean termination of remote-helpers (was Re: [PATCH 2/2] Add a
 remote helper to interact with mediawiki (fetch & push))
Date: Wed, 31 Aug 2011 15:25:53 +0200
Message-ID: <CAGdFq_gSpFm8D1qHs5smUgsqyZXRjw73QFCCkBjTi0n4pwzmHA@mail.gmail.com>
References: <1314378689-8997-1-git-send-email-Matthieu.Moy@imag.fr>
 <1314378689-8997-2-git-send-email-Matthieu.Moy@imag.fr> <vpqd3flzrow.fsf_-_@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, gitster@pobox.com,
	Jeremie Nikaes <jeremie.nikaes@ensimag.imag.fr>,
	Arnaud Lacurie <arnaud.lacurie@ensimag.imag.fr>,
	Claire Fousse <claire.fousse@ensimag.imag.fr>,
	David Amouyal <david.amouyal@ensimag.imag.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Aug 31 15:27:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qykp1-0006Ru-0k
	for gcvg-git-2@lo.gmane.org; Wed, 31 Aug 2011 15:27:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755867Ab1HaN0j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Aug 2011 09:26:39 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:43512 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755436Ab1HaN0f (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Aug 2011 09:26:35 -0400
Received: by gxk21 with SMTP id 21so531841gxk.19
        for <git@vger.kernel.org>; Wed, 31 Aug 2011 06:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=M+70m6R7dpdSlqlyKtv9oH0RAc72DAUXB57NSaaaRiE=;
        b=bO9sFaI45vd2qp3aPfE4olNRIcU3Rnh8va7VJ1fkNOfa84bAiBJFJ0dHlCbEbVXVOO
         GX0YsPGdE68ZPk0G6ssrb75mj491DuN7PWwLg0l/BySpfbdYuSWefG5x6qwHjiUZpYJi
         wIPZ/iy0qFMW1pwqwx7l8kTGVak7sBhN+kNUA=
Received: by 10.68.157.230 with SMTP id wp6mr510227pbb.428.1314797193303; Wed,
 31 Aug 2011 06:26:33 -0700 (PDT)
Received: by 10.68.55.7 with HTTP; Wed, 31 Aug 2011 06:25:53 -0700 (PDT)
In-Reply-To: <vpqd3flzrow.fsf_-_@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180469>

Heya,

On Wed, Aug 31, 2011 at 14:33, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> I was expecting this part to be more controversial, so I'm just
> repeating it to draw more attention ;-).

Eek! :)

> # Inform Git that we're done, otherwise Git won't close it's stdin,
> # and the next loop will be infinite.
> close(STDOUT);
> # Flush stdin before we terminate. If we don't, git fetch
> # (transport-helper.c's sendline function) will try to write to our
> # stdin, which may be closed, and git fetch will be killed. That's
> # probably a bug in transport-helper.c, but in the meantime ...
> while (<STDIN>) {};

Is this caused by you not reading the terminating '\n' that git sends
when all commands are done? We previously didn't do this for imports
(we couldn't, hence the new import/done behavior), so perhaps you just
need to fix that? It's entirely possible you've found a bug though.

-- 
Cheers,

Sverre Rabbelier
