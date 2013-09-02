From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] Turn off pathspec magic on "{checkout,reset,add} -p" on
 native Windows builds
Date: Mon, 2 Sep 2013 16:30:00 +0700
Message-ID: <20130902092959.GA17306@lanh>
References: <521EF02A.2020300@viscovery.net>
 <1378001284-18426-1-git-send-email-pclouds@gmail.com>
 <5224334A.2090300@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Alex Riesen <raa.lkml@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Sep 02 11:27:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGQPW-0005eQ-D1
	for gcvg-git-2@plane.gmane.org; Mon, 02 Sep 2013 11:27:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758421Ab3IBJ06 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Sep 2013 05:26:58 -0400
Received: from mail-pb0-f54.google.com ([209.85.160.54]:59936 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758411Ab3IBJ05 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Sep 2013 05:26:57 -0400
Received: by mail-pb0-f54.google.com with SMTP id ro12so4519750pbb.41
        for <git@vger.kernel.org>; Mon, 02 Sep 2013 02:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=33IqZimjGqqToklcddJEwdVEqTVUAi6zSibm3xyufxE=;
        b=ertbI1q6ymATcMh6Ks60M1G7G28G55ZzN1ZCmQ5EOtyM0xc8GgAA9G2Ule40lNSnM9
         7o/35606B2y9n7rQATjg0dLUqvZj7BEOciFv2aabawXagadHzLF9scLcgQ56IqOY/8Y3
         vrJzMnR0DMVR6A1uwJ6IBH4wd+vYDM2pOdXzTfbE8UtGUsbuVVcu4/eTxFqg0DLOZYQO
         dVeVaJJxBbPe189UwhGBLwhGbHRaC2oGA4B/JlSsEpvqREoHVoioh5hTbjr/3pvwZHtr
         SciwufGGftC/MsZT0vD3hQkyEY6/dKW/Hk7MtU1gX5OZlpMU4wxWFe/VOJhd7XLaBNmg
         M/7w==
X-Received: by 10.66.171.204 with SMTP id aw12mr25239045pac.7.1378114016719;
        Mon, 02 Sep 2013 02:26:56 -0700 (PDT)
Received: from lanh ([115.73.192.103])
        by mx.google.com with ESMTPSA id a5sm14712163pbw.4.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 02 Sep 2013 02:26:55 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 02 Sep 2013 16:30:00 +0700
Content-Disposition: inline
In-Reply-To: <5224334A.2090300@viscovery.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233631>

On Mon, Sep 02, 2013 at 08:42:18AM +0200, Johannes Sixt wrote:
> Am 9/1/2013 4:08, schrieb Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy:
> > git-add--interactive.perl rejects arguments with colons in 21e9757
> > (Hack git-add--interactive to make it work with ActiveState Perl -
> > 2007-08-01). Pathspec magic starts with a colon, so it won't work i=
f
> > these pathspecs are passed to git-add--interactive.perl running wit=
h
> > ActiveState Perl. Make sure we only pass plain paths in this case.
> >=20
> > Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@g=
mail.com>
> > ---
> >  Johannes, can you check the test suite passes for you with this
> >  patch? I assume that Cygwin Perl behaves differently and does not =
hit
> >  this limit. So I keep the special case to GIT_WINDOWS_NATIVE only.
> >  I'll resend the patch with a few others on the same topic if it wo=
rks
> >  for you.
>=20
> It does not help. The error in git-add--interactive is avoided, but t=
he
> failure in t2016-checkout-patch.sh is now:
>=20
> expecting success:
>         set_state dir/foo work head &&
>         # the third n is to get out in case it mistakenly does not ap=
ply
>         (echo y; echo n; echo n) | (cd dir && git checkout -p foo) &&
>         verify_saved_state bar &&
>         verify_state dir/foo head head
>=20
> No changes.
> not ok 13 - path limiting works: foo inside dir
>=20
> and the same "No changes." happens in t7105-reset-patch.sh

Right. Because I got rid of ':(prefix)foo' form but I passed 'foo'
instead of 'dir/foo'. How about this on top?

-- 8< --
diff --git a/builtin/add.c b/builtin/add.c
index 3402239..a138360 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -257,9 +257,15 @@ int run_add_interactive(const char *revision, cons=
t char *patch_mode,
 	if (revision)
 		args[ac++] =3D revision;
 	args[ac++] =3D "--";
+#ifdef GIT_WINDOWS_NATIVE
+	GUARD_PATHSPEC(pathspec, PATHSPEC_FROMTOP);
+	for (i =3D 0; i < pathspec->nr; i++)
+		args[ac++] =3D pathspec->items[i].match;
+#else
 	for (i =3D 0; i < pathspec->nr; i++)
 		/* pass original pathspec, to be re-parsed */
 		args[ac++] =3D pathspec->items[i].original;
+#endif
=20
 	status =3D run_command_v_opt(args, RUN_GIT_CMD);
 	free(args);
-- 8< --
