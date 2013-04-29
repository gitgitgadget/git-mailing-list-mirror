From: Ilya Basin <basinilya@gmail.com>
Subject: Re: git-svn: problem with svn cp trunk/subdir tags/subdir_1.0
Date: Mon, 29 Apr 2013 17:00:32 +0400
Message-ID: <1531127990.20130429170032@gmail.com>
References: <1826029946.20130429164645@gmail.com>
Reply-To: Ilya Basin <basinilya@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Ray Chen <rchen@cs.umd.edu>, Eric Wong <normalperson@yhbt.net>
To: Git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 29 15:00:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWnhD-0004FX-5E
	for gcvg-git-2@plane.gmane.org; Mon, 29 Apr 2013 15:00:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757236Ab3D2NAj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 09:00:39 -0400
Received: from mail-lb0-f173.google.com ([209.85.217.173]:47155 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754695Ab3D2NAi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 09:00:38 -0400
Received: by mail-lb0-f173.google.com with SMTP id 10so5679216lbf.32
        for <git@vger.kernel.org>; Mon, 29 Apr 2013 06:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:x-mailer:reply-to:x-priority:message-id:to:cc
         :subject:in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=6VzaznJ6e+8U7Dt3688FGsNPyPM8tfp6CHmyaSymN+M=;
        b=NoEMe2HSoSZD+0v69VPRKfV7oalFJNkUhJAv6z5pj5VCzWsl4E0zXRsCjZOBAlrlgx
         84ncbVMuRxKA5T6xtTXkhDwnFlfYg7/s0tX+UUMr+DY2fUdEomkGRqM1Y8eCMiQGRNVW
         yhIIkypYslRx9FPLam+0WWtYdSn5uqnwLVOM0z9RpyEbNtZF+lz//m8W4sfjtDQz02qk
         sxIO83QuO9gwvlWPuqgXUOYleIqYaSoiXqNbunXp/tKHvpwaA1KXGlu/lQiMOTk6PYeU
         X64vWYtb1L6G3uzoLJT0oYGxldIx4rnTHEP+/F9c/LRA5nMc7cU/VXTPMFv5Lb+v8Fne
         n0zw==
X-Received: by 10.152.2.73 with SMTP id 9mr21955653las.45.1367240436896;
        Mon, 29 Apr 2013 06:00:36 -0700 (PDT)
Received: from BASIN.reksoft.ru ([2a00:1120:0:1001:e800:dcfc:85a:7bae])
        by mx.google.com with ESMTPSA id s1sm7809508lag.2.2013.04.29.06.00.34
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 29 Apr 2013 06:00:35 -0700 (PDT)
X-Mailer: Voyager (v3.99.4) Professional
X-Priority: 3 (Normal)
In-Reply-To: <1826029946.20130429164645@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222792>

IB> After fixing --preserve-empty-dirs plus --stdlayout a new problem
IB> arised:
IB> When creating a tag or branch from a subdir, a disjoint branch
IB> is created. Then git-svn re-imports the commits using this dir as
IB> strip path.

IB> Why? I would instead keep the current commit as parent, delete
IB> everything except the subdir and move its contents to root directory.

IB> During this re-import the variable %added_placeholder is not up to
IB> date. Because the branch is disjoint, this variable should be empty in
IB> the beginning, but it's not.
IB> Because of that git-svn tries to delete non-existent .gitignore files
IB> and dies.

IB> I think, if a disjoint branch is created, %added_placeholder should be
IB> pushed and cleared. A new set of paths starting with "trunk/" will be
IB> added to it during re-import.
IB> When re-import is done, we should translate the paths to
IB> "tags/subdir_1.0/" and merge with the original %added_placeholder.

A simpler approach would be to store paths in %added_placeholder
already translated from "trunk/subdir/" to "tags/subdir_1.0/".
But in the beginning of re-import Fetcher doesn't know the new branch
name.

-- 
