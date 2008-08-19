From: "Boaz Stuller" <boazstuller@gmail.com>
Subject: Problem with git-svn
Date: Tue, 19 Aug 2008 09:41:28 -0400
Message-ID: <5979e28c0808190641l343ed48fi75c55f9f0cdb1bcf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 19 15:43:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVRTp-00077g-Hr
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 15:42:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754776AbYHSNla (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 09:41:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752007AbYHSNla
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 09:41:30 -0400
Received: from rv-out-0506.google.com ([209.85.198.230]:36994 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754771AbYHSNl3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 09:41:29 -0400
Received: by rv-out-0506.google.com with SMTP id k40so2455454rvb.1
        for <git@vger.kernel.org>; Tue, 19 Aug 2008 06:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=u+JMnYHy6Qf9NQ9kOc1w/7jKtSxoALleIK+qfCj6eGo=;
        b=ZJwZaJLb8VhlLt1mYtcIIyCB4NkGlcjczUJT2DF/z6uaRLhrzfjhCTJiTvR5zXtRW6
         QoadeeGZb4HMCKQHt7lxxL/bdSg4LwQvo06X7UpOYseLW3aY4Dly3HWx9nTA0+mjrrDq
         iX+mdzKBYdNuHpdqUfuvTKUx+OTasm/ytY7Kg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=v3lqVAW1RSD7vI+ZIuQOLiv0sx1YEwTSXCETmsZb42XO7xineBAQf3zokz3zZ3L8IF
         bRWd2zGVhV4WVUVPlYm1/Cc2LkUNGx8kjjiy+ESstkEV6iTRdMsfpQCj14v/Ck7x25tT
         sQR2DKmlyx2AejDGJ8uYOc0jslRTvrIudm2YI=
Received: by 10.140.164.1 with SMTP id m1mr4051143rve.266.1219153288834;
        Tue, 19 Aug 2008 06:41:28 -0700 (PDT)
Received: by 10.141.163.16 with HTTP; Tue, 19 Aug 2008 06:41:28 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92859>

I'm having a problem with git-svn.  I was connecting to a remote svn
repository via the svn+ssh:// protocol using an embedded username in
the url, i.e svn+ssh://boazstuller@svn.example.com/some/complicated/path.
 When I upgraded to 1.6.0, 'git svn dcommit' stopped working and
instead kept asking me for a password.   I tracked the problem down to
the following commit:

commit ba24e7457aa1f958370bbb67dfb97e3ec806fd4a
Author: Eric Wong <normalperson@yhbt.net>
Date:   Thu Aug 7 02:06:16 2008 -0700
    git-svn: add ability to specify --commit-url for dcommit

I don't know perl, but the problem seems to be where around line 446,
'$gs->full_url' gets changed to  '$url'.  Apparently, $gs->full_url
contained the embedded username but $url has it stripped out, i.e
svn+ssh://svn.example.com/some/complicated/path , so ssh can't tell
what username I'm trying to log in as.

Best wishes,
Bo
