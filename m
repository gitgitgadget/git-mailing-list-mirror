From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Breakage (?) in configure and git_vsnprintf()
Date: Mon, 12 Dec 2011 11:25:24 +0100
Message-ID: <4EE5D694.7040407@alum.mit.edu>
References: <4EE4F97B.9000202@alum.mit.edu> <20111212064305.GA16511@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	git discussion list <git@vger.kernel.org>,
	Michal Rokos <michal.rokos@nextsoft.cz>,
	Brandon Casey <casey@nrlssc.navy.mil>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Dec 12 11:25:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ra34w-00019Q-Fj
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 11:25:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751710Ab1LLKZq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 05:25:46 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:37753 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751105Ab1LLKZq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 05:25:46 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id pBCAPOXM002704
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 12 Dec 2011 11:25:24 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.23) Gecko/20110921 Lightning/1.0b2 Thunderbird/3.1.15
In-Reply-To: <20111212064305.GA16511@sigill.intra.peff.net>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186904>

On 12/12/2011 07:43 AM, Jeff King wrote:
> On Sun, Dec 11, 2011 at 07:42:03PM +0100, Michael Haggerty wrote:
>> 2. The configure problem causes git_vsnprintf() to be wrapped around the
>> C library version.  This leads to many failures in the test suite.  I
>> suppose that git_vsnprintf() is broken in some way.
> 
> I enabled SNPRINTF_RETURNS_BOGUS manually and was able to see the test
> suite failures. Very oddly, I could get them while running the full
> suite in parallel, but when I ran individual scripts, the problem went
> away. Which makes no sense to me at all.
> 
> However, I peeked at the git_vsnprintf function, and one obvious error
> is that it calls vsnprintf multiple times on the same va_list.

Thanks for the quick response!  Yes, I think you've hit the nail on the
head.  (Though I think Andreas is correct that va_end() needs to be
called on the copies.)  Either with or without va_end(), your patch
fixes the test suite failures for me.

> I'll leave the issue of "-std=c89" triggering SNPRINTF_RETURNS_BOGUS to
> people who know and care about autoconf. My gut is to say "don't do
> that". Git is not actually pure c89. [...]

OK, I can live with that.  Poor Junio will probably be stuck correcting
my non-c89isms again, though :-(

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
