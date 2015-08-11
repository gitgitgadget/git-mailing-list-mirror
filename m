From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v5 2/5] refs: add ref_type function
Date: Tue, 11 Aug 2015 14:39:18 -0400
Organization: Twitter
Message-ID: <1439318358.5283.20.camel@twopensource.com>
References: <1438322781-21181-1-git-send-email-dturner@twopensource.com>
	 <1438322781-21181-2-git-send-email-dturner@twopensource.com>
	 <CACsJy8DK9k67yM_mJqbqgDxNKdGKpoLPOQQ4beqGgzUobzyFUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 11 20:39:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPESL-0001kn-Us
	for gcvg-git-2@plane.gmane.org; Tue, 11 Aug 2015 20:39:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751788AbbHKSjW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2015 14:39:22 -0400
Received: from mail-qg0-f41.google.com ([209.85.192.41]:36669 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751724AbbHKSjV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2015 14:39:21 -0400
Received: by qgdd90 with SMTP id d90so45152145qgd.3
        for <git@vger.kernel.org>; Tue, 11 Aug 2015 11:39:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=H7r5KF6td/i0a2oozhq6sD0wmHGmGt2MtWmLeEp6Mso=;
        b=JN5lkJ3b6ZCx3o5T3xXJ59CCYUU2P8xcJqHpzjt+9vNpjv4cBEmNj7nnM5clgaqZ5I
         H551ByxU5iv/MtqG4GLhQwZc9DnvLgwchudO6iZHMZDYEnvqvFnlUZ26M3eXVxU+to50
         xtukM/HrRM0doAjJKERwQx3rcZZZviTi/gM3AL7mvRNRGjJfy/8qBSyqCBtfb978ov2Y
         zaE27uiY04CK/HNTwv/6HhdIJE6JtMKjtp5hG4ZlazcsGPUSXJ+qKJgJ22IYv//kf+no
         zbdctCJ1ypZF6kJO6w4ffP84llowdPkbGhbVlJzy5HOLQE0/KdoytbcMmahVMmpZ37dv
         Byng==
X-Gm-Message-State: ALoCoQnpCtuZpcFQpClCxGrDzrgEi4Q4WiiOk8BF5xx0ldXyMIRCBHR/3V+Y6HhZAIrmQ5JLQtpK
X-Received: by 10.140.22.135 with SMTP id 7mr51136308qgn.98.1439318360406;
        Tue, 11 Aug 2015 11:39:20 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id b90sm1670713qga.48.2015.08.11.11.39.19
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Aug 2015 11:39:19 -0700 (PDT)
In-Reply-To: <CACsJy8DK9k67yM_mJqbqgDxNKdGKpoLPOQQ4beqGgzUobzyFUQ@mail.gmail.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275708>

On Mon, 2015-08-03 at 20:55 +0700, Duy Nguyen wrote:
> On Fri, Jul 31, 2015 at 1:06 PM, David Turner <dturner@twopensource.com> wrote:
> > Add a function ref_type, which categorizes refs as per-worktree,
> > pseudoref, or normal ref.
> 
> For per-worktree refs, you probably should follow common_list[] in
> path.c because that's how file-based ref namespace is splitted between
> per-repo and per-worktree, even though just as simple as "everything
> outside refs/ is per-worktree" (with an exception of NOTES_MERGE_REF,
> which should be on the list as well). At least the two should be
> aligned so that the default file-based backend works the same way as
> new backends.

I've looked into this, and decided not to follow common_list.  That's
because I've hacked the path.c code to treat refs/worktree specially;
it's under refs (common), but it's per-worktree, so it's special-cased.
You may have seen this in the per-worktree-refs-for-bisect thread:
http://permalink.gmane.org/gmane.comp.version-control.git/275673

This will require some special-casing in the alternate backends, but
they can use common the is_per_worktree_ref function.  
