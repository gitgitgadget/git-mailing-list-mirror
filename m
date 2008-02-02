From: Sean <seanlkml@sympatico.ca>
Subject: Re: [PATCH] Avoid segfault when passed malformed refspec
Date: Fri, 1 Feb 2008 20:26:02 -0500
Message-ID: <BAYC1-PASMTP11F54ED60A103C52F2406AAE310@CEZ.ICE>
References: <BAYC1-PASMTP124F1019C2D2CD7AA81CF5AE310@CEZ.ICE>
	<7vzluk6ugn.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 02 02:26:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JL79a-0006GX-VE
	for gcvg-git-2@gmane.org; Sat, 02 Feb 2008 02:26:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760634AbYBBB0E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2008 20:26:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760530AbYBBB0D
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Feb 2008 20:26:03 -0500
Received: from bay0-omc2-s36.bay0.hotmail.com ([65.54.246.172]:48780 "EHLO
	bay0-omc2-s36.bay0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755929AbYBBB0C (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Feb 2008 20:26:02 -0500
Received: from BAYC1-PASMTP11 ([65.54.191.184]) by bay0-omc2-s36.bay0.hotmail.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 1 Feb 2008 17:26:01 -0800
X-Originating-IP: [74.15.77.168]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([74.15.77.168]) by BAYC1-PASMTP11.CEZ.ICE over TLS secured channel with Microsoft SMTPSVC(6.0.3790.2668);
	 Fri, 1 Feb 2008 17:26:00 -0800
Received: from guru.attic.local ([10.10.10.28])
	by linux1.attic.local with smtp (Exim 4.43)
	id 1JL84k-0008Jo-Up; Fri, 01 Feb 2008 21:25:50 -0500
In-Reply-To: <7vzluk6ugn.fsf@gitster.siamese.dyndns.org>
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.5; i686-pc-linux-gnu)
X-OriginalArrivalTime: 02 Feb 2008 01:26:01.0023 (UTC) FILETIME=[91E45CF0:01C8653A]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72202>

On Fri, 01 Feb 2008 17:03:04 -0800
Junio C Hamano <gitster@pobox.com> wrote:

> Sean <seanlkml@sympatico.ca> writes:
> >
> > +		if (!rs[i].dst)
> > +			rs[i].dst = xstrdup("");
>
> I haven't followed the codepath carefully before responding, it
> feels like sweeping the breakage under the carpet, without
> fixing the real issue.
> 
> If the problem is a badly formatted input, shouldn't the code
> die loudly with diagnostic message, instead of pretending as if
> the user said something different (and sensible), especially
> without telling the user that that is what the code is doing?
> 

Hey Junio,

You're probably right.  It seemed like a reasonable fix at the time
without having to understand the code too deeply.  With the above
patch, the code does complain to the user:

  $ git-fetch ../repo refs/heads/* :refs/heads/* 
  fatal: * refusing to create funny ref 'floop' locally

But surely a better error could be shown if fetch is made to
squawk whenever a destination ref is omitted.   I just wasn't
confident enough in the code, or in knowing what refspec rules
are universally applicable.

Sean
