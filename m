From: Dun Peal <dunpealer@gmail.com>
Subject: Efficiently detecting paths that differ from each other only in case
Date: Fri, 8 Oct 2010 01:13:07 -0500
Message-ID: <AANLkTimGAbosbD0pprROu_g-UW38faotYA2dTxj9scsP@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 08 08:13:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P46Ch-00079B-Bv
	for gcvg-git-2@lo.gmane.org; Fri, 08 Oct 2010 08:13:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752932Ab0JHGNJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Oct 2010 02:13:09 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:40897 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751628Ab0JHGNI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Oct 2010 02:13:08 -0400
Received: by vws3 with SMTP id 3so227348vws.19
        for <git@vger.kernel.org>; Thu, 07 Oct 2010 23:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=9usxPDB4cvPpgSZh2VvwuwG8uLpurK3dg0z+ThOv5iE=;
        b=KK+0VG3W1nQHM4C4wxwc2YSdkwpNQit9C5X68dVzynmIkXYJNPBy4VH2Iugc/de9c+
         FmZVdjaLtuVKn8tri6IWt+7BZ69tLuu5wIn7u54pE+aM8qucRJU0DD0hyNW1MUib/SRG
         rUsGtYTBnrtRi2DrcyVrFoACsJkKsSr/KgwnU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=uHMAkKveseWqsQW0jrMfUsYjPWohfdJmgLM+/I/UCCTzyLEAHo9N3w/UPMS2TGqx3g
         ln23E1D0zXtnFpS0AiYx2XgYU/i8z6qOcgabxpOdetf/nqJyHVYYYJQqskLZqbjeLa/S
         Mr2Qe8HFiEahblbRr8YkUd/usEXg12WCvx2J4=
Received: by 10.220.199.193 with SMTP id et1mr567920vcb.56.1286518387865; Thu,
 07 Oct 2010 23:13:07 -0700 (PDT)
Received: by 10.220.187.9 with HTTP; Thu, 7 Oct 2010 23:13:07 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158473>

Hi,

I'm writing a Git hook, for a bare central repo, to reject pushes of
paths that differ from existing tracked paths only by letter case.

So, for example, if the following path is tracked in the repo:

foo/bar.py

Commits adding any of the following paths would be rejected:

Foo/bar.py
foo/Bar.py
fOO/BAR.py

Etc. I know how to do it by listing paths with ls-files, but my repo
contains many thousands of files, so I was wondering if there was a
more efficient way than for every commit:

1. Get a list of all paths in the repo from ls-files.
2. Lowercase all paths.
3. Check for repeats.

Thanks, D
