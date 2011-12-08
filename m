From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 0/2] Parsing a subcommand using parse-options
Date: Thu,  8 Dec 2011 17:37:06 +0530
Message-ID: <1323346028-9201-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 08 13:08:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYcly-0006aY-Jh
	for gcvg-git-2@lo.gmane.org; Thu, 08 Dec 2011 13:08:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750817Ab1LHMIM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Dec 2011 07:08:12 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:41987 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750770Ab1LHMIJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Dec 2011 07:08:09 -0500
Received: by iakc1 with SMTP id c1so2502678iak.19
        for <git@vger.kernel.org>; Thu, 08 Dec 2011 04:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=/CqxwcRbt9j7igz9Mrl+dBCwpOyEkLM9JsvBUd/jxTM=;
        b=u2lMc3+Ggc4EZaisU6dlx1Z3MQKTLXQLNz1PB9wRGLSikdNi9BXP531MQGQalSbf7S
         CO3KyXBfEcf7uOpEjhtRMP8NMlbGGy6S+ULuWjEyfhe0d3VUKH+dCRmYOOpO9ohWfeWr
         T27ocCH0/O+1fNbQMP7/+m9jGY6C8fHAqQT6w=
Received: by 10.42.29.137 with SMTP id r9mr3305310icc.20.1323346089214;
        Thu, 08 Dec 2011 04:08:09 -0800 (PST)
Received: from localhost.localdomain ([203.110.240.205])
        by mx.google.com with ESMTPS id el2sm18965489ibb.10.2011.12.08.04.08.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 08 Dec 2011 04:08:08 -0800 (PST)
X-Mailer: git-send-email 1.7.7.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186548>

Hi,

It's been itching me for some time now: I want parse-options to be
able to parse a "subcommand".  It all started when I noticed how ugly
my implementation of '--continue' and '--quit' in git-revert were:
using an OPT_BOOLEAN to parse the option into separate integer
variables, and then using if-else constructs to turn that into an
enum.  Yuck!  Also, wouldn't we all love something like this in the
future?

  git stash show
            ^^ -- The subcommand "show" to the git-stash builtin

Ofcourse, git-stash.sh is just a shell script, and the full motivation
doesn't arise until someone decides to turn it into a C builtin.  So,
I went hunting for a C builtin that used subcommands and found
something relatively obscure: git-bundle.  It does option-parsing by
hand; changing it to use parse-options is the perfect opportunity to
implement this subcommand feature!

Thoughts?

-- Ram

Ramkumar Ramachandra (2):
  parse-options: introduce OPT_SUBCOMMAND
  bundle: rewrite builtin to use parse-options

 builtin/bundle.c         |  111 ++++++++++++++++++++++++++++++----------------
 parse-options.c          |    5 +-
 parse-options.h          |    3 +
 t/t0040-parse-options.sh |   31 +++++++++++++
 test-parse-options.c     |    4 ++
 5 files changed, 114 insertions(+), 40 deletions(-)

-- 
1.7.7.3
