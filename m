From: "Eric Raible" <raible@gmail.com>
Subject: ':/<oneline prefix>' notation doesn't support full file syntax
Date: Wed, 2 Jul 2008 22:42:52 -0700
Message-ID: <279b37b20807022242q69ad2fcbwb8c11a9d6165272d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes.Schindelin@gmx.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 03 10:25:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEK7p-0002yW-VR
	for gcvg-git-2@gmane.org; Thu, 03 Jul 2008 10:25:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754289AbYGCG7u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2008 02:59:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753908AbYGCG6H
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 02:58:07 -0400
Received: from wf-out-1314.google.com ([209.85.200.172]:20165 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754867AbYGCFmy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2008 01:42:54 -0400
Received: by wf-out-1314.google.com with SMTP id 27so660268wfd.4
        for <git@vger.kernel.org>; Wed, 02 Jul 2008 22:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=nqz2PFpJov7ZbSOh4uEoRj1J0CdwmXLtBoq+gOr3lcs=;
        b=e32Xs+jh64SfX7FPoeEacD5j5kBnQfHvABEhnqhBWDA3iRb0zjxJ6RWXRVTOdA7ugA
         +BwuMIrXQM7qq5UmXVF7BvjdMPjYPMOT2jLDXH7sYn9lZ5hK/r5a7KtU8KFPMc+AXNgh
         DBerAtHF1hHHsGC/36hErmp1RJWvyBZ+4wX5A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=N0znkp1Mz8V2tMPnxg4SoAy2Vtsj+PdzHhoS2IbNXzzDiwyrmczi7Ot53R3xuH+I78
         WZ5JKvmMIsz7Vw7o7eFnJ9f30pAnXDnMwLaYU1+Us+HSmcH8OGIDQ1TG8SLzd8c9gA20
         FM5Mq/Twf/+uVp2rfSXFJRznBlavf5ePsoj9k=
Received: by 10.142.237.20 with SMTP id k20mr3410004wfh.146.1215063772345;
        Wed, 02 Jul 2008 22:42:52 -0700 (PDT)
Received: by 10.142.14.12 with HTTP; Wed, 2 Jul 2008 22:42:52 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87252>

Although the rev-parse documentation claims that the
tree-ish:path/to/file syntax works is applicable, this is
not so when using the :/ "oneline prefix" syntax:

% git rev-parse v1.5.0.1-227-g28a4d94
28a4d940443806412effa246ecc7768a21553ec7
% git rev-parse ":/object name"
28a4d940443806412effa246ecc7768a21553ec7

% git rev-parse v1.5.0.1-227-g28a4d94:sha1_name.c
0781477a71ac4d76a1b8783868d6649cae7f8507
% git rev-parse ":/object name":sha1_name.c
:/object name:sha1_name.c
fatal: ambiguous argument ':/object name:sha1_name.c': unknown
revision or path not in the working tree.
Use '--' to separate paths from revisions

A quick look at int sha1_name.c:get_sha1() shows that it doesn't
even try to make this work.  Is this worth fixing?
Or at least documenting?

- Eric
