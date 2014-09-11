From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 06/19] rename_ref: don't ask read_ref_full where the ref came
 from
Date: Wed, 10 Sep 2014 20:06:52 -0700
Message-ID: <20140911030652.GJ18279@google.com>
References: <CAL=YDWmtitT7kHsZqXmojbv8eKYwKwVn7c+gC180FPQN1uxBvQ@mail.gmail.com>
 <CAL=YDWnd=GNycrPO-5yq+a_g569fZDOmzpat+AWrXd+5+bXDQA@mail.gmail.com>
 <CAL=YDWka47hV2TMcwcY1hm+RhbiD6HD=_ED4zB84zX5e5ABf4Q@mail.gmail.com>
 <CAL=YDWm9VaKUBRAmmybHzOBhAg_VvNc0KMG0W_uTA02YYzQrzA@mail.gmail.com>
 <20140820231723.GF20185@google.com>
 <20140911030318.GD18279@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Thu Sep 11 05:07:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRuip-000145-Hh
	for gcvg-git-2@plane.gmane.org; Thu, 11 Sep 2014 05:06:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751598AbaIKDG4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2014 23:06:56 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:48972 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751442AbaIKDGz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2014 23:06:55 -0400
Received: by mail-pa0-f54.google.com with SMTP id lj1so9784465pab.13
        for <git@vger.kernel.org>; Wed, 10 Sep 2014 20:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=mL9cU7MjSRcsWK0taXtIb6J+YPh8e+zP9CwfvECWk8o=;
        b=dnx6p4L0CBkhnUpHH1Dty022Nksy4IGxEkWbdhqkEYTbjCAEc7yvLFIdyXnMplAF3V
         pheJY1UQqrtJO2t0oIkV+2hM4CWvjYDzKOZK3UWaR3lrkhvQ++J+6q6dblr76CqWKgGQ
         kFWNNGtDaZguHrotOyxI/2EToy8WL7T/S7ucCDWSFfZl3dBirDZAEvINGpKnH47cFbSb
         Jq/DWbRs54lzKHAZkUtu7yGQ3QsaVaDJPXgQ/FAv8UgRqHxU1DhQpVEggTRDL/xQvrsk
         zSZgldiSgm+2Mno6UmylaQScIxoNqEYC67B/XwhN2Ostjf0q0FQjdW/7ujZBef7rqbEl
         Qrmg==
X-Received: by 10.68.69.68 with SMTP id c4mr1384857pbu.163.1410404815086;
        Wed, 10 Sep 2014 20:06:55 -0700 (PDT)
Received: from google.com (aiede.mtv.corp.google.com [172.27.69.120])
        by mx.google.com with ESMTPSA id m1sm15931581pdh.18.2014.09.10.20.06.54
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 10 Sep 2014 20:06:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140911030318.GD18279@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256818>

From: Ronnie Sahlberg <sahlberg@google.com>
Date: Wed, 30 Apr 2014 12:41:04 -0700

We call read_ref_full with a pointer to flags from rename_ref but since
we never actually use the returned flags we can just pass NULL here instead.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 refs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 99a9b86..39571f5 100644
--- a/refs.c
+++ b/refs.c
@@ -2671,7 +2671,7 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 		goto rollback;
 	}
 
-	if (!read_ref_full(newrefname, sha1, 1, &flag) &&
+	if (!read_ref_full(newrefname, sha1, 1, NULL) &&
 	    delete_ref(newrefname, sha1, REF_NODEREF)) {
 		if (errno==EISDIR) {
 			if (remove_empty_directories(git_path("%s", newrefname))) {
-- 
2.1.0.rc2.206.gedb03e5
