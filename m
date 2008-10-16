From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv6 0/5] gitweb: PATH_INFO enhancement
Date: Thu, 16 Oct 2008 22:27:06 +0200
Message-ID: <1224188831-17767-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 16 22:28:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqZS3-0000BA-Cs
	for gcvg-git-2@gmane.org; Thu, 16 Oct 2008 22:28:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753842AbYJPU0z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2008 16:26:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753616AbYJPU0z
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Oct 2008 16:26:55 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:17896 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753220AbYJPU0y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2008 16:26:54 -0400
Received: by nf-out-0910.google.com with SMTP id d3so137749nfc.21
        for <git@vger.kernel.org>; Thu, 16 Oct 2008 13:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=4zUjlLrfpL03/tThpG3epbPPzngmgjhu2+cKpoc7xMg=;
        b=IKYpMj4HrXOa7OuyEM1Xdmmb0DuGxJjQRwq1vcGbYY7FeFN64lLoaMrh8zZ6fueq4v
         GuQWJjLhBlQlnPn8s4CdRkkptbUjS7NWOs02ZPQ0gaVHKzkpTP6lWyQ4PYow/iD6jl4O
         /6sVCk2mQWbEbXMlHJSpwx0WfWe+Gp19WDSgo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=voa/KoXaLxPRyBQKMRKfCRlF++TVI7dJq1pUhUXxJonx+T/LqTCKSeO38lNscYSdye
         xXBnQn0Q8YUJkHtNmhh6OvrqthxP456BXXhHDAFS4VihFW1FnOt1BOVsisbDhNJ8BwII
         7MWyyatDga5WqChexNdEkW/bf6F6gmVdSGwTM=
Received: by 10.210.41.1 with SMTP id o1mr3432125ebo.75.1224188813415;
        Thu, 16 Oct 2008 13:26:53 -0700 (PDT)
Received: from localhost ([94.37.30.171])
        by mx.google.com with ESMTPS id 3sm2493205eyj.3.2008.10.16.13.26.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 16 Oct 2008 13:26:52 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98412>

Sixth attempt for my gitweb PATH_INFO patchset, whose purpose is to
reduce the use of CGI parameters by embedding as many parameters as
possible in the URL path itself, provided the pathinfo feature is
enabled.

The new typical gitweb URL is therefore in the form

$project/$action/$parent:$file..$hash:$file

(with useless parts stripped). Backwards compatibility for old-style
$project/$hash[:$file] URLs is kept, as long as $hash is not a refname
whose name happens to match a git action.

The main implementation is provided by paired patches (#1#2, #4#5)
that implement parsing and generation of the new style URLs.

Patch #3 is a minor improvement to the URL syntax that allows web
sites to be properly browsable in raw mode.

The patchset depends on my previous input parameter handling patch
currently waiting in 'next'. This resend fixes a couple of problems
I found in v5.

Giuseppe Bilotta (5):
  gitweb: parse project/action/hash_base:filename PATH_INFO
  gitweb: generate project/action/hash URLs
  gitweb: use_pathinfo filenames start with /
  gitweb: parse parent..current syntax from PATH_INFO
  gitweb: generate parent..current URLs

 gitweb/gitweb.perl |  124 +++++++++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 114 insertions(+), 10 deletions(-)
