From: Jacek Masiulaniec <jacekm@dobremiasto.net>
Subject: git archive: tar.umask ignored
Date: Tue, 12 Apr 2011 10:39:41 +0100
Message-ID: <BANLkTimTs+Qh9fNs6pLcZidYy-YjXNR2iw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 12 11:39:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9a4a-0000EU-0A
	for gcvg-git-2@lo.gmane.org; Tue, 12 Apr 2011 11:39:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756810Ab1DLJjm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2011 05:39:42 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:59925 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751844Ab1DLJjl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2011 05:39:41 -0400
Received: by iyb14 with SMTP id 14so6457806iyb.19
        for <git@vger.kernel.org>; Tue, 12 Apr 2011 02:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:date:x-google-sender-auth
         :message-id:subject:from:to:content-type;
        bh=moDEdkZiyIFu1r4/EP5nen/k1Qu9k+yGzJLB1ofBI2s=;
        b=UiUD3P5IlHIfeH1iykFJ70yIlQrRP0+7sMplG/LQGzRWneGakYkMEVKmUQDVE9vTfI
         GmMfbERVbwqP77VT+EcFu2rj8Xi9OjzQ2NJh63IAbekX7EO3KAfYMzbjxt9mqh0saoT/
         x9C1roenHsM4CdUh1szZ5pdO6/Lcot7klhe6w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type;
        b=dFpMsb5NCIpoPE0RTEqcFftbFL6U4ad0uv4DFmKaU4olJrTZZY8uM4UR+0JKwgWBE5
         vmDs//SKbfy2lHiQLlwdu9Mi8PFB0GwBrfRtnbGhP2z9DVDT61Otc+jYQsuEMAx5D7pG
         r5aflRta8wF73AVMwytISwm343xcCXrCt6zoI=
Received: by 10.231.4.139 with SMTP id 11mr6645893ibr.65.1302601181191; Tue,
 12 Apr 2011 02:39:41 -0700 (PDT)
Received: by 10.231.17.71 with HTTP; Tue, 12 Apr 2011 02:39:41 -0700 (PDT)
X-Google-Sender-Auth: 0eX2qgd12A8odR-byd_xAYuwI5E
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171387>

Hello git@,

I believe git has an issue with command line override of configuration options.
Notice how in both cases below the file mode is 775 despite tar.umask
difference:

[jacekm@localhost git]$ ./git --version
git version 1.7.4.4
[jacekm@localhost git]$ ./git archive --remote=/repo/website.git HEAD
| tar -tvf - | head -1
drwxrwxr-x root/root         0 2011-04-11 13:47:09 bin/
[jacekm@localhost git]$ ./git -c tar.umask=0022 archive
--remote=/repo/website.git HEAD | tar -tvf - | head -1
drwxrwxr-x root/root         0 2011-04-11 13:47:09 bin/
[jacekm@localhost git]$

In contrast, tweaking tar.umask in ~/.gitconfig does have the desired
impact on the file mode.

Jacek
