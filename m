From: Marc Branchaud <mbranchaud@xiplink.com>
Subject: Re: [PATCH 0/4] Support triangular workflows
Date: Mon, 18 Mar 2013 11:55:56 -0400
Message-ID: <5147390C.9060907@xiplink.com>
References: <1363612575-7340-1-git-send-email-artagnon@gmail.com> <20130318142526.GA23075@sigill.intra.peff.net>
Reply-To: marcnarc@xiplink.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 18 17:07:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHcae-0006E3-3a
	for gcvg-git-2@plane.gmane.org; Mon, 18 Mar 2013 17:07:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753238Ab3CRQGp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Mar 2013 12:06:45 -0400
Received: from smtp172.dfw.emailsrvr.com ([67.192.241.172]:52187 "EHLO
	smtp172.dfw.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751947Ab3CRQGo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Mar 2013 12:06:44 -0400
X-Greylist: delayed 626 seconds by postgrey-1.27 at vger.kernel.org; Mon, 18 Mar 2013 12:06:44 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp17.relay.dfw1a.emailsrvr.com (SMTP Server) with ESMTP id 8E38D1F83DD
	for <git@vger.kernel.org>; Mon, 18 Mar 2013 11:56:18 -0400 (EDT)
X-Virus-Scanned: OK
Received: from smtp146.ord.emailsrvr.com (smtp146.ord.emailsrvr.com [173.203.6.146])
	by smtp17.relay.dfw1a.emailsrvr.com (SMTP Server) with ESMTPS id E57C01F83DC
	for <git@vger.kernel.org>; Mon, 18 Mar 2013 11:56:17 -0400 (EDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp19.relay.ord1a.emailsrvr.com (SMTP Server) with ESMTP id 6850C3B0141;
	Mon, 18 Mar 2013 11:55:46 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp19.relay.ord1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id E2DDC3B013C;
	Mon, 18 Mar 2013 11:55:45 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130221 Thunderbird/17.0.3
In-Reply-To: <20130318142526.GA23075@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218425>

On 13-03-18 10:25 AM, Jeff King wrote:
> On Mon, Mar 18, 2013 at 06:46:11PM +0530, Ramkumar Ramachandra wrote:
> 
>> I've put off implementing remote.default corresponding to
>> remote.pushdefault, as Jeff suggested in [1], because it's currently
>> not an itch; apart from the obvious symmetry, I don't know what
>> purpose it serves: why would anyone want to fetch from a remote other
>> than origin by default?  Why wouldn't they simply swap that remote's
>> name with "origin"?  However, it's a nice thing to have for symmetry,
>> and it should be trivial to implement: any interested person is
>> welcome to pick it up.
> 
> Yeah, I agree that it does not have much point, aside from people who
> have an unreasonable aversion to using the word "origin". There was a
> series posted last summer to add remote.default:
> 
>   http://article.gmane.org/gmane.comp.version-control.git/201065
> 
> It ended up stalled and never got merged. I think the main impetus was
> that "git clone -o foo" should leave "foo" in remote.default (of course,
> that still leaves unanswered why anyone would really want to use "-o
> foo" in the first place).

I'm the guy who dropped the ball on that series.  I still intend to pick it
up (honest!) but I just haven't had the time.

The impetus was originally getting relative submodule paths to work on
detached HEADs [1].  My patch for that doesn't work when someone does "clone
-o", because various parts of git assume there's a remote named "origin".
The discussion led to the idea of using the remote name specified during the
initial clone, and implementing that as a remote.default config value.

As for why "clone -o" exists, it was added in v1.1.0:

    commit e6c310fd0d7384973efc6b1d5999a5e8a5b2f3bd
    Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
    Date:   Thu Dec 22 23:37:24 2005 +0100

    git-clone: Support changing the origin branch with -o

    Earlier, git-clone stored upstream's master in the branch named 'origin',
    possibly overwriting an existing such branch.

    Now you can change it by calling git-clone with '-o <other_name>'.

    [jc: added ref format check, subdirectory safety, documentation
     and usage string.]

    Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
    Signed-off-by: Junio C Hamano <junkio@cox.net>

It sounds like the original need for the -o option is no longer pertinent.
OTOH, for folks who deal with several remotes it's nice to name them, and
"origin" isn't necessarily a useful or intuitive name.

		M.

[1] http://thread.gmane.org/gmane.comp.version-control.git/200145
