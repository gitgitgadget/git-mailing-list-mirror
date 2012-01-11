From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: Re: [PATCH RFC] commit: allow to commit even if there are intent-to-add entries
Date: Wed, 11 Jan 2012 16:59:40 +0700
Message-ID: <1326275982-29866-1-git-send-email-pclouds@gmail.com>
References: <1326261707-11484-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 11 11:00:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkuyP-00079O-9H
	for gcvg-git-2@lo.gmane.org; Wed, 11 Jan 2012 11:00:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753040Ab2AKJ7z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Jan 2012 04:59:55 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:42218 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752499Ab2AKJ7x (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jan 2012 04:59:53 -0500
Received: by iabz25 with SMTP id z25so884554iab.19
        for <git@vger.kernel.org>; Wed, 11 Jan 2012 01:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=shw7EhqClQ+rnF/jvK4l+v1p94UKZEqTR0BE9R43ZpM=;
        b=cfGYvkx5DdOPryN/7ABNAbkGPPBosEglQG0m3v14eLkcuK5TtQsfpGWNJqYPN3Iwcd
         Ov6p+SKkATETFppCsPzKnC1HJvqEGUUoLEOhmzfZhdgvr21QHwDejUqhRVW1UhuG6Hy7
         IKnpLSSjfraIOrGs3hGgMoJF5rLiXhwfoAS18=
Received: by 10.50.207.72 with SMTP id lu8mr6435025igc.0.1326275992077;
        Wed, 11 Jan 2012 01:59:52 -0800 (PST)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id g34sm3520064ibk.10.2012.01.11.01.59.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 11 Jan 2012 01:59:51 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 11 Jan 2012 16:59:43 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1326261707-11484-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188350>

2012/1/11 Junio C Hamano <gitster@pobox.com>:
> I have a mild suspicion that in earlier incarnation of the patch we u=
sed
> to let empty blobs committed, and then we used to instead not commit
> anything at all for such a path, and the real users were bitten by ei=
ther
> of these approaches, forgetting to add the contents to the final comm=
it.
>
> So I am not sure if this is such a good idea.

I found your elaborate writing [1] about it. These are the
interpretations listed in that post:

-- 8< --
When running "commit" and "status" with files marked with "intent to ad=
d",
I think there are three possible interpretations of what the user wants=
 to
do.

 (1) I earlier said "I'll decide the exact contents to be committed for
     these paths and tell you by running 'git add' later." when I said
     'git add -N'.  But I forgot to do so before running "git commit".
     Thanks for catching this mistake and erroring out.

 (2) I said "I'll decide the exact content to be committed ... later."
     when I said 'git add -N'. I am running "git commit" now, but I sti=
ll
     don't know what the final contents for this path should be.  I
     changed my mind, and I do not want to include the addition of thes=
e
     paths in the commit I am making.  Please do not error out, but jus=
t
     ignore the earlier 'add -N' for now.

 (3) I said "I'll decide the exact content to be committed ... later."
     when I said 'git add -N'. I am running "git commit" now, without
     explicitly telling you with 'git add' about the final contents for
     these paths.  Please take it as an implicit hint that I am happy w=
ith
     the contents in the working tree and commit them as if I said 'git
     add' on these paths, but do leave modifications to already tracked
     paths that I haven't added with 'git add'.
-- 8< --

So (1) may be the safe and sane interpretation and should be the
default. But perhaps we should allow (2) also, for example with
--skip-intent-to-add option? It's really frustrating to remove all
i-t-a, commit (I don't do "commit <path>"), then add them back.

[1] http://article.gmane.org/gmane.comp.version-control.git/170658

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (2):
  cache-tree: update API to take abitrary flags
  commit: add --skip-intent-to-add to allow commit with i-t-a entries
    in index

 builtin/commit.c       |   10 +++++++---
 cache-tree.c           |   35 +++++++++++++++++------------------
 cache-tree.h           |    5 ++++-
 merge-recursive.c      |    2 +-
 t/t2203-add-intent.sh  |   17 +++++++++++++++++
 test-dump-cache-tree.c |    2 +-
 6 files changed, 47 insertions(+), 24 deletions(-)

--=20
1.7.3.1.256.g2539c.dirty
