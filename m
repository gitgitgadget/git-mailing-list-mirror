From: Jonas Berlin <xkr47@outerspace.dyndns.org>
Subject: Re: [PATCH] Fix "cvs log" to use UTC timezone instead of local
Date: Wed, 05 Sep 2007 21:45:21 +0000
Organization: Helsinki University of Technology
Message-ID: <46DF2371.5030603@outerspace.dyndns.org>
References: <11889090932256-git-send-email-xkr47@outerspace.dyndns.org> <alpine.LFD.0.999.0709040612260.3088@evo.linux-foundation.org> <46DF2058.7060405@outerspace.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Sep 05 23:45:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IT2gg-0001yo-U6
	for gcvg-git@gmane.org; Wed, 05 Sep 2007 23:45:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752182AbXIEVpU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 17:45:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756726AbXIEVpT
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 17:45:19 -0400
Received: from emh01.mail.saunalahti.fi ([62.142.5.107]:46542 "EHLO
	emh01.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757022AbXIEVpS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 17:45:18 -0400
Received: from saunalahti-vams (vs3-12.mail.saunalahti.fi [62.142.5.96])
	by emh01-2.mail.saunalahti.fi (Postfix) with SMTP id 3F1E31B01E;
	Thu,  6 Sep 2007 00:45:16 +0300 (EEST)
Received: from emh06.mail.saunalahti.fi ([62.142.5.116])
	by vs3-12.mail.saunalahti.fi ([62.142.5.96])
	with SMTP (gateway) id A00A39192D0; Thu, 06 Sep 2007 00:45:16 +0300
Received: from outerspace.dyndns.org (a88-112-29-101.elisa-laajakaista.fi [88.112.29.101])
	by emh06.mail.saunalahti.fi (Postfix) with ESMTP id 0ED74E51C6;
	Thu,  6 Sep 2007 00:45:13 +0300 (EEST)
Received: from [IPv6:2001:14b8:141::] (outerspace [IPv6:2001:14b8:141::])
	by outerspace.dyndns.org (Postfix) with ESMTP id 7161970F5A;
	Thu,  6 Sep 2007 00:45:22 +0300 (EEST)
User-Agent: Thunderbird 2.0.0.6 (X11/20070728)
In-Reply-To: <46DF2058.7060405@outerspace.dyndns.org>
X-Enigmail-Version: 0.95.3
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57768>

Quoting Jonas Berlin on 09/05/2007 09:32 PM UTC:
> Quoting Linus Torvalds on 09/04/2007 01:22 PM UTC:
>> That can be done various ways:
>>
>>  - use the "raw log format" which has dates as seconds-since-UTC (and with 
>>    an *informational* timezone thing that should then just be ignored).
>>
>>    This is likely the best approach, since anything but this will 
> 
> This seems straightforward to implement, so I will go with this.

I just realized that since git-cvsserver creates a SQLite database (assumably for keeping track of what cvs revision numbers map to which git commits) AND the "timezonized" timestamps are stored as strings in there, switching to UTC timestamps would either break current SQLite databases or then require backwards compatibility code to handle the pretty-printed timestamp (with the UTC unrolling code from the patch I sent).

> I guess at this point it's good to mention that current cvs implementations (at least 1.12.12) produce timestamps of format "yyyy-mm-dd HH:MM:SS +ZZZZ" (i.e. they do include timezone information) while older versions (at least 1.11.22) produce the UTC-only format "yyyy/mm/dd HH:MM:SS" which is currently used by git-cvsserver. Backwards compatibility generally being a good thing, while at the expense of timezone information, I chose to keep the older UTC-only format. Should you prefer to keep the timezone information, I'll update the cvs log format instead. Heck, I could even support both through some configuration option if you really wanted :)

Another option would be to scrap support for old cvs clients.. I could investigate when the new format was introduced..

-- 
- xkr47
