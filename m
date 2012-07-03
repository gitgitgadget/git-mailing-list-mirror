From: Hallvard Breien Furuseth <h.b.furuseth@usit.uio.no>
Subject: Re: [Q] Branch aliases =?UTF-8?Q?=28synonyms=29=3F?=
Date: Tue, 03 Jul 2012 19:49:39 +0200
Message-ID: <93495bc04d9f7426bef1b1de1b202280@ulrik.uio.no>
References: <1919214.YKUdgul2iY@laclwks004>
 <93cfd6eb9045585728dfe649359a103c@ulrik.uio.no>
 <4261222.bYBuBBxnOa@laclwks004>
 <CALKQrgeAXLSwsqwTe_FZN0aNHwnoSBHBt+PO9jpCtzRM1Aeyrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Cc: Brian Foster <brian.foster@maxim-ic.com>,
	git mailing list <git@vger.kernel.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue Jul 03 19:49:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sm7ER-0003KA-Gg
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jul 2012 19:49:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932097Ab2GCRtm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jul 2012 13:49:42 -0400
Received: from mail-out1.uio.no ([129.240.10.57]:44595 "EHLO mail-out1.uio.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752632Ab2GCRtm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2012 13:49:42 -0400
Received: from mail-mx3.uio.no ([129.240.10.44])
	by mail-out1.uio.no with esmtp (Exim 4.75)
	(envelope-from <h.b.furuseth@usit.uio.no>)
	id 1Sm7EL-0004Va-1D; Tue, 03 Jul 2012 19:49:41 +0200
Received: from w3prod-wm03.uio.no ([129.240.4.40] helo=webmail.uio.no)
	by mail-mx3.uio.no with esmtpsa (TLSv1:AES256-SHA:256)
	user hbf (Exim 4.76)
	(envelope-from <h.b.furuseth@usit.uio.no>)
	id 1Sm7EK-000337-JV; Tue, 03 Jul 2012 19:49:40 +0200
Received: from c766A01C3.dhcp.bluecom.no ([195.1.106.118])
 by webmail.uio.no
 with HTTP (HTTP/1.1 POST); Tue, 03 Jul 2012 19:49:39 +0200
In-Reply-To: <CALKQrgeAXLSwsqwTe_FZN0aNHwnoSBHBt+PO9jpCtzRM1Aeyrw@mail.gmail.com>
X-Sender: h.b.furuseth@usit.uio.no
User-Agent: Roundcube Webmail/0.4.2
X-UiO-Ratelimit-Test: rcpts/h 3 msgs/h 1 sum rcpts/h 5 sum msgs/h 2 total rcpts 2509 max rcpts/h 20 ratelimit 0
X-UiO-Spam-info: not spam, SpamAssassin (score=-5.0, required=5.0, autolearn=disabled, FSL_RCVD_USER=0.001,T_RP_MATCHES_RCVD=-0.01,UIO_MAIL_IS_INTERNAL=-5, uiobl=NO, uiouri=NO)
X-UiO-Scanned: F10BFFA02D949EBF6724D44980F5B1F071C69392
X-UiO-SPAM-Test: remote_host: 129.240.4.40 spam_score: -49 maxlevel 80 minaction 2 bait 0 mail/h: 58 total 1445949 max/h 475 blacklist 0 greylist 0 ratelimit 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200924>

 On Tue, 3 Jul 2012 18:22:43 +0200, Johan Herland <johan@herland.net> 
 wrote:
> FWIW, we have done a similar thing at $dayjob: A git repo (originally
> converted form Subversion) still used "trunk" as the main development
> branch. We wanted to start following Git conventions, so we renamed 
> it
> to "master", and set up "trunk" as a symref to "master". We then told
> all the other developers that "trunk" is now "master", and that they
> should switch at their own leisure. After a grace period, we will
> remove the "trunk" symref.
> (...)

 Yes, a symref in the master repo only seems tidy enough.
 I should have realized that's what he meant.

 I can think of one irritant to warn developers of:

 git fetch           # Fetches both A and B
 git checkout A      # Lemme see how this looks for A users...
 ...
 git checkout B      # My scripts are still using B though...
 ...commit something...
 git push            # Pushes B, doesn't know remote A is forwarded
 git push            # Rejected, non-fast-forward of your old A

 "WTF, why does that keep happening all the time?"

 git branch -d A     # Fixes the above (if A is not checked out:)


 And if you haven't already, it may be best to do

 git config --bool receive.denyNonFastForwards  true
 git config --bool receive.denyDeletes          true

 just in case someone gets too clever and does something like:
 "Now how do I get rid of the remote A?  Google... Aha"
 git push origin :refs/heads/A  # whoops, wrong A deleted:-)

 Hallvard
