From: Jay Soffian <jaysoffian@gmail.com>
Subject: sparse checkout bug?
Date: Sat, 24 Sep 2011 15:50:57 -0400
Message-ID: <CAG+J_DwRPq69TUMOeqU5O9pv=cHZWEP1VJ1_NRaJv5BSFhF00g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Sep 24 21:51:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R7YFj-0007Vq-BX
	for gcvg-git-2@lo.gmane.org; Sat, 24 Sep 2011 21:51:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751599Ab1IXTu7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Sep 2011 15:50:59 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:54888 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751390Ab1IXTu6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Sep 2011 15:50:58 -0400
Received: by gyg10 with SMTP id 10so3299253gyg.19
        for <git@vger.kernel.org>; Sat, 24 Sep 2011 12:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=5bRXQZsCGsBe0kpSM1y98Xr9t2uXb2+wh4a+eCOKtnk=;
        b=RI77geQErT/X18prOmDh42KLRB4VJZC05+vOzCrtbXBImPekjl7dje1tkOBiuIMox4
         gQs8rhxBnz/E1h0IUIFdvzT4jIT5GhRzZ1tkBe7upphjCUoBTMRo4vavs4e4I5/LQkof
         c4oxHxtLYCNAsaPPpJ/nbm/T5zx/bwE2NkXuI=
Received: by 10.146.60.29 with SMTP id i29mr1121290yaa.26.1316893857887; Sat,
 24 Sep 2011 12:50:57 -0700 (PDT)
Received: by 10.147.32.18 with HTTP; Sat, 24 Sep 2011 12:50:57 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182039>

I wanted to exclude a single massive directory from a checkout (the
LayoutTests directory from WebKit, which includes 130k files), so I
tried:

$ git config core.sparsecheckout true
$ echo '*' > .git/info/sparse-checkout
$ echo '!LayoutTests' >> .git/info/sparse-checkout
$ git read-tree -m -u HEAD

But LayoutTests is not being excluded. I also tried every variation of
including leading/trailing slash and trailing '*'.

Simple repro:

git init sparse-test && cd sparse-test &&
touch foo && mkdir bar && touch bar/baz &&
git add foo bar/baz &&
git commit -m initial &&
git config core.sparsecheckout true &&
echo '*' > .git/info/sparse-checkout &&
echo '!bar' >> .git/info/sparse-checkout &&
git read-tree -m -u HEAD &&
ls -1R
foo

bar:
baz

j.
