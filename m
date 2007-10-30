From: Lars Knoll <lars@trolltech.com>
Subject: Re: [PATCH] Speedup scanning for excluded files.
Date: Tue, 30 Oct 2007 09:28:49 +0200
Organization: Trolltech
Message-ID: <200710300828.49840.lars@trolltech.com>
References: <200710290845.26727.lars@trolltech.com> <118833cc0710291559kbd874a8o8111b9495090ef27@mail.gmail.com> <7vzly1sc7p.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Morten Welinder" <mwelinder@gmail.com>, git@vger.kernel.org,
	"Pierre Habouzit" <madcoder@debian.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 30 08:29:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImlX7-0006yR-VL
	for gcvg-git-2@gmane.org; Tue, 30 Oct 2007 08:29:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753053AbXJ3H2x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 03:28:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752727AbXJ3H2w
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 03:28:52 -0400
Received: from esparsett.troll.no ([62.70.27.18]:35280 "EHLO
	esparsett.troll.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752527AbXJ3H2w (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2007 03:28:52 -0400
Received: from esparsett.troll.no (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP
	id E485874216; Tue, 30 Oct 2007 08:28:50 +0100 (CET)
Received: from dahab.troll.no (dahab.troll.no [10.3.4.8])
	by esparsett.troll.no (Postfix) with ESMTP
	id DBC4A741FD; Tue, 30 Oct 2007 08:28:50 +0100 (CET)
User-Agent: KMail/1.9.6
In-Reply-To: <7vzly1sc7p.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tuesday 30 October 2007, Junio C Hamano wrote:
> "Morten Welinder" <mwelinder@gmail.com> writes:
> >> +                               } else if (x->flags & EXC_FLAG_ENDSWITH)
> >> { +                                       if (!strcmp(exclude + 1,
> >> pathname + pathlen -x->patternlen + 1))
> >
> > Is there some guarantee that the result of that subtraction is still
> > within the string?
>
> Good eyes.
>
> If pattern is "*.exe", patternlen is 5, and strcmp wants to
> compare 4 chars, so pathlen is better be at least that long, and
> we do allow that pattern to match a hidden file ".exe".
>
> Like this?
>
> 	if (x->patternlen - 1 <= pathlen &&
>         	!strcmp(exclude + 1, pathname + pathlen - x->patternlen + 1))
> 		return to_exclude;

Yes, that looks right. Thanks for catching that one.

Lars
