From: =?UTF-8?B?Wm9sdMOhbiBGw7x6ZXNp?= <zfuzesi@eaglet.hu>
Subject: Re: [PATCH] gitweb: parse_commit_text encoding fix
Date: Thu, 6 Aug 2009 10:15:25 +0200
Message-ID: <9ab80d150908060115q4b56b2e5xb327e09cda7e2b7a@mail.gmail.com>
References: <9ab80d150908010955l3710c54bp9e2716570fd1d5ed@mail.gmail.com>
	 <1249198944-19630-1-git-send-email-zfuzesi@eaglet.hu>
	 <7viqh43vz3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 06 10:24:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYyGV-0007PG-NB
	for gcvg-git-2@gmane.org; Thu, 06 Aug 2009 10:24:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752759AbZHFIX3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Aug 2009 04:23:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752729AbZHFIX3
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 04:23:29 -0400
Received: from mail-fx0-f228.google.com ([209.85.220.228]:51267 "EHLO
	mail-fx0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752217AbZHFIX1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Aug 2009 04:23:27 -0400
Received: by fxm28 with SMTP id 28so588808fxm.17
        for <git@vger.kernel.org>; Thu, 06 Aug 2009 01:23:27 -0700 (PDT)
Received: by 10.103.193.13 with SMTP id v13mr1950070mup.68.1249546525827; Thu, 
	06 Aug 2009 01:15:25 -0700 (PDT)
In-Reply-To: <7viqh43vz3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125050>

2009/8/4 Junio C Hamano <gitster@pobox.com>:
>
> Thanks, Zolt=C3=A1n.
>
> We should be able to set up a script that scrapes the output to test =
this
> kind of thing. =C2=A0We may not want to have a test pattern that matc=
hes too
> strictly for the current structure and appearance of the output
> (e.g. counting nested <div>s, presentation styles and such), but if w=
e can
> robustly scrape off HTML tags (e.g. "elinks -dump") and check the
> remaining payload, it might be enough.
>
> Jakub what do you think? =C2=A0I suspect that scraping approach may t=
urn out to
> be too fragile for tests to be worth doing, but I am just throwing ou=
t a
> thought.
>

This issue comes out when chop_and_escape_str function is called with
a non-ascii string (like my name :)) without before calling to_utf8 on
it. "author_name" and "committer_name" are two examples, and
"author_name" shows up with bad encoding in HTML.

Example from one of my repos (little piece from shortlog output):
<td class=3D"author"><span title=3D"F=C3=83=C2=BCzesi Zolt=C3=83=C2=A1n=
">F=C3=BCzesi Zolt=C3=A1n</span></td>
After applying the patch:
<td class=3D"author">F=C3=BCzesi Zolt=C3=A1n</td>

This is an "old" (seen in 1.5.6 version too) and (I think) minor issue.
I haven't spent time on thinking how a test script could show this yet.
Waiting for Jakub's reaction.
