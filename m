From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH 1/2] http-push: push <remote> :<branch> deletes remote
	branch
Date: Wed, 27 Feb 2008 20:27:53 +0100
Message-ID: <20080227192753.GB1818@localhost>
References: <alpine.LSU.1.00.0802181733400.30505@racer.site> <20080223212843.GA30054@localhost> <20080224085830.GD13416@glandium.org> <20080224180340.GA11515@localhost> <20080224184832.GA24240@glandium.org> <20080225232820.GA18254@localhost> <7vprukfttt.fsf@gitster.siamese.dyndns.org> <20080227085442.GA22501@localhost> <alpine.LSU.1.00.0802270947110.22527@racer.site> <20080227192334.GA1818@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 27 20:28:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JURx5-0005Ks-M3
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 20:28:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755208AbYB0T1s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2008 14:27:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753901AbYB0T1s
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 14:27:48 -0500
Received: from fk-out-0910.google.com ([209.85.128.184]:36914 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755125AbYB0T1r (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 14:27:47 -0500
Received: by fk-out-0910.google.com with SMTP id z23so3892431fkz.5
        for <git@vger.kernel.org>; Wed, 27 Feb 2008 11:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        bh=X9iFxYGEGRpB+qXGbTNKjZYXGQKAbJF4uJQGMqm25IM=;
        b=U7CfZOFqxxuK7LPOLkWRON5p80WM7N/9eNapexscCsBEo3s00WhaJ1fvol3D6yomh8ei6T8bEPg10Jl7rQ9n9A3Pm/IvDUmATFxcS+BXhqSHLScqsnmmW+/dAnbwul4E9D/RcWv8fUVdnkW/y7S0gQ6usiUwXwsAp1kf5XvGpD8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=GPvNy0TUhmLBomTel1mdQCuQINimyGJx8xr8Kzw9jLMJ9/YRL64iBjSRGEPb7gfrTNTMieZzDTZUYhRP3M+7TS/kr8bZCBY2XeubVQfcEbHXXAVVyU6VuRiyLqDzHEwxx1NFLv0g22NXTp1gHXDZdhr69r0lM2O/S7sR+fmemAk=
Received: by 10.82.125.8 with SMTP id x8mr13001823buc.22.1204140466041;
        Wed, 27 Feb 2008 11:27:46 -0800 (PST)
Received: from darc.dyndns.org ( [84.154.73.116])
        by mx.google.com with ESMTPS id j10sm3488224mue.14.2008.02.27.11.27.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 27 Feb 2008 11:27:45 -0800 (PST)
Received: from drizzd by darc.dyndns.org with local (Exim 4.68)
	(envelope-from <drizzd@aon.at>)
	id 1JURwX-0000ps-LQ; Wed, 27 Feb 2008 20:27:53 +0100
Content-Disposition: inline
In-Reply-To: <20080227192334.GA1818@localhost>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75288>

This mirrors current ssh/git push syntax.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---
 http-push.c |   17 ++++++++++++-----
 1 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/http-push.c b/http-push.c
index 0beb740..4b31070 100644
--- a/http-push.c
+++ b/http-push.c
@@ -2138,6 +2138,8 @@ static int delete_remote_branch(char *pattern, int force)
 
 	/* Send delete request */
 	fprintf(stderr, "Removing remote branch '%s'\n", remote_ref->name);
+	if (dry_run)
+		return 0;
 	url = xmalloc(strlen(remote->url) + strlen(remote_ref->name) + 1);
 	sprintf(url, "%s%s", remote->url, remote_ref->name);
 	slot = get_active_slot();
@@ -2311,6 +2313,16 @@ int main(int argc, char **argv)
 
 		if (!ref->peer_ref)
 			continue;
+
+		if (is_zero_sha1(ref->peer_ref->new_sha1)) {
+			if (delete_remote_branch(ref->name, 1) == -1) {
+				error("Could not remove %s", ref->name);
+				rc = -4;
+			}
+			new_refs++;
+			continue;
+		}
+
 		if (!hashcmp(ref->old_sha1, ref->peer_ref->new_sha1)) {
 			if (push_verbosely || 1)
 				fprintf(stderr, "'%s': up-to-date\n", ref->name);
@@ -2342,11 +2354,6 @@ int main(int argc, char **argv)
 			}
 		}
 		hashcpy(ref->new_sha1, ref->peer_ref->new_sha1);
-		if (is_zero_sha1(ref->new_sha1)) {
-			error("cannot happen anymore");
-			rc = -3;
-			continue;
-		}
 		new_refs++;
 		strcpy(old_hex, sha1_to_hex(ref->old_sha1));
 		new_hex = sha1_to_hex(ref->new_sha1);
-- 
1.5.4.2.156.ge3c5
