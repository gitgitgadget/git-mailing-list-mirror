From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Introduction of a ce_namelen field
Date: Fri,  6 Jul 2012 18:07:28 +0200
Message-ID: <1341590850-15653-1-git-send-email-t.gummerer@gmail.com>
References: <7vtxxns4z4.fsf@alter.siamese.dyndns.org>
Cc: trast@student.ethz.ch, gitster@pobox.com, mhagger@alum.mit.edu,
	pclouds@gmail.com, t.gummerer@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 06 18:08:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SnB57-0000fP-0E
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jul 2012 18:08:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755082Ab2GFQIZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jul 2012 12:08:25 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:61138 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750802Ab2GFQIY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2012 12:08:24 -0400
Received: by eeit10 with SMTP id t10so3704183eei.19
        for <git@vger.kernel.org>; Fri, 06 Jul 2012 09:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=CJey3Olw8LGcB3dUleScEKRzLL5TwQg9UJHTf2kVhcE=;
        b=AWQM8Ul2l2ZCUFJaLNbJs1lsw6+G3DXqwClOxDISp1/AXSmxbNfGW8I/T0UhFmJ8vv
         IMneQdA1DC+/Cc4frDnnD1DxaRlDQ/dzWt2tlG9gua4f4eso56lEiAp04tO9pTEgumQ8
         nnmquYSyi1X3yyfJWmpWZtMljBannVtnBEzfJB17uRVob2lwnhUV547vd2A7RKrF6P4q
         +ZR/9qWsnYz/yqdQYMa9M063tAPA8Gg8EE2aMTOQ+VFfqMVpWJ2/dQkLTOTLDgv9Bf5Z
         QNdv9yyl3Dyvw4Csq7vebQclnLOzmf+krjbdOoDejCn8RhV3UICe8S8ssc9dLs20fl9n
         VOWA==
Received: by 10.14.188.139 with SMTP id a11mr7595885een.139.1341590902771;
        Fri, 06 Jul 2012 09:08:22 -0700 (PDT)
Received: from localhost ([2a01:7e00::f03c:91ff:fedf:f4db])
        by mx.google.com with ESMTPS id u14sm72687016eem.4.2012.07.06.09.08.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 06 Jul 2012 09:08:22 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.GIT
In-Reply-To: <7vtxxns4z4.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201119>

Thanks to the review of Junio, Duy and Thomas here is a reroll of the
patches, where the name length is separated from the flags in the
in-memory format and which includes a little bit of a performance
optimization by using the ce_namelen field instead of strlen() in
a couple of places thanks to the suggestion of Duy.

[PATCH/RFC v2 1/2] Strip namelen out of ce_flags into a ce_namelen
[PATCH/RFC v2 2/2] Replace strlen(ce->name) with ce_namlen

builtin/apply.c        |    3 ++-
builtin/blame.c        |    3 ++-
builtin/checkout.c     |    3 ++-
builtin/update-index.c |    9 ++++++---
cache.h                |   18 ++++++------------
read-cache.c           |   58 +++++++++++++++++++++++++++++++++++-----------------------
tree.c                 |    7 ++++---
unpack-trees.c         |    5 +++--
8 files changed, 60 insertions(+), 46 deletions(-)
