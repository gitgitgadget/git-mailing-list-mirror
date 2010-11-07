From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: Refactoring git-rebase.sh and git-rebase--interactive.sh
Date: Sat, 6 Nov 2010 21:57:25 -0400
Message-ID: <AANLkTikbSU7LMnrT7uz5SSd8_x_cK_dHiVN37McJe+AT@mail.gmail.com>
References: <AANLkTimeWDbJPor9PnKgW5sD7DLjqrm-vTzEtnARvP3M@mail.gmail.com>
	<AANLkTinSb09oZHN8br5goeoG2b+Cgra88E1qeLqi-Y=z@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes.Schindelin@gmx.de, christian.couder@gmail.com,
	trast@student.ethz.ch, Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 07 03:03:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PEubV-0000VO-RQ
	for gcvg-git-2@lo.gmane.org; Sun, 07 Nov 2010 03:03:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751732Ab0KGB50 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Nov 2010 21:57:26 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:43569 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751453Ab0KGB50 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Nov 2010 21:57:26 -0400
Received: by qyk12 with SMTP id 12so826701qyk.19
        for <git@vger.kernel.org>; Sat, 06 Nov 2010 18:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=9BLsqOxOXqyO6dzIwE1uOSFoEaxXiCHrmuzODNMyxFE=;
        b=h2da7KAuwFVu/BfVOkuB7vl95FDqGHD2PnP3b/hhWlnZWBP4bnJR8/A0aQbaFOHdOw
         VQhjxXXWft44nqp8KMcqC4hXuBAs8oQ9Eo/tm3TjdnijCw+8WjOoP848W6YyxviQDuBD
         dNgJvuDemk4UW8Sx1BUZCoQOGPEBZg7Jkz5Oc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=lVaaXTiC9JojnUB84hPvkTxtYp0kQ+CvytMtHZsFHAMKpHh7SkkhwjI9qd2WFxG8yN
         +QjwAEx00iUEhM3C4+2md0pLJJ0ncyvpH2lCDY44Az487DTHJ9jGW0Q8AVaziHKLyaQ2
         ZEDjQVhZbMP5B9l9xrNpyfIWx3a+kBpcc+rJE=
Received: by 10.224.206.137 with SMTP id fu9mr2615900qab.40.1289095045572;
 Sat, 06 Nov 2010 18:57:25 -0700 (PDT)
Received: by 10.224.20.82 with HTTP; Sat, 6 Nov 2010 18:57:25 -0700 (PDT)
In-Reply-To: <AANLkTinSb09oZHN8br5goeoG2b+Cgra88E1qeLqi-Y=z@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160863>

> 2. a. If --continue, --skip or --abort requested, rebase-apply/ or
> =A0 =A0 =A0rebase-merge/ must exist. (What if -i is also passed and
> =A0 =A0 =A0 =A0 =A0rebase-apply/ exists?)
> =A0 b. Otherwise, rebase-apply/ or rebase-merge/ must not exist

This actually hints at a more general question, namely whether command
line or saved options should be used when continuing a rebase. For
example, if an interactive rebase has been started with a certain merge
strategy, should that merge strategy be used throughout the rebase, or
should whatever is passed on the command line when continuing be used
instead? Does it depend on which option we are talking about?

As far as I can understand from the code, it seems like non-interactive
rebase currently does not store e.g. the merge strategy, but allows it
to be passed on the command line together with '--continue' (but only i=
f
passed before). Interactive rebase, OTOH, does store the option when th=
e
rebase is initated and does not allow it to be overriden on the command
line. I have not tested either of them, so I may very well be wrong.

Whatever the current behavior is, how do you think it *should* behave?
