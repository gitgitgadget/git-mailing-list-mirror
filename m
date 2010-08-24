From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v3 0/3] rev-parse: strengthen validation of ref@{n} references
Date: Tue, 24 Aug 2010 14:52:41 +1000
Message-ID: <1282625564-12752-1-git-send-email-jon.seymour@gmail.com>
References: <20100824001454.GB17406@burratino>
Cc: gitster@pobox.com, jrnieder@gmail.com,
	Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 24 06:53:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OnlVY-0004mt-Q3
	for gcvg-git-2@lo.gmane.org; Tue, 24 Aug 2010 06:53:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751749Ab0HXExH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Aug 2010 00:53:07 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:40831 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751362Ab0HXExF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Aug 2010 00:53:05 -0400
Received: by pwi7 with SMTP id 7so2344381pwi.19
        for <git@vger.kernel.org>; Mon, 23 Aug 2010 21:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=cQWm3W6jA2kdoINpZLkzweTB4TS8Ij7ImBhmVfD0At4=;
        b=Vp8cNz0H93ylnH999aW9zKrMkpljWxPSQYSu9JpFNJNpL2XeZxh8EKPgZR+P1uficR
         cZsds4JzKCrkizMRPg2omtw8wUR/rHj2PG81g/8yBgh6iR7RWavMbFayEin9m9jfL82G
         rhKRjpA3GqcpJeBYIyHlYWrh7yzBx1AnaT1vU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=E6IV+bgc6tTCLCGGc4imQvonpaRkh5OiW0rWAL2A+I2zBF+txFef9KcA6z+eZjPK/y
         8rERvYVqqhhzs65fmRlyOKkZvVhHWNSFhBRCIhP0x9LeBp/xeADVdy0j2kHpaVVxl3FJ
         XMzv9+onFEk+sAjpKK8yDnFH6Z1hDzYNi6qyg=
Received: by 10.142.234.6 with SMTP id g6mr5277349wfh.146.1282625585010;
        Mon, 23 Aug 2010 21:53:05 -0700 (PDT)
Received: from localhost.localdomain ([120.16.94.110])
        by mx.google.com with ESMTPS id n2sm9394805wfl.1.2010.08.23.21.52.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 23 Aug 2010 21:53:03 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.100.gceecd
In-Reply-To: <20100824001454.GB17406@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154286>

This series changes git rev-parse so that references of the form:

       ref@{n}

cause rev-parse to fail with a non-zero status code if n >= size of the
reference log for ref.

The first commit implements the changed behaviour; the second commit
replaces uses of fprintf (within sha1_name.c) with warning; 
the third commit updates the tests to include tests for the changed behaviour.

This is the third revision of this series. It differs from the first
in that it uses die rather than error to report the condition
and thus exits early, without generating any output on stdout
for the failing argument. It also reports just a single fatal
message instead of both an error message and a fatal message.

The original patch and this revision are both based on suggestions
from Junio. Corrections to diagnostic output inspired by Jonathan Nieder's
review.

Jon Seymour (3):
  rev-parse: exit with non-zero status if ref@{n} is not valid.
  sha1_name.c: use warning in preference to fprintf(stderr
  rev-parse: tests git rev-parse --verify master@{n}, for various n

 sha1_name.c                    |   20 +++++++++++---------
 t/t1503-rev-parse-verify.sh    |   11 +++++++++++
 t/t1506-rev-parse-diagnosis.sh |    9 +++++++++
 3 files changed, 31 insertions(+), 9 deletions(-)

-- 
1.7.2.1.100.gceecd
