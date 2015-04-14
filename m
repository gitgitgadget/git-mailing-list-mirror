From: Matthew Rothenberg <mroth@khanacademy.org>
Subject: PATH modifications for git-hook processes
Date: Tue, 14 Apr 2015 12:04:25 -0400
Message-ID: <CAKuTQSGEmHHr-c+Tc2jM-JPkx6+_f3gp8Zjj8EuQy_e4=PvMzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 14 18:04:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yi3KB-0007c1-GN
	for gcvg-git-2@plane.gmane.org; Tue, 14 Apr 2015 18:04:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755657AbbDNQE1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Apr 2015 12:04:27 -0400
Received: from mail-oi0-f44.google.com ([209.85.218.44]:33402 "EHLO
	mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755622AbbDNQE0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Apr 2015 12:04:26 -0400
Received: by oica37 with SMTP id a37so5521612oic.0
        for <git@vger.kernel.org>; Tue, 14 Apr 2015 09:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=khanacademy.org; s=google;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=9MuoKp9JK8bTiqcppHyWjuzVPtSIUpO4MfK9yar8jPk=;
        b=WMsqKWouP8CKdnN8GljxHFWvdC1Lxib+iZpD77uGk37AFjl9DQyC7HoqHTXTehOkbR
         y+rzov1nfdaGQo8uwqFimVi/sidmBC8lNsowhM1j+L9Q9I0UUp7EHbgchJfTanLi7Cor
         +XSCbekdQ+9nuFbKzclwX2OqJ1xOmvA2gVA1s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=9MuoKp9JK8bTiqcppHyWjuzVPtSIUpO4MfK9yar8jPk=;
        b=UwuJyVOjqeAF7ZkaVsfwJxwBqp2G9j5F4LLZhZPK8PEr3W8cgVTfyqmSzjD4+dTXCt
         eeM9oseh6fzW74dKZDXX0z3dDzM2E1GtdrJM2gdNMgafOB7TgmxVBNmSBKFj5H9VEwhh
         BF3FE/e2FxKsbJriyN20bAAy9YdNJ7fKkSI0gx0IVTERq65erknMU3Q+QcrDry8u4Jbm
         9KP4Ufu7gbsPLHbphfqvNRz6QQXpfg1uiUtRKPmN0P4vvLIg5UKr8B2iNbkokWykuu55
         m2VZQZvTFnhsO8fDTZP2Znf27iXbXdQ1JH3hfrmeLBqoH08tdmOVTw/Kp1r28WYDAcUP
         hXDA==
X-Gm-Message-State: ALoCoQlo3mGR9DBFkALkltjc6geEi6lZrudXs+7/ekgtX4MHI9crwbl/PHdI5FwwivrV1CSWTwcE
X-Received: by 10.202.226.21 with SMTP id z21mr11981733oig.134.1429027465989;
 Tue, 14 Apr 2015 09:04:25 -0700 (PDT)
Received: by 10.76.112.37 with HTTP; Tue, 14 Apr 2015 09:04:25 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267143>

Using git 2.3.5 (on darwin, installed via homebrew), when executing a
script via the commit-msg githook, the following gets *prepended* to
the $PATH for the subprocess:

  /usr/local/Cellar/git/2.3.5/libexec/git-core:/usr/local/Cellar/git/2.3.5/libexec/git-core:/usr/local/bin:{rest
of path...}

I can't find any documentation about this path modification behavior
in the git docs, and I'm not familiar enough with the source code to
locate it there either.

In our case, the prepending of /usr/local/bin is particularly
problematic, as it effectively reorders our chosen PATH hierarchy (in
which user-space versions of commands are picked up prior to system
installed ones).

(It's also curious that the git-core directory gets prepended twice,
but that doesn't cause us any particular issues.)

My questions:
 - what is the expected PATH modification behavior for subprocesses of
git-hooks? Is this documented anywhere?
 - what would be causing /usr/local/bin to be prepended here, and can
it be adjusted via preference?

Thanks!
