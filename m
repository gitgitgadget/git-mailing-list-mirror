From: Tanay Abhra <tanayabh@gmail.com>
Subject: [RFC/PATCH 2/2] config: Add new query functions to the api
Date: Mon, 26 May 2014 10:33:21 -0700
Message-ID: <1401125601-18249-3-git-send-email-tanayabh@gmail.com>
References: <1401125601-18249-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 26 19:36:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Woyog-0004oY-Kn
	for gcvg-git-2@plane.gmane.org; Mon, 26 May 2014 19:36:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751782AbaEZRgB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2014 13:36:01 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:58190 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751731AbaEZRgA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2014 13:36:00 -0400
Received: by mail-pa0-f41.google.com with SMTP id lj1so7843566pab.14
        for <git@vger.kernel.org>; Mon, 26 May 2014 10:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=55NSPEAKjaqdnnNjDoX0kKs6Cb5H2vDzQINZVF6/95w=;
        b=aKDDGWRuNk74eKvDzauKdbHGesEsgLkgux97c/n50QiXTwSGdHtz4M7zlPZNGKFa24
         evHJSwLCBAU1Xu2nn26XsuEvBvpNDaX0jsHh46AofSuRmPFZuIZfssGj05t1Pqsd00bl
         O2wmM8Qq2zgL8pc2iOfmuhwHP+F8P7J9yqlppKHrNkzrwgZwm6JrHwpQrC8esvIvDqCp
         nRtyHMimbGO3zfdF5EPJsCXvDctRXs1pFPKhOboRZDL+Yf4oTXX6IDf8PYnVi4EJUgKD
         ieydEmdOD9/O6y4tA6EQuy7meBD6fHp9LH83RrXrBrB6MDFrBozPdxe653hWIqlUnsfV
         w4kQ==
X-Received: by 10.68.237.228 with SMTP id vf4mr30038095pbc.131.1401125760301;
        Mon, 26 May 2014 10:36:00 -0700 (PDT)
Received: from localhost.localdomain ([117.254.217.73])
        by mx.google.com with ESMTPSA id sh5sm19261135pbc.21.2014.05.26.10.35.51
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 26 May 2014 10:35:59 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
In-Reply-To: <1401125601-18249-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250110>

Add explanations for `git_config_get_string_multi` and `git_config_get_string`
which utilize the config cache for querying in an non callback manner for a
specific variable.

Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
---
 Documentation/technical/api-config.txt | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/technical/api-config.txt b/Documentation/technical/api-config.txt
index 230b3a0..33b5b90 100644
--- a/Documentation/technical/api-config.txt
+++ b/Documentation/technical/api-config.txt
@@ -77,6 +77,25 @@ To read a specific file in git-config format, use
 `git_config_from_file`. This takes the same callback and data parameters
 as `git_config`.
 
+Querying for specific variables
+-------------------------------
+
+For programs wanting to query for specific variables in a non callback
+manner, the config API provides two functions `git_config_get_string`
+and `git_config_get_string_multi`. They both take a single parameter,
+
+- a variable as the key string for which the corresponding values will
+  be retrieved and returned.
+
+They both read value from an internal cache generated previously from
+reading the config files. `git_config_get_string` returns the value with
+the highest priority(i.e. value in the repo config will be preferred over
+value in user wide config for the same variable).
+
+`git_config_get_string_multi` returns a `string_list` containing all the
+values for that particular variable, sorted in order of increasing
+priority.
+
 Value Parsing Helpers
 ---------------------
 
-- 
1.9.0.GIT
