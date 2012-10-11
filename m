From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: [minor] two tests broken when run with a --root directory that's a symlink
Date: Thu, 11 Oct 2012 23:55:53 +0200
Message-ID: <CACBZZX6Cu_4X=AywsDMebdoFYdEN1Gmp439aEAcehHBuMhziTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Tim Henigan <tim.henigan@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 11 23:56:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TMQk4-0004yg-IC
	for gcvg-git-2@plane.gmane.org; Thu, 11 Oct 2012 23:56:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759484Ab2JKV4Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Oct 2012 17:56:16 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:47101 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759433Ab2JKV4O (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Oct 2012 17:56:14 -0400
Received: by mail-ob0-f174.google.com with SMTP id uo13so2252684obb.19
        for <git@vger.kernel.org>; Thu, 11 Oct 2012 14:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        bh=WnghcGtC1bCEBt/CytQEyFg9mETfG5qUmmuS7xq7v/0=;
        b=MmfkPLtKuN0e50vX2dceS+Hu6ajbgDGlo4w1KBzbXgc1iAyQApOcOFURNRo+edJg6/
         A5OWvzCfmDLGQ7hy5I/zL5rh24geucGsmmyUU+HRyf/wMyMbcEgL28pf64/Xg49Uf6pe
         gDhaB+7N51b1yYYuJtFU665ldW7Uqvo6xs637uBUNxn4H5Mlt7pu8H2p7WjrHN/GDaVk
         CeFewK1IrWesOW6fwp+ZpOMo7+QzX3o8JKn0+ola0twsHRpYgCr8yJFYJX+6DGuWZAQY
         A0T0khhSPbkWJblrVqrPmM1wjf37oUtFQ3IURgSANdr0YSZ5tiU3b39a/D7LYEOsvZKy
         kWMw==
Received: by 10.60.169.48 with SMTP id ab16mr2019198oec.15.1349992573733; Thu,
 11 Oct 2012 14:56:13 -0700 (PDT)
Received: by 10.60.94.225 with HTTP; Thu, 11 Oct 2012 14:55:53 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207516>

These issues are minor, I noticed it because I test with /dev/shm/git
as the --root, which on Debian is symlinked to /run/..

    $ rm -rf /tmp/{foo,bar}
    $ mkdir /tmp/target; ln -s /tmp/target /tmp/link
    $ prove ./t4035-diff-quiet.sh ./t9903-bash-prompt.sh :: --root=/tmp/target
    ./t4035-diff-quiet.sh ... ok
    ./t9903-bash-prompt.sh .. ok
    All tests successful.
    Files=2, Tests=64,  1 wallclock secs ( 0.04 usr  0.00 sys +  0.07
cusr  0.06 csys =  0.17 CPU)
    Result: PASS
    $ prove ./t4035-diff-quiet.sh ./t9903-bash-prompt.sh :: --root=/tmp/link
    ./t4035-diff-quiet.sh ... Dubious, test returned 1 (wstat 256, 0x100)
    Failed 3/20 subtests
    ./t9903-bash-prompt.sh .. Dubious, test returned 1 (wstat 256, 0x100)
    Failed 6/44 subtests

Everything else in the test suite passes with a --root that's a symlink.
