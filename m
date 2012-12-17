From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] log --format: teach %C(auto,black) to paint it black only
 on terminals
Date: Mon, 17 Dec 2012 18:44:10 +0700
Message-ID: <CACsJy8Dt4vEpO+EcAhWnko=XAajQ9OMgbDbVx78Eb=sZTjmKQA@mail.gmail.com>
References: <72BB37CB88C48F4B925365539F1EE46C182613A9@icexch-m3.ic.ac.uk>
 <72BB37CB88C48F4B925365539F1EE46C18261403@icexch-m3.ic.ac.uk>
 <20121213131329.GA5042@sigill.intra.peff.net> <CACsJy8AgtwtJfMXzArJLiHQtR+WNRJxRdRgUts30EN-QvgGT=g@mail.gmail.com>
 <20121215101659.GB21577@sigill.intra.peff.net> <7v7gojtbgr.fsf@alter.siamese.dyndns.org>
 <7vobhtm5pk.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"Srb, Michal" <michal.srb11@imperial.ac.uk>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 17 12:44:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TkZ7y-0004Ta-Cj
	for gcvg-git-2@plane.gmane.org; Mon, 17 Dec 2012 12:44:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752289Ab2LQLol (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2012 06:44:41 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:54406 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752154Ab2LQLol (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2012 06:44:41 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so5789391oag.19
        for <git@vger.kernel.org>; Mon, 17 Dec 2012 03:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=RbinFbUj2X3ei5OXR2ZI5VSPr9IoiEoFoswUC0Ozn1Q=;
        b=lQEZCfXxReIeWUhoY0yEN1YkbV3xzn1uFwfXn/BmdZx7gsptoxFnrP1FWLSD/WaYcY
         AdAggYAKBT3vVQtkszZClhjkX1F4D/IFdWqCkCLkJUtgb0dhDUf1J8z5d6I/kWpySlM3
         c0sXaSONO3O9Al0TxLza60pdxKx/C6P2+ww2JJnfwsNrndvsz0s+05XDPf6jOPOfQa3/
         KGVC+E4gO36TR+h8FfYJ/Bm8CmIjGFhfMXd5F15yMLBkKjdF7kjtLU5Y+jeQzvP3FDAS
         YkhYxT2HqfLkjf3BeqJahiXmh5VRlZ0iaGVDMXayFjfj1C6qsPw5973YxVvacnc0ymyk
         MAjQ==
Received: by 10.60.30.70 with SMTP id q6mr11224713oeh.107.1355744680443; Mon,
 17 Dec 2012 03:44:40 -0800 (PST)
Received: by 10.182.27.168 with HTTP; Mon, 17 Dec 2012 03:44:10 -0800 (PST)
In-Reply-To: <7vobhtm5pk.fsf_-_@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211678>

On Mon, Dec 17, 2012 at 3:40 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Traditionally, %C(color attr) always emitted the ANSI color
> sequence; it was up to the scripts that wanted to conditionally
> color their output to omit %C(...) specifier when they do not want
> colors.
>
> Optionally allow "auto," to be prefixed to the color, so that the
> output is colored iff it goes to the terminal.

I see "prefix" is clearly documented. Still it feels a bit unnatural
that %C(red,auto) won't work. But we can make that case work later if
somebody cares enough.

>                         if (!end)
>                                 return 0;
> -                       color_parse_mem(placeholder + 2,
> -                                       end - (placeholder + 2),
> +                       if (!memcmp(begin, "auto,", 5)) {
> +                               if (!want_color(-1))
> +                                       return end - placeholder + 1;

This want_color() checks color.ui and only when color.ui = auto, it
bothers to check if the output is tty. I think the document should say
that "auto," (or maybe another name because it's not really auto)
respects color.ui.
-- 
Duy
