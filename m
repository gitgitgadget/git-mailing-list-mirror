From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 0/4] Fix triangular workflows for upstream, simple
Date: Sun,  9 Jun 2013 22:43:16 +0530
Message-ID: <1370798000-2358-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Leandro Lucarella <leandro.lucarella@sociomantic.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 09 19:15:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UljDJ-0001pk-B5
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 19:15:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751313Ab3FIRPZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 13:15:25 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:49802 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751144Ab3FIRPX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 13:15:23 -0400
Received: by mail-pd0-f179.google.com with SMTP id q10so700429pdj.38
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 10:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=cP8RUFkxkd97HMhlhZI+Lf4VkpjuTribM57qed3ypis=;
        b=vUuDWz5LyXJ++UdC9wXdCPWxdkCxdi1pIEDvonHM8uEoyu8+Vze6fOx8hIyjOr/Zhv
         ZtLk6B37ReI2mgCg4ey1eo/8NefKqOJYqXANys2RLwXBxONQw0OVTyAcabGIa97c2R3m
         rT3aCk8yYEWYcT1/m7lVsu4DOpSESWXp1A5fSYcC/AExSDEtD2P30t3uT1aaYWQ3XWZa
         ETmQnBnk1EMMlxuKOHJ0LNdUtFMPlpP70GMKjLOCcJSWl0iQIGcxUx1H3vFtGOJUCH2W
         EJenzTG1Ci74IsTVNOB+QdmXT8yXTD9j0kj1WBeRMplIlB+1zURBQb57ko9MxmEls06I
         K/Vw==
X-Received: by 10.68.105.164 with SMTP id gn4mr6751007pbb.42.1370798122561;
        Sun, 09 Jun 2013 10:15:22 -0700 (PDT)
Received: from localhost.localdomain ([122.164.213.38])
        by mx.google.com with ESMTPSA id rn7sm7235373pbc.12.2013.06.09.10.15.20
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 09 Jun 2013 10:15:21 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.247.g485169c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227028>

Junio C Hamano wrote:
> It might be a beginning of a change in the right direction (I didn't
> check the codeflow), but given that the test that comes after the
> one you removed is looking at branch->merge[0] and deciding what to
> do, and branch.$name.merge should *never* affect anything when
> remote.pushdefault or branch.$name.pushremote is in use while
> deciding what is pushed out or if the push is allowed, I do not
> think the removal of these five lines alone can possibly "work".

I just spent hours breaking my head thinking about why you said my
patch cannot possibly "work".  I give up.

The artificial limitation was introduced by you in 135dade, and here's
the relevant part of the commit message:

  - The current branch does have its remote and upstream branch configured,
    but the user said "git push $there", where $there is not the remote
    named by "branch.$name.remote".  By definition, no branch at repository
    $there is set to integrate with the current branch in this case, and
    this push is not meant to update any branch at the remote repository
    $there.

What definition is this, and why does it only apply to
upstream/simple?  Did you implicitly assume that upstream/simple are
only meant to be used in centralized workflows?

Thanks.

Ramkumar Ramachandra (4):
  t/push-default: remove redundant test_config lines
  push: make upstream, simple work with pushdefault
  t/push-default: generalize test_push_{success, commit}
  t/push-default: test pushdefault with all modes

 builtin/push.c          |  5 -----
 t/t5528-push-default.sh | 30 ++++++++++++++++++++++++------
 2 files changed, 24 insertions(+), 11 deletions(-)

-- 
1.8.3.247.g485169c
