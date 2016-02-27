From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 1/2] submodule: port resolve_relative_url from shell to C
Date: Sat, 27 Feb 2016 15:28:22 +0700
Message-ID: <20160227082821.GA14856@lanh>
References: <1455320356-15778-1-git-send-email-sbeller@google.com>
 <1455320356-15778-2-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, jrnieder@gmail.com,
	Jens.Lehmann@web.de
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sat Feb 27 09:28:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZaEN-0001ay-E5
	for gcvg-git-2@plane.gmane.org; Sat, 27 Feb 2016 09:28:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752013AbcB0I1v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Feb 2016 03:27:51 -0500
Received: from mail-pf0-f171.google.com ([209.85.192.171]:35834 "EHLO
	mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751426AbcB0I1u (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Feb 2016 03:27:50 -0500
Received: by mail-pf0-f171.google.com with SMTP id w128so17215440pfb.2
        for <git@vger.kernel.org>; Sat, 27 Feb 2016 00:27:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JkX6zcbj55Kbp6u9D83ReEGzODqhug96QNmkb/UFEQE=;
        b=aLc/HFjP9HJrklBE+460yHdjSWQRF3XMG20Por2Wvfrpzdv0r+xUQwwtKX3q3j5wo8
         R+Z0HHOYwaG99vi865Rp+2yrDRXXJFVHsq52kBRUpc0dk3F5wWRZ40QbL8PYIySDSFG0
         B1TTaYFIw06fxIK4CfClkKyz6hWlZ2xqndM2el9JzPWuC+oW63ML+04/Tgs+56u3RMAH
         ZD/tPBRN6AXWmBj7AYEXcV788syzi/CopTt/iH/gyf8F/WHVKp1fHmQehaQOC2/OY/sB
         KBKALv+NEpOhER/AdBZDUqAlyKdBS5XOlEi2K+MhHAJfEsAWYyel6smbf9pMCTuS4y8U
         DrQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JkX6zcbj55Kbp6u9D83ReEGzODqhug96QNmkb/UFEQE=;
        b=MV2aPMzkZCo3ysaMp3DNYxC87xs8QLaBTCgg4ftzSmavVxOr8H5ds5NFcxRMZPvNGf
         p29W/GFU0ufUzeufyecveN26SPTSq3JFYxItsXpJZHwVgExpx8lHqjiSeDAhCfdxhbPy
         RsCJPxgY08gEBxZCHpz3KZV9qULoEShhEtdYaWgTlDrpvTzzUncVKsZuom6O7OPHnInY
         EPoR8Led1V2c7GKrc8A2GHzots2A6v/bwSw0rUB2hOsnvU0iusQ3cQVrJD8vYUahvXEH
         LTAyU/UItXI/TFOWzpZPlGJBrgSs89KneaLzqh9+wpMFhhSrEggO//Exfxs/aA3oYYwH
         nIPg==
X-Gm-Message-State: AD7BkJIg5wHeiPizMf/Oa/HyTGcHQw/YLUXyZJ7UUb5ZtgwbzwvMwQbG7zwADzG7hIEY7A==
X-Received: by 10.98.8.80 with SMTP id c77mr8009001pfd.42.1456561669563;
        Sat, 27 Feb 2016 00:27:49 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id 67sm24286541pfi.2.2016.02.27.00.27.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Feb 2016 00:27:48 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 27 Feb 2016 15:28:22 +0700
Content-Disposition: inline
In-Reply-To: <1455320356-15778-2-git-send-email-sbeller@google.com>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287686>

On Fri, Feb 12, 2016 at 03:39:15PM -0800, Stefan Beller wrote:
> Later on we want to automatically call `git submodule init` from
> other commands, such that the users don't have to initialize the
> submodule themselves.  As these other commands are written in C
> already, we'd need the init functionality in C, too.  The
> `resolve_relative_url` function is a large part of that init
> functionality, so start by porting this function to C.
> 
> To create the tests in t0060, the function `resolve_relative_url`
> was temporarily enhanced to write all inputs and output to disk
> when running the test suite. The added tests in this patch are
> a small selection thereof.
> 
> Signed-off-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  builtin/submodule--helper.c | 208 +++++++++++++++++++++++++++++++++++++++++++-

i18n fixes. Can you squash this patch in when it's re-rolled?

-- 8< --
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index f4a0fd7..a6e54fa 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -22,7 +22,7 @@ static char *get_default_remote(void)
 	const char *refname = resolve_ref_unsafe("HEAD", 0, sha1, &flag);
 
 	if (!refname)
-		die("No such ref: HEAD");
+		die(_("No such ref: %s"), "HEAD");
 
 	/* detached HEAD */
 	if (!strcmp(refname, "HEAD"))
-- 8< --
