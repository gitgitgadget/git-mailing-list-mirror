From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH 0/2] Improve git-pull's option parsing
Date: Mon, 18 May 2015 21:54:54 +0800
Message-ID: <1431957296-31534-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 18 15:55:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuLVh-0002gJ-70
	for gcvg-git-2@plane.gmane.org; Mon, 18 May 2015 15:55:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752454AbbERNzJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2015 09:55:09 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:33899 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750835AbbERNzH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2015 09:55:07 -0400
Received: by pabru16 with SMTP id ru16so153491633pab.1
        for <git@vger.kernel.org>; Mon, 18 May 2015 06:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=HO2InmGJpPe9RypS0AekSgs7DkztNQ9r0LKpxAo/kC0=;
        b=uTxlTYzgVgzHYMLC2gf+reZa1pfR3vWp1caDz4/CVLUndT/WtWsNZsrbfnvH1t+iXz
         JJURYiQkCDVAQ9o4KrHCj+1Z4/uHv5M/vEsXSgqKVW7JjigtjzXX8iH2k0OWeaZJ2Iag
         Y8XTCmP9KzkPJgoohy1okrVHXYHfgJje6zvVQ2bMhlrcjDtSOF0D6v2S0TA7eXXGvZ7h
         qmGwF9DBFCaZCNn0qjI/IuTiBCcLt5nWci+crK8FYb0eW5qwj/fwsTLB+RD15hHQOfDD
         hepr5JIRHTOYT+VGl7k2VocB+JOWn6vHfyzxMkI8vuYlrtxPkpXcPsd8mc9nKqFYr9PK
         BGAw==
X-Received: by 10.70.124.131 with SMTP id mi3mr44593437pdb.28.1431957306877;
        Mon, 18 May 2015 06:55:06 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id v2sm10185365pdn.90.2015.05.18.06.55.04
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 May 2015 06:55:05 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269249>

While parsing the command-line arguments, git-pull stops parsing at the
first unrecognized option, assuming that any subsequent options are for
git-fetch, and can thus be kept in the shell's positional parameters
list, so that it can be passed to git-fetch via the expansion of "$@".

However, certain functions in git-pull assume that the positional
parameters do not contain any options. Fix this by making git-pull handle
git-fetch's options as well at the option parsing stage.

With this change in place, we can move on to migrate git-pull to use
git-rev-parse --parseopt such that its option parsing is consistent with the
other git commands.

Paul Tan (2):
  pull: handle git-fetch's options as well
  pull: use git-rev-parse --parseopt for option parsing

 git-pull.sh             | 137 ++++++++++++++++++++++++++++++++++--------------
 t/t5520-pull.sh         |  20 +++++++
 t/t5521-pull-options.sh |  14 +++++
 3 files changed, 132 insertions(+), 39 deletions(-)

-- 
2.1.4
