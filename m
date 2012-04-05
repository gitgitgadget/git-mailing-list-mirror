From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 4/7] revert: allow single-pick in the middle of
 cherry-pick sequence
Date: Thu, 5 Apr 2012 07:15:08 -0500
Message-ID: <20120405121507.GA5175@burratino>
References: <20111122111207.GA7399@elie.hsd1.il.comcast.net>
 <20111122112001.GF7399@elie.hsd1.il.comcast.net>
 <7vr50zd5x0.fsf@alter.siamese.dyndns.org>
 <20111123012721.GA14217@elie.hsd1.il.comcast.net>
 <4ECCB3A2.5030102@viscovery.net>
 <20111123100452.GA30629@elie.hsd1.il.comcast.net>
 <4ECCC935.7010407@viscovery.net>
 <20111210124644.GA22035@elie.hsd1.il.comcast.net>
 <20111210125948.GE22035@elie.hsd1.il.comcast.net>
 <CACBZZX53dhb2SYMcMrQnhm3nsdTvZOm_0BCbSdPEPNdT0vxgTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 05 14:15:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFlb3-0008Ne-RM
	for gcvg-git-2@plane.gmane.org; Thu, 05 Apr 2012 14:15:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751880Ab2DEMPT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Apr 2012 08:15:19 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:39892 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751591Ab2DEMPS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Apr 2012 08:15:18 -0400
Received: by gghe5 with SMTP id e5so629791ggh.19
        for <git@vger.kernel.org>; Thu, 05 Apr 2012 05:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=UqW/Hmdg01gg3uLikFw2jnNx4/RoLFKIhNPsN2wGaPk=;
        b=CGAfq1IW62ADBdIC8L4omdCCGnMSv7Dl9tQGXIcDqXFVcadcRUqZTt47HwHZ0s60rl
         bmvIoiL/94qzo8JvW9FC52SyguNtxqyjVDuI/8jJIldjOa5/eonsPW100qKAUPoVvecJ
         Pobw17PUMQCPvs/IUK0FxtQhy3TWQcXapO9EnnAwFHuz+VajGXq7CXYW6Alx7n1kKK24
         oOE78gkq91mEEm+rXSYZ5sidmPOMApmG8xdRgJj2/rNm5lh4Fx3/MLrZd4jpWWTk1FGp
         7VITtcEt4YwAzCKpYYpZMZcoIMNiNb/ev2syUtXW1HvTW5Pr57v4XCQU6ZU3QhrsRbZ8
         YVOw==
Received: by 10.50.187.226 with SMTP id fv2mr4553209igc.40.1333628117224;
        Thu, 05 Apr 2012 05:15:17 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id k8sm10830570igz.4.2012.04.05.05.15.15
        (version=SSLv3 cipher=OTHER);
        Thu, 05 Apr 2012 05:15:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACBZZX53dhb2SYMcMrQnhm3nsdTvZOm_0BCbSdPEPNdT0vxgTA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194767>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> This might be an issue introduced later in Ramkumar's code when he
> moved this around, but on git.git's e5056c0 I get this:
>
>     $ ./git revert --author=3D=C3=86var :/i18n
>     fatal: BUG: expected exactly one commit from walk

This seems buggy on two counts:

 1. The ":/" magic should probably imply --do-walk so that

	git show --author=3D=C3=86var :/i18n

    does the right thing.

 2.

	$ git cherry-pick --author=3D=C3=86var origin/pu
	fatal: BUG: expected exactly one commit from walk

   The single-pick code does not understand that such a
   simple revision specifier can return no revisions.  A more
   appropriate error message would be

	fatal: empty commit set passed

diff --git i/sequencer.c w/sequencer.c
index a37846a5..736ccd57 100644
--- i/sequencer.c
+++ w/sequencer.c
@@ -908,7 +908,10 @@ int sequencer_pick_revisions(struct replay_opts *o=
pts)
 		if (prepare_revision_walk(opts->revs))
 			die(_("revision walk setup failed"));
 		cmit =3D get_revision(opts->revs);
-		if (!cmit || get_revision(opts->revs))
+		if (!cmit)
+			/* e.g. "git cherry-pick --author=3Dnobody <commit>" */
+			die(_("empty commit set passed"));
+		if (get_revision(opts->revs))
 			die("BUG: expected exactly one commit from walk");
 		return single_pick(cmit, opts);
 	}
