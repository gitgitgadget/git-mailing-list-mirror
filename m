From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 3/4] attr.c::path_matches(): special case paths that end
 with a slash
Date: Wed, 27 Mar 2013 08:30:22 +0700
Message-ID: <CACsJy8A8QNaKUoMUYri6uUs56suerUZ5n48Q3VDD-=OcruBqww@mail.gmail.com>
References: <20130323083927.GA25600@sigill.intra.peff.net> <1364323171-20299-1-git-send-email-gitster@pobox.com>
 <1364323171-20299-4-git-send-email-gitster@pobox.com> <20130326190558.GC26462@sigill.intra.peff.net>
 <20130326213319.GA3058@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	avila.jn@gmail.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 27 02:31:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKfD0-0007dM-7q
	for gcvg-git-2@plane.gmane.org; Wed, 27 Mar 2013 02:31:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754276Ab3C0Bax (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Mar 2013 21:30:53 -0400
Received: from mail-oa0-f47.google.com ([209.85.219.47]:64197 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753281Ab3C0Bax (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Mar 2013 21:30:53 -0400
Received: by mail-oa0-f47.google.com with SMTP id o17so8224288oag.20
        for <git@vger.kernel.org>; Tue, 26 Mar 2013 18:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=XWXJoTVy7L+oaqEQl2H4a5EQeQ6gYjyFDhGFb2gvh2k=;
        b=RFRyL6Mky+dp6gVYTAXf45CVfLsJPqV3y2E1n+VRn1GWU7BJM7e1g2/cexJQkLrQO4
         fmhEU7UdSI3+hO3I03F8rtYlVTv2ZMetgRy708i9Tg3IEbqpfQ3027TQfl9NoIyBee9d
         sfxSwXVzNZksmYUMKkNDnQbfYFDDXk/oxsnYpTOI/rWbkfGdhurAGzBgHRDoZTDGFwpv
         FdceI/QDi7HkBSoSBg1mXC5IPOtrxsU7hhtdFXQ1+e1RjmnO7Drnz30CN0JGQvuhbzWM
         SAJeY7WMQUQX25f6zZRUlWGP1oSYjT/riQ4CbPLlKbE31NRbrR+/+WW3GxrM9zjLVuwq
         SjiA==
X-Received: by 10.182.8.70 with SMTP id p6mr3067165oba.90.1364347852599; Tue,
 26 Mar 2013 18:30:52 -0700 (PDT)
Received: by 10.76.27.137 with HTTP; Tue, 26 Mar 2013 18:30:22 -0700 (PDT)
In-Reply-To: <20130326213319.GA3058@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219233>

On Wed, Mar 27, 2013 at 4:33 AM, Jeff King <peff@peff.net> wrote:
> Hmm. match_pathname does have this:
>
>         /*
>          * baselen does not count the trailing slash. base[] may or
>          * may not end with a trailing slash though.
>          */
>         if (pathlen < baselen + 1 ||
>             (baselen && pathname[baselen] != '/') ||
>             strncmp_icase(pathname, base, baselen))
>                 return 0;
>
> which seems to imply that the trailing slash is important here, and that
> we should not drop it when passing the path to match_pathname. I'm
> still trying to figure out exactly what it is that the extra slash check
> is for, and whether it might not have the same problem.

The "may not end with a trailing slash" can only happen when baselen
== 0. And that rule is documented in code, at this line in
last_exclude_matching_from_list:

assert(x->baselen == 0 || x->base[x->baselen - 1] == '/');
-- 
Duy
