From: Patryk Obara <patryk.obara@gmail.com>
Subject: [PATCH 0/2] commit -t appends newline after template file
Date: Tue, 26 May 2015 08:15:06 +0200
Message-ID: <1432620908-16071-1-git-send-email-patryk.obara@gmail.com>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 26 08:16:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yx8A9-0006NG-Nw
	for gcvg-git-2@plane.gmane.org; Tue, 26 May 2015 08:16:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751363AbbEZGP4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 May 2015 02:15:56 -0400
Received: from mail-wg0-f49.google.com ([74.125.82.49]:35580 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751287AbbEZGPz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 May 2015 02:15:55 -0400
Received: by wgme6 with SMTP id e6so18699471wgm.2
        for <git@vger.kernel.org>; Mon, 25 May 2015 23:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=iMDqOtlQl2P+L2hv6Igc5slGZi37pWiFUrF9zwnJFFE=;
        b=W7b9ITHIDuSaWdMNspd4TfqAk63iua1qVuqbNLtLgr7RjQZWmReG55/GTodE9UR7rM
         pd8QJ34K8EIre8V/YT5Qxx640jkSA9PFQZAwypOYhwRD7o6wTDcg4a9y7cFXnJkDVqos
         o+zs2XwQZ190ZI4+EU85j0Zg0/6ildMgylT0oARnZk+pNI4kHm7LH8M+dAlFpioNdBVB
         H6x0T81+H2zIbKFNKV/CIM+w+0JJyyAjvq0nn9S+Tg6L2wnssAsTFa2t7I2SZMTKhkeC
         ric4HbMjkPL6JgI5+MBrHeiw9TZaXaFTSq+0Oem2zX9om+pKKoIbbMB/4v+9lchf2nLG
         vtzg==
X-Received: by 10.180.85.42 with SMTP id e10mr36916006wiz.17.1432620914369;
        Mon, 25 May 2015 23:15:14 -0700 (PDT)
Received: from tars.localdomain ([188.121.16.104])
        by mx.google.com with ESMTPSA id js3sm20027090wjc.5.2015.05.25.23.15.13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 May 2015 23:15:13 -0700 (PDT)
X-Mailer: git-send-email 2.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269930>

These are my first patches to git, so be extra pedantic during review, please.

I noticed, that newline is appended, when I try to use template file - which
is annoying if template ends with comment. I digged a bit and it turned out
that:

* my editor (vim) was appending newline before eof in template, (I forgot
  about this); most editors, that I tested appends newline before eof by
  default. Emacs was exception here.

* commit --status appends newline unconditionally before placing first
  comment line - it needs to do this or comment might be appended to last line
  of template file. Usually, in result two newlines are appended after
  template file content - and unexpected empty line appears in editor.

* tests for git-commit do not verify newlines at all

I fixed tests and wrote few more (patch 1/2) - after applying this patch
some tests won't pass (they shouldn't be passing in the first place imo).
Patch 2 fixes all broken tests.

More detailed description is in mails to follow.
