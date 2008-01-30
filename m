From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC] Authenticate push via PGP signature, not SSH
Date: Wed, 30 Jan 2008 01:16:05 -0500
Message-ID: <20080130061605.GQ24004@spearce.org>
References: <479D5611.4010205@vilain.net> <20080128081258.GE24004@spearce.org> <479E5021.7010404@vilain.net> <20080129041000.GK24004@spearce.org> <20080129190845.GC30093@artemis.madism.org> <20080130042201.GO24004@spearce.org> <47A01162.7070503@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Wed Jan 30 07:16:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JK6FX-0000G9-QV
	for gcvg-git-2@gmane.org; Wed, 30 Jan 2008 07:16:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751650AbYA3GQL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2008 01:16:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752479AbYA3GQK
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jan 2008 01:16:10 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:58435 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751555AbYA3GQJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2008 01:16:09 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JK6Ex-0008TU-AQ; Wed, 30 Jan 2008 01:16:07 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id E181220FBAE; Wed, 30 Jan 2008 01:16:05 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <47A01162.7070503@vilain.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72028>

Sam Vilain <sam@vilain.net> wrote:
> Shawn O. Pearce wrote:
> > I just read the GnuPG manual and you are obviously correct.  The only
> > way to get GnuPG to process a key is to load it onto a keyring.
> > We could extract the armored (or binary) public key and load it
> > onto a temporary keyring created just for the purpose of verifying
> > this connection, but that's rather messy.
> 
> It should be fine just to throw the lot into a single keyring, and just
> check which key verified it after the fact and whether that key was allowed.
> 
> The Perl Crypt::OpenPGP module doesn't suffer from this problem (and is
> performant), though it suffers from a dependency stack that will hurt
> everyone except Debian users ;-).

Heh.  One of my Gentoo boxes seems to claim this would be an easier
emerge than the Qt3 emerge that it keeps trying to do, and failing,
for the past week and a half.  But yea, I don't have half the stuff
its asking for installed.
 
> >> $ gpg --keyring path/to/the/keyring.gpg --quiet --batch --status-fd 1 --verify some-file.tar.gz.gpg 2>|/dev/null
> >> [GNUPG:] SIG_ID dw0VliO0DFjOQA3HUSHijYekQYY 2008-01-29 1201633002
> >> [GNUPG:] GOODSIG BC6AFB5BA1EE761C Pierre Habouzit <pierre.habouzit@polytechnique.edu>
> >> [GNUPG:] VALIDSIG 72B4C59ADA78D70E055C129EBC6AFB5BA1EE761C 2008-01-29 1201633002 0 3 0 17 2 00 72B4C59ADA78D70E055C129EBC6AFB5BA1EE761C
> ^^^ there GPG just told you which key was used.

Yup.  I think that's what we'll have to do.  But managing the keyring
is (I think) something we need to solve.  It should be able to be
done remotely, assuming you have authority, and ideally through
standard Git channels.

If we're going to the trouble of effectively replacing SSH for
authenticated Git object push (at least for stuff that is open
source and thus doesn't require privacy during upload) we might
as well make sure it can actually be managed too.

-- 
Shawn.
