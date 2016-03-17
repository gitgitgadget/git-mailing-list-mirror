From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: bug: sparse config interpretation incorrectness in 2.8.0-rc2
Date: Thu, 17 Mar 2016 07:56:32 +0700
Message-ID: <20160317005632.GA17778@duynguyen-vnpc.dek-tpc.internal>
References: <56E9F5B3.6030903@fb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Mateusz Kwapich <mitrandir@fb.com>
To: Durham Goode <durham@fb.com>
X-From: git-owner@vger.kernel.org Thu Mar 17 01:56:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agMF4-000773-3U
	for gcvg-git-2@plane.gmane.org; Thu, 17 Mar 2016 01:56:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966957AbcCQA4l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 20:56:41 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:33396 "EHLO
	mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932684AbcCQA4k (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2016 20:56:40 -0400
Received: by mail-pf0-f176.google.com with SMTP id 124so96510124pfg.0
        for <git@vger.kernel.org>; Wed, 16 Mar 2016 17:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gmkhl+aG3UhFcFmWvrgUlHyRl4MfPPLc48CiV+7OP7I=;
        b=HHkuaXL+4eG+iJShaD2GbwXW/C8Mru8kSvkza/A1sqXsU2BR86gxlxrhUR/rBGT+Iw
         STc/QbXiE2q7vaG/SlaFDBpekF4wWvrZaE3XQzbU3utW5hGHq0vMBxcStyMgMQYk9YzU
         UymkJDzi+/TEnehGLmpyaQ/X6uLUQTfZKY5hTQxenGaRHZhByi2HxAxtpiMcM3doEPYS
         5GwOlwiWeYJ1D0Io0kS8mJey8IFnmTRCl9rjAHJDY0XvldY6W0uYBwVrTAl8WSV4hnK2
         52oV2w0w/uZQOmzbtSPfyxoZ1VVbGDlPo1TCNgoiR/rSyTVsXt3PXau39vB276Ryunkn
         6urw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gmkhl+aG3UhFcFmWvrgUlHyRl4MfPPLc48CiV+7OP7I=;
        b=AETzpQ+Lc/GL0wvhNZl5HQORb2WHtVP3Ow11w4u9IzSGM6p1f3uHgvnE69+nPjQ1gY
         wxjGAeX8GujVkIn8Yvo3Q4kYhO+DG+uek5gFsKxPIhkfr7NewGfJddnoYnnDYeeht7/m
         EufxyDO4N2+JMkvOY6ecG7bPJS4WYbDtL1Tzoe3+aALkS0aEvDj6bqbHW4s4kxZQF+JY
         /5sga1jlfKfYInyp3b9xGTBg/AX6lraufQkovXU1OYhcg+3/gHM8RlAYfMBl48sE7KhD
         fv8HAcgNVfyTu+RvbtY93bAJPVQ9jGVlcPt/5Zi0kiie20iWNckDGsfCeEuPZuDkRW29
         n7YQ==
X-Gm-Message-State: AD7BkJIGOzQJ6t8TtJy4lkMDV/mNIt1DFjtCbMWQNh+nN8Syc+QMWMyvb5f2zJ476zZGOA==
X-Received: by 10.66.190.40 with SMTP id gn8mr10502569pac.64.1458176199334;
        Wed, 16 Mar 2016 17:56:39 -0700 (PDT)
Received: from duynguyen-vnpc.dek-tpc.internal ([14.161.14.188])
        by smtp.gmail.com with ESMTPSA id l88sm8443922pfj.7.2016.03.16.17.56.36
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 Mar 2016 17:56:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <56E9F5B3.6030903@fb.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289066>

On Wed, Mar 16, 2016 at 05:09:23PM -0700, Durham Goode wrote:
> Using git 2.8.0-rc2, given a repo with the following files:
> 
> - one/hideme
> - one/donthide
> - two/foo
> 
> A sparse config of:
> 
> cat > .git/info/sparse-checkout <<EOF
> /*
> !one/hideme
> EOF
> 
> Results in a repository that only has `one/donthide` in it.  I would
> expect `two/foo`to be present as well.  This worked in 2.6, and
> bisecting it points to d589a67eceacd1cc171bbe94906ca7c9a0edd8c5
> "dir.c: don't exclude whole dir prematurely" (author cc'd).

Thank you. This should fix it. I think I understand why it goes
wrong. I'm going to run some more tests and post a proper patch later.

-- 8< --
diff --git a/dir.c b/dir.c
index 69e0be6..77f38a5 100644
--- a/dir.c
+++ b/dir.c
@@ -1027,7 +1027,6 @@ static struct exclude *last_exclude_matching_from_list(const char *pathname,
 				exc = x;
 				break;
 			}
-			continue;
 		}
 
 		if (x->flags & EXC_FLAG_MUSTBEDIR) {
-- 8< --
--
Duy
