From: Will Palmer <wmpalmer@gmail.com>
Subject: Re: [PATCH/RFC 0/9] add long forms for format placeholders
Date: Tue, 29 Mar 2011 07:44:32 +0100
Message-ID: <1301381072.2335.26.camel@dreddbeard>
References: <1301354251-23380-1-git-send-email-wmpalmer@gmail.com>
	 <7vei5qvkgw.fsf@alter.siamese.dyndns.org>
Reply-To: wmpalmer@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 29 08:44:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4SfT-000863-Br
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 08:44:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751871Ab1C2Goh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2011 02:44:37 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:55168 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751727Ab1C2Gog (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2011 02:44:36 -0400
Received: by wya21 with SMTP id 21so3473778wya.19
        for <git@vger.kernel.org>; Mon, 28 Mar 2011 23:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:subject:from:reply-to:to:cc:in-reply-to
         :references:content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=7hNOkMEasNzDj9MwJQtuqb6HncPDMSUoUOV6QU4eIVY=;
        b=O5gHXwDK1nkATWVp8d+kB93fOTHUrlL/5pBh7T9vupoxQw6sJnIC29iyYDxjDJOd5N
         TPiHaPTkWkL21bxf+3oDtRXx86sScal5zx+ZDyGpbVis+kQHG/HdmwrX7HafeqHCzwCA
         YeQBY2DdTgF4hzPsM80rw+ptKXs1UWQocZ8qo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=MtdOtYNWucBEc3DsF/vJbcqCFBgzO+e72J+12xVYuDJQM8LdY65C16zz2kgdEvaFTM
         YdMnx00qOpLPz9NgYeoHUD1h+98pelruO9PJExcbJ0FUgWN/69t/d4OoPnBBbwGtlUu+
         zm/GUhT+wR1RfUxkmkBmxRQkBla5EJSt3m7u4=
Received: by 10.227.153.152 with SMTP id k24mr4793842wbw.3.1301381075638;
        Mon, 28 Mar 2011 23:44:35 -0700 (PDT)
Received: from [192.168.0.129] (5acc3aad.bb.sky.com [90.204.58.173])
        by mx.google.com with ESMTPS id y29sm2361651wbd.4.2011.03.28.23.44.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 Mar 2011 23:44:34 -0700 (PDT)
In-Reply-To: <7vei5qvkgw.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 2.28.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170229>

On Mon, 2011-03-28 at 17:28 -0700, Junio C Hamano wrote:
> Will Palmer <wmpalmer@gmail.com> writes:
> 
> > I've been kicking around this series for a while now as part of a larger
> > effort of refactoring the pretty formats. A recent discussion on the
> > list has lead me to believe that this smaller subset may be of use
> > sooner, rather than later.
> >
> > This series attempts to add "long forms" for common format placeholders
> > in the "git log" family of commands, making the way for yet more
> > placeholders to be added without needing to worry too much about the
> > increasingly limited set of available one-letter mnemonics. It also
> > moves towards the possibility of eventual unification with the format
> > options in for-each-ref.
> 
> I don't claim that I read 1300+ long [PATCH 5/9] carefully, but I like the
> direction in which this topic is going very much.
> 
> Except that [PATCH 2/9] looked quite out of place---more like "I wanted to
> sneak this feature in" than "this was needed to keep the resulting code
> backward compatible" or anything like that.

just for context, we're talking about:
 [PATCH/RFC 2/9] add support for --date=unix to complement %at

I was warned that I should tweak that message!

This one is actually in there to make the later [PATCH 5/9] more
consistent in how it handled dates, as: {AUTHOR,COMMITTER}_DATE: <TYPE>,
rather than having a special case just for _UNIX.

When I added DATE_UNIX to the enum, gcc started complaining about
unhandled enum values in switch()es. To get around those (and noticing
that %at was the only format that wasn't available as a --date= switch)
--date=unix was added. It seemed like a good idea to move that change to
earlier in the series, rather than "sneaking it in" as part of [PATCH
5/9]

Of course, [PATCH 1/9] is only in there to make the documentation tweaks
in [PATCH 2/9] more readable.

> 
> Off the top of my head, I don't think of a reason to say that [PATCH 3/9]
> is going in a wrong direction---is there a reason to make you worried in
> the particular change?

 [PATCH/RFC 3/9] interpret %C(invalid) as we would %%C(invalid)

This one I was iffy on. On the one hand, it's inconsistent to treat
%C(invalid) any differently from %Z(doesn't even exist), but on the
other hand we lose feedback of telling the user why it's actually not
working as intended.

The real purpose of it was to prevent strange messages later on in the
larger series, which adds support for %(alias:<aliasname>). Seeing the
message "bad color value 'bkue' for variable '--pretty format'" when
what you actually typed was:
    commit %h%+(alias:mergeline)%+(alias:message)
could be confusing.

> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
-- Will
