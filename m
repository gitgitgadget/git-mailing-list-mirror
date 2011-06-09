From: NAKAMURA Takumi <geek4civic@gmail.com>
Subject: Git is not scalable with too many refs/*
Date: Thu, 9 Jun 2011 12:44:42 +0900
Message-ID: <BANLkTimnCqaEBVreMhnbRBV3r-r1ZzkFcg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 09 05:44:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUWAq-0002IG-ND
	for gcvg-git-2@lo.gmane.org; Thu, 09 Jun 2011 05:44:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756415Ab1FIDop (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 23:44:45 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:61162 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756070Ab1FIDon (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 23:44:43 -0400
Received: by wwa36 with SMTP id 36so1235114wwa.1
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 20:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=p5Jdf87guKGNwnIANcEMAZ3J8Lff2uKjemyjRTeiI68=;
        b=cUd2Q1HY3ODXj9qLMpfcQTqO9eLTS3jp7PRoV14ohe2WmchmfJi1oEiW1CJ/L07TrN
         gPXDxMnUD94ixMWYFMkHcG26Yd821KI93OJf/Z9RKzZP934cybkIrgwiCyJtxp2lbhjd
         C3gng+1Zx/Z9dC7QybNn3EDKkkA45YLUgnQk0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=Z4o4HF7Fz+k8R3Xzc2z+PyFhyduUCxhqZiWUp0ne6dhAlN/NRl3g8DvKiwItX+Qoh4
         6AfxUC4/uef6cWy6mHxeiEBm6kiaGuKWJccVh6y4M/jbJpGKYuEb4M0OnLtHnCy4SvJe
         SyGcysJXhz/lsQjOn/8jlT33+TT0O4B3maP94=
Received: by 10.227.157.134 with SMTP id b6mr213588wbx.59.1307591082052; Wed,
 08 Jun 2011 20:44:42 -0700 (PDT)
Received: by 10.227.54.76 with HTTP; Wed, 8 Jun 2011 20:44:42 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175488>

Hello, Git. It is my 1st post here.

I have tried tagging each commit as "refs/tags/rXXXXXX" on git-svn
repo locally. (over 100k refs/tags.)
Indeed, it made something extremely slower, even with packed-refs and
pack objects.
I gave up, then, to push tags to upstream. (it must be terror) :p

I know it might be crazy in the git way, but it would bring me conveniences.
(eg. git log --oneline --decorate shows me each svn revision)
I would like to work for Git to live with many tags.

* Issues as far as I have investigated;

  - git show --decorate is always slow.
    in decorate.c, every commits are inspected.
  - git rev-tree --quiet --objects $upstream --not --all spends so much time,
    even if it is expected to return with 0.
    As you know, it is used in builtin/fetch.c.
  - git-upload-pack shows "all" refs to me if upstream has too many refs.

I would like to work as below if they were valuable.

  - Get rid of inspecting commits in packed-refs on decorate stuff.
  - Implement sort-by-hash packed-refs, (not sort-by-name)
  - Implement more effective pruning --not --all on revision.c.
  - Think about enhancement of protocol to transfer many refs more effectively.

I am happy to consider the issue, thank you.

...Takumi
