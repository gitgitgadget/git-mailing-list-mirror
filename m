From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v2 0/3] Towards a useable git-branch
Date: Fri, 24 May 2013 19:49:34 +0530
Message-ID: <1369405177-7855-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 24 16:18:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ufsom-0006CK-HH
	for gcvg-git-2@plane.gmane.org; Fri, 24 May 2013 16:18:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756393Ab3EXOR7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 10:17:59 -0400
Received: from mail-pb0-f42.google.com ([209.85.160.42]:37521 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756373Ab3EXORy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 10:17:54 -0400
Received: by mail-pb0-f42.google.com with SMTP id uo1so4283844pbc.15
        for <git@vger.kernel.org>; Fri, 24 May 2013 07:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=vJvDrJ+UDOU7w2ySRHG8O9RrHM7qSpoaUr1+YFK4/v0=;
        b=Sh5/8IhtfDfJIyJEZNLexOn3GZK4HJDYODHZ1RCOUXBO77xsNL87FOuo0IRxOMEroT
         0126Pie+D+0MWyEU+fTDD5uEolZ0WtjTngQqvdYvZlqOyX49YjrhMOM/RPMMUrlUq6WD
         0dCmPZQ+LYdJeOQ+JzSbkbFDfdbJuA08lsUYO6O2iasEOy9tmIypaJbfFrpxlpcfaE5U
         FRK6p6gfVm9sJ+3nTSVAIVz2UqWHbzgX+HK0NBu2YhUSpz1iP2rW0pl8+e7hkawmOFo1
         ggy5r+9pwkSl97GCqRBf9m/UbBwc9Y4ka9/5Q1FOhJy3WyxscmyEfZIsRLZ4te12zi8S
         ZYTA==
X-Received: by 10.68.202.99 with SMTP id kh3mr17942814pbc.74.1369405074299;
        Fri, 24 May 2013 07:17:54 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id qp4sm16338288pbc.41.2013.05.24.07.17.51
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 24 May 2013 07:17:53 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.2.g99b8f3f.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225354>

So, while investigating alignment operators in pretty-formats, I found
out that it's way too much effort and totally not worth it (atleast
not immediately; we can add it later if we want).  What I want now is
a useable git-branch output.  And I think I can say that I've achieved
it.

I currently have hot aliased to

for-each-ref --format='%C(red)%(HEAD)%C(reset) %C(green)%(refname:short)%C(reset)%(upstream:trackshort)' --count 10 --sort='-committerdate' refs/heads

and it works beautifully for me.  Sample output:

% git hot
* hot-branch<>
  pickaxe-doc>
  publish-rev=
  publish-rev-test
  upstream-error=
  push-current-head=
  master=
  prompt=
  autostash-stash=
  rebase.autostash=

The asterisk is red, the branch names are in green, and the tracking
marker is white.

I'm very happy with the implementation too:

1. color only kicks in at the parsing layer.
2. HEAD is a new atom.
3. :track[short] is a formatp like :short.

There is no need to use a hammer and coerce everything into an atom,
or throw everything out the window and start from scratch to conform
to pretty-formats perfectly.  Let's extend the existing format to be
_useful_ sensibly.

Thanks.

Ramkumar Ramachandra (3):
  for-each-ref: introduce %C(...) for color
  for-each-ref: introduce %(HEAD) marker
  for-each-ref: introduce %(upstream:track[short])

 builtin/for-each-ref.c | 81 +++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 73 insertions(+), 8 deletions(-)

-- 
1.8.3.rc3.2.g99b8f3f.dirty
