X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 3/n] gitweb: Use 's' regexp modifier to secure against filenames with LF
Date: Mon, 30 Oct 2006 22:25:11 +0100
Message-ID: <200610302225.11897.jnareb@gmail.com>
References: <200610301953.01875.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 30 Oct 2006 21:33:32 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=BcYcLcLCNxU/iGKTbIsjJusJ14AdBddXzHwrB7URuZZy/VXKpnth0bQ7QajOnXJP5ijyP+EMaJU07/ymxau0Qm5dO7K0+qTT2YT3WPA85yy2jXQd6Yqma8P5HLbNWdC4xp3v7qeRgRrx1C9U2KENSzB6Chpifjgl1yn7HG1dHxA=
User-Agent: KMail/1.9.3
In-Reply-To: <200610301953.01875.jnareb@gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30527>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Geed9-0001be-3F for gcvg-git@gmane.org; Mon, 30 Oct
 2006 22:25:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161495AbWJ3VZK (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 30 Oct 2006
 16:25:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161497AbWJ3VZK
 (ORCPT <rfc822;git-outgoing>); Mon, 30 Oct 2006 16:25:10 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:44347 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1161495AbWJ3VZH
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 30 Oct 2006 16:25:07 -0500
Received: by ug-out-1314.google.com with SMTP id 32so1266540ugm for
 <git@vger.kernel.org>; Mon, 30 Oct 2006 13:25:05 -0800 (PST)
Received: by 10.67.30.6 with SMTP id h6mr4903190ugj; Mon, 30 Oct 2006
 13:25:05 -0800 (PST)
Received: from host-81-190-18-116.torun.mm.pl ( [81.190.18.116]) by
 mx.google.com with ESMTP id 29sm3371400uga.2006.10.30.13.25.04; Mon, 30 Oct
 2006 13:25:04 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Use 's' (treat string as single line) regexp modifier in
git_get_hash_by_path (against future changes, probably unnecessary)
and in parse_ls_tree_line (when called with '-z'=>1 option) to secure
against filenames containing newline.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Without this patch filename with LF broke "tree" view.

 gitweb/gitweb.perl |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index edca27d..0fd1360 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -890,7 +890,7 @@ sub git_get_hash_by_path {
 	close $fd or return undef;
 
 	#'100644 blob 0fa3f3a66fb6a137f6ec2c19351ed4d807070ffa	panic.c'
-	$line =~ m/^([0-9]+) (.+) ([0-9a-fA-F]{40})\t(.+)$/;
+	$line =~ m/^([0-9]+) (.+) ([0-9a-fA-F]{40})\t(.+)$/s;
 	if (defined $type && $type ne $2) {
 		# type doesn't match
 		return undef;
@@ -1305,7 +1305,7 @@ sub parse_ls_tree_line ($;%) {
 	my %res;
 
 	#'100644 blob 0fa3f3a66fb6a137f6ec2c19351ed4d807070ffa	panic.c'
-	$line =~ m/^([0-9]+) (.+) ([0-9a-fA-F]{40})\t(.+)$/;
+	$line =~ m/^([0-9]+) (.+) ([0-9a-fA-F]{40})\t(.+)$/s;
 
 	$res{'mode'} = $1;
 	$res{'type'} = $2;
-- 
1.4.3.3
