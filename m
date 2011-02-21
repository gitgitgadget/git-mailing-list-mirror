From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 08/15] clone: split "Cloning into" message into two
Date: Mon, 21 Feb 2011 04:18:53 -0600
Message-ID: <20110221101852.GI32137@elie>
References: <1298143495-3681-1-git-send-email-avarab@gmail.com>
 <20110221040012.GB26968@elie>
 <20110221101229.GA32137@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 21 11:19:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PrSrB-0002Zl-M3
	for gcvg-git-2@lo.gmane.org; Mon, 21 Feb 2011 11:19:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755214Ab1BUKS7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Feb 2011 05:18:59 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:61870 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755208Ab1BUKS6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Feb 2011 05:18:58 -0500
Received: by mail-iw0-f174.google.com with SMTP id 8so1729136iwn.19
        for <git@vger.kernel.org>; Mon, 21 Feb 2011 02:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=9Smbh0mFX4VtcAcT3RBepQuimGbXvEO/bFJYmE9ZVfw=;
        b=Sf9+vtuGqoUo/zlpS4DjkCkptwsTCaWNh/TVEXsB7eHbO6DCj+fs3g/IzxVNwe8kQK
         qxBdGsvZgEx5t+8pRkO5NgvauTehS7FoZBbHYhgHBgQs8FCKF7Q51p4/h4AP8j/IfM5R
         VO7vYt9kqmKxiEDq9/ukeG3Zs2/5EZKP2nZkE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=v+ogFgGxGSxpAbIpOITTSbcTHtGTv1ouWWYF5ZzZPvMd1j7RuIqMwOqxnrdldwemXG
         7LwfVfc+rzdhFrrnC2Ol8OOE200wn2ahgUlKOwVUL/9SW5V74yV5OxUS7HBb2TDxmV7c
         8A2uDoaxaI/nBJhE38vCZ5USUrCzmrORcL/sM=
Received: by 10.231.30.73 with SMTP id t9mr1048840ibc.64.1298283538585;
        Mon, 21 Feb 2011 02:18:58 -0800 (PST)
Received: from elie (adsl-69-209-53-52.dsl.chcgil.sbcglobal.net [69.209.53.52])
        by mx.google.com with ESMTPS id 8sm5040453iba.10.2011.02.21.02.18.56
        (version=SSLv3 cipher=OTHER);
        Mon, 21 Feb 2011 02:18:57 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110221101229.GA32137@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167463>

=46rom: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Date: Wed, 1 Sep 2010 15:54:30 +0000

Separate the "Cloning into %s" and "Cloning into bare repository %s"
messages to make them easier to translate.  No noticeable change
intended.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/clone.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index f46d09b..db0240d 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -468,9 +468,12 @@ int cmd_clone(int argc, const char **argv, const c=
har *prefix)
 		die(_("could not create leading directories of '%s'"), git_dir);
 	set_git_dir(make_absolute_path(git_dir));
=20
-	if (0 <=3D option_verbosity)
-		printf("Cloning into %s%s...\n",
-		       option_bare ? "bare repository " : "", dir);
+	if (0 <=3D option_verbosity) {
+		if (option_bare)
+			printf("Cloning into bare repository %s...\n", dir);
+		else
+			printf("Cloning into %s...\n", dir);
+	}
 	init_db(option_template, INIT_DB_QUIET);
=20
 	/*
--=20
1.7.4.1
