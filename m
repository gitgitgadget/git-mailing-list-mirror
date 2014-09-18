From: Patrick Reynolds <piki@github.com>
Subject: Re: [PATCH] unblock and unignore SIGPIPE
Date: Thu, 18 Sep 2014 09:35:05 -0500
Message-ID: <CAJrMUs-68cNXdh1dbRbjGBdrT0hukR7DH=mf7v05EDjL7qzP-Q@mail.gmail.com>
References: <1408080565-33234-1-git-send-email-patrick.reynolds@github.com>
	<xmqqd2av1bsg.fsf@gitster.dls.corp.google.com>
	<20140917081148.GB16200@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Chris Packham <judge.packham@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 18 16:35:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XUcno-0008WC-Cs
	for gcvg-git-2@plane.gmane.org; Thu, 18 Sep 2014 16:35:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756666AbaIROfJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Sep 2014 10:35:09 -0400
Received: from mail-oi0-f51.google.com ([209.85.218.51]:35433 "EHLO
	mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756391AbaIROfF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Sep 2014 10:35:05 -0400
Received: by mail-oi0-f51.google.com with SMTP id x69so704610oia.24
        for <git@vger.kernel.org>; Thu, 18 Sep 2014 07:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=zpG9aT6y0ivBtab8/HjwlRbQwiOiONq9MkX5CSfnRow=;
        b=fvh3Qit7zqctnH8OFYdFaY8cX0LpCyQLrNl2cvR1rHUSBAZekrlJrx4AqcL96L95og
         7wgQwHoW4BP2YBZEDJeWvkTUE6+JuNHRq8sdUsiIj+NhfRgU0a6hdjGOztxqSa+CazmF
         7gM8fEkhB5wK2fwe3u3IwvwbN41j1xIJs2fMQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=zpG9aT6y0ivBtab8/HjwlRbQwiOiONq9MkX5CSfnRow=;
        b=SvsvRdRoRKj+964catNZtVF7v9rVBWUlc21VrahCaCvgzMFHJzZVz1cWvtFtDXAuoK
         FM8G4oC9cgITbB5tvIf2EVMwIE4trHfO4/C2dmvFzxMCE3gCi3JUzKQxocLJrzvZxy6U
         UltLgFBD51Q2oP8AieGaLZhyvCLa8ZJ+5ob8k/zOp2OrOiBwW1NlfE7MzgYHYyTmteeR
         gq6qZGoHFJl6KTkJ3h7vJ1xQm8CTf+p3W21QBA2BrnZIaYEgwP7s5Egy6+wBtKy72tdi
         XP7UgNtog721Zb2FHnL0i/KPtUrVD6zvktJGbg/RlcbfpZ/4ysTZdZ8PQBGptVi1Fhnp
         Mnog==
X-Gm-Message-State: ALoCoQkBMhefN4iYr8o+VNXBbxSK25QEYdJ0h0kOb982acpJDGNuoJkhD4q4TiPwY+ytTbHzSYA8
X-Received: by 10.60.99.104 with SMTP id ep8mr4824670oeb.38.1411050905136;
 Thu, 18 Sep 2014 07:35:05 -0700 (PDT)
Received: by 10.76.9.103 with HTTP; Thu, 18 Sep 2014 07:35:05 -0700 (PDT)
In-Reply-To: <20140917081148.GB16200@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257260>

On Wed, Sep 17, 2014 at 3:11 AM, Jeff King <peff@peff.net> wrote:
> Would we want to call it from external C commands, too? For the most
> part, git.c is the entry point for running git commands, and any
> sanitizing it does will be inherited by sub-commands. But it _is_ still
> legal to call dashed commands individually, and even required in some
> cases (e.g., git-upload-pack for ssh clients).

git-upload-pack is protected pretty well from SIGPIPE shenanigans,
because its stdout all goes through write_or_die, as of cdf4fb8.  We
did, long ago, have some EPIPE problems with upload-pack and SSH
clients, but it all predates cdf4fb8.

So I think it's redundant to unblock SIGPIPE in git-upload-pack.

I'll tidy up as Junio recommended, recheck the tests, and submit
an updated patch shortly.

--Patrick
