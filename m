From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 0/8] more warnings and cleanups
Date: Wed, 16 Mar 2011 01:53:15 -0500
Message-ID: <20110316065256.GA5988@elie>
References: <20110316024959.GA24932@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 16 07:53:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pzkbn-0003uY-Nt
	for gcvg-git-2@lo.gmane.org; Wed, 16 Mar 2011 07:53:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751710Ab1CPGxX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2011 02:53:23 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:35066 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751241Ab1CPGxV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2011 02:53:21 -0400
Received: by gyf1 with SMTP id 1so534712gyf.19
        for <git@vger.kernel.org>; Tue, 15 Mar 2011 23:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=FoJvD3E4c5tmVH9zhwKROP1tmjaRhYFxgG9rkEg1SXY=;
        b=LGNcSW090eX5NojJ5e45LS/eHMUCbd/Z06p//2Ssn2pwbsa7JP8448zvXF2wlPPJDM
         g4rIi849a8478sEOXhgONQdy/1uVKP+qkfCZihbDmyB9rLhxjDs2MJwfhxXxEK9TqdA0
         B+vy2QkFRMxgiFyrAcYOuaButrxKyU5oqTeKI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=MfkFMJUCcjvmOfvEkjxsfdZxydP3csIFFl1urrf8D8m15Gvuebb4p3YV8ymUJ4ssRP
         ALKtBzncUWu5wZCcbuoSR9NncdXK2hM9rKqrf1R5ItK0mUPFsDMElTLg0jaHyvMA/Uhb
         5N4dar8cjX7Gt00ihDOlbuHusmIx8V0qy6vZ4=
Received: by 10.90.61.39 with SMTP id j39mr1019923aga.17.1300258401204;
        Tue, 15 Mar 2011 23:53:21 -0700 (PDT)
Received: from elie (adsl-69-209-56-53.dsl.chcgil.sbcglobal.net [69.209.56.53])
        by mx.google.com with ESMTPS id u20sm822163anu.34.2011.03.15.23.53.19
        (version=SSLv3 cipher=OTHER);
        Tue, 15 Mar 2011 23:53:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110316024959.GA24932@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169108>

Here are some more patches in the same vein.

Patches 1-4 fix style problems noticed with make CC="c89 -pedantic"
(mostly concerning the -pedantic rather than the c89).

Patch 5 updates fast-import.c (and everyone else) to put braces on the
same line as "struct foo" --- the waste of space had bothered me every
time I hacked on fast-import.c so now is my chance. :)

Patches 6-8 factor out some new functions to un-indent code a little.
The indented code was discovered in changing

	struct pretty_print_ctx ctx = {0};

into something more verbose to appease gcc -Wmissing-field-initializers,
which probably wasn't a good idea after all. :)  But the by-product is
nice.

Jonathan Nieder (8):
  enums: omit trailing comma for portability
  compat: make gcc bswap an inline function
  svn-fe: do not use "return" for tail call returning void
  vcs-svn: remove spurious semicolons
  standardize brace placement in struct definitions
  branch: split off function that writes tracking info and commit
    subject
  cherry: split off function to print output lines
  diff --submodule: split into bite-sized pieces

 builtin/add.c         |    3 +-
 builtin/blame.c       |    3 +-
 builtin/branch.c      |   48 +++++++++++++----------
 builtin/grep.c        |    3 +-
 builtin/index-pack.c  |    6 +--
 builtin/log.c         |   34 +++++++++--------
 cache.h               |    2 +-
 commit.h              |    3 +-
 compat/bswap.h        |   18 +++++----
 config.c              |    3 +-
 convert.c             |    2 +-
 diff.c                |    6 +--
 fast-import.c         |   42 +++++++-------------
 http-push.c           |   15 ++-----
 http-walker.c         |    6 +--
 http.h                |   15 ++-----
 merge-recursive.c     |   12 ++----
 pack-check.c          |    3 +-
 string-list.h         |    3 +-
 submodule.c           |  103 +++++++++++++++++++++++++++++--------------------
 transport-helper.c    |    3 +-
 vcs-svn/repo_tree.c   |    2 +-
 vcs-svn/string_pool.c |    2 +-
 vcs-svn/svndump.c     |    3 +-
 24 files changed, 164 insertions(+), 176 deletions(-)
