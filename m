From: Santhosh <santhoshmani@gmail.com>
Subject: Re: [PATCH/BUG] git-svn: add test for renamed directory fetch
Date: Thu, 3 Apr 2008 19:29:27 +0530
Message-ID: <3bc895b00804030659p21dcae2av2cad3db41935fa4e@mail.gmail.com>
References: <3bc895b00804030647o652e432cqb5a90eafbac906b2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 03 16:05:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JhQ3l-0005rL-GI
	for gcvg-git-2@gmane.org; Thu, 03 Apr 2008 16:04:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756921AbYDCOEN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Apr 2008 10:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756710AbYDCOEM
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Apr 2008 10:04:12 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:26333 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756640AbYDCOEM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Apr 2008 10:04:12 -0400
Received: by ug-out-1314.google.com with SMTP id z38so703440ugc.16
        for <git@vger.kernel.org>; Thu, 03 Apr 2008 07:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=B1hlyGHbL7+GBHiT/fyaq6SN9eOsTpKO8eY5n0Apgr0=;
        b=DBOfvNxqfpV+WamRoJGER9H5U8RvFqUd0pOgSHNOHyKWxktSALieB6Kn9G7SarKf+1AmsddDfv5BiK5wX75vLoYicbFOC7kNFsqr+XiVofaDd99yr+UrAePHIXxj+tVkuz2HX92aEnomILZWSt9+q0T5M6IkErEzQPK9i2huGFE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FzJ2NyDjs1QPnGDGNwwR4pt9a+Jq+nn5O2UivufLCPXN0PrlnCnHZyYGNljTEoPv/ePzjaxJCg69YUiYpROKRXjApuzb2qeDLJFBlXcxJYJhfLDbdftM8ULunisSFHQMQz5eaHIiA8mUyaKOeRXmbNUIXdzIL2ahheQi4MDs25M=
Received: by 10.142.237.20 with SMTP id k20mr7053730wfh.227.1207231167258;
        Thu, 03 Apr 2008 06:59:27 -0700 (PDT)
Received: by 10.142.133.13 with HTTP; Thu, 3 Apr 2008 06:59:27 -0700 (PDT)
In-Reply-To: <3bc895b00804030647o652e432cqb5a90eafbac906b2@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78755>

git svn init svn://zzz/trunk/yyy (/some/path/with/rename/history)
git svn fetch

results in the following error if the "path" being fetched was renamed
in the past.

branch_from: /xxx => /xxx/trunk/yyy
Found possible branch point: svn://xxx/trunk/yyy => svn://zzz/trunk/yyy, 7
Initializing parent: git-svn@7
svn-remote.svn.url already set: svn://zzz/trunk/yyy
wanted to set to: svn://xxx/trunk/yyy

The above patch (testcase) exposes this bug. It seems to have been
introduced in the commit "c586879cdfa4f8181a14e953a9152a4639eef333".
Reverting this patch fixes this bug.

Regards,
Santhosh.

On Thu, Apr 3, 2008 at 7:17 PM, Santhosh <santhoshmani@gmail.com> wrote:
> This test tries to fetch a directory which had renames in the history from a
>  SVN repository.
>  ---
>   t/t9121-git-svn-fetch-renamed-dir.sh |   23 +++++++++
>   t/t9121/renamed-dir.dump             |   90 ++++++++++++++++++++++++++++++++++
>   2 files changed, 113 insertions(+), 0 deletions(-)
>   create mode 100755 t/t9121-git-svn-fetch-renamed-dir.sh
>   create mode 100644 t/t9121/renamed-dir.dump
>
>  diff --git a/t/t9121-git-svn-fetch-renamed-dir.sh
>  b/t/t9121-git-svn-fetch-renamed-dir.sh
>  new file mode 100755
>  index 0000000..5cd65a6
>  --- /dev/null
>  +++ b/t/t9121-git-svn-fetch-renamed-dir.sh
>  @@ -0,0 +1,23 @@
>  +#!/bin/sh
>  +#
>  +# Copyright (c) 2008 Santhosh Kumar Mani
>  +
>  +
>  +test_description='git-svn can fetch renamed directories'
>  +
>  +. ./lib-git-svn.sh
>  +
>  +test_expect_success 'load repository with renamed directory' "
>  +       svnadmin load -q $rawsvnrepo < ../t9121/renamed-dir.dump &&
>  +       start_httpd
>  +       "
>  +
>  +test_expect_success 'init and fetch repository' "
>  +       git svn init $svnrepo/newname &&
>  +       git svn fetch
>  +       "
>  +
>  +stop_httpd
>  +
>  +test_done
>  +
>  diff --git a/t/t9121/renamed-dir.dump b/t/t9121/renamed-dir.dump
>  new file mode 100644
>  index 0000000..5f9127b
>  --- /dev/null
>  +++ b/t/t9121/renamed-dir.dump
>  @@ -0,0 +1,90 @@
>  +SVN-fs-dump-format-version: 2
>  +
>  +UUID: 06b9b3ad-f546-4fbe-8328-fcb4e6ef5c3f
>  +
>  +Revision-number: 0
>  +Prop-content-length: 56
>  +Content-length: 56
>  +
>  +K 8
>  +svn:date
>  +V 27
>  +2008-04-02T09:11:59.778557Z
>  +PROPS-END
>  +
>  +Revision-number: 1
>  +Prop-content-length: 117
>  +Content-length: 117
>  +
>  +K 7
>  +svn:log
>  +V 14
>  +initial import
>  +K 10
>  +svn:author
>  +V 8
>  +santhosh
>  +K 8
>  +svn:date
>  +V 27
>  +2008-04-02T09:13:03.170863Z
>  +PROPS-END
>  +
>  +Node-path: name
>  +Node-kind: dir
>  +Node-action: add
>  +Prop-content-length: 10
>  +Content-length: 10
>  +
>  +PROPS-END
>  +
>  +
>  +Node-path: name/a.txt
>  +Node-kind: file
>  +Node-action: add
>  +Prop-content-length: 71
>  +Text-content-length: 6
>  +Text-content-md5: b1946ac92492d2347c6235b4d2611184
>  +Content-length: 77
>  +
>  +K 13
>  +svn:mime-type
>  +V 10
>  +text/plain
>  +K 13
>  +svn:eol-style
>  +V 2
>  +LF
>  +PROPS-END
>  +hello
>  +
>  +
>  +Revision-number: 2
>  +Prop-content-length: 109
>  +Content-length: 109
>  +
>  +K 7
>  +svn:log
>  +V 7
>  +renamed
>  +K 10
>  +svn:author
>  +V 8
>  +santhosh
>  +K 8
>  +svn:date
>  +V 27
>  +2008-04-02T09:14:22.952186Z
>  +PROPS-END
>  +
>  +Node-path: newname
>  +Node-kind: dir
>  +Node-action: add
>  +Node-copyfrom-rev: 1
>  +Node-copyfrom-path: name
>  +
>  +
>  +Node-path: name
>  +Node-action: delete
>  +
>  +
>  --
>  1.5.5.rc3.dirty
>
