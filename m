From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 0/2] Port `git submodule init` from shell to C
Date: Tue, 19 Jan 2016 18:03:14 -0800
Message-ID: <1453255396-31942-1-git-send-email-sbeller@google.com>
References: <xmqqa8o188i0.fsf@gitster.mtv.corp.google.com>
Cc: Stefan Beller <sbeller@google.com>, j6t@kdbg.org,
	sunshine@sunshineco.com, Jens.Lehmann@web.de
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jan 20 03:03:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLi7M-00089H-W3
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jan 2016 03:03:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933695AbcATCDZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2016 21:03:25 -0500
Received: from mail-pf0-f176.google.com ([209.85.192.176]:36759 "EHLO
	mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933035AbcATCDX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2016 21:03:23 -0500
Received: by mail-pf0-f176.google.com with SMTP id n128so185228041pfn.3
        for <git@vger.kernel.org>; Tue, 19 Jan 2016 18:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CN5RE3a8G6K4YnJqXLHBLL2XNTG5XNtfNNAmp96eT0Q=;
        b=Ravd7UPpLPknok4MCwwSJinfIjz082tPFDjnuxlK3wkuf+6ctDjoQov4WW/KQ9f5nV
         k5H+HyXGOAOwcRpMJRHue59sz8DB0BIko7vhoyMq/SNMa6a0nQBOvHDvV8kCA4HxsKhC
         m4J2AeXCaIcqrkNIgJZyVFmG9V834hsDBZT1gsU7A/GV8cZcXbXkXyfU2GiA1JkDsORi
         4jIdHX0YrGmtoNoe865Tzz8aoJgn2U8kyKt9k6Bu6JQFHhs+rqRRm3sZHJcBpIlJ4xNR
         qM24p2JF9B+zV7L0meNxkp7IcPUOHzXIHAj6WG3euJtpnyZ4TLL55wGNgOHJHr3SdaUk
         PeYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CN5RE3a8G6K4YnJqXLHBLL2XNTG5XNtfNNAmp96eT0Q=;
        b=J3YqCbbAYEH4ugAN+pFJ7PNOxTwxw9Znkg06mHuDX6KBSMOSMo72xrye6HYKd8VIId
         FCysE/jESTIGy4evf55ohR10IP4Fq3wRw3s0S7Y+76D/tRx+9NrN6NmnGPb9ya86Pk93
         lXMhfbcvWSGSmQcZozEEQK/Ka8tL9uYwIZaCYLEPe9MFfwdZnUGxIQ1KjsY0aiUxOzo2
         s5kDjms/v00eT2VE8CIaVXosarzMkcxAb02PkA/pch3e2gHUzsRbcarbpIqse/oQPEwn
         0y6y4QHW09e+ZgvAQMwyo8J5AD2ZDt0MRFdmR5KjoTiywqbQhZ27ZDBICXhbCTbqqAgi
         HNaQ==
X-Gm-Message-State: ALoCoQmr8s9vA6eI+TsexGXXKYOMMX5HfyGlG69TYTXroID04PXsMu2aFpqaTPwdFahfc69h9RE81ADiBUohJ/hQERLbpGJo0Q==
X-Received: by 10.98.65.148 with SMTP id g20mr49186074pfd.21.1453255402777;
        Tue, 19 Jan 2016 18:03:22 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:25db:c0:235a:551d])
        by smtp.gmail.com with ESMTPSA id ze5sm44744724pac.32.2016.01.19.18.03.21
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 19 Jan 2016 18:03:21 -0800 (PST)
X-Mailer: git-send-email 2.7.0.rc0.44.g6033384.dirty
In-Reply-To: <xmqqa8o188i0.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284414>

This replaces sb/submodule-init.
As I was crafting another series on top of this series I noticed a two bugs,
so I am resending it fixed.

* honor the quiet setting
* print to stderr instead of stdout. (In the next series we want to
  call init_submodule from within update_clone whose stdout is piped into
  git-submodule.sh, so stderr is the only way to talk to the user)

Thanks,
Stefan

The interdiff:

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index c7bd38a..fecc9aa 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -226,7 +226,7 @@ static int git_submodule_config(const char *var, const char *value, void *cb)
        return parse_submodule_config_option(var, value);
 }
 
-static void init_submodule(const char *path, const char *prefix)
+static void init_submodule(const char *path, const char *prefix, int quiet)
 {
        const struct submodule *sub;
        struct strbuf sb = STRBUF_INIT;
@@ -275,9 +275,9 @@ static void init_submodule(const char *path, const char *prefix)
                if (git_config_set(sb.buf, url))
                        die(_("Failed to register url for submodule path '%s'"),
                            displaypath);
-
-               printf(_("Submodule '%s' (%s) registered for path '%s'\n"),
-                       sub->name, url, displaypath);
+               if (!quiet)
+                       fprintf(stderr, _("Submodule '%s' (%s) registered for path '%s'\n"),
+                               sub->name, url, displaypath);
                free(url);
        }
 
@@ -325,7 +325,7 @@ static int module_init(int argc, const char **argv, const char *prefix)
                die(_("Pass at least one submodule"));
 
        for (i = 0; i < argc; i++)
-               init_submodule(argv[i], prefix);
+               init_submodule(argv[i], prefix, quiet);
 
        return 0;
 }


Stefan Beller (2):
  submodule: port resolve_relative_url from shell to C
  submodule: port init from shell to C

 builtin/submodule--helper.c | 330 +++++++++++++++++++++++++++++++++++++++++++-
 git-submodule.sh            | 118 +---------------
 t/t0060-path-utils.sh       |  42 ++++++
 3 files changed, 370 insertions(+), 120 deletions(-)

-- 
2.7.0.rc0.44.g6033384.dirty
