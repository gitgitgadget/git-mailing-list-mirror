From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v2 0/8] Default pager and editor
Date: Fri, 30 Oct 2009 05:16:34 -0500
Message-ID: <20091030101634.GA1610@progeny.tock>
References: <1256742357-sup-3798@ntdws12.chass.utoronto.ca>
 <7vskd3o11t.fsf@alter.siamese.dyndns.org>
 <20091029073224.GA15403@progeny.tock>
 <20091029075021.GC15403@progeny.tock>
 <7v8weu6idl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ben Walton <bwalton@artsci.utoronto.ca>,
	Johannes Sixt <j.sixt@viscovery.net>,
	David Roundy <roundyd@physics.oregonstate.edu>,
	GIT List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 30 11:06:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3oNN-0004HI-19
	for gcvg-git-2@lo.gmane.org; Fri, 30 Oct 2009 11:06:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756367AbZJ3KGW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Oct 2009 06:06:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755881AbZJ3KGW
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 06:06:22 -0400
Received: from mail-yx0-f187.google.com ([209.85.210.187]:63420 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755849AbZJ3KGV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 06:06:21 -0400
Received: by yxe17 with SMTP id 17so2531098yxe.33
        for <git@vger.kernel.org>; Fri, 30 Oct 2009 03:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=JHKugT1t/0r9I556qTnz/JFmKefE0dtlixpTjeyyt5w=;
        b=tXnuh4kzZAroH2gFoHQuceqymM++HgA3ekBukNHXQRv3KkXq568BkSWmsfRFyPxDha
         1jDl/vPn57G/PPgWsLQ5MHebguT0r+CZ8YHjw1pM3hb3QYq0fLVbPxmnV17wwZYB3xSl
         Bd1tKE0G7WVqeVbgqxjTuhUsZ9KKTwm8aYdiQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=vkfKl/Mc6boghdGgbwEh3DyzAl0W9i4iFByaU/Zg9GlVdm8hhkdDVOJpYR/U6Lnb09
         vLel38LdECgu0MDQo373oBKAh8xavhMJMt3v1CrRdq/egU0Grg3iw4720l8TSlfC4veB
         xSapEOLwEty8piakFHMzstSIcoSxoQk7j16qA=
Received: by 10.90.222.1 with SMTP id u1mr3798125agg.103.1256897186302;
        Fri, 30 Oct 2009 03:06:26 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 4sm1292636yxd.70.2009.10.30.03.06.24
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 30 Oct 2009 03:06:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v8weu6idl.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131684>

Junio C Hamano wrote:

> My "how about" patch on DEFAULT_PAGER might be minimally safe with
>=20
>     make DEFAULT_PAGER=3D"/c/my program/less"

It isn=E2=80=99t, actually, since in pager.c the pager already gets run=
 through
sh if it contains certain shell metacharacters.

> but if you are going to do this for real, you would need to use prope=
r
> quoting in the Makefile (look for _SQ for hints).

Good catch --- thanks.
=20
> > This change makes t7005-editor into a mess.  Any ideas for fixing
> > this?
>=20
> I think the introduction of DEFAULT_EDITOR makes it unfixable; your
> DEFAULT_EDITOR may be set to '/usr/bin/vi' not 'vi'.
>=20
> Just detect DEFAULT_EDITOR being not the default 'vi' and abort/skip =
the
> entire test, perhaps?

Yep, unfortunately that looks like the best thing to do.  I tried to
salvage some of the test for distros (like Debian) that might override
the default without using an absolute path.

Here=E2=80=99s an updated series.  It doesn=E2=80=99t provide git var -=
-run yet since
the Windows exit status magic means that would require either futzing
with the run_pager() implementation or reimplementing cat in var.c.

Thoughts?

Johannes Sixt (1):
  Teach git var about GIT_EDITOR

Jonathan Nieder (6):
  launch_editor: Longer error message when TERM=3Ddumb
  Handle more shell metacharacters in editor name
  Teach git var about GIT_PAGER
  add -i, send-email, svn, p4, etc: Use "git var GIT_EDITOR"
  am -i, git-svn: use $(git var GIT_PAGER) instead of 'less'
  Provide a build time default-editor setting

Junio C Hamano (1):
  Provide a build time default-pager setting

 Documentation/config.txt         |    4 +---
 Documentation/git-commit.txt     |    2 +-
 Documentation/git-send-email.txt |    4 ++--
 Documentation/git-var.txt        |   14 ++++++++++++++
 Makefile                         |   28 ++++++++++++++++++++++++++++
 cache.h                          |    2 ++
 contrib/fast-import/git-p4       |    5 +----
 editor.c                         |   33 ++++++++++++++++++++++++++++--=
---
 git-add--interactive.perl        |    3 +--
 git-am.sh                        |    5 ++++-
 git-send-email.perl              |    3 ++-
 git-sh-setup.sh                  |   19 ++++++-------------
 git-svn.perl                     |   11 ++++-------
 pager.c                          |   24 ++++++++++++++++++++----
 t/t7005-editor.sh                |   31 ++++++++++++++++++++++++------=
-
 var.c                            |   20 ++++++++++++++++++++
 16 files changed, 158 insertions(+), 50 deletions(-)
