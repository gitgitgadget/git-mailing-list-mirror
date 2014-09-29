From: Roberto Eduardo Decurnex Gorosito <decurnex.roberto@gmail.com>
Subject: `git log relative_path_to_object` does not respect the --work-tree path
Date: Mon, 29 Sep 2014 13:40:06 -0300
Message-ID: <CABj5xzc0bVfyzR5PD5K3STSvdvWEOYeMkayB=GTfKbfij+G5Zw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 29 18:40:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XYe00-0006VX-FQ
	for gcvg-git-2@plane.gmane.org; Mon, 29 Sep 2014 18:40:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754807AbaI2Qk2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Sep 2014 12:40:28 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:59524 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754059AbaI2Qk1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Sep 2014 12:40:27 -0400
Received: by mail-lb0-f174.google.com with SMTP id l4so18457185lbv.33
        for <git@vger.kernel.org>; Mon, 29 Sep 2014 09:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=fV3ynSl1OKksN0zBt6GngAoY3XuPXx1o3xkjyr2Y1Mk=;
        b=cL/syyRBVmNBzNyNq+co6cLIuSfM86UWBm5ggt6nrw0w9eCu5yt5bHOrmaSpIZMvXa
         Jaq6Jd7X7C/deeEv1rZakBNxYO3fSn3DDn1G7htpLlPNxVmQsHej6tpzYmfDliRRUI8U
         Oob9Ngw3N2x4ivSiRYC5bcw30MHQXhFXUmneOxL7sstioGqfjdv4fVnPgA0TbeRPbAnn
         Z5mdwRzkPxWAtX1dnttlWrcUf1SvjessKEMgBloODJ8E1PMJmmeK8+QtiQiNddhoIYMb
         KksU5MTVKFamtbRmJUP/UlWJNlK0O/2LWSOcLqXUZdFFuGUvjECGkGLDXKMfETnvdRaW
         H3sA==
X-Received: by 10.112.140.137 with SMTP id rg9mr4909902lbb.93.1412008826327;
 Mon, 29 Sep 2014 09:40:26 -0700 (PDT)
Received: by 10.25.42.131 with HTTP; Mon, 29 Sep 2014 09:40:06 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257626>

When passing objects to the `git log`, by just naming them or using
the `--objects` option, relative paths are evaluated using the current
working directory instead of the current working tree path.

Even the error message is clearly wrong.
    "unknown revision or path not in the working tree."

Example:

Given a repo at "~/path/to_repo" containing a file such as "README.md"
("~/path/to_repo/README.md")

~/path$ git --work-tree=~/path/to_repo log README.md
fatal: ambiguous argument 'README.md': unknown revision or path not in
the working tree.

As you can see here
(https://github.com/robertodecurnex/git/blob/master/setup.c#L147) git
is trying to `lstat` the path as it was given when it should validate
the file existence within the work tree (perpending the work-tree
before the file name).

Note: I now several workarounds for this, I'm not looking for a
solution to the specific problem but to discuss the implementation and
evaluate a change over the current behavior.

Regards,
--
Roberto Decurnex
