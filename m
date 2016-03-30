From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv4 5/6] submodule update: test recursive path reporting from subdirectory
Date: Tue, 29 Mar 2016 18:27:45 -0700
Message-ID: <1459301266-12403-6-git-send-email-sbeller@google.com>
References: <1459301266-12403-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, jacob.keller@gmail.com,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Mar 30 03:28:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1al4vX-0004Ah-Al
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 03:28:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932314AbcC3B2C (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 21:28:02 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:32816 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932090AbcC3B16 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 21:27:58 -0400
Received: by mail-pa0-f53.google.com with SMTP id zm5so27427581pac.0
        for <git@vger.kernel.org>; Tue, 29 Mar 2016 18:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yq/Z71imv9jUXYaijjfSKz1gq9THQgVfNMN5cIlSH9I=;
        b=nBSv8q5Bk3PbBCIuf+UdR1oIEzhpDzgSIlXLXV6bszMMFlZqZV2v9Y6yOkZNFqrqD8
         vLYFoRpHAKWLVm4izMiZ372zh9kN4JKjPipp+Lta+MAeQi6w/Lm3cubJsX6NXbzZc7zt
         MMLdpho9NqSuBLTJCkFiRjM2FRevRBBGxXBJP6vS97T5LSh+n1UibchffNypXsa2HZsa
         6rVANMxTOvYo1q3v2HzuGn9yQb3O0GhXpXBjqXKUfA72C+AgANksnu+aIgNM84JHOu7V
         BR+aHWKGs2C4Y/b2TM598HO6cOxIb0TNUjrpGQzc/P0KlU5dMjfloQULZ0JqefLX3lpR
         pKZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yq/Z71imv9jUXYaijjfSKz1gq9THQgVfNMN5cIlSH9I=;
        b=aWK2gXRHS+eR537IbIAoelad2aSth9OkAlqztny/uShhJhdRC0c08dI+DMcfcB/Y0Z
         twJG6UCwZCMlpl9q+AZK8Qa4ldmt2H2/eGIAAfem7UedzrlRWq0aG7Yrrc+OnXGKzVh6
         CwALlddpRIO5RehI0d3hKEPEr5sEfmdH4ZUs7fs7Z/o65TEgj2cetReHYXExevRmqJqV
         hIwhLlHe5l4t/fmP/hhbHWAyD6TpfSUrvLZykciByQ2NAHy+QbK/zOd/9dMQvD6Jukzw
         4jHv1wOuy7lpiFe4Db+88qxmrVrpNz5J7wy02Xu/1qyr/z3ywww6ZYlOWixyYTRWINMH
         k4bw==
X-Gm-Message-State: AD7BkJLgwSpeTv5Cvn/d2U9L34L2gPPm2RaVwqlgtC7RHsxEuu7kzXxf+O+bu3ndtF5yMjeR
X-Received: by 10.66.171.75 with SMTP id as11mr260321pac.36.1459301277237;
        Tue, 29 Mar 2016 18:27:57 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:9cc5:9f4:3ffe:cd1])
        by smtp.gmail.com with ESMTPSA id v14sm1155216pas.10.2016.03.29.18.27.56
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 29 Mar 2016 18:27:56 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.2.gb331331
In-Reply-To: <1459301266-12403-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290255>

This patch is just a test and fixes no bug as there is currently no bug
in the path handling of `submodule update`.

In `submodule update` we make a call to `submodule--helper list --prefix
"$wt_prefix"` which looks a bit brittle and likely to introduce a bug
for the path handling. It is not a bug as the prefix is ignored inside
the submodule helper for now. If this test breaks eventually, we want
to make sure the `wt_prefix` is passed correctly into recursive submodules.
Hint: In recursive submodules we expect `wt_prefix` to be empty.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 t/t7406-submodule-update.sh | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 01dd324..e5af4b4 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -379,6 +379,26 @@ test_expect_success 'submodule update - command in .git/config catches failure -
 	test_cmp actual expect
 '
 
+cat << EOF >expect
+Execution of 'false $submodulesha1' failed in submodule path '../super/submodule'
+Failed to recurse into submodule path '../super'
+EOF
+
+test_expect_success 'recursive submodule update - command in .git/config catches failure -- subdirectory' '
+	(cd recursivesuper &&
+	 git submodule update --remote super &&
+	 git add super &&
+	 git commit -m "update to latest to have more than one commit in submodules"
+	) &&
+	git -C recursivesuper/super config submodule.submodule.update "!false" &&
+	git -C recursivesuper/super/submodule reset --hard $submodulesha1^ &&
+	(cd recursivesuper &&
+	 mkdir -p tmp && cd tmp &&
+	 test_must_fail git submodule update --recursive ../super 2>../../actual
+	) &&
+	test_cmp actual expect
+'
+
 test_expect_success 'submodule init does not copy command into .git/config' '
 	(cd super &&
 	 H=$(git ls-files -s submodule | cut -d" " -f2) &&
-- 
2.8.0.2.gb331331
