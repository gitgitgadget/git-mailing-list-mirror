From: "Marco Costalba" <mcostalba@gmail.com>
Subject: QGit: Shrink used memory with custom git log format
Date: Sat, 24 Nov 2007 09:14:42 +0100
Message-ID: <e5bfff550711240014n78f24b46qf012957d92b1a8e1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Nov 24 09:15:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvqAJ-0001u1-2k
	for gcvg-git-2@gmane.org; Sat, 24 Nov 2007 09:15:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751607AbXKXIOn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Nov 2007 03:14:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751330AbXKXIOn
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Nov 2007 03:14:43 -0500
Received: from rv-out-0910.google.com ([209.85.198.187]:49685 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751269AbXKXIOm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Nov 2007 03:14:42 -0500
Received: by rv-out-0910.google.com with SMTP id k20so51905rvb
        for <git@vger.kernel.org>; Sat, 24 Nov 2007 00:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=/y6J/Prq+N+VNcwwDpVL2S6mIT8zI3IDMYWYKFgqgdc=;
        b=I2CnN0y2JqSn9cGfnlBmsp/KQcy3Bpvw0T1nAzmdtRc4aoQJW60ih82Dbv3hd9hkfTng/tOEs18bwc9EX7SkF1/M0+6EuDzPasCbvN8u3qTLSO5Y6B5+yF7F/38FMSI9z0K37IcH8qpMixUsSKgPqsaTYchx2lSxqX4xRmY0Lbw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=AhvqvH2IZ7y1R4YFtnA2qUGEjf1ONR9Az9rbnSAOArkDuVKSuodLDnUNpjqD6LcDekatbMK0gajvoSHvROY3GKSFKhEpackWDVrQ5R4lazr6meRK85VA9EHvHERTR/oN1rgxSBQZ5utOUvxxfLXJOHLmSMDiys1/UpoILZck1nw=
Received: by 10.141.171.6 with SMTP id y6mr92234rvo.1195892082076;
        Sat, 24 Nov 2007 00:14:42 -0800 (PST)
Received: by 10.140.185.19 with HTTP; Sat, 24 Nov 2007 00:14:42 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65938>

Hi all,

   I have pushed a patch series to

git://git.kernel.org/pub/scm/qgit/qgit4.git

that changes the format of git log used to read data from a git repository.

Now instead of --pretty=raw a custom made --pretty=format is given,
this shrinks loaded data of 30% (17MB less on Linux tree) and gives a
good speed up when you are low on memory (especially on big repos)

Next step _would_ be to load log message body on demand (another 50%
reduction) but this has two drawbacks:

(1) Text search/filter on log message would be broken

(2) Slower to browse through revisions because for each revision an
additional git-rev-list /git-log command should be executed to read
the body

The second point is worsted by the fact that it is not possible to
keep a command running and "open" like as example git-diff-tree
--stdin and feed with additional revision's sha when needed. Avoiding
the burden to startup a new process each time to read a new log
message given an sha would let the answer much more quick especially
on lesser OS's

Indeed there is a git-rev-list --stdin option but with different
behaviour from git-diff-tree --stdin and not suitable for this.

Marco
