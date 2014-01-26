From: Martin Erik Werner <martinerikwerner@gmail.com>
Subject: [PATCH 0/2] in-tree symlink handling with absolute paths
Date: Sun, 26 Jan 2014 15:22:24 +0100
Message-ID: <1390746146-9478-1-git-send-email-martinerikwerner@gmail.com>
References: <20140115124859.GA4283@mule>
Cc: richih@debian.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 26 15:23:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W7QcO-0001sr-Po
	for gcvg-git-2@plane.gmane.org; Sun, 26 Jan 2014 15:23:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751565AbaAZOWv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jan 2014 09:22:51 -0500
Received: from mail-lb0-f177.google.com ([209.85.217.177]:57813 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751348AbaAZOWu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jan 2014 09:22:50 -0500
Received: by mail-lb0-f177.google.com with SMTP id z5so3664824lbh.8
        for <git@vger.kernel.org>; Sun, 26 Jan 2014 06:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VZ+/pjH7d6V1DHLBZuDfcxbtZMzvkC88yKEEnOQaaXE=;
        b=Yfr2OTl47MPZW0cJcc7O2LFoWH1z3kuzMul3V0/HBqOAfgpy5jtUiVcLUBzF1gS+ix
         vYbIoaN3JrJBiaF+kl6WacR4uqIstcT21WdR90+2k04gNtuW4h20jro41z8PbPz9hYic
         zNHJ7HqNqQrWMpdr74s7gz8FwQFvvOz5Zf0CNb9zwKOTo5IwJelU81uXraaGoQlEGtDn
         nplQgXtkR/TLqaSRJbZ1iCjw35QnieRKEdZNC67x/q8xUyqe0tcXJP7TvBWpkyjqxQNO
         /PIY5CHRlnmxIk2IxrAuhJXQsJwZdpsWnRb+ErS8dpp6IIuESS5lQ/kSbCeMRqrSE+rH
         kaHg==
X-Received: by 10.152.43.103 with SMTP id v7mr57667lal.46.1390746169107;
        Sun, 26 Jan 2014 06:22:49 -0800 (PST)
Received: from mule.student.uu.se (nl116-226-21.student.uu.se. [130.243.226.21])
        by mx.google.com with ESMTPSA id g8sm12109991lae.1.2014.01.26.06.22.47
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 26 Jan 2014 06:22:48 -0800 (PST)
X-Mailer: git-send-email 1.8.5.2
In-Reply-To: <20140115124859.GA4283@mule>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241087>

On Wed, 2014-01-15 at 13:48 +0100, Martin Erik Werner wrote:
> If git-mv is provided absolute paths when moving symlinks, it tries to
> dereference them and (attempts to) move the symlink target rather than the
> symlink itself, this seems like a quite odd behaviour since it's inconsistent
> with how git-mv works with symlinks if given relative paths, and I'm thinking
> it might be a bug, since it not documented in the git-mv manpage.

I've done a bit more digging into this: The issue applies to pretty much all
commands which can be given paths to files which are present in the work tree,
so add, cat-file, rev-list, etc.

I've written a test and a fix which seems to do the right thing.

Martin Erik Werner (2):
      t0060: Add test for manipulating symlinks via absolute paths
      setup: Don't dereference in-tree symlinks for absolute paths

 setup.c               | 54 ++++++++++++++++++++++++++++++++-------------------
 t/t0060-path-utils.sh |  7 +++++++
 2 files changed, 41 insertions(+), 20 deletions(-)
