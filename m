From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 01/10] ref-filter: add %(refname:shortalign=X) option
Date: Mon, 13 Jul 2015 01:26:20 +0530
Message-ID: <CAOLa=ZThDcmM79hL0TUh6+8=NkQBWOWK=Ti+-v+2PCysquw-1w@mail.gmail.com>
References: <CAOLa=ZQyHwza6L9r6iFX1GkVrC+F-XNwegO=bGyxafjY3JoYpw@mail.gmail.com>
 <1436437671-25600-1-git-send-email-karthik.188@gmail.com> <xmqqk2u8kmre.fsf@gitster.dls.corp.google.com>
 <CAOLa=ZTNGV=NAXDPB3HX=fanPMQaQQc4ZpFdDFeg+LJ8SFuVOQ@mail.gmail.com>
 <CACsJy8BsLnkPFX04WujMdnBiRGmXacF1QSQudb3T8nxGrZ_1Fg@mail.gmail.com> <CACsJy8BL0ccxNYLE0gqBx5KTpqTOt=Ut6-k3fauxXNt2wpxSEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 12 21:56:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZENMu-0003ba-Pz
	for gcvg-git-2@plane.gmane.org; Sun, 12 Jul 2015 21:56:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751361AbbGLT4v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Jul 2015 15:56:51 -0400
Received: from mail-ob0-f182.google.com ([209.85.214.182]:34138 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751183AbbGLT4u (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jul 2015 15:56:50 -0400
Received: by obqd1 with SMTP id d1so3682148obq.1
        for <git@vger.kernel.org>; Sun, 12 Jul 2015 12:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=wpwWUlawWP8dl1LkaaAQfM/icGumo2B5whxJVBfmzuc=;
        b=H8AXio6r7smK2J/aUM7boUmuF34LxqKkblqkO7oFs02nsa82ZBz/SmDglN1WKqaSLx
         ko34uTjttOor0OJdkapOTpBUGq2/g1QKiwwl+FWdDIERN/yA3BDDQAjTj1daw0/2InIe
         e4J4V2EvH/zU+HeJToDf7uEDh+wFD2eZEd95Yg0A5iho4YVUpsLD123wkqDPTnS/itIl
         EfX9sNs4lxXXXW5Rrt0TmL/BBjZcLvtooaFgnoaZ3jPLZbopg6VCzxSuEROEzEXtFcAY
         1onwrodJySJQJiUPPj9dWQA7CcXAOXszxSKlobaxHvXtJvgd02FWU53NTPp9YMuVG9aS
         DFuQ==
X-Received: by 10.182.236.7 with SMTP id uq7mr27316132obc.42.1436731010013;
 Sun, 12 Jul 2015 12:56:50 -0700 (PDT)
Received: by 10.182.26.73 with HTTP; Sun, 12 Jul 2015 12:56:20 -0700 (PDT)
In-Reply-To: <CACsJy8BL0ccxNYLE0gqBx5KTpqTOt=Ut6-k3fauxXNt2wpxSEw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273903>

On Sun, Jul 12, 2015 at 7:17 AM, Duy Nguyen <pclouds@gmail.com> wrote:
>
> I guess if you can have multiple arguments after ':' in an atom, then
> you have wiggle room for future. But it looks like you only accept one
> argument after ':'.. (I only checked the version on 'pu'). Having an
> "alignment atom" to augment the real one (like %< changes the behavior
> of the next placeholder), could also work, but it adds dependency
> between atoms, something I don't think ref-filter.c is ready for.
>

I was thinking of something on the lines of having a function which right
before printing checks if any "align" option is given to the end of a given
item and aligns it accordingly, this ensures that any item which needs to
have such an option can easily do so.

https://github.com/KarthikNayak/git/commit/0284320483d6442a6425fc665e740f9f975654a1

This is what I came up with, you could have a look and let me know if
you have any
suggestions.

> Another thing, the atom value is also used for sorting. When used for
> sorting, I think these padding spaces should not be generated or it
> may confuse the sort algorithm. Left alignment may be ok, right or
> center alignment (in future?), not  so much. Perhaps we should do the
> padding in a separate phase, outside populate_value(). If you go this
> route, having separate atoms for alignment works better: you don't
> have to parse them in populate_value() which is for actual values, and
> you can handle dependency easily (I think).

This was cleared out in your other reply.

>
> By the way, please consider adding _() back to translatable strings,
> usually those die() or warn(), or "[ahead %s]"... In the last case,
> because you don't really know how long the string is after
> translation, avoid hard coding buffer size (to 40).

Yes, sure, maybe a cleanup patch at the end to do all of cleanup any
such use cases :)

Thanks for all the suggestions.

-- 
Regards,
Karthik Nayak
