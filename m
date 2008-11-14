From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [RFC PATCH] repack: make repack -a equivalent to repack -A and
	drop previous -a behavior
Date: Fri, 14 Nov 2008 01:02:19 +0100
Message-ID: <20081114000219.GB5285@atjola.homenet>
References: <7xh1_tFsJkHTjg4Hjm-R4mGSRfYyGFmLI62OMmaNg32f86EbVIYvYrGiYpEGkvooY4pUM1e7CHk@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Fri Nov 14 01:03:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0m9y-00034K-VW
	for gcvg-git-2@gmane.org; Fri, 14 Nov 2008 01:03:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752054AbYKNACY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Nov 2008 19:02:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751807AbYKNACY
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Nov 2008 19:02:24 -0500
Received: from mail.gmx.net ([213.165.64.20]:32791 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751268AbYKNACX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2008 19:02:23 -0500
Received: (qmail invoked by alias); 14 Nov 2008 00:02:21 -0000
Received: from i577B96AD.versanet.de (EHLO atjola.local) [87.123.150.173]
  by mail.gmx.net (mp004) with SMTP; 14 Nov 2008 01:02:21 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+6o/ksEH26uzF8Sik5oZyzmDkBJq3trowMlsynXE
	a+I5lh+0b8RlPU
Content-Disposition: inline
In-Reply-To: <7xh1_tFsJkHTjg4Hjm-R4mGSRfYyGFmLI62OMmaNg32f86EbVIYvYrGiYpEGkvooY4pUM1e7CHk@cipher.nrlssc.navy.mil>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100933>

On 2008.11.13 17:22:36 -0600, Brandon Casey wrote:
> Once upon a time, repack had only a single option which began with th=
e first
> letter of the alphabet.  Then, a second was created which would repac=
k
> unreachable objects into the newly created pack so that git-gc --auto=
 could
> be invented.  But, the -a option was still necessary so that it could=
 be
> called every now and then to discard the unreachable objects that wer=
e being
> repacked over and over and over into newly generated packs. Later, -A=
 was
> changed so that instead of repacking the unreachable objects, it ejec=
ted
> them from the pack so that they resided in the object store in loose =
form,
> to be garbage collected by prune-packed according to normal expiry ru=
les.
>=20
> And so, -a lost its raison d'etre.
>=20
> Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
> ---
>=20
>=20
> This is on top of bc/maint-keep-pack

I didn't check all the (proposed) commits for that branch, so just let
me know if I'm missing anything, but doesn't this change mean that you
just lose what "-ad" did?

We have:
	-a	Create a new pack, containing all reachable objects
	-A	Same as -a
	-ad	Same as -a, and drop all old packs and loose objects
	-Ad	Sama as -ad, but keep unreachable objects loose

-Ad is nice regarding it's safety-net value, but eg. after a large
filter-branch run, when refs/original and the reflogs have been cleaned=
,
you just want to get rid of all those old unreachable objects,
immediately. For example after importing and massaging some large
history from SVN, the -Ad behaviour is definitely _not_ what I want
there. Writing a few thousand loose objects just to prune them is just =
a
waste of time.

Bj=F6rn
