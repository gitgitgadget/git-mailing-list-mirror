From: "Ulrik Sverdrup" <ulrik.sverdrup@gmail.com>
Subject: Bug: git archive not doing export-subst when using --prefix= option
Date: Tue, 8 Apr 2008 23:35:04 +0200
Message-ID: <a1b6cb1b0804081435w24074d1aq177e8c1a5e1af0f8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 08 23:35:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjLTq-0000VL-De
	for gcvg-git-2@gmane.org; Tue, 08 Apr 2008 23:35:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752420AbYDHVfH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Apr 2008 17:35:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752101AbYDHVfH
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Apr 2008 17:35:07 -0400
Received: from fk-out-0910.google.com ([209.85.128.187]:60473 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751896AbYDHVfF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Apr 2008 17:35:05 -0400
Received: by fk-out-0910.google.com with SMTP id 19so2892622fkr.5
        for <git@vger.kernel.org>; Tue, 08 Apr 2008 14:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=beTajnoNfou1T/i/c735qrVpaMpzw7QD4pl/Ev4A1s4=;
        b=h1gP8AA9++llhj6BzA+T+JA5W8KXhxMk7YGbc0Rl2GBPSSAFtPX13AjsLpebpHLSzXoKdS5K30vWRWDT3l3UCTqe50mtTjXdSQSPgF+HApXD05ea3RjwKOFVxlbwyZr3h/Qr6oa5pMFH2qDKvSwmh183eH5wVZnQLVm52A0VBEY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=RxcnFBOuSh09zujaG2Ph/elZJeKNiJGz/315+Glv2N+FxrvsrjkyyIn5htHGF2XWsCQxQcaOeYUF7G5ZqFRKZKo4WtIt+VzEVChQcuM4lVQP4g22RlmqRUiQAGCZpchxZqWxe4opvBiT8TngN5TO5kzeEBDM8aMvidMFJizb7w8=
Received: by 10.82.145.19 with SMTP id s19mr10712921bud.27.1207690504065;
        Tue, 08 Apr 2008 14:35:04 -0700 (PDT)
Received: by 10.82.116.11 with HTTP; Tue, 8 Apr 2008 14:35:04 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79033>

In one of my small projects, I just tried to add an export-subst format to
my version file to have the git version in the released tarball. However it
seems git-archive --prefix="tarballname-version/" does not work well
together with export-subst.

I have very old git! (v1.5.4.4). So please help me and try to reproduce
this with newer versions:

The repo is publicly available at

git clone git://repo.or.cz/dragbox.git

The file in the repo having an export substitution format is
Dragbox/version.py.in

Now try to export the git tree with git-archive, with and without --prefix=
We will do some hackery and grep the binary output.

	$ git archive HEAD | grep --text "git_version"
	git_version = "9c3f6c0af7e67a354cac9a24e24e2057d17778ef"
	$ git archive --prefix="dragbox-git/" HEAD | grep --text "git_version"
	git_version = "$Format:%H$"


I noticed in another even smaller repository that it would not behave the
same but equally spurious; it would only perform the substitution for some
prefixes and not for others (for example with or without ending slash)

Regards
Ulrik Sverdrup
