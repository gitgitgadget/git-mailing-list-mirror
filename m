From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fixed non portable use of expr and removed incorrect use of test -eq for string comparison
Date: Thu, 23 Aug 2007 02:25:27 -0700
Message-ID: <7vveb6txfc.fsf@gitster.siamese.dyndns.org>
References: <20070822132359.GA13750@informatik.uni-freiburg.de>
	<11878139102715-git-send-email-david@olrik.dk>
	<7vejhvi67x.fsf@gitster.siamese.dyndns.org>
	<20070823090600.GB6573@informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Jack Olrik <david@olrik.dk>, git@vger.kernel.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
X-From: git-owner@vger.kernel.org Thu Aug 23 11:25:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IO8wa-0003tB-MI
	for gcvg-git@gmane.org; Thu, 23 Aug 2007 11:25:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757795AbXHWJZd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 23 Aug 2007 05:25:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758036AbXHWJZd
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Aug 2007 05:25:33 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:58407 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757791AbXHWJZc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Aug 2007 05:25:32 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 3F4FC126A6C;
	Thu, 23 Aug 2007 05:25:51 -0400 (EDT)
In-Reply-To: <20070823090600.GB6573@informatik.uni-freiburg.de> (Uwe
	=?utf-8?Q?Kleine-K=C3=B6nig's?= message of "Thu, 23 Aug 2007 11:06:00
 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56482>

Uwe Kleine-K=C3=B6nig <ukleinek@informatik.uni-freiburg.de> writes:

> Junio C Hamano wrote:
>> By the way, I do not know if the use of "which" there is
>> portable.  Have Solaris folks tried this program ever?
> I don't count myself to "Solaris folks", even though I still use it t=
o
> read and write my email.  But anyhow I know some of the pitfalls...
>
> 	login@~ > /bin/bash --version
> 	GNU bash, version 3.00.16(1)-release (sparc-sun-solaris2.10)
> 	Copyright (C) 2004 Free Software Foundation, Inc.
>
> 	login@~ > /bin/bash
>
> 	zeisberg@login ~$ which httpd && echo successful
> 	no httpd in /home/zeisberg/bin /home/zeisberg/usr/bin /opt/bin
> 	/usr/local/graphics/bin /usr/local/gnu/bin /usr/local/bin
> 	/usr/local/X11R6/bin /usr/xpg4/bin /usr/bin /usr/ccs/bin /usr/sbin
> 	/usr/ucb /usr/openwin/bin
> 	successful

Thanks.  Somebody else tried:

	found=3D`which "$command"`
        if test -n "$found"
        then
        	... use $found as the full path to the command
	fi

and got burned because "no httpd in ..." comes to the stdout!
I did not exactly recall if there was an issue with the exit
status, but your demonstration shows that the status is also
useless.

We _could_ do something ugly and pointless like:

	test -f `which "$command"`

but I'd say I prefer the alternative I sent out at that point.
