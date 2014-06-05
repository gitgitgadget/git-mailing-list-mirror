From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH 0/5] submodule config lookup API
Date: Thu, 5 Jun 2014 08:04:25 +0200
Message-ID: <20140605060425.GA23874@sandbox-ub>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <jens.lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 05 08:04:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsQn1-0005ld-Fp
	for gcvg-git-2@plane.gmane.org; Thu, 05 Jun 2014 08:04:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751306AbaFEGEf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2014 02:04:35 -0400
Received: from smtprelay01.ispgateway.de ([80.67.31.35]:50425 "EHLO
	smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750891AbaFEGEe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2014 02:04:34 -0400
Received: from [77.20.146.74] (helo=sandbox-ub)
	by smtprelay01.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1WsQms-0000Op-E8; Thu, 05 Jun 2014 08:04:30 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250811>

I have been holding back this series during the RC phase but now I think
it is ready for another round. The most important changes:

  * The API is using a singleton now. No need to pass in the cache
    object anymore.

  * Local configuration can be looked up by passing in the null_sha1

  * We use the API for existing lookup of submodule values

One open question:

  * Since behind the scenes there is a global cache filled with the
    values: Do we need to free it explicitely? Or is it ok to let it be
    dealt with on exit?

The last iteration was here:

http://article.gmane.org/gmane.comp.version-control.git/243818

Heiko Voigt (5):
  hashmap: add enum for hashmap free_entries option
  implement submodule config cache for lookup of submodule names
  extract functions for submodule config set and lookup
  use new config API for worktree configurations of submodules
  do not die on error of parsing fetchrecursesubmodules option

 .gitignore                                       |   1 +
 Documentation/technical/api-hashmap.txt          |   2 +-
 Documentation/technical/api-submodule-config.txt |  63 ++++
 Makefile                                         |   2 +
 builtin/checkout.c                               |   1 +
 builtin/fetch.c                                  |   1 +
 diff.c                                           |   1 +
 diffcore-rename.c                                |   2 +-
 hashmap.c                                        |   2 +-
 hashmap.h                                        |   8 +-
 name-hash.c                                      |   4 +-
 submodule-config.c                               | 435 +++++++++++++++++++++++
 submodule-config.h                               |  29 ++
 submodule.c                                      | 122 ++-----
 submodule.h                                      |   4 +-
 t/t7410-submodule-config.sh                      | 141 ++++++++
 test-hashmap.c                                   |   6 +-
 test-submodule-config.c                          |  74 ++++
 18 files changed, 791 insertions(+), 107 deletions(-)
 create mode 100644 Documentation/technical/api-submodule-config.txt
 create mode 100644 submodule-config.c
 create mode 100644 submodule-config.h
 create mode 100755 t/t7410-submodule-config.sh
 create mode 100644 test-submodule-config.c

-- 
2.0.0
