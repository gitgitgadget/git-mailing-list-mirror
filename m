From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/6] cherry-pick: treat CHERRY_PICK_HEAD and REVERT_HEAD as refs
Date: Thu, 25 Jun 2015 14:11:57 -0700
Message-ID: <xmqqsi9fwl0i.fsf@gitster.dls.corp.google.com>
References: <1435265110-6414-1-git-send-email-dturner@twopensource.com>
	<1435265110-6414-2-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Thu Jun 25 23:12:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8ERc-0004Lk-0M
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jun 2015 23:12:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752558AbbFYVMT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2015 17:12:19 -0400
Received: from mail-ig0-f169.google.com ([209.85.213.169]:35928 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751811AbbFYVMA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2015 17:12:00 -0400
Received: by igbiq7 with SMTP id iq7so946921igb.1
        for <git@vger.kernel.org>; Thu, 25 Jun 2015 14:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=k5yX6heXg62+7cjPYJGtrpKoCpqiYlzbVL6Pnlxmuj0=;
        b=dlfbC3hbLs3EP9EtRPWjPtQCgClD3s2PjrWNA8uI7W86lFGav5EoDHsAbmw4jJQH3h
         9XHbHuNjvgb19OoMwbd73WetaHks9IECEew3dOpiE/l5mLWoxj7uPTSOo6mYYvmn95us
         lDi8VEF4GUNKo1bjAAgTuOWXWmbVi0d6x2X+XiH0YXi1ljf1UbJxToznp4wsI4FEbRBk
         5fYkKTsDILrRu0fFLYp0zkW3jLLzNRtJWEOmCGKNkqSphEB0KzbTos8PBp8kx5qSYvTM
         cia3kyYbNLdt9f+epkLYV2dJvsWGJd8OutvjnXDWQnqFRgvNFzMdTlXWVWRcbi/sB3Vt
         qFAw==
X-Received: by 10.50.129.101 with SMTP id nv5mr6950724igb.31.1435266718925;
        Thu, 25 Jun 2015 14:11:58 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:3512:3582:e5d3:22a9])
        by mx.google.com with ESMTPSA id je2sm4099009igb.8.2015.06.25.14.11.57
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 25 Jun 2015 14:11:58 -0700 (PDT)
In-Reply-To: <1435265110-6414-2-git-send-email-dturner@twopensource.com>
	(David Turner's message of "Thu, 25 Jun 2015 16:45:06 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272736>

David Turner <dturner@twopensource.com> writes:

> Instead of directly writing to and reading from files in
> $GIT_DIR, use ref API to interact with CHERRY_PICK_HEAD
> and REVERT_HEAD.
>
> Signed-off-by: David Turner <dturner@twopensource.com>
> ---

I may have said this already in the last round, but I cannot shake
off the feeling that this patch is doing two completely unrelated
things at once.

The change to refs.c that introduced the should_autocreate_reflog()
helper (which is a good idea even without any other changes in this
patch) and then using that to commit_ref_update() does not have
anything to do with CHERRY_PICK_HEAD/REVERT_HEAD, does it?

 * commit_ref_update() gained a new "flags" parameter, but it does
   not seem to be used at all.  Why?

 * Why is it a good idea to move the "does the log exist or should
   we auto-create?" check from log_ref_setup() to
   commit_ref_update()?

These are not just unexplained, but does not have anything to do
with using ref API to write and read CHERRY_PICK_HEAD/REVERT_HEAD.

They _might_ be a prerequisite, but it is not clear why.  I suspect
that you do not have to touch refs.c at all for the purpose of the
"theme" of the patch explained by the "Subject" line.
