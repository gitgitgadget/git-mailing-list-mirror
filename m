From: Christopher Dunn <cdunn2001@gmail.com>
Subject: format-patch and submodules
Date: Thu, 4 Jun 2015 16:20:20 -0700
Message-ID: <CAD2z=MAu1qrr9=wwBnOJZZ3JCJOsmFWi=gDgKMQKU3_P-01e3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 05 01:20:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0eR1-0005S0-Kl
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jun 2015 01:20:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753808AbbFDXUX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jun 2015 19:20:23 -0400
Received: from mail-vn0-f47.google.com ([209.85.216.47]:37677 "EHLO
	mail-vn0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752335AbbFDXUV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jun 2015 19:20:21 -0400
Received: by vnbg62 with SMTP id g62so7114186vnb.4
        for <git@vger.kernel.org>; Thu, 04 Jun 2015 16:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=0M7unB1sqQogDhOhvp8vf0mUjeZ+T+Ys3itnvF/o90s=;
        b=lsEV7GrfSSbnvV4XQEN6XYDbQfwrw+86f2IXqVzabwnBdXefXxKzi23zqmOxZsyEGP
         n93SS6LdfrBk1wcWclVdibM0zYylbLqlTkKT6aWo8ZeGqWwq6RIk4YrBPbkz7p5WGmD+
         9Pne1m6VgVjBZaqJjoTkJRIqVdlrrW8uU/UW74zkmQKHQmP+IIf1ilhM3DJRIc8ARTEx
         rlT3/QQ+blBhkRXWpUjoD2/VsqbfkKfLzkBNqKxJxgEo/JNUIj3p3UnEuVo+NI8s+PpK
         EPb1sJUglZyTh8hU+2m8qDC80SF1Ag1XSiNglZCJWX07LvznBIuMIk5i2qSo78FYwH6B
         XK9A==
X-Received: by 10.52.9.228 with SMTP id d4mr853461vdb.57.1433460020489; Thu,
 04 Jun 2015 16:20:20 -0700 (PDT)
Received: by 10.52.98.134 with HTTP; Thu, 4 Jun 2015 16:20:20 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270804>

(Seen in git versions: 2.1.0 and 1.9.3 et al.)

$ git format-patch --stdout X^..X | git apply check -
fatal: unrecognized input

This fails when the commit consists of nothing but a submodule change
(as in 'git add submodule foo'), but it passes when a file change is
added to the same commit.

There used to be a similar problem for empty commits, but that was
fixed around git-1.8:

    http://stackoverflow.com/questions/20775132/cannot-apply-git-patch-replacing-a-file-with-a-link

Now, 'git format-patch' outputs nothing for an empty commit. I suppose
that needs to be the behavior also when only submodules are changed,
since in that case there is no 'diff' section from 'format-patch'.

Use-case: git-p4

Of course, we do not plan to add the submodule into Perforce, but we
would like this particular command to behave the same whether there
are other diffs or not.

~Christopher Dunn (cdunn2001)
