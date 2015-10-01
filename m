From: Max Kirillov <max@max630.net>
Subject: [PATCH/RFC 0/2] close packs files when they are not needed
Date: Thu,  1 Oct 2015 06:29:21 +0300
Message-ID: <1443670163-31193-1-git-send-email-max@max630.net>
References: <xmqqlhbn7ky1.fsf@gitster.mtv.corp.google.com>
Cc: Max Kirillov <max@max630.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 01 05:30:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZhUZc-0001TF-DO
	for gcvg-git-2@plane.gmane.org; Thu, 01 Oct 2015 05:30:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755246AbbJAD3t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Sep 2015 23:29:49 -0400
Received: from p3plsmtpa07-09.prod.phx3.secureserver.net ([173.201.192.238]:54471
	"EHLO p3plsmtpa07-09.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755159AbbJAD3s (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Sep 2015 23:29:48 -0400
Received: from wheezy.local ([82.181.81.240])
	by p3plsmtpa07-09.prod.phx3.secureserver.net with 
	id PfVh1r0055B68XE01fVmsM; Wed, 30 Sep 2015 20:29:47 -0700
X-Mailer: git-send-email 2.3.4.2801.g3d0809b
In-Reply-To: <xmqqlhbn7ky1.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278882>

> The right approach may to have a helper in sha1_file.c that closes
> and cleans up _all_ packs, and call it from here, instead of having
> builtin/clone.c even know about implementation details such as
> packed_git is a linked list, etc. 

Like this?

Note I did not test it to actually work for the current
code. Trying now what I could do with lsof, just to be sure
myself, but probably its use not appropriate for the
project.

Max Kirillov (2):
  sha1_file: close all pack files after running
  sha1_file: set packfile to O_CLOEXEC at open

 builtin/pack-objects.c |  2 +-
 cache.h                |  3 +-
 git.c                  |  2 ++
 pack-bitmap.c          |  2 +-
 sha1_file.c            | 80 +++++++++++++++++++++++++++++++++++---------------
 5 files changed, 63 insertions(+), 26 deletions(-)

-- 
2.3.4.2801.g3d0809b
