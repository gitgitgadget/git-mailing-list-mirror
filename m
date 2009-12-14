From: "Lhunath (Maarten B.)" <lhunath@gmail.com>
Subject: Can't handle renamed resources on case insensitive filesystems.
Date: Mon, 14 Dec 2009 15:27:30 +0100
Message-ID: <63135FDB-C8EF-4DBC-AEF5-4B0636C8D349@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Dec 14 15:27:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKBtk-00085j-Ej
	for gcvg-git-2@lo.gmane.org; Mon, 14 Dec 2009 15:27:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757436AbZLNO1f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2009 09:27:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757433AbZLNO1f
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Dec 2009 09:27:35 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:53989 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757422AbZLNO1e convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Dec 2009 09:27:34 -0500
Received: by ewy19 with SMTP id 19so3431516ewy.21
        for <git@vger.kernel.org>; Mon, 14 Dec 2009 06:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:content-type
         :content-transfer-encoding:subject:date:message-id:to:mime-version
         :x-mailer;
        bh=scNAbECmb6O+RwMvRjXQImSKCIbR1sL5radngTbhJtc=;
        b=Fcx7iY8YGadnjyC7hi8Gmoqn2U8YrKQaBSVdZXNF9h8DoFmqA4IHAubJUHk23DCiFC
         03OuCJN185FFOt7XaMZRb24i722Qby/bbGDG+58Prnu3bHe3qGZRs3Z3yl34NL9ENIZZ
         +sEws0Gly+P41kUd0uuNJu0YYCM07daK9+46A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:content-type:content-transfer-encoding:subject:date:message-id
         :to:mime-version:x-mailer;
        b=HH0JnROtFvUXAaFhrgLZZigYffKa3zXwA/SsRrKyrRwhLVchLpnagLNERg/b3be8Qj
         h73WagVLMcuFJKdJTZPkjO6OIfWTLg3zECxIOcaWkbSObgWZiWvtV/wSFRdX+9vtBwHb
         V6oTglgOKrhgfiHkTT0+epw/suom5qITIz+zQ=
Received: by 10.213.25.79 with SMTP id y15mr5758359ebb.78.1260800852672;
        Mon, 14 Dec 2009 06:27:32 -0800 (PST)
Received: from mbillemo.lin-k.net ([80.169.61.18])
        by mx.google.com with ESMTPS id 10sm3958263eyz.31.2009.12.14.06.27.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 14 Dec 2009 06:27:32 -0800 (PST)
X-Mailer: Apple Mail (2.1077)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135214>

GIT has quite a few issues concerning renamed files on case insensitive filesystems, such as Mac OS X's default HFS+.

For instance:

lhunath@Myst t $ git mv Foo foo
fatal: destination exists, source=Foo, destination=foo

Moreover, when a repository contains Foo and foo in one commit and in a subsequent commit, "foo" is removed; "Foo" will also disappear when checking out the latter.

Most of these issues are likely just a result of the underlying file system's handling of GIT's commands; though considering that Mac OS X's default fs is case insensitive by default, and the Mac and Windows userbases combined are quite large; it might be very much appropriate to do a check for this (if needed) and handle renames (and other operations?) in a way that they would not cause conflicts on these file systems (eg. rename to a temporary filename first and then rename to destination).

In particular; these issues make it awfully painful to refactor Java class names from things like JndiUtils -> JNDIUtils.  Not only is it hard to get the commit INTO the repository correctly; it is also hard to check the commit OUT for somebody who has no idea any of this is needed.