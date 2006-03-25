From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: [PATCH 3/4] send-email: lazy-load Email::Valid and make it optional
Date: 25 Mar 2006 07:07:38 -0800
Message-ID: <86zmje36md.fsf@blue.stonehenge.com>
References: <11432834111972-git-send-email-normalperson@yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git <git@vger.kernel.org>,
	Ryan Anderson <ryan@michonline.com>, Greg KH <greg@kroah.com>
X-From: git-owner@vger.kernel.org Sat Mar 25 16:08:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FNAN6-00040f-3E
	for gcvg-git@gmane.org; Sat, 25 Mar 2006 16:08:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751424AbWCYPHo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Mar 2006 10:07:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751425AbWCYPHo
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Mar 2006 10:07:44 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:5640 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP
	id S1751424AbWCYPHo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Mar 2006 10:07:44 -0500
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id 2BB468F5B5;
	Sat, 25 Mar 2006 07:07:39 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 21502-01-9; Sat, 25 Mar 2006 07:07:38 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 2C1988F5CD; Sat, 25 Mar 2006 07:07:38 -0800 (PST)
To: Eric Wong <normalperson@yhbt.net>
x-mayan-date: Long count = 12.19.13.2.17; tzolkin = 11 Caban; haab = 15 Cumku
In-Reply-To: <11432834111972-git-send-email-normalperson@yhbt.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17985>

>>>>> "Eric" == Eric Wong <normalperson@yhbt.net> writes:

Eric> +my $have_email_valid = eval { require Email::Valid or undef };

This is not necessary... if eval fails, it returns undef by definition.  Your
code presumes that the non-zero last-expression-evaluated of a require is also
returned from the require, which I believe is only accidentally true, although
the behavior may be recently documented and therefore promised.  (On perl 5.8,
it looks a bit fishy to me at a quick glance.)

My favorite idiom for a possibly failing eval-step is:

        my $can_I_do_this = eval { riskything; 1 };

If riskything fails, eval returns undef.  If it succeeds, it evaluates the 1,
and returns that.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
