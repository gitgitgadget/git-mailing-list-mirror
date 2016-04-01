From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv4 0/4] Some cleanups
Date: Thu, 31 Mar 2016 17:35:42 -0700
Message-ID: <1459470946-16522-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, peff@peff.net, sunshine@sunshineco.com
X-From: git-owner@vger.kernel.org Fri Apr 01 02:35:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aln46-0007ib-Ug
	for gcvg-git-2@plane.gmane.org; Fri, 01 Apr 2016 02:35:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755637AbcDAAfu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 20:35:50 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:35862 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753371AbcDAAft (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 20:35:49 -0400
Received: by mail-pa0-f52.google.com with SMTP id tt10so77423174pab.3
        for <git@vger.kernel.org>; Thu, 31 Mar 2016 17:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=7kXfT1vS2EwFbuC0SJ6A19nl/6yARkcR8aXo/9To8Do=;
        b=M9xFHc32Ew5BuQq7xC3ix8cVvI1nDFGW/zr1Vhw5akVmxkte0Z4G53xv9mVAlc9oRN
         vBClzY8WaBpjnuzNCT8JqMVcvpKN7bBU8Y+y7qS9abecsHCJr4OAoZl1ehslMVrPeNO8
         +H34cJe+1oJXGx32j/1NBLnoW8By25Ty9P06CL71vmzNFnowhkr2hHFd2glAr9TMlAFh
         S6vbrd9ma00GKyYtvQJWh6TY6njyn46VYGHg7HcQ9u1j/nq9zw3rP+HzHsIzMT795Y/L
         FG6ReMsKMIPJGqn+ukKw28NTDWp9MF3DOgpJEogA3FBPSbzXT2fEq/bv3lAQhbjmVZ3T
         QADw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7kXfT1vS2EwFbuC0SJ6A19nl/6yARkcR8aXo/9To8Do=;
        b=SNpisV3E0yUiE34MQIEYjt1OIFWGpshXtP4N/z22Y2t4mblGFidhVXR/N4OnrLaJGW
         tF7102r5/J9LWhPbiLYkuuDP/82ZHNg2rwSLwTDKJyr+Ye21OGnn0gUVq064VuV/wUhl
         B1ADEvXlfnOxGh8lZRkfr64sazp682LaZlQpUbc3N2rqbq25QIcTnSUqdoW3jHA7zsTJ
         lXSvnnOaFMYSILvTTLXsnUk9j73bzvzXRogWBXR2TnCyH3Fyrm2wqiGcNsufbMyKRrHF
         gdttkVLfo7+xBkWAuf5l/rSDO7OWukcWQ+d/HF7IlBvLgcQzvbesS45ggbBGSlEI/Jp/
         aX2w==
X-Gm-Message-State: AD7BkJKRua5gQw9uWzY95ZeG7reC1MOZdjCmgU0OJKZw4NXWZMOimhHUR19Ki9iLbOo9ppRh
X-Received: by 10.66.171.75 with SMTP id as11mr18074157pac.36.1459470948506;
        Thu, 31 Mar 2016 17:35:48 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:a519:64be:5369:a180])
        by smtp.gmail.com with ESMTPSA id qy7sm15991895pab.34.2016.03.31.17.35.47
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 31 Mar 2016 17:35:47 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.264.gc776916.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290496>

Thanks for the reviews!
Thanks Jeff, Eric, Junio!

This replaces sb/misc-cleanups.

* Revert the builtin/notes fix to the first version as git_config_get_value
  is dangerous, and the memory allocation and free is just a small overhead here
* the bundle code integrates all of the suggestions (i.e. rollback_lock_file
  conditioned on (!bundle_to_stdout).
  
I hope I got everything by now. I will head out for today and tomorrow I'll
be traveling to NY, where there is the Git Merge conference on Mon, Tues and some
vacation afterwards. I'll be online in a very limited fashion. (I plan on taking
my phone only, no laptop), so in case I missed a thing this series will halt
for a while or someone else picks it up.

Thanks,
Stefan

diff to remotes/origin/sb/misc-cleanups (which doesn't contain the bundle fix):
diff --git a/builtin/notes.c b/builtin/notes.c
index 386402d..afcfa8f 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -741,13 +741,14 @@ static int merge_commit(struct notes_merge_options *o)
 static int git_config_get_notes_strategy(const char *key,
 					 enum notes_merge_strategy *strategy)
 {
-	const char *value;
+	char *value;
 
-	if (git_config_get_value(key, &value))
+	if (git_config_get_string(key, &value))
 		return 1;
 	if (parse_notes_merge_strategy(value, strategy))
 		git_die_config(key, "unknown notes merge strategy %s", value);
 
+	free(value);
 	return 0;
 }
 
diff --git a/bundle.c b/bundle.c
index 506ac49..08e32ca 100644
--- a/bundle.c
+++ b/bundle.c
@@ -435,12 +435,14 @@ int create_bundle(struct bundle_header *header, const char *path,
 
 	/* write prerequisites */
 	if (compute_and_write_prerequisites(bundle_fd, &revs, argc, argv))
-		return -1;
+		goto err;
 
 	argc = setup_revisions(argc, argv, &revs, NULL);
 
-	if (argc > 1)
-		return error(_("unrecognized argument: %s"), argv[1]);
+	if (argc > 1) {
+		error(_("unrecognized argument: %s"), argv[1]);
+		goto err;
+	}
 
 	object_array_remove_duplicates(&revs.pending);
 
@@ -448,17 +450,23 @@ int create_bundle(struct bundle_header *header, const char *path,
 	if (!ref_count)
 		die(_("Refusing to create empty bundle."));
 	else if (ref_count < 0)
-		return -1;
+		goto err;
 
 	/* write pack */
 	if (write_pack_data(bundle_fd, &revs))
-		return -1;
+		goto err;
 
 	if (!bundle_to_stdout) {
 		if (commit_lock_file(&lock))
 			die_errno(_("cannot create '%s'"), path);
 	}
 	return 0;
+err:
+	if (!bundle_to_stdout) {
+		close(bundle_fd);
+		rollback_lock_file(&lock);
+	}
+	return -1;
 }
 
 int unbundle(struct bundle_header *header, int bundle_fd, int flags)


Stefan Beller (4):
  notes: don't leak memory in git_config_get_notes_strategy
  abbrev_sha1_in_line: don't leak memory
  bundle: don't leak an fd in case of early return
  credential-cache, send_request: close fd when done

 builtin/notes.c    |  5 +++--
 bundle.c           | 18 +++++++++++++-----
 credential-cache.c |  1 +
 wt-status.c        |  4 +---
 4 files changed, 18 insertions(+), 10 deletions(-)

-- 
2.5.0.264.gc776916.dirty
