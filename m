From: Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH] git-remote - Unset core.origin when deleting the default remote
Date: Sat, 12 Jan 2008 00:54:31 -0500
Message-ID: <1200117273-3524-2-git-send-email-mlevedahl@gmail.com>
References: <7v63xzzszp.fsf@gitster.siamese.dyndns.org>
 <1200117273-3524-1-git-send-email-mlevedahl@gmail.com>
Cc: git@vger.kernel.org, Mark Levedahl <mlevedahl@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Jan 12 06:55:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDZKl-0003KA-8M
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 06:55:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757657AbYALFyl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2008 00:54:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751463AbYALFyk
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jan 2008 00:54:40 -0500
Received: from an-out-0708.google.com ([209.85.132.240]:2935 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751237AbYALFyi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2008 00:54:38 -0500
Received: by an-out-0708.google.com with SMTP id d31so299153and.103
        for <git@vger.kernel.org>; Fri, 11 Jan 2008 21:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=uxKyKRXEdsgWKA6jKYxGPn7fJbImKqV+y/3m9+L4M5w=;
        b=jyKRDwoa957Tj9xwfj5WXuXAdmwXIWIbuJXZyjlz2bWkE7gEPBjTRuOxzW8GhhR4yOFhwjonwKosaO4v5FDBeSFzxWV6zOVWF2eBWrbo4C6snr2A8Qok1GOPTXMYo+XZO6nv/5fPQCPsKQyni2AeHt3GYgDKnCrmPOr5UdrnTto=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=s/CBs5LWeau7ZVJetz0YMxXroVe8ntLmInouLWGA0k8ue+BxWG5UXAWpTLiwPzULLhiB9QKaCrJajTALllGzNaF9cJtRaCVRL5/8ADVMWCKes6tX/hi30DoIt9Okjxpv3xt4X2H1MH10ZT2FY7E69fFKXC4cCIZ23mKFkLNiHk4=
Received: by 10.100.247.14 with SMTP id u14mr8573529anh.85.1200117278306;
        Fri, 11 Jan 2008 21:54:38 -0800 (PST)
Received: from localhost.localdomain ( [71.163.17.196])
        by mx.google.com with ESMTPS id c37sm6069027ana.9.2008.01.11.21.54.36
        (version=SSLv3 cipher=OTHER);
        Fri, 11 Jan 2008 21:54:37 -0800 (PST)
X-Mailer: git-send-email 1.5.4.rc2.98.g1f3d5
In-Reply-To: <1200117273-3524-1-git-send-email-mlevedahl@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70271>

Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
---
 git-remote.perl |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/git-remote.perl b/git-remote.perl
index d13e4c1..75d2371 100755
--- a/git-remote.perl
+++ b/git-remote.perl
@@ -328,6 +328,11 @@ sub rm_remote {
 
 	$git->command('config', '--remove-section', "remote.$name");
 
+	my $defremote = $git->config("core.origin");
+	if (defined $defremote && $defremote eq $name) {
+	       $git->command("config", "--unset", "core.origin");
+	}
+
 	eval {
 	    my @trackers = $git->command('config', '--get-regexp',
 			'branch.*.remote', $name);
-- 
1.5.4.rc2.98.g1f3d5
