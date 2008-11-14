From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [RFC PATCH] repack: make repack -a equivalent to repack -A and
 drop previous -a behavior
Date: Thu, 13 Nov 2008 18:53:29 -0600
Message-ID: <jKWdt94ZxgNW0UAgUUW-qjTtpWohpQXMfvw-AUmOXND8SD5yFw0N8w@cipher.nrlssc.navy.mil>
References: <7xh1_tFsJkHTjg4Hjm-R4mGSRfYyGFmLI62OMmaNg32f86EbVIYvYrGiYpEGkvooY4pUM1e7CHk@cipher.nrlssc.navy.mil> <20081114000219.GB5285@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Fri Nov 14 01:54:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0mxU-0008Gc-GL
	for gcvg-git-2@gmane.org; Fri, 14 Nov 2008 01:54:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752662AbYKNAxd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Nov 2008 19:53:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752631AbYKNAxd
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Nov 2008 19:53:33 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:49999 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751505AbYKNAxd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2008 19:53:33 -0500
Received: by mail.nrlssc.navy.mil id mAE0rU6I006537; Thu, 13 Nov 2008 18:53:30 -0600
In-Reply-To: <20081114000219.GB5285@atjola.homenet>
X-OriginalArrivalTime: 14 Nov 2008 00:53:30.0188 (UTC) FILETIME=[693F10C0:01C945F3]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100940>

Bj=F6rn Steinbrink wrote:
> On 2008.11.13 17:22:36 -0600, Brandon Casey wrote:
>> Once upon a time, repack had only a single option which began with t=
he first
>> letter of the alphabet.  Then, a second was created which would repa=
ck
>> unreachable objects into the newly created pack so that git-gc --aut=
o could
>> be invented.  But, the -a option was still necessary so that it coul=
d be
>> called every now and then to discard the unreachable objects that we=
re being
>> repacked over and over and over into newly generated packs. Later, -=
A was
>> changed so that instead of repacking the unreachable objects, it eje=
cted
>> them from the pack so that they resided in the object store in loose=
 form,
>> to be garbage collected by prune-packed according to normal expiry r=
ules.
>>
>> And so, -a lost its raison d'etre.
>>
>> Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
>> ---
>>
>>
>> This is on top of bc/maint-keep-pack
>=20
> I didn't check all the (proposed) commits for that branch, so just le=
t
> me know if I'm missing anything, but doesn't this change mean that yo=
u
> just lose what "-ad" did?

yes.

> We have:
> 	-a	Create a new pack, containing all reachable objects
> 	-A	Same as -a
> 	-ad	Same as -a, and drop all old packs and loose objects

by loose objects, I assume you mean packed unreachable objects.

> 	-Ad	Sama as -ad, but keep unreachable objects loose
>=20
> -Ad is nice regarding it's safety-net value, but eg. after a large
> filter-branch run, when refs/original and the reflogs have been clean=
ed,
> you just want to get rid of all those old unreachable objects,
> immediately. For example after importing and massaging some large
> history from SVN, the -Ad behaviour is definitely _not_ what I want
> there. Writing a few thousand loose objects just to prune them is jus=
t a
> waste of time.

hmm. That's a good point. Even though I think it is likely that the tho=
usand
loose objects that are written will be small commit objects and not blo=
bs,
this use case may be enough to trump the safety benefit provided by the
proposed change.

-brandon
