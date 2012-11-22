From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v5 15/15] fast-export: don't handle uninteresting refs
Date: Thu, 22 Nov 2012 01:15:45 +0100
Message-ID: <CAMP44s0Sd9V+GCqxid_rCwNH49-+dzmreg9zwPgxoZb1hQkb1A@mail.gmail.com>
References: <1352642392-28387-1-git-send-email-felipe.contreras@gmail.com>
	<1352642392-28387-16-git-send-email-felipe.contreras@gmail.com>
	<7vmwya3h0x.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Max Horn <max@quendi.de>, Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Pete Wyckoff <pw@padd.com>, Ben Walton <bdwalton@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Julian Phillips <julian@quantumfyre.co.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 22 21:34:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TbdTh-0003nF-MY
	for gcvg-git-2@plane.gmane.org; Thu, 22 Nov 2012 21:34:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754796Ab2KVUeM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2012 15:34:12 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:57955 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756741Ab2KVTZ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2012 14:25:57 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so8315918oag.19
        for <git@vger.kernel.org>; Thu, 22 Nov 2012 11:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=fT6CJlt8wyHWt/+JNEwHgd3I6zjtuQdh6/X68vsDG7U=;
        b=uJT9D1j3MmiFvXyac1MzenRyFnwTT79q+KsCVAHv9SS9wThHlnmIC8fQ1JiGBYNjM2
         PW4DF8aLSMAE0dh3gGFh97QaYNk33fjR1AggRZ7o35lEeJ+GDw8YNzFuIxySL+qxLQVp
         iQH0qoKK5+ZBE90FDj9BzGwOttMZZtgbk3ztSqkaZV86H9r10OtnRL84yTE4+aU5h19U
         u1yanqus9lDzsLu/cF5l7S594ThJFeSHl2O/ofKzMRA1SvpO1JTM6Mpd+Vwtrcv2Thk8
         YEsZqEdLkyNx3/d6yvUY+/pSSBaBp+pbRzB1o2Yd/M3gF/UmfVy2lgHY0luGfjZK2woQ
         m/Tg==
Received: by 10.60.31.6 with SMTP id w6mr1921930oeh.65.1353543345888; Wed, 21
 Nov 2012 16:15:45 -0800 (PST)
Received: by 10.60.32.196 with HTTP; Wed, 21 Nov 2012 16:15:45 -0800 (PST)
In-Reply-To: <7vmwya3h0x.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210210>

On Wed, Nov 21, 2012 at 7:14 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> They have been marked as UNINTERESTING for a reason, lets respect that.
>> ...
>> The current behavior is most certainly not what we want. After this
>> patch, nothing gets exported, because nothing was selected (everything
>> is UNINTERESTING).
>
> The old behaviour was an incorrect "workaround" that has been
> superseded by your 14/15 "make sure updated refs get updated", no?
> Mentioning that would help people realize that this patch would not
> cause regression on them, I would think.

This particular patch is not getting rid of that "workaround", if you
can call it that, it's just making it work correctly.

There's absolutely no possibility of regression (that is known or
anybody has mentioned).

The only argument that was put forward was that 'git fast-export
^master master' should throw:
from :0

As it does now, because in the future, with another patch (that nobody
is pursuing), it might do:
from 8c7a786

Which as I have tried to explain; is equally useless.

There's no regression, nobody would be affected negatively by this
because when there are no marks, nobody expects a 'from :0'; it's
totally useless, and when there are marks, nobody expects an update
when the user does '^uninteresting master' for the 'uninteresting'
ref. And not even potential future users would be affected, because
'from 8c7a786' is not helpful either, even if the user wanted
'^uninsteresting' to be updated (which they won't), the git SHA-1 is
useless to a remote helper without marks.

Cheers.

-- 
Felipe Contreras
