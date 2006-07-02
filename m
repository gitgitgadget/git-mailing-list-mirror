From: "Marco Costalba" <mcostalba@gmail.com>
Subject: [POSSIBLE REGRESSION] Spurious revs after patch "revision.c: --full-history fix"
Date: Sun, 2 Jul 2006 14:19:01 +0200
Message-ID: <e5bfff550607020519k6007f41bne34d10c0e919f3c8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 02 14:19:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fx0v4-0008Eq-C9
	for gcvg-git@gmane.org; Sun, 02 Jul 2006 14:19:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750932AbWGBMTE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Jul 2006 08:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751230AbWGBMTE
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Jul 2006 08:19:04 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:45668 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750932AbWGBMTC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Jul 2006 08:19:02 -0400
Received: by py-out-1112.google.com with SMTP id c39so1071533pyd
        for <git@vger.kernel.org>; Sun, 02 Jul 2006 05:19:01 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=gp8s23fYZHKXNqdHZkJgeCFlOvXPiokN1zD/BBGEyVuPxbHTLOsKYfKj7Rsa8Ml5HkbRncuDbnVxrBrwNs0wZV74fWgKcHa8qsB0FoHP2kB45AgmfA274UmLj5tJt64cUhnjxoNKsngG1b0B9b8430I9QB7VB32GyOQszEVhk10=
Received: by 10.35.27.1 with SMTP id e1mr151650pyj;
        Sun, 02 Jul 2006 05:19:01 -0700 (PDT)
Received: by 10.35.52.17 with HTTP; Sun, 2 Jul 2006 05:19:01 -0700 (PDT)
To: junkio@cox.net
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23105>

After patch "revision.c: --full-history fix" (6631c73)

I have this in git tree.

I have _manually_  ( --abbrev=nr does not apply in this case)
truncated to 7 chars the SHA to be more readable)

$ git-rev-list --topo-order --parents --remove-empty HEAD -- builtin-add.c
021b6e4 93872e0
93872e0 3c6a370
3c6a370 e8f990b
e8f990b f259339
f259339 0d78153
0d78153
b4189aa
283c8ee
$ git-rev-list --topo-order --remove-empty HEAD -- builtin-add.c
021b6e4
93872e0
3c6a370
e8f990b
f259339
0d78153
$

What it seems is that with --parents  option two more spurious revs
are printed out. This revs have nothing to do with builtin-add.c, the
file is newer then both of them.

I have tested with different files and always we have spurious
revisions in case of files that were added after initial commit, and
always the erroneous revisions are older then file creation one.

This is a possible regression that breaks things (I've found it thanks
to an assert in qgit).

   Marco
