From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: RFT: rebase--helper
Date: Wed, 20 Apr 2016 09:29:40 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1604191813310.2826@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: git-for-windows@googlegroups.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 20 09:29:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asma5-0007XU-QI
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 09:29:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754437AbcDTH3q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2016 03:29:46 -0400
Received: from mout.gmx.net ([212.227.15.19]:56556 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752813AbcDTH3p (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2016 03:29:45 -0400
Received: from virtualbox ([37.24.143.127]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MNZ9u-1aq2Up2UNW-0079sc; Wed, 20 Apr 2016 09:29:41
 +0200
X-X-Sender: virtualbox@virtualbox
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:PpWIE0cJVF2TNT+TV/+XMral9VWGpxjoGxD15NLfTVZzziQOvFK
 rZwR2w7KN7jXDhHjZMJH8oKZ8QciCRjdn7iH3tH95/3LP+h5+r66kfCyh6sYXw6Qmun005m
 qdHDQWzlXcph4PbTz+3nqoYm2IDBuINwv6Z5rE8MpIkPqkS1TmVh305PjGggx2Q5wozlj1d
 1aziFTakddsTDUZ2aTyNA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:vq94c10TWzI=:uZ23hsSVP5RIPVJQ3uyI0Y
 L0WaKlwRiWxwcfpd6xNOK9v2k8Pvg5B7qhlDgwFXEwaT2KhgdOSt2UiDZs99I6BzVVHfwzx1m
 quyThdDiFoF9iOBdWz8h3YdlL2nGDUJfBvMSTau29aeCxCPLHlPgnR7MviCSOtYBsZziZ1wWN
 xCrx+3C98DMgCvigcx+RPyUb7+Qsd0/ffwIRPx1tMsEsI0G7yg6NSFYJW4s/H1T/svsuiDI5U
 4Z9/+ieQDD5PlZo70ppMbobUjZ/jaqfiXRXoeFTQR+AzUKE7cZbnshfnag8z02BPwgr6hnEf2
 zyjtipAW9gjpxT7hKi7vEsJeCqqEHH8+g9OY58EOKy6Wq0Z9Ll7AYXBPVkuroF3UVN3t6GfA3
 RT6XhX6vbugZyU6OL7iUzf2dwsOHn7muQOYR8GWuImx72hXNMswuEMohcy+C4AqlQbxi/VgVr
 eliaMBQp+Y8KNbNvtoLRoAAeIxriYhHjZwPFuwe6mtgDeIgccZ9lLsvUxmlm86dc9hYxt/UjS
 BLuEUG47Yp93lDHhEn0eP+ExJg9Wq+puU8GGamhnWx2dDpJgi6PnC5f2W4aFp7ITZCKoTMzEa
 ZIXV9FB/Tq84ZTLusrPXTI8KDGJ544wIz1lEd6ROjgo3uqHGJVM2In4jkHc7WWB+K8K3NMy4p
 9i7Dzm1vNFtFyYJF9HtD/VYHYPMsgfBuzgEKD4bmxNiKphMBUutWh+s1fdAqqVXwNhFfEwrzd
 SRJcNecIh1nLyhMvunyHhXikY5AWRdjO8BIUk+YQDt39w5QDeZFokpsZMD0sZQgY1ZXAt7uR 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291988>

Hi all,

some of you are already aware that I was working on speeding up the
interactive rebase by slowly moving the performance-critical parts into a
builtin helper (unfortunately, we missed the boat long time ago when it
would still have been feasible to convert the entire rebase family into
builtins and to reasonably hope for a bug-free conversion).

Well, now I am at a point where I am reasonably certain that I have
something worth testing, and I would like to solicit help by others now.
So if you know how to write good bug reports and are not worried about
spending a bit of time to help move this project forward, I would be
really glad if you gave it a whirl with your typical rebase -i scenarios.

Here is an installer of Git for Windows with the rebase-helper:

	https://github.com/dscho/git/releases/tag/rebase-helper-v0

For non-Windows users, please pick up my 'interactive-rebase' branch from
https://github.com/dscho/git/ (and no, this topic branch is not in its
final shape, and I will break it down into more digestable patch series
before submitting)

Known issues:

- exec commands do not report the command about to be run

- when pick'ing an already-applied patch, the last line of the error
  message does not quote the commit we tried to pick

- it chokes on lines in the todo script with leading white-space

(The last problem is already solved in my topic branch.)

And finally a note for everybody who got this far: expect `git rebase -i`
to be *slower* with this version, not faster. The reason is that it will
run the rebase *twice*, once with the old shell script version, and then
using the rebase--helper, and then it cross-validates the results. That
also means that you need to resolve merge conflicts twice, reword twice,
and make sure that any "exec" commands are safe to be run twice (oh, and
GIT_NOTES_REWRITE_MODE=concatenate will also wreak havoc, of course).

Thank y'all in advance,
Johannes
