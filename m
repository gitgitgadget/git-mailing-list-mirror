From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] index-pack: avoid excessive re-reading of pack directory
Date: Tue, 9 Jun 2015 20:46:24 -0700
Message-ID: <CAJo=hJv6O66yFC_O_4aeL2JxBOtk2f+k1wGt3VW7dk71Q1ov3A@mail.gmail.com>
References: <7FAE15F0A93C0144AD8B5FBD584E1C5519758FC3@C111KXTEMBX51.ERF.thomson.com>
 <CACsJy8AMhEKe-eM7jvYcEx+7ZmfvdD+p1s4VYHjKuAwZsDWc-w@mail.gmail.com>
 <CACsJy8Cs6GcRQ-kgnSqwxP4MPHfds9qiir1_O1hc5cZ+0QP-EA@mail.gmail.com>
 <7FAE15F0A93C0144AD8B5FBD584E1C5519759641@C111KXTEMBX51.ERF.thomson.com>
 <CACsJy8BULBJ=cL1+4TFX_7tYSCFL3MNEz1Ay0YGqx8W_8=nwAg@mail.gmail.com>
 <20150522071224.GA10734@peff.net> <CACsJy8Bb1O7QZtiPWdzYwYgOdV0dLDgD3Xu_YaWNUbsuTqJB5g@mail.gmail.com>
 <7FAE15F0A93C0144AD8B5FBD584E1C55197764FE@C111KXTEMBX51.ERF.thomson.com>
 <20150605121817.GA22125@peff.net> <20150605122921.GA7586@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: steve.norman@thomsonreuters.com,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 10 05:46:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2Wya-0003Uo-Hc
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jun 2015 05:46:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753280AbbFJDqr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2015 23:46:47 -0400
Received: from mail-wi0-f179.google.com ([209.85.212.179]:36055 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752246AbbFJDqq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2015 23:46:46 -0400
Received: by wigg3 with SMTP id g3so34513495wig.1
        for <git@vger.kernel.org>; Tue, 09 Jun 2015 20:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=LFWnh6Z4JUROlKedzg8mhXgRJFCHg0Zl9PZkSl/8qKM=;
        b=QsC7OkDTjP+bFKQEIklVPk6rbwCoG3GD9kyWkuc4WbjEyKHhgwvJBJASAvi3ha6GrX
         GJ5QXSLLXnZpNkrZK15htga825UXoJxBlAsNR1iYeOXfwxq+S9iuGC+30NzaE8r4jutI
         KL3RJxOnZpZDY5Ypply4exKwAKdFILTPVhkJA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=LFWnh6Z4JUROlKedzg8mhXgRJFCHg0Zl9PZkSl/8qKM=;
        b=ZW7fnMI1GjMhN5tb9MwvZdkmRQMJo6dDFEF2qfuYeJNgf62/AsYh2urH1lF8z0vHCu
         0tqV8oZzcdvSdsK7TpgucR8WM444v7kbiciahHl3xAc6UakzYt2DwlKWBlp6d7yST0D1
         vm2tne9Fm9gS8mp1YrXqYQAA6V2PUZo9QjxtOCW4YH1aRUpxzyVDSRNn5mQk6iJPf7XD
         k3wXHL74DzjTehWutPe9Mn9x/hhYTToz0sLOm/Sy4tVPs21Jq/nW4d2q+uAyIzeGEqRu
         qBbpZu6S58R8Y2lcXuupSPgIcGTkp36RTfksEVHcs3B0atAEkiUspQuQOMsFuQ4swpaE
         H3gw==
X-Gm-Message-State: ALoCoQlODzwNe8ldw/7kLUCOuoUWlChlSXae7/OvFR7aKKWhde3gd/CIn9s6F3wCmDgfIsDEc//1
X-Received: by 10.180.198.199 with SMTP id je7mr3908842wic.34.1433908004981;
 Tue, 09 Jun 2015 20:46:44 -0700 (PDT)
Received: by 10.28.49.134 with HTTP; Tue, 9 Jun 2015 20:46:24 -0700 (PDT)
In-Reply-To: <20150605122921.GA7586@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271254>

On Fri, Jun 5, 2015 at 5:29 AM, Jeff King <peff@peff.net> wrote:
>
> However, some code paths make a large number of
> has_sha1_file checks which are _not_ expected to return 1.
> The collision test in index-pack.c is such a case. On a
> local system, this can cause a performance slowdown of
> around 5%. But on a system with high-latency system calls
> (like NFS), it can be much worse.
>
> This patch introduces a "quick" flag to has_sha1_file which
> callers can use when they would prefer high performance at
> the cost of false negatives during repacks. There may be
> other code paths that can use this, but the index-pack one
> is the most obviously critical, so we'll start with
> switching that one.

Hilarious. We did this in JGit back in ... uhm before 2009. :)

But its Java. So of course we had to do optimizations.


> @@ -3169,6 +3169,8 @@ int has_sha1_file(const unsigned char *sha1)
>                 return 1;
>         if (has_loose_object(sha1))
>                 return 1;
> +       if (flags & HAS_SHA1_QUICK)
> +               return 0;
>         reprepare_packed_git();
>         return find_pack_entry(sha1, &e);

Something else we do is readdir() over the loose objects and store
them in a map in memory. That way we avoid stat() calls during that
has_loose_object() path. This is apparently a win enough of the time
that we always do that when receiving a pack over the wire (client or
server).
