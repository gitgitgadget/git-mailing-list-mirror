From: Tanay Abhra <tanayabh@gmail.com>
Subject: [RFC/PATCH v2 2/2] config: Add new query functions to the api docs
Date: Mon,  2 Jun 2014 07:47:40 -0700
Message-ID: <1401720460-6525-3-git-send-email-tanayabh@gmail.com>
References: <1401720460-6525-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 02 16:49:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrTYH-0007t5-1L
	for gcvg-git-2@plane.gmane.org; Mon, 02 Jun 2014 16:49:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754670AbaFBOtS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2014 10:49:18 -0400
Received: from mail-pb0-f50.google.com ([209.85.160.50]:40371 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754041AbaFBOtP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2014 10:49:15 -0400
Received: by mail-pb0-f50.google.com with SMTP id ma3so4340323pbc.9
        for <git@vger.kernel.org>; Mon, 02 Jun 2014 07:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=j8gd6fpfprY4gzgqgXJ1X0RadObHhRXoZkr65FANpR8=;
        b=KLX1C5XLOYQjHBTvi+U6MIjGbsGeKdDD96kwfWNQFQ4fJMpoLAV85xXXNF22r8tMba
         vYdJfgD7l5IrWC4eIVG8z7XHJGAC9Q/dS9D3WorHB0867MLQxUQc3zisUCQgpr6wJwb/
         dHsxk8Oq0UG6PIenJmY3q+N9G/RGqNDCU4eiE8dwCxH9U1lCaCstLYvyop/M9LYIoaP8
         A14YL2kdsHakScv2VMQt2RKM56nTLhnZ5E2rpC9GrMHk9PU5JEnogskPRGOFwTrFfvju
         3iynJq3du07Swt5D+TvMwCp+wb7u7ysE0uWqY8r9dtqVHd4xvGWdTyFEUZ8KYXHKYPmu
         JoRw==
X-Received: by 10.66.194.102 with SMTP id hv6mr27414373pac.138.1401720554840;
        Mon, 02 Jun 2014 07:49:14 -0700 (PDT)
Received: from localhost.localdomain ([117.254.216.65])
        by mx.google.com with ESMTPSA id ja8sm20927802pbd.3.2014.06.02.07.49.08
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 02 Jun 2014 07:49:14 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
In-Reply-To: <1401720460-6525-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250568>

Add explanations for `git_config_get_string_multi` and `git_config_get_string`
which utilize the config hash table for querying in a non-callback manner for
a specific variable.

Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
---
 Documentation/technical/api-config.txt | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/technical/api-config.txt b/Documentation/technical/api-config.txt
index 230b3a0..8f1a37e 100644
--- a/Documentation/technical/api-config.txt
+++ b/Documentation/technical/api-config.txt
@@ -77,6 +77,24 @@ To read a specific file in git-config format, use
 `git_config_from_file`. This takes the same callback and data parameters
 as `git_config`.
 
+Querying For Specific Variables
+-------------------------------
+
+For programs wanting to query for specific variables in a non-callback
+manner, the config API provides two functions `git_config_get_string`
+and `git_config_get_string_multi`. They both take a single parameter,
+
+- a key string in canonical flat form for which the corresponding values
+  will be retrieved and returned.
+
+They both read values from an internal cache generated previously from
+reading the config files. `git_config_get_string` returns the value with
+the highest priority(i.e. value in the repo config will be preferred over
+value in user wide config for the same variable).
+
+`git_config_get_string_multi` returns a `string_list` containing all the
+values for that particular key, sorted in order of increasing priority.
+
 Value Parsing Helpers
 ---------------------
 
-- 
1.9.0.GIT
