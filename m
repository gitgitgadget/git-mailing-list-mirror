From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v2 0/2] rev-parse: strengthen validation of ref@{n} references
Date: Tue, 24 Aug 2010 09:11:41 +1000
Message-ID: <1282605103-8320-1-git-send-email-jon.seymour@gmail.com>
References: <7vr5hp1e6i.fsf@alter.siamese.dyndns.org>
Cc: gitster@pobox.com, Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 24 01:12:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OngBR-00056u-JZ
	for gcvg-git-2@lo.gmane.org; Tue, 24 Aug 2010 01:12:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751531Ab0HWXL7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Aug 2010 19:11:59 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:54476 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751207Ab0HWXL6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Aug 2010 19:11:58 -0400
Received: by pxi10 with SMTP id 10so2456871pxi.19
        for <git@vger.kernel.org>; Mon, 23 Aug 2010 16:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=BPBrmjIAQBRhDDJt8P8v+7UukbShkH4bto/OQKpsmdE=;
        b=w+vWlDFuB6fjInzLU6Ietg1eB9fXa64O+HkyZtUV5rqTtGVWn16vG5zKEZDkTuWs3A
         9Xv7oZ2ubgOUlK00b5beIKDVfdIUR8LYmDEydMjMv7HUo8XK4O4kD7xyTDYbW4VbRjYv
         i7GFNgwR8JwoCe5TFdecvbfNQuAOzOguZVQrc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=WMMmIbLUw2FqwOLvx0Mm1+g5XynGyEn8XI0oyfBz/1EhrahDq1Qv5V/aFMgwMhTqVf
         QoUf2n7ri0K3LAQ2Bm5SSRF/jRcc0CnBnKPWhxrNjbr612yru1hwDHq9KPS+ZbjMoWRl
         7VEAYbyXnyNSBlOB0zyDvOh1HhKgFfG4zDIPo=
Received: by 10.142.218.12 with SMTP id q12mr3856867wfg.144.1282605118075;
        Mon, 23 Aug 2010 16:11:58 -0700 (PDT)
Received: from localhost.localdomain (124-169-135-9.dyn.iinet.net.au [124.169.135.9])
        by mx.google.com with ESMTPS id v13sm9081625wfv.5.2010.08.23.16.11.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 23 Aug 2010 16:11:57 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.99.geab11
In-Reply-To: <7vr5hp1e6i.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154271>

This series changes git rev-parse so that references of the form:

	ref@{n}

cause rev-parse to fail with a non-zero status code if n >= size of the 
reference log for ref.

The first commit implements the changed behaviour, the second commit 
updates the tests to include tests for the changed behaviour.

This is the second revision of this series. It differs from the first
in that it uses die rather than error to report the condition
and thus exits early, without generating any output on stdout
for the failing argument. It also reports just a single fatal
message instead of both an error message and a fatal message.

The original patch and this revision are both based on suggestions
from Junio.

Jon Seymour (2):
  rev-parse: exit with non-zero status if ref@{n} is not valid.
  rev-parse: tests git rev-parse --verify master@{n}, for various n

 sha1_name.c                    |   20 +++++++++++---------
 t/t1503-rev-parse-verify.sh    |   11 +++++++++++
 t/t1506-rev-parse-diagnosis.sh |    9 +++++++++
 3 files changed, 31 insertions(+), 9 deletions(-)

-- 
1.7.2.1.99.geab11
