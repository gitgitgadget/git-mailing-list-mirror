From: Chris Pettitt <cpettitt@gmail.com>
Subject: [PATCH] git-p4 support for perforce renames.
Date: Mon, 15 Oct 2007 21:35:45 -0700
Message-ID: <1192509345-21340-1-git-send-email-cpettitt@gmail.com>
Cc: Chris Pettitt <cpettitt@gmail.com>
To: Simon Hausmann <simon@lst.de>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 16 06:36:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IheAE-0005aT-Gi
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 06:36:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754165AbXJPEgI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 00:36:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754140AbXJPEgH
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 00:36:07 -0400
Received: from wa-out-1112.google.com ([209.85.146.178]:35963 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754136AbXJPEgF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 00:36:05 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2239469wah
        for <git@vger.kernel.org>; Mon, 15 Oct 2007 21:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer;
        bh=zP1ZL+Iwncii8ftgZpm6+pMEn34YdRUJRUUtXMXORNc=;
        b=fETBVPmgR83wvSxMCrSaSquAaVTNPJa/wVqAMl/r+/kr04qwBQS9R3SF3vHblySg4RkBvunmkH6y7eHbh4GZ4PgxKd6LqoywYAprn5ziaLM6CMNWeIhe/Ihrw9yWrLlSqGcrrodjDIlB241Ns5k29lQLz39BitIVFxs10J4AWt4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer;
        b=a514qPe32xy5lWkmk8f2NtEdpOib/mPo0hrdC/DRclTrJusfQAZZWV6d9LDFuRTCWeFT1lXDQUzT+Gia4HHbadQbs9IrXd+kzvsV79eX2xEvgRqH/I9xXruJgsDXXXm8M9OBCvD/X3CLckfaws4QlHGe6hH2Zr/5B6x9AySlNec=
Received: by 10.114.124.1 with SMTP id w1mr7889436wac.1192509361601;
        Mon, 15 Oct 2007 21:36:01 -0700 (PDT)
Received: from localhost ( [76.236.71.63])
        by mx.google.com with ESMTPS id m29sm6385960poh.2007.10.15.21.35.56
        (version=SSLv3 cipher=OTHER);
        Mon, 15 Oct 2007 21:35:59 -0700 (PDT)
X-Mailer: git-send-email 1.5.3.4.206.g58ba4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61074>

The current git-p4 implementation does support file renames. However, because
it does not use the "p4 integrate" command, the history for the renamed file is
not linked to the new file.

This changeset adds support for perforce renames with the integrate command.
Currently this feature is only enabled when calling git-p4 submit with the -M
option. This is intended to look and behave similar to the "detect renames"
feature of other git commands.

The following sequence is used for renamed files:

    p4 integrate -Dt x x'
    p4 edit x'
    rm x'
    git apply
    p4 delete x

By default, perforce will not allow an integration with a target file that has
been deleted. That is, if x' in the example above is the name of a previously
deleted file then perforce will fail the integrate. The -Dt option tells
perforce to allow the target of integrate to be a previously deleted file.

Signed-off-by: Chris Pettitt <cpettitt@gmail.com>

 contrib/fast-import/git-p4 |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)
-- 
1.5.3.4.206.g58ba4
