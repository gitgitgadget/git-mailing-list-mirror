From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] mktag.c: improve verification of tagger field and tests
Date: Wed, 26 Mar 2008 16:03:29 -0500
Message-ID: <47EABA21.90708@nrlssc.navy.mil>
References: <1206490795-13247-1-git-send-email-casey@nrlssc.navy.mil> <47E99B98.1060506@nrlssc.navy.mil> <1b46aba20803260421t4db4987gc6fc8b2e556032e0@mail.gmail.com> <47EA7927.9060201@nrlssc.navy.mil> <7vhcete8oi.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Carlos Rica <jasampler@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 26 22:04:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JecnP-0001vb-1h
	for gcvg-git-2@gmane.org; Wed, 26 Mar 2008 22:04:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756250AbYCZVDs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Mar 2008 17:03:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755370AbYCZVDs
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Mar 2008 17:03:48 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:53403 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754068AbYCZVDr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2008 17:03:47 -0400
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m2QL3Too010386;
	Wed, 26 Mar 2008 16:03:30 -0500
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 26 Mar 2008 16:03:29 -0500
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
In-Reply-To: <7vhcete8oi.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 26 Mar 2008 21:03:29.0614 (UTC) FILETIME=[D7A096E0:01C88F84]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15806001
X-TM-AS-Result: : Yes--2.768500-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNTY3LTgzMzUxOC03MDAw?=
	=?us-ascii?B?NzUtMTM5MDEwLTcwMTU4My03MDM5NjktNzAxNDU1LTcwMTUxMy0x?=
	=?us-ascii?B?ODcxMzQtNzAxNjA0LTcwMDY4NS03MDA4NDYtNzA0MjU3LTcwOTI1?=
	=?us-ascii?B?MS03MDM2NTctNzAwNjE4LTcwNzMyMS0xMTMyMTEtNzA5NzU1LTcw?=
	=?us-ascii?B?Njk4NC03MDUxNjctNzAzNzIwLTcwMjExMy03MDI3OTEtMTQ4MDM5?=
	=?us-ascii?B?LTE0ODA1MS0yMDA0MA==?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78312>

Junio C Hamano wrote:
> By the way, I
>    think tagger information should get the same validation as committer
>    and author information gets elsewhere in the system;

I agree. Do you have any pointers to suggest? I haven't seen any place in
the code that does thorough validation. Usually, these fields are generated
within git, or converted to the internal form using some dwim procedure.

I keyed on get_ac_line() in builtin-blame.c and force_author in builtin-commit.c

builtin-commit.c searches for the angle brackets '<' and '>' as a validation
for the argument to --author.

get_ac_line() searches from the end of the string and sets tz, timestamp,
and email to the last space-separated entries. timestamp is fed to strtoul
and tz is fed to atoi. These two both skip leading space, but they are
never fed leading space from get_ac_line().

date.c:parse_date() keys on +\- to recognize timezone.

I think I'll make all of the optional components non-optional and make the
format a little stricter.

-brandon
