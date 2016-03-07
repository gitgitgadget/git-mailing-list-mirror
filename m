From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 0/4] make t6302 usable even without GPG installed
Date: Sun,  6 Mar 2016 19:10:23 -0500
Message-ID: <1457309427-30124-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 07 01:11:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1acilP-00082O-UL
	for gcvg-git-2@plane.gmane.org; Mon, 07 Mar 2016 01:11:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751333AbcCGAK6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Mar 2016 19:10:58 -0500
Received: from mail-io0-f195.google.com ([209.85.223.195]:33749 "EHLO
	mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751054AbcCGAK6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Mar 2016 19:10:58 -0500
Received: by mail-io0-f195.google.com with SMTP id g203so9613695iof.0
        for <git@vger.kernel.org>; Sun, 06 Mar 2016 16:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=v0TeaAVb6gSoAPvwkCF2MNcECbJlhnQ5KUZhSnZ6fMk=;
        b=RCkz+L12FqaulNm4F23U5hBuwO/A+smTDpT4IWiL/u2IQwMgNx9ToKBAR9oZJPJN77
         XEuyvt765RqU4lYsWZSHLQr7+rGawMdKJBDvH5twGq1Sqs6AlD/PisMSc066RGBNfLHe
         69qwdrGFIC5qyvHSHgoRMS2Ew6+9T6mR+tLde2KteqbOG2kluLUp/aMcd5VVsX4imeTU
         HdRr2+5j1Xbm7YFVQYCOMG6FVydx9WrP/wjdtw1j8PE90tCb0UpMSYCt7L9XkkWHZg4h
         EKiBd3OSLuoFk1bpxx0eG2A00keQT8fIAIkPncjWXBZw46WgVITE8wijTAhDcH/Waqnw
         UZAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=v0TeaAVb6gSoAPvwkCF2MNcECbJlhnQ5KUZhSnZ6fMk=;
        b=R1cKDJoALSql9skNA5QA6C4B1A8uGIgIz7zMzO8ShxhRISLNj75k6f2HQWWZXzFfv2
         KpdwMBNjdkhmnyRcxr1hVxC27gGJ9lyjnp37gIh7rZm2tB9DAaFZ0wZLxxb15j1P1kVk
         jTXpuhb/ajrmV5G1ONtE8QijP//AC1FK+HxB4rTi2nqgo+jA7Ss2TNtoc8wMZSgPSCXq
         eOdzSFFP+r5Qj/w21yDuP9xRmT9OBqOa3FTu6Kq5os3M4f44iZDm2YDopNsS11fMsbut
         3jY0OkfcT5+Kcnr0AP4iacqnFOjrkNAOAv39NHJkBADtKMG25cAGduWVZsfgy/9XsbFT
         jnBQ==
X-Gm-Message-State: AD7BkJKl7e2nShwIUDYjY5YPk0hJ4DdoBMB7PdAAhbzzpaWD7LW/3DzFyd4iLkuOmTSINQ==
X-Received: by 10.107.137.152 with SMTP id t24mr9346318ioi.147.1457309457103;
        Sun, 06 Mar 2016 16:10:57 -0800 (PST)
Received: from localhost.localdomain (user-12l3c5v.cable.mindspring.com. [69.81.176.191])
        by smtp.gmail.com with ESMTPSA id t62sm1337418ioi.41.2016.03.06.16.10.56
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 06 Mar 2016 16:10:56 -0800 (PST)
X-Mailer: git-send-email 2.8.0.rc1.175.g19dcece
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288371>

This is a re-roll of [1] which aims to allow t6302 to be run even
without GPG installed. Changes since v1:

* rather than converting existing signed tags to unsigned, make testing
  of unsigned tags a normal part of the script and just suppress testing
  of signed tags when GPG is missing (Junio)

* new patch: silence redundant warning about missing GPG

[1]: http://thread.gmane.org/gmane.comp.version-control.git/285170

Eric Sunshine (4):
  lib-gpg: drop unnecessary "missing GPG" warning
  t6302: normalize names and descriptions of signed tags
  t6302: also test annotated in addition to signed tags
  t6302: skip only signed tags rather than all tests when GPG is missing

 t/lib-gpg.sh                   |  5 +--
 t/t6302-for-each-ref-filter.sh | 95 ++++++++++++++++++++++++++++--------------
 2 files changed, 65 insertions(+), 35 deletions(-)

-- 
2.8.0.rc1.175.g19dcece
