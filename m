From: Angelo Borsotti <angelo.borsotti@gmail.com>
Subject: push race
Date: Mon, 15 Oct 2012 11:14:11 +0200
Message-ID: <CAB9Jk9Be4gGaBXixWN7Xju7N6RGKH+FonhaTbZFJ6uYsJDk8dg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Oct 15 11:14:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNgkh-0001Pr-Ln
	for gcvg-git-2@plane.gmane.org; Mon, 15 Oct 2012 11:14:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751359Ab2JOJON (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2012 05:14:13 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:43117 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750722Ab2JOJOM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2012 05:14:12 -0400
Received: by mail-vb0-f46.google.com with SMTP id ff1so4960245vbb.19
        for <git@vger.kernel.org>; Mon, 15 Oct 2012 02:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=+4MZ6Q/ZZiXu64uyuDJqImAH9mZQ5n27aCuInI5aJ/M=;
        b=ucBpfJtaZzSNRr5x2F/5vI48wZlWdjJ+8cRvUsOHieSmW3MRnEsijzUqHYx12AgY22
         fimBtfLzlDA+poSZMyUIfQ2vdxIigg8cCsxSz/MH74dhWOjDP1n7+uRrhi64GmEnyrTY
         D5eWoSeZne9+se1pmoW2OTcV6eWPx8o/IHaMWJ2Ne6yXXa/dvAp8U0PpogxtxGQrcA9c
         aHDWIbE/t1Wo3jHDto7FJr0APudKLh2xY8hvLE0cCDwFuOLG7laGGcYM/GnWrEaJSjgG
         zmFjGB15K/NKENnySNNuVddwSWO+02gUhNwFG6XAR1S13ooNqvBfZqu4Hmvi98Mq5Rx5
         tb/g==
Received: by 10.220.240.18 with SMTP id ky18mr6327527vcb.54.1350292451823;
 Mon, 15 Oct 2012 02:14:11 -0700 (PDT)
Received: by 10.58.68.40 with HTTP; Mon, 15 Oct 2012 02:14:11 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207729>

Hello,

the push command checks first if the tips of the branches match those
of the remote
references, and if it does uploads the snapshot.
The checking and the uploading are two distinct operations that should
be indivisible.
Suppose that two workstations are pushing at the same time, and that the push of
the first has just checked the tips and found that they are ok, and
--before-- the
push command uploads the snapshot, the second workstation checks the tips too.
The test would be successful, and both workstation would upload their
files, actually
overwriting each others'.
I have browsed push.c, transport.c, connect.c, send-pack.c, but have
not found any
synchronization that protects the checking and the uploading with some critical
sections.
Has some sort of mutual exclusion been implemented, or it is up to the user to
guarantee that two pushes are not done simultaneously?

-Angelo Borsotti
