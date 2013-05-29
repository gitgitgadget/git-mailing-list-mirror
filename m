From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 0/3] Towards a useable git-branch
Date: Wed, 29 May 2013 10:22:57 +0700
Message-ID: <CACsJy8CyocXvjqM5BYgdnhYJPB8wyZ2+qcM9_7EU-WDmw+F5Qw@mail.gmail.com>
References: <1369405177-7855-1-git-send-email-artagnon@gmail.com>
 <CACsJy8AEkmiWP46tOBkXRkWDGO+k5YW+GJB-ak8HfTpghQP5eQ@mail.gmail.com>
 <CACsJy8Av8LmiefR5XFuFadZERmivZAAB9TbysFjeUSb2hzgWBw@mail.gmail.com>
 <CACsJy8CW-xtXR15m80oaoex0QF5Vi2L2-kqEzOPxCY2UBmdhxw@mail.gmail.com>
 <CALkWK0kb2D2nH_pDi0TihmFzuEAvWnGJeX0sOXD1TEWLZ7YWHw@mail.gmail.com> <CALkWK0k=2NZsbSnxS50w+bux8q9mZh7GZzpCqhTP=2jqyHnBSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 29 05:23:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhWz6-0008Mw-Bx
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 05:23:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759449Ab3E2DX2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 May 2013 23:23:28 -0400
Received: from mail-ob0-f170.google.com ([209.85.214.170]:56790 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759346Ab3E2DX1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 May 2013 23:23:27 -0400
Received: by mail-ob0-f170.google.com with SMTP id er7so10086118obc.29
        for <git@vger.kernel.org>; Tue, 28 May 2013 20:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=4Xylt/Mypg5e2I7SFygCP0xYLh9MjledaPuwiHCzQPo=;
        b=dJz+sGRWl8I6zEOsmhBz51Chvx0TMpYhz1CafyLCBI8hPgBNGa2VISjJ9xPaj8BMnU
         lG0WoNNLOw9TOpJkWniR1tqeQJfmUr3/7E7BYvuP/K1jNCi/SfJzzGAh34qcJPDd0bbL
         0kLOGNNLOlveOzWyWRmibwlCK7/jpIIo/5ruRHMK3fJRojUQBQN2z0rZhsKbgPUadT0q
         blaGPaG610vdXws/ixmoAhcB+STRNG03a8vY65bjfvjV+eMoZRKF6mrigapP9928RyCU
         9vwsSQOH1DF1L9qqTWiHIi4ZCfgi+8KG3uJWf4CSxncGbEaYoYxL7GRyflVhp4PQ4OwR
         tpWA==
X-Received: by 10.60.99.10 with SMTP id em10mr444414oeb.58.1369797807251; Tue,
 28 May 2013 20:23:27 -0700 (PDT)
Received: by 10.76.171.199 with HTTP; Tue, 28 May 2013 20:22:57 -0700 (PDT)
In-Reply-To: <CALkWK0k=2NZsbSnxS50w+bux8q9mZh7GZzpCqhTP=2jqyHnBSg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225711>

On Tue, May 28, 2013 at 9:01 PM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Also, a couple of minor annoyances:
>
> 1. When f-e-r is invoked with refs/tags, we get stray output.  Atleast
> it doesn't segfault, thanks to your ignore-commit patch.  Maybe
> printing stray output is the right thing to do, as opposed to erroring
> out.

What format did you use?

> 2. %>(*) only works with f-e-r atoms, not with pretty-format atoms.
> This is ofcourse obvious from the implementation, but isn't it a
> little consistent?

It is not. I think it's documented as well as a known implementation
limitation. It's not hard to be fixed (we could call
format_commit_message again for all entries, this time with a single
placeholder, to collect the best width). If anybody does need %>(*)%H
to work, we could do it. BTW, the way I implement get_atom_width() is
not really optimal. For n lines, we call print_value() in
get_atom_width n^2 times. We could cache the calculated width instead
and reduce that to n times.

> Should we start off a new pretty-ref-formats document, where we
> explicitly exclude things like %ae (because of the hex overriding
> thing)?  I don't think it's a problem if documented properly.

And this one is doucmented as well, I think. I'd really like to
introduce a new --pretty option (or something) that does not accept
%xx as a hex notion, so %ae and friends won't be hidden. It's also a
good thing for compatibility because currently %H in --format produces
%H. After this, %H produces something else. It's unlikely that anybody
has done that. But it's even better if we avoid that possibility
entirely with a new option.
--
Duy
