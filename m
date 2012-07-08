From: Hilco Wijbenga <hilco.wijbenga@gmail.com>
Subject: On using receive.denyNonFastForwards and advice.pushNonFastForward
Date: Sun, 8 Jul 2012 14:26:50 -0700
Message-ID: <CAE1pOi1M-fdMJtZw9MNL2R6zWvpXvWVo4ros_NSCQtLmQb6TOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Users <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jul 08 23:27:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Snz0j-0003YC-84
	for gcvg-git-2@plane.gmane.org; Sun, 08 Jul 2012 23:27:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752169Ab2GHV1M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jul 2012 17:27:12 -0400
Received: from mail-gh0-f174.google.com ([209.85.160.174]:57460 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752066Ab2GHV1M (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jul 2012 17:27:12 -0400
Received: by ghrr11 with SMTP id r11so9603469ghr.19
        for <git@vger.kernel.org>; Sun, 08 Jul 2012 14:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=WuWwVB15om0Q2GMvyt/LSOlBtfCrEq8oCPVYGFvoKQM=;
        b=eulTBJzEYOi2f6j8znJyGfhUdEQ7yf1KBgn+0PY5o2ABYajBDcD7ySJDFXD6usJowe
         mNHvR2joejHdLFdg70l+BIIMSXBCqrH4zVeL0MSlWQN5oCeznBsREsIo+kdrdjtIi77k
         k6tOnxkNB5Ga+bdi4hhAxo4cctiLjq7UEwohx3FU8uWd7RbB1a1izlvGn/5SpvlBAaLn
         lY0WOJEiuG8DClVQ7+IHCMFgkyxOoU4O7+1BB95wYavtEdBiPWj8ZsJ04cKb0xGcE8Ra
         vZphhprUD0ey10eJU+Rrnyfd4FWte+IJj41j+TMnYzspPEMLMXPiglPBSpVxDhsscB6P
         ZAJg==
Received: by 10.236.180.40 with SMTP id i28mr44713331yhm.22.1341782831083;
 Sun, 08 Jul 2012 14:27:11 -0700 (PDT)
Received: by 10.236.80.1 with HTTP; Sun, 8 Jul 2012 14:26:50 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201185>

Hi all,

I was wondering how hard it would be to make "git push" more adamant
about not pushing non-ff updates. So I wanted to see the effects of
receive.denyNonFastForwards and advice.pushNonFastForward. (By the
way, why is one plural and the other singular? That doesn't seem
consistent?)

HERE=$(pwd) &&
git init --bare remote-repo &&
cd remote-repo/ &&
git config --add receive.denyNonFastForwards true &&
cd .. &&
git clone file://$HERE/remote-repo local-repo &&
cd local-repo/ &&
git config --add advice.pushNonFastForward true &&
echo "1" > one.txt &&
git add -A . && git commit -m 1 && git push origin master &&
git checkout -b next &&
echo "a" > two.txt &&
git add -A . && git commit -m 2 &&
git checkout master &&
echo "2" > one.txt &&
git add -A . && git commit -m 3 && git push origin master &&
git merge next &&
git push

To my surprise there was neither warning nor error. Does this last
push really qualify as a FF update? Apparently, linear history and
FF-only updates are not the same thing?

Cheers,
Hilco
