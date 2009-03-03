From: =?UTF-8?B?VG9yIEFybmUgVmVzdGLDuA==?= <torarnv@gmail.com>
Subject: Re: [PATCH] git-clone: Add option --branch to override initial branch
Date: Tue, 03 Mar 2009 01:11:27 +0100
Message-ID: <49AC75AF.4080003@gmail.com>
References: <1236031882-2052-1-git-send-email-torarnv@gmail.com> <alpine.DEB.1.00.0903030047130.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 03 01:13:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeIGP-0004do-TC
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 01:13:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757323AbZCCALl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Mar 2009 19:11:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756806AbZCCALl
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Mar 2009 19:11:41 -0500
Received: from mail-fx0-f176.google.com ([209.85.220.176]:62253 "EHLO
	mail-fx0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759807AbZCCALk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Mar 2009 19:11:40 -0500
Received: by fxm24 with SMTP id 24so2232295fxm.37
        for <git@vger.kernel.org>; Mon, 02 Mar 2009 16:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=fCJbYxAWjnW1VpvISRqz/4hcIiyQy7auskWYjPSbG/c=;
        b=ehn5nv2zYYUvGfUuYHBiFT5Q6iiZNI5RZiqbmiEX2fJF+N1ZOm9PxAlM7pCbo2lxx/
         rN/bZ30elZ/QRudOTEXLBZLBP090aAf1TGNAiJM/d8mhlXRumSUcNqxIZo0jnHUbtzST
         SBAOB6EXPQV3BKmngF9BSHVN6tQd0Bd+a/yk4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=nkV6tDoqlttZmmmoMS5Y0Z+NaG3CTOV0MmaHZ4bDpXovkiKnLzAUn0KMTSbY3mzxFF
         w4ZbesBbeognRgXLRMHZfHQayNPM4Gb5XBrR8r1w7LggzYdjnF2UBXWaFTBsdqNDod+u
         XoeYILjcTnj5xp5cJ+6iiWL7vplCfxsymZMqM=
Received: by 10.86.59.18 with SMTP id h18mr2030203fga.1.1236039097057;
        Mon, 02 Mar 2009 16:11:37 -0800 (PST)
Received: from ?192.168.1.226? (212251244070.customer.cdi.no [212.251.244.70])
        by mx.google.com with ESMTPS id l12sm42702fgb.51.2009.03.02.16.11.36
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 02 Mar 2009 16:11:36 -0800 (PST)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <alpine.DEB.1.00.0903030047130.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111980>

Johannes Schindelin wrote:
> On Mon, 2 Mar 2009, Tor Arne Vestb=C3=B8 wrote:
>> The options --branch and -b allow the user to override the initial=20
>> branch created and checked out by git-clone. Normally this is the ac=
tive=20
>> branch of the remote repository, which is also the fallback if the=20
>> selected branch is not found.
>=20
> I do not think that falling back if the selected branch is not found =
is a=20
> wise choice.

Ah, was not sure what the proper response would be. I'll resubmit with =
a
die() instead.

> Besides, the common way to check out something different than the rem=
ote's=20
> HEAD is like this:
>=20
> 	$ git clone -n $URL
> 	$ cd $DIR
> 	$ git checkout -t origin/$BRANCH

Yepp, plus removing the original branch:

 $ git branch -D $ORIGINAL_ACTIVE_BRANCH # typically master

> I am undecided if that is good enough, or your patch is needed.

The idea was to be able to tell someone "hey, if you want to hack on
some feature for next, do the following:"

 $ git clone git://git.kernel.org/pub/scm/git/git.git -b next

Maybe next is not such a good example, since it does not diverge that
much from master and pu, but imagine a repository with a master, plus
other branches that over time diverge from master (where you would
typically use git-new-workdir to have them in a separate working tree).

In that situation it would be nice to be able to tell someone, hey, if
you want to work on this odd branch which is not master, just do -b.

Tor Arne
