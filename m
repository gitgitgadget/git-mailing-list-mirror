From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 0/6] Kill and replace update_linked_gitdir()
Date: Mon, 18 Jan 2016 18:21:28 +0700
Message-ID: <1453116094-4987-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 18 12:03:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aL7b4-0003s1-1C
	for gcvg-git-2@plane.gmane.org; Mon, 18 Jan 2016 12:03:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754478AbcARLDi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 Jan 2016 06:03:38 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35095 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754273AbcARLDh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jan 2016 06:03:37 -0500
Received: by mail-pf0-f196.google.com with SMTP id 65so11613841pff.2
        for <git@vger.kernel.org>; Mon, 18 Jan 2016 03:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=1jOBd4Qb3pRd9+r9N+bDxBiq7hEvwNOb38vvM0N+k7U=;
        b=K0BJF/VQGlGM0y9/4uhZfZk83TX5JVKqNmh3CMjWe7fLhs34masutv1r2wOAZEVn95
         vZZVNPLNcr2AJfQbAknR23H1ZtyINAyvoxiM2QVw1ZyX3kGjJ2cnzeE0oRnhhrarLot8
         RXlCghBrvB3k67qvHL8CUuiwyCt3EDKeHWQv7O63Kvgs7CleW/eApO04P2QtUWImlItw
         c/NhdaX5v64nSa3SZxVjlNkw8jkAtm/FTNtxXNPaXz+kOaWul+ACgIC8Rjm+n35aJ654
         KqWIpWHtbWCWsBiGTguTOIahicE/8ZnA5GFWYKxCx+7do9MH8IV++3uRT2ZAc3r36pYE
         U90Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-type:content-transfer-encoding;
        bh=1jOBd4Qb3pRd9+r9N+bDxBiq7hEvwNOb38vvM0N+k7U=;
        b=JNPz9l+MGW5ErAMqS3eUaEDu2h+n693HmTA5vMr/vPJJS7Ioiw9vo9IQz7SARNhCx+
         wc0R7oD9vUrNmNE/QOs00ntsW20BbwiPWo0uAXy4b+lE6ed4TbX/dj13qr4xFOZOHAan
         djLmsYshRUOJG3pDZqx1rr268jAp/vwRUCZfNK4AiYcs3t+x5iEhk0ythgY/UGlgFmR6
         OFcVRTBVURiRgH0g9Jcm/MOGf0d9N1X5/kFLvT022Q4oauiDJ5gfS7tNjtOglxbChUBK
         Ysmd/AxzTmHn9GHD2KrsgdPt2F96vKsUq507gmmriyVDjmwFBCXNzZrSDZj2b+GwLUcv
         7gxw==
X-Gm-Message-State: ALoCoQlEwswxBK+4GUS6iGzJ6xJgGOoyBjS2K8EyMn8c5vCanceI0T9K8xBSsApRXgl6kPaSp3m0C8UsCCym/6yQkUDjl+iMDA==
X-Received: by 10.98.67.212 with SMTP id l81mr35477300pfi.90.1453115016474;
        Mon, 18 Jan 2016 03:03:36 -0800 (PST)
Received: from lanh ([115.72.43.83])
        by smtp.gmail.com with ESMTPSA id v7sm33166585pfa.77.2016.01.18.03.03.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jan 2016 03:03:35 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Mon, 18 Jan 2016 18:21:38 +0700
X-Mailer: git-send-email 2.7.0.96.g5373197
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284284>

There are a couple of problems with this function:

 - premature design
 - create "gitdir" file outside multi-worktree context
 - update the file's content with relative path, with breaks "worktree =
list"

The first three patches kill it, as a result. They are relatively safe.

The last three re-implement it in a new form, "worktree refresh",
inspired by "update-index --refresh". For now the user can use this
command to correct some internal data after moving a worktree. In
future, we might do automatic refresh like we do with the index.

The last three try out new design, so it will probably take more time
to graduate than the first three, which may end up in the next release
as worktree bug fix.

Eric Sunshine (1):
  worktree.txt: how to fix up after moving a worktree

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (5):
  worktree.c: fix indentation
  worktree: stop supporting moving worktrees manually
  abspath.c: add and use real_path_dup()
  setup.c: record the location of .git file
  worktree: new command to fix up worktree's info after moving

 Documentation/git-worktree.txt | 21 ++++++++++++++++-----
 abspath.c                      |  5 +++++
 builtin/clone.c                |  2 +-
 builtin/init-db.c              |  6 +++---
 builtin/worktree.c             | 18 ++++++++++++++++++
 cache.h                        |  2 ++
 setup.c                        | 26 +++++++++++---------------
 t/t1501-worktree.sh            |  9 +++++++++
 worktree.c                     |  8 ++++----
 9 files changed, 69 insertions(+), 28 deletions(-)

--=20
2.7.0.96.g5373197
