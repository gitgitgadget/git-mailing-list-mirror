From: "Marten Svanfeldt (dev)" <developer@svanfeldt.com>
Subject: [PATCH fixed] git-svn: Update git-svn to use the ability to
 place temporary files within repository directory
Date: Thu, 13 Nov 2008 00:38:06 +0800
Message-ID: <491B066E.8030501@svanfeldt.com>
References: <491AE935.4040406@svanfeldt.com>
Reply-To: developer@svanfeldt.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: normalperson@yhbt.net
To: msysgit@googlegroups.com, git@vger.kernel.org
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Wed Nov 12 17:39:49 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-gx0-f59.google.com ([209.85.217.59])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0Iku-0008KD-Vv
	for gcvm-msysgit@m.gmane.org; Wed, 12 Nov 2008 17:39:49 +0100
Received: by gxk19 with SMTP id 19so51797gxk.21
        for <gcvm-msysgit@m.gmane.org>; Wed, 12 Nov 2008 08:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :x-spam-checker-version:x-spam-level:x-spam-status:received
         :message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding:reply-to:sender:precedence:x-google-loop
         :mailing-list:list-id:list-post:list-help:list-unsubscribe
         :x-beenthere-env:x-beenthere;
        bh=3ZKHKyOTh3k7gpPDNK0Y7MgiSfHcGF5Qh6eNySv3Rrs=;
        b=uOD4e5nRZGpIF3518/ejgDotdK/lkSgqHrVVQBHGi1qinzf9+FL211zP9x6HSxLF8V
         HmFXiUzPKd4Pf4mMSI/hCs8UYSNprVA3YvLX4yX1LhTl1fC6TuTHZAMPtv3BUIQZWloD
         T2jyF7XSUhZ8h/4Kkq8s+ZmhJ9LzxlUdoZMJE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :x-spam-checker-version:x-spam-level:x-spam-status:message-id:date
         :from:user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding:reply-to
         :sender:precedence:x-google-loop:mailing-list:list-id:list-post
         :list-help:list-unsubscribe:x-beenthere-env:x-beenthere;
        b=10ajbv3bOOPeqA60qm6JEHWFwr1YyHkIVQ3wD7QLoN+JegKLU+KDjBl2cgzM/O8ZZG
         XgI+t762A+nLSecD2ZHBJpBpTjre/tOIRArvJCzgKAtCcYd+5kK4utW3jB0iBVdjhPj8
         2BMpJ+mAoxazDGf6FNxtnndmQOC8G7TkDmU+8=
Received: by 10.90.73.17 with SMTP id v17mr650556aga.12.1226507912515;
        Wed, 12 Nov 2008 08:38:32 -0800 (PST)
Received: by 10.106.28.34 with SMTP id b34gr3154prb.0;
	Wed, 12 Nov 2008 08:38:32 -0800 (PST)
X-Sender: developer@svanfeldt.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.151.155.5 with SMTP id h5mr6410202ybo.7.1226507911970; Wed, 12 Nov 2008 08:38:31 -0800 (PST)
Received: from smtp.anarazel.de (mail.anarazel.de [217.115.131.40]) by mx.google.com with ESMTP id 7si15749834yxg.0.2008.11.12.08.38.31; Wed, 12 Nov 2008 08:38:31 -0800 (PST)
Received-SPF: neutral (google.com: 217.115.131.40 is neither permitted nor denied by best guess record for domain of developer@svanfeldt.com) client-ip=217.115.131.40;
Authentication-Results: mx.google.com; spf=neutral (google.com: 217.115.131.40 is neither permitted nor denied by best guess record for domain of developer@svanfeldt.com) smtp.mail=developer@svanfeldt.com
Received: by smtp.anarazel.de (Postfix, from userid 108) id 57DED448005; Wed, 12 Nov 2008 17:38:30 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on mail
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00 autolearn=ham version=3.2.5
Received: from [140.114.202.94] (x970003.HUNG.ab.nthu.edu.tw [140.114.202.94]) by smtp.anarazel.de (Postfix) with ESMTPSA id 13CF5448004; Wed, 12 Nov 2008 17:38:20 +0100 (CET)
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
In-Reply-To: <491AE935.4040406@svanfeldt.com>
X-Enigmail-Version: 0.95.7
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit+owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit+help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit+unsubscribe@googlegroups.com>
X-BeenThere-Env: msysgit@googlegroups.com
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100765>


This fixes git-svn within msys where Perl will provide temporary files with path
such as /tmp while the git suit expects native Windows paths.

Signed-off-by: Marten Svanfeldt <developer@svanfeldt.com>
---
Somehow I managed to screw up the last patch when getting it ready for
submission. This patch is a fixed version that actually works.

 git-svn.perl |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index ef6d773..23ceaff 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -3312,11 +3312,11 @@ sub change_file_prop {

 sub apply_textdelta {
 	my ($self, $fb, $exp) = @_;
-	my $fh = Git::temp_acquire('svn_delta');
+	my $fh = $::_repository->temp_acquire('svn_delta');
 	# $fh gets auto-closed() by SVN::TxDelta::apply(),
 	# (but $base does not,) so dup() it for reading in close_file
 	open my $dup, '<&', $fh or croak $!;
-	my $base = Git::temp_acquire('git_blob');
+	my $base = $::_repository->temp_acquire('git_blob');
 	if ($fb->{blob}) {
 		print $base 'link ' if ($fb->{mode_a} == 120000);
 		my $size = $::_repository->cat_blob($fb->{blob}, $base);
@@ -3357,7 +3357,8 @@ sub close_file {
 				warn "$path has mode 120000",
 						" but is not a link\n";
 			} else {
-				my $tmp_fh = Git::temp_acquire('svn_hash');
+				my $tmp_fh = $::_repository->temp_acquire(
+					'svn_hash');
 				my $res;
 				while ($res = sysread($fh, my $str, 1024)) {
 					my $out = syswrite($tmp_fh, $str, $res);
@@ -3745,7 +3746,7 @@ sub change_file_prop {

 sub _chg_file_get_blob ($$$$) {
 	my ($self, $fbat, $m, $which) = @_;
-	my $fh = Git::temp_acquire("git_blob_$which");
+	my $fh = $::_repository->temp_acquire("git_blob_$which");
 	if ($m->{"mode_$which"} =~ /^120/) {
 		print $fh 'link ' or croak $!;
 		$self->change_file_prop($fbat,'svn:special','*');
-- 
1.6.0.3.1439.gc9385a
