From: BJ Hargrave <bj@bjhargrave.com>
Subject: tar on Mac does not like empty tar from git archive
Date: Mon, 8 Apr 2013 14:36:05 -0400
Message-ID: <ABD0C67A-0B2B-4E32-AF49-93FBABC032A7@bjhargrave.com>
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 08 20:36:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPGvP-0004gU-B7
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 20:36:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935273Ab3DHSgK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 14:36:10 -0400
Received: from mail-yh0-f49.google.com ([209.85.213.49]:37526 "EHLO
	mail-yh0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934738Ab3DHSgJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Apr 2013 14:36:09 -0400
Received: by mail-yh0-f49.google.com with SMTP id q14so394803yhf.36
        for <git@vger.kernel.org>; Mon, 08 Apr 2013 11:36:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:content-type:content-transfer-encoding:subject:date
         :message-id:cc:to:mime-version:x-mailer:x-gm-message-state;
        bh=z/LX90S7uWer9syklAF+BdfYwXMdIoM2q7ZZMpj+KhU=;
        b=ppe2tf99A+Vcm97xAS9uV2UsSIywUKeC4DYAF/mB1pLSO+LkJ5XTB96T/xUKwZN9eO
         bla5dL02Of1DvTIlD1iCkLqtD3TFQRjzN70iyEjZaDgEX5VysOq0Xh/Eqm7Rda4fSVyD
         wplCgsFpJ7W6dWmWVWZAUdhPKWOy1CMEbzXmKkAdJ5KLsAg0HAKPbXAdxy2pyUz6prNs
         cHhSTH4sC+Rsdg/1G3eO5C/JlJ80Myq9DjslIUo1nprKljTPVx/LpPtmf394yrfHYnUg
         CNJi0KSWSyNL+X024SOinK9gCRBqBWI43qALDVs2/klvYBZsQZ9kof///+GzH8ldgAMU
         auUg==
X-Received: by 10.236.123.142 with SMTP id v14mr13383185yhh.83.1365446168336;
        Mon, 08 Apr 2013 11:36:08 -0700 (PDT)
Received: from macbookpro2.hargrave.local ([68.204.6.187])
        by mx.google.com with ESMTPS id x33sm38859255yhn.18.2013.04.08.11.36.06
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 08 Apr 2013 11:36:07 -0700 (PDT)
X-Mailer: Apple Mail (2.1503)
X-Gm-Message-State: ALoCoQmfLqIh/eq77bn3qpmPViA9QtcXimBIl2XuZS18rArfR+WqhKrz4j1TUmzlyb7Uw/PpCgPU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220485>

Git 1.8.2.1 includes commit bd54cf17 - archive: handle commits with an empty tree

Test 2 of t5004-archive-corner-cases, "tar archive of empty tree is empty", fails on Mac OS X 10.8.3 (with XCode 4.6.1) since the tar command exits with return code 1 on the generated  tar file.

expecting success: 
	git archive --format=tar HEAD >empty.tar &&
	make_dir extract &&
	"$TAR" xf empty.tar -C extract &&
	check_dir extract

tar: Damaged tar archive
tar: Error exit delayed from previous errors.
not ok 2 - tar archive of empty tree is empty

tar tf "trash directory.t5004-archive-corner-cases/empty.tar"; echo $?
tar: Damaged tar archive
tar: Error exit delayed from previous errors.
1

tar --version
bsdtar 2.8.3 - libarchive 2.8.3

It appears that bsdtar does not like the empty tar files created by git archive. An empty tar file created by bsdtar is accepted.

tar cT /dev/null | tar t; echo $?
0

-- 

BJ Hargrave
