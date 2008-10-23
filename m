From: Deskin Miller <deskinm@umich.edu>
Subject: [PATCH] git-svn: change dashed git-config to git config
Date: Thu, 23 Oct 2008 15:21:34 -0400
Message-ID: <20081023192134.GB8320@euler>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: normalperson@yhbt.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 23 21:23:01 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kt5lo-0003Yq-20
	for gcvg-git-2@gmane.org; Thu, 23 Oct 2008 21:22:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752292AbYJWTVl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Oct 2008 15:21:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752501AbYJWTVl
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Oct 2008 15:21:41 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:51151 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752211AbYJWTVk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Oct 2008 15:21:40 -0400
Received: by yw-out-2324.google.com with SMTP id 9so160041ywe.1
        for <git@vger.kernel.org>; Thu, 23 Oct 2008 12:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition:user-agent
         :sender;
        bh=MSsixXgiIsJuODmyjzkhh/Y9+b99zS71RCl4XjmQjpY=;
        b=CcqTqcyj1IqhRbKJsuRferYP3EOCG6cOnPoaR+90b/MbD86UjbxQgufmPR8q90r27S
         I8ANxS2Zc7Jdma6897eviG2PiLorQWeLrzGJGUP/UlHrlSLFOYOjSispqQR8pKeOhPsE
         YYN7g4jwquEGQOPLRLl5knZvKMVPO0YbpyE0I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent:sender;
        b=vby4zyXasyzo1ie0gcuhMFfmtZOl3SzWlBcretFctQjZAh0MpXsLtR/S9PrwqDJW9a
         LLMYT/sEF0SfWrLaig+pFpt4e0SSYBX8M57J1pUuVUBnnLFQhhkkRoCOyA8YMa15UneY
         clraO3HhbIwcGlOBthZ/NnT1UU8Zq1q48xT4o=
Received: by 10.231.17.135 with SMTP id s7mr643156iba.21.1224789698337;
        Thu, 23 Oct 2008 12:21:38 -0700 (PDT)
Received: from euler ([141.213.134.57])
        by mx.google.com with ESMTPS id 5sm10821945ywl.4.2008.10.23.12.21.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 23 Oct 2008 12:21:37 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98984>

---
When testing git-svn changes, I'll often use git-svn.perl directly on a
repository of mine, to see how things work.  Recently I had this happen:

$ git-svn.perl info
Use of uninitialized value in scalar chomp at ../git/git-svn.perl line 1202.
Use of uninitialized value in concatenation (.) or string at ../git/git-svn.perl line 1203.

but the expected output showed up correctly, giving the SVN-like info.

git svn info appeared to work just fine though, despite there being essentially
no difference between the two.  However, if I do the following, this is what I
see:

$ env /usr/libexec/git-core/git-svn info
Can't exec "git-config": No such file or directory at /usr/libexec/git-core/git-svn line 1202.
Use of uninitialized value in scalar chomp at /usr/libexec/git-core/git-svn line 1202.

Again, the SVN info would still appear.

Regardless, I think we want to change this call to use the non-dashed form.

Deskin Miller
 
 git-svn.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 33e1b50..2e68c68 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1126,7 +1126,7 @@ sub read_repo_config {
 		my $v = $opts->{$o};
 		my ($key) = ($o =~ /^([a-zA-Z\-]+)/);
 		$key =~ s/-//g;
-		my $arg = 'git-config';
+		my $arg = 'git config';
 		$arg .= ' --int' if ($o =~ /[:=]i$/);
 		$arg .= ' --bool' if ($o !~ /[:=][sfi]$/);
 		if (ref $v eq 'ARRAY') {
-- 
1.6.0.2.554.g3041b
