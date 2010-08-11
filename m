From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 3/4] cherry-pick/revert: Use error() for failure message
Date: Wed, 11 Aug 2010 03:37:24 -0500
Message-ID: <20100811083724.GD16495@burratino>
References: <20100725005443.GA18370@burratino>
 <AANLkTilnQhsopnuAf0nja8Qq63VrOlt0_uCJrqYv5X-v@mail.gmail.com>
 <201007251122.41166.trast@student.ethz.ch>
 <20100729235151.GB6623@burratino>
 <AANLkTi=ao2RY8NGm4cACqz3_5zfT2zvXB4JHOopBD9T5@mail.gmail.com>
 <20100811083100.GA16495@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@student.ethz.ch>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Jeff King <peff@peff.net>,
	Christian Couder <chriscool@tuxfamily.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 11 10:39:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oj6qd-0002s6-7g
	for gcvg-git-2@lo.gmane.org; Wed, 11 Aug 2010 10:39:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932743Ab0HKIjD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Aug 2010 04:39:03 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:63330 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932680Ab0HKIix convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Aug 2010 04:38:53 -0400
Received: by yxg6 with SMTP id 6so4027410yxg.19
        for <git@vger.kernel.org>; Wed, 11 Aug 2010 01:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=zbPmnccUcgNMCtdkfxzv0hkT4msQz3W458CepaoBHYs=;
        b=gthfrEZn/yPmrsxIEUESFXmG1M4C4/1lKNV4Moy+amzOdR61gSUvQw7IrHm+KIi89j
         9dvM6y/f+f3vOVEBmnqtGk8ilt1E5pd+5l9gsuBrjDMRBXaOWvxoJ3c48LvvKg5gp1nh
         Hr2XiIyREy3Jvl7M+R3wZDRy4AYuBT3p5Oc1I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=Ze4YjdA8TPnK+6W+c58LQnCX8MUT6cdrxsISYe0nPIzjf0YHLKxpPSLEbj1ZfwmdJO
         b1kQ8sec7Zfd2sAEGLco6gqnnPvQYzdFj9hLx6nAr46Yrfz1g4CBpGvD4Os7hqi7ZtuI
         l1eXEdvOufyc78/3LgyESXHPzfvR620g5+ddY=
Received: by 10.151.148.14 with SMTP id a14mr4049475ybo.421.1281515932612;
        Wed, 11 Aug 2010 01:38:52 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id v6sm5140504ybm.11.2010.08.11.01.38.51
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 11 Aug 2010 01:38:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100811083100.GA16495@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153208>

When cherry-pick fails after picking a large series of commits, it can
be hard to pick out the error message and advice.  Clarify the error
and prefix it with =E2=80=9Cerror: =E2=80=9D to help.

Before:

	Automatic cherry-pick failed.  [...advice...]

After:

	error: could not apply 7ab78c9... Do something neat.
	[...advice...]

Noticed-by: Thomas Rast <trast@student.ethz.ch>
Encouraged-by: Sverre Rabbelier <srabbelier@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/revert.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 74c1581..9a7483b 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -524,8 +524,11 @@ static int do_pick_commit(void)
 	}
=20
 	if (res) {
-		fprintf(stderr, "Automatic %s failed.%s\n",
-			mebuf.buf, help_msg());
+		error("could not %s %s... %s",
+		      action =3D=3D REVERT ? "revert" : "apply",
+		      find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV),
+		      msg.subject);
+		fprintf(stderr, help_msg());
 		rerere(allow_rerere_auto);
 	} else {
 		if (!no_commit)
--=20
1.7.2.1.544.ga752d.dirty
