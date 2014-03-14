From: Peter Wolanin <pwolanin@gmail.com>
Subject: bug report: regression in git subtree add
Date: Fri, 14 Mar 2014 16:49:37 -0400
Message-ID: <CANae7MgZQs4tV9QcJvU3_anABSj-uTdwO+Y4x4mWKySprOEnBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 14 21:57:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOZA5-0002sM-IN
	for gcvg-git-2@plane.gmane.org; Fri, 14 Mar 2014 21:57:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755812AbaCNU46 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2014 16:56:58 -0400
Received: from mail-qg0-f46.google.com ([209.85.192.46]:64084 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754459AbaCNU45 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2014 16:56:57 -0400
Received: by mail-qg0-f46.google.com with SMTP id e89so8933662qgf.5
        for <git@vger.kernel.org>; Fri, 14 Mar 2014 13:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=KGvOBSMyQJtd8v4ZoSoqFIyNBFQ28pwinu/IYJAUdYY=;
        b=KrZrfoYCOM2SRzYks0L2tblxJGLJ82UaX0RUyolTVFrGUcdcKa9PUblh055N6xb1re
         rXFQQ3flWgIxC3C+ZM6l52imFR2z715Y1S488SRZTO4fo0OtsiWseUQqbyxCtnjNdpah
         n9L1pd9foYFRpojDn+ika8pENEvmrH/EBxmMjEVPFx2l6VxBqe6R80dVuouWdC6v/U+9
         zFvAONFhGiNZeliYYhwucSZqpoo96L0s/ZI5cnZh8vRVPsJjcfemaaSMjfY3VQCK6RhL
         tdMT5wMBMQGnE9aivRoEyhXMhVS2nIj/7q9OMx8sruDqYjdud65uAO5mDUf0/uTbjar0
         8xag==
X-Received: by 10.224.123.137 with SMTP id p9mr12396629qar.39.1394830177727;
 Fri, 14 Mar 2014 13:49:37 -0700 (PDT)
Received: by 10.96.118.227 with HTTP; Fri, 14 Mar 2014 13:49:37 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244109>

In this commit:
https://github.com/git/git/commit/10a49587fabde88c0afbc80a99d97fae91811f5f

git subtree add for a remote repository and branch was fundamentally broken.

It works by chance if a local branch exists that matches the name of
the desired remote branch.  Thus, "master" happens to work and the bug
possibly escapes common notice.

cmd_add_repository() does a git fetch - the desired remote refspec can
never be found in the local repo until that git fetch is run, so the
attempt to validate it within cmd_add() is wrong - if desired, that
should happen after the fetch in cmd_add_repository().

I think the additions shown in lines 505 and 506 should be reverted,
since the rev is also checked in cmd_add_commit()

Best,

Peter Wolanin
