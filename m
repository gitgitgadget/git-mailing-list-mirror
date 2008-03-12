From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Solaris test failure for git-1.5.4.4 -- t0021-conversion.sh
Date: Tue, 11 Mar 2008 21:11:28 -0700
Message-ID: <7vhcfc8tu7.fsf@gitster.siamese.dyndns.org>
References: <8ec76080803110533m14041aebhc779d117a5bb6112@mail.gmail.com>
 <alpine.DEB.1.00.0803110954360.4428@alchemy.localdomain>
 <8ec76080803111014w209e1ceep9baf6d5c8c7f6a20@mail.gmail.com>
 <20080311173536.GA14687@sigill.intra.peff.net>
 <20080311174045.GB14687@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Whit Armstrong <armstrong.whit@gmail.com>,
	Asheesh Laroia <asheesh@asheesh.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 12 05:12:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZIKE-0000jO-9B
	for gcvg-git-2@gmane.org; Wed, 12 Mar 2008 05:12:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750972AbYCLELm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2008 00:11:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751104AbYCLELm
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Mar 2008 00:11:42 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44244 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750972AbYCLELl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2008 00:11:41 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 2ABE52DE3;
	Wed, 12 Mar 2008 00:11:38 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 3BFDB2ADD; Wed, 12 Mar 2008 00:11:32 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76918>

Jeff King <peff@peff.net> writes:

>> Looks like /usr/ucb/tr is OK with this, but /usr/bin/tr is not. Both
>> seem to handle the more verbose:
>> 
>> tr \
>>   'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ' \
>>   'nopqrstuvwxyzabcdefghijklmNOPQRSTUVWXYZABCDEFGHIJKLM'

Besides tests, I think we have invocations of "tr" that Solaris people
might want to audit in the real scripts.  POSIX does not require [] around
the strings, but when from-string and to-string are of the same length,
having [] around them would not hurt (they transliterate to themselves)
and that is the only reason why we tend to use [] form to help potential
porters to ancient System V systems ;-)

filter-branch uses A-Z (BSD style) range which also is Kosher in POSIX but
will break historical System V that requires [] around ranges.

bisect has "tr '[\012]' ' '" which I think we can get rid of by rewriting
the users of the resulting string.
