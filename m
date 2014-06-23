From: Mark Ferrell <major@homeonderanged.org>
Subject: Triangular workflow with Central repo
Date: Mon, 23 Jun 2014 16:37:22 -0700
Message-ID: <CANR0-ag4ZKmHBNPxYkohBJEpXierFV+K3Ub4tH8YYD7FK73FdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 24 01:37:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WzDo3-0000JY-Cs
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jun 2014 01:37:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752742AbaFWXho (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2014 19:37:44 -0400
Received: from mail-qg0-f53.google.com ([209.85.192.53]:59197 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751573AbaFWXhn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2014 19:37:43 -0400
Received: by mail-qg0-f53.google.com with SMTP id i50so6475743qgf.26
        for <git@vger.kernel.org>; Mon, 23 Jun 2014 16:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:from:date:message-id:subject:to:content-type;
        bh=/FXiLUBD+0dbku25EIxp2Fxdv58DFsr3SLKh5SvdlFQ=;
        b=uFAy7lxteejmZBKKur3HRV+OwRBwO5oyt80qixLNf9Gti5xqXJRRZgKpjG/eupq8iW
         UEXxYc7ggIrvu0SCGbu4FWKXXZKNNk6Rsonf20PCzTb8/yoXQ/hSwQsVdhRPQ81VpoZQ
         HTdHYTHs2EpPMFNisIZBtA2dUvYTM4kVCpjQ4kiSxMOgdTOjNS0LSqtOmtaSd68hk0nM
         YpOI5jEIiGdVB9Eza4jsVw33Vz1gpjnNVUjRb7yeFPVFZvv0XphN7ddriTl8PKh6YAu/
         vs7tvJ+RTCTfYBEmI2Hi80rJGlVO9ybgpxPFWfhpsolPEoGTyc5CS5vr9Iuk73bG4jWN
         dzcg==
X-Received: by 10.140.26.179 with SMTP id 48mr35695321qgv.51.1403566662735;
 Mon, 23 Jun 2014 16:37:42 -0700 (PDT)
Received: by 10.140.27.41 with HTTP; Mon, 23 Jun 2014 16:37:22 -0700 (PDT)
X-Google-Sender-Auth: SPmK4C8DUdQVitpBWEMiYUcUQKg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252380>

I was trying to setup a git client to deal with our version of a
triangular workflow and found that there where no configuration
directives which supported our use case.

Developers create and commit to branches named dev/<user>/TOPIC
(Branch permissions are handled by Gitolite).  If the topic is
prefixed with 'pqm/' then the revisions are treated as "proposals" for
changing the head of a higher-level branch.  E.g. pushing to
dev/bob/pqm/master results in the PQM software checking out that
revision and running tests upon the source.  If all tests pass then
the 'master' branch is updated to point at the submitted revision. The
benefit for us using this approach is that it gives developers a
private sandbox in which they can push/pull code between one another
w/out needing a separate repository per-developer (or setting up a
repo on everyones workstation), and if they choose to submit code
changes to be a new baseline they simply create a PQM branch and
submit to it.

I found that it is possible to setup git to easily deal with this
work-flow (triangular) if the pull repository is different than the
push repository, but our use case relies on the pull branch being
different than the push branch.  It would seem that git would need a
branch.<name>.push directive for this to work out.
