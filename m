From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v4 0/9] Default pager and editor
Date: Wed, 11 Nov 2009 17:51:00 -0600
Message-ID: <20091111235100.GA1140@progeny.tock>
References: <20091030101634.GA1610@progeny.tock>
 <20091031012050.GA5160@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ben Walton <bwalton@artsci.utoronto.ca>,
	Johannes Sixt <j.sixt@viscovery.net>,
	David Roundy <roundyd@physics.oregonstate.edu>,
	GIT List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 12 00:41:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8Mo8-000468-6q
	for gcvg-git-2@lo.gmane.org; Thu, 12 Nov 2009 00:41:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759627AbZKKXkt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Nov 2009 18:40:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759603AbZKKXkt
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Nov 2009 18:40:49 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:41713 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759614AbZKKXks (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2009 18:40:48 -0500
Received: by yxe17 with SMTP id 17so1457452yxe.33
        for <git@vger.kernel.org>; Wed, 11 Nov 2009 15:40:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=cS5PtFZtg4isMTYfHi6WXG9xwiSOUuXGHDTJdeg3Cwg=;
        b=LRrLJAcFlGz3DAtFBVlncLNraKo5vSua+QlluoIBUasCbCbvPN0LnQxGk2tNtzjDs3
         W8Xn3elK5l84/5QE849/HLPGjQKsNXG7EwszkebtsFWtp9gZtY6drgbl7Mrr1o8G6s28
         uWSuAycIE7HXIvoaO5godyJJzJ1GVCxPt62Cg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=rSLo+VM+EpFx+LBT4o8Cbg/+EYgQFbxa1pgHWyOL9uqMlzYcdwZiO9qEDdSYNZx3Pq
         CQjrOux8Nq15F5JFb1LdqQrB2SnJleQRYsyBXHbW5KOVl4M6+2v3POgyC92Elj/M/A4g
         RDZZkEXM2ANVXAJeozI37JCXg/u2lbxr3Ifgg=
Received: by 10.150.88.25 with SMTP id l25mr3934971ybb.170.1257982850506;
        Wed, 11 Nov 2009 15:40:50 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 15sm1056626gxk.12.2009.11.11.15.40.48
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 11 Nov 2009 15:40:49 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20091031012050.GA5160@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132721>

Junio C Hamano wrote:=20

> * jn/editor-pager (2009-10-30) 8 commits
>  - Provide a build time default-pager setting
>  - Provide a build time default-editor setting
>  - am -i, git-svn: use "git var GIT_PAGER"
>  - add -i, send-email, svn, p4, etc: use "git var GIT_EDITOR"
>  - Teach git var about GIT_PAGER
>  - Teach git var about GIT_EDITOR
>  - Do not use VISUAL editor on dumb terminals
>  - Handle more shell metacharacters in editor names
>=20
> Any comments?

Here=E2=80=99s a reroll.  The interdiff is very small:

diff --git a/ident.c b/ident.c
index 99f1c85..26409b2 100644
--- a/ident.c
+++ b/ident.c
@@ -205,7 +205,7 @@ const char *fmt_ident(const char *name, const char =
*email,
 		if ((warn_on_no_name || error_on_no_name) &&
 		    name =3D=3D git_default_name && env_hint) {
 			fprintf(stderr, env_hint, au_env, co_env);
-			env_hint =3D NULL; /* warn only once, for "git var -l" */
+			env_hint =3D NULL; /* warn only once */
 		}
 		if (error_on_no_name)
 			die("empty ident %s <%s> not allowed", name, email);

and the corresponding hunk in patch 3 could be safely discarded.
Aside from that, patch 3 has been unsquashed from patch 4, since it is
an independent fix that might be worth ejecting; the Signed-off-by
lines on patches 2 and 4 have been fixed; and the commit message for
patch 4 has been expanded to explain more.

In short, nothing of substance has changed.  If you are reminded of
any thoughts on the series, please let me know.

I think it is fair to say every one of these patches except the first
was someone else=E2=80=99s idea.  Thanks, everyone.

Jonathan Nieder (8):
  Handle more shell metacharacters in editor names
  Do not use VISUAL editor on dumb terminals
  Suppress warnings from "git var -l"
  Teach git var about GIT_EDITOR
  Teach git var about GIT_PAGER
  add -i, send-email, svn, p4, etc: use "git var GIT_EDITOR"
  am -i, git-svn: use "git var GIT_PAGER"
  Provide a build time default-editor setting

Junio C Hamano (1):
  Provide a build time default-pager setting

 Documentation/config.txt         |    4 +--
 Documentation/git-commit.txt     |    2 +-
 Documentation/git-send-email.txt |    4 +-
 Documentation/git-var.txt        |   14 +++++++++++
 Makefile                         |   28 ++++++++++++++++++++++
 cache.h                          |    2 +
 contrib/fast-import/git-p4       |    5 +---
 editor.c                         |   32 ++++++++++++++++++-------
 git-add--interactive.perl        |    3 +-
 git-am.sh                        |    5 +++-
 git-send-email.perl              |    3 +-
 git-sh-setup.sh                  |   19 +++++----------
 git-svn.perl                     |   11 +++-----
 ident.c                          |    2 +-
 pager.c                          |   24 ++++++++++++++++---
 t/t7005-editor.sh                |   47 ++++++++++++++++++++++++++++--=
-------
 t/t7501-commit.sh                |    8 +++---
 t/test-lib.sh                    |    8 +++---
 var.c                            |   26 ++++++++++++++++++++-
 19 files changed, 178 insertions(+), 69 deletions(-)
