From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH] If deriving SVN_SSH from GIT_SSH on msys, also add quotes
Date: Sat, 23 Jan 2010 15:20:28 +0100
Message-ID: <4B5B05AC.2050200@gmail.com>
References: <4B5ACDD5.8080007@gmail.com> <fabb9a1e1001230322t708756fahce326511d3f0bda5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	jugg@hotmail.com
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 23 15:25:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYgvF-0004Bv-G4
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jan 2010 15:25:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755688Ab0AWOU5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Jan 2010 09:20:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755683Ab0AWOU5
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jan 2010 09:20:57 -0500
Received: from fg-out-1718.google.com ([72.14.220.154]:4735 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755665Ab0AWOU4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jan 2010 09:20:56 -0500
Received: by fg-out-1718.google.com with SMTP id l26so428250fgb.1
        for <git@vger.kernel.org>; Sat, 23 Jan 2010 06:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:newsgroups:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=L5q1biF5LoKNSW/01OIKfTep81D4QZF1D6XNLVtkFjA=;
        b=wg/RFAavfv4nNS8YQLoejbHmDKEdRYC7LFXecZJEMfE4sdLpo6fzGhSzM6TlZzBZ7R
         bVPR/3t6mg4wNxK90CNqn+NiwAC7gIMbjIdDsh1q0jBuna5KfxQEz65CNkGicb7x1Fen
         TVYrrpv6sfGW4bfe/6A2lzQbuWEDQDGvSUBz0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        b=crhEn9GKLq8DpT4FwcCObedPj3ahLtQZX1A0noMW0uAnLcIDgfwZR3LuxBbWV+2jmV
         Aspk4yCA0tO/SZQZ/hrrQ3sX4fxnzcTov5yjvanmfiSbscY2TPxwlowmKceq5QMfMXVt
         eAFKnDp6UTRx6EGtJ2w3OZU4eIoU0vmshO0Oo=
Received: by 10.103.205.11 with SMTP id h11mr2211827muq.110.1264256455048;
        Sat, 23 Jan 2010 06:20:55 -0800 (PST)
Received: from ?192.168.1.11? (91-67-62-42-dynip.superkabel.de [91.67.62.42])
        by mx.google.com with ESMTPS id s11sm13091893mue.19.2010.01.23.06.20.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 23 Jan 2010 06:20:54 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <fabb9a1e1001230322t708756fahce326511d3f0bda5@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137841>

In contrast to GIT_SSH, SVN_SSH requires quotes for paths that contain
spaces. As GIT_SSH will not work if it contains quotes, it is safe to
assume it never contains quotes. Also, adding quotes to SVN_SSH for paths
that do not contain spaces does no harm. So we always add quotes when
deriving SVN_SSH from GIT_SSH.

This fixes msysGit issue 385, see
http://code.google.com/p/msysgit/issues/detail?id=385

Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
---
 git-svn.perl |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 650c9e5..ef39a9f 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -26,6 +26,7 @@ if (! exists $ENV{SVN_SSH}) {
 		$ENV{SVN_SSH} = $ENV{GIT_SSH};
 		if ($^O eq 'msys') {
 			$ENV{SVN_SSH} =~ s/\\/\\\\/g;
+			$ENV{SVN_SSH} =~ s/(.*)/"$1"/;
 		}
 	}
 }
-- 
1.6.6.265.ga0f40
