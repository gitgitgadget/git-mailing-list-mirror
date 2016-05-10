From: Yaroslav Halchenko <yoh@onerussian.com>
Subject: Re: wishlist; unify behavior while cloning non-bare repos over http
 to be in line with ssh/local
Date: Tue, 10 May 2016 18:10:32 -0400
Message-ID: <20160510221032.GV23764@onerussian.com>
References: <xmqqfutpoepz.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Benjamin Poldrack <benjaminpoldrack@gmail.com>,
	Michael Hanke <michael.hanke@gmail.com>
To: Git Gurus hangout <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 11 00:10:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0FrS-0007Kf-Rj
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 00:10:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752268AbcEJWKf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2016 18:10:35 -0400
Received: from washoe.dartmouth.edu ([129.170.30.229]:39098 "EHLO
	smtp.onerussian.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751739AbcEJWKe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 18:10:34 -0400
Received: from smtp.onerussian.com ([192.168.100.6] helo=washoe.onerussian.com)
	by smtp.onerussian.com with esmtps (TLS1.2:RSA_AES_128_CBC_SHA1:128)
	(Exim 4.80)
	(envelope-from <yoh@onerussian.com>)
	id 1b0FrM-0006GA-HG; Tue, 10 May 2016 18:10:32 -0400
Received: from yoh by washoe.onerussian.com with local (Exim 4.84)
	(envelope-from <yoh@onerussian.com>)
	id 1b0FrM-0006G5-7Z; Tue, 10 May 2016 18:10:32 -0400
Content-Disposition: inline
In-Reply-To: <xmqqfutpoepz.fsf@gitster.mtv.corp.google.com>
 <CA+P7+xoCmMV01=11GRVsuOSoTPgzSFT-VAeqa1SCcLnzpGcb0Q@mail.gmail.com>
X-URL: http://www.onerussian.com
X-Image-Url: http://www.onerussian.com/img/yoh.png
X-PGP-Key: http://www.onerussian.com/gpg-yoh.asc
X-fingerprint: C5B9 05F0 E8D9 FD96 68FF  366F A2DE 2350 62DA 33FA
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: 192.168.100.6
X-SA-Exim-Rcpt-To: git@vger.kernel.org, benjaminpoldrack@gmail.com, michael.hanke@gmail.com
X-SA-Exim-Mail-From: yoh@onerussian.com
X-SA-Exim-Scanned: No (on smtp.onerussian.com); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294202>


On Tue, 10 May 2016, Jacob Keller wrote:
> > The necessary update to the client might as simple as using
> > $GIVEN_URL/.git/ and attempting the request again after seeing the
> > probe for $GIVEN_URL/info/refs fails.
> I know at least Jenkin's Git plugin has a workaround to solve this
> issue that is quite similar.

On Tue, 10 May 2016, Junio C Hamano wrote:

> >> traverse website since could lead to dangerous places.  But .git is under
> >> originating url directory, as well as info/ or HEAD or any other object
> >> accessed by git, so IMHO this concern is not a concern.

> I am afraid that the reason why you saw no response is primarily
> because nobody is interested in extending dumb commit-walker HTTP
> transport after the world has largely moved on and abandoned it.

> The necessary update to the client might as simple as using
> $GIVEN_URL/.git/ and attempting the request again after seeing the
> probe for $GIVEN_URL/info/refs fails.

Sure -- workarounds are possible, and we are at the state that many dependent
projects seems are doing that already (as above noted Jenkin's Git plugin, smth
along the lines probably done by github for https as well).  In my case I even
have managed to erect a lovely apache rewrite rule which seems to work, so I
can just 'git clone --recursive' a collection of 30 submodules without a hiccup
(we are also interested in .git/annex part here ;) ).  Citing here if it
comes handy for anyone

    # To overcome http://thread.gmane.org/gmane.comp.version-control.git/293777
    # we need to rewrite urls so that there is no need for explicit .git/
    RewriteEngine On
    RewriteCond "!.*/\.git/.*"
    RewriteRule "(.*?/)((?<!\.git/)(HEAD|config|annex/objects/.*|objects/(info/[^/]+|[0-9a-f]{2}/[0-9a-f]{38}|pack/pack-[0-9a-f]{40}.(pack|idx))|git-(upload|receive)-pack)|info/refs)$" "$1.git/$2" [PT]

and sure thing in our project now we can add such sensing for .git/ and/or
reattempts to request again.  But that is the point -- it seems to be a
relatively common hiccup which could be fixed in the "root".  So I (and
possibly others) would just very much appreciate if it was (thus it was a
[wishlist] ;) )

Cheers,
-- 
Yaroslav O. Halchenko
Center for Open Neuroscience     http://centerforopenneuroscience.org
Dartmouth College, 419 Moore Hall, Hinman Box 6207, Hanover, NH 03755
Phone: +1 (603) 646-9834                       Fax: +1 (603) 646-1419
WWW:   http://www.linkedin.com/in/yarik        
