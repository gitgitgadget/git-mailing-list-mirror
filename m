From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv7 0/5]  gitweb: PATH_INFO enhancement
Date: Tue, 21 Oct 2008 21:34:49 +0200
Message-ID: <1224617694-29277-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 21 21:36:38 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsN1i-0004hL-S6
	for gcvg-git-2@gmane.org; Tue, 21 Oct 2008 21:36:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751841AbYJUTed (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2008 15:34:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752343AbYJUTec
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Oct 2008 15:34:32 -0400
Received: from mu-out-0910.google.com ([209.85.134.185]:50668 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750966AbYJUTeb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2008 15:34:31 -0400
Received: by mu-out-0910.google.com with SMTP id g7so2262687muf.1
        for <git@vger.kernel.org>; Tue, 21 Oct 2008 12:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=gOXYOdGE64jLH1qy5qJt8GAhyT1KxyFMicDNaXp/p7Y=;
        b=czsa4Zr+BX9lobpAmOAFk7hwcigcZUoB0eVC0sKlP5O3E9HQy10nzBskEhwIsLsBP2
         DsDyUJ8O6ITLu7v8fLFvvRklLQlmHyHRhC8+L+It467UIqfcRvTVaBSAKIEjhzJEfqU0
         iDvJKubcSC9VGrWgPP3EWrSD3neG1BXBD7upI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=oGaT9CA7W6RGM/o0VDeiBbxNSgq0275xfQHj1xGZr4BItSKkKj9AcrCe6PHndWqmWa
         VLoXuXoaj1O+nTETSDAYl0avACOxcmiLsCzN+aXWYpNIhSsdydicVO1l/JnvblJLXvLI
         bpR8g73RzB/SRT2l1/SMn/Gu98RrMVQLHxIkk=
Received: by 10.181.234.8 with SMTP id l8mr1202302bkr.105.1224617665638;
        Tue, 21 Oct 2008 12:34:25 -0700 (PDT)
Received: from localhost ([94.37.30.171])
        by mx.google.com with ESMTPS id 31sm17469932fkt.3.2008.10.21.12.34.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 21 Oct 2008 12:34:25 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98811>

Sevent attempt for my gitweb PATH_INFO patchset, whose purpose is to
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
currently waiting in 'next'. This resend fixes some mainly aesthetical
issues spotted by Jakub

Giuseppe Bilotta (5):
  gitweb: parse project/action/hash_base:filename PATH_INFO
  gitweb: generate project/action/hash URLs
  gitweb: use_pathinfo filenames start with /
  gitweb: parse parent..current syntax from PATH_INFO
  gitweb: generate parent..current URLs

 gitweb/gitweb.perl |  133 +++++++++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 122 insertions(+), 11 deletions(-)
