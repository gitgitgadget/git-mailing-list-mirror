From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 0/6] modernize t1500
Date: Tue, 10 May 2016 01:20:49 -0400
Message-ID: <20160510052055.32924-1-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Michael Rappazzo <rappazzo@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 10 07:21:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0075-0003ga-EW
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 07:21:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751445AbcEJFVe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2016 01:21:34 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:36182 "EHLO
	mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751254AbcEJFVd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 01:21:33 -0400
Received: by mail-io0-f195.google.com with SMTP id k129so407007iof.3
        for <git@vger.kernel.org>; Mon, 09 May 2016 22:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=AxR3leFWt+HkV3VnI++1GcPD8VGKbtxeED6J7v7EzRg=;
        b=O93uF+Egwbr2FyOK4+kNI9GVA7LBlFAYU6RFCppwT3OYhRwiH7azPFNmIv42SMkUOD
         CI0WMiLeeOzD0tkVBeDemgnAkdGcja0e8Q7Os80Mdp+G90RSlMFIcKOc8/PO8xPZKMHq
         31UP4hlKqAAi2fqNn/Hifi9Gj+3eG8idGftEgCfPtcGsSJhXSrOcBVW25v8VNx+NDIfk
         ga9/MZQrziFKtHAhP1343tqD5xkxkVZxnF9VvHvK1Ay/uwevDX5R92sxIayPhYSfY6Qv
         LLzlf2GsEfI2vkI8LWDcGV8RG8kXy99Ahkg3dANTjefAQqb316/0zXmScj5pc05x7mnA
         sl8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=AxR3leFWt+HkV3VnI++1GcPD8VGKbtxeED6J7v7EzRg=;
        b=gQrVfJQkfPVYfAjmzB743KkVM9rqHZjFgKZYKMH4c4O15ZkJv2byGyDSvB7UVyfcZz
         q78IwMv77v61qrx/XfcqmprBHKLncQlde+pInaOHDPGsz6/szhLH9jaSPRjBPbIy+RdY
         Nw4ZNFuDv8Xm/WG6MPv5V1CpcLy0VQXRISYWOS1X80I82BLw2nvosEsj+a3irWMOd5MS
         bYeYbid5BVQL9ahFriydFjsV/Nd0oJ+g+2w77MfLeEwuOdfJRSBXHxpG5Mdj6vI7227f
         q9O8hIneJ8y7yvvQSYK7Ek4V3mgLWZX7VjHMRbEbSVYxH7tweSPCDIGfQoNXxfAxiKok
         b5Zg==
X-Gm-Message-State: AOPr4FVLEWEX59FUvfP96g73W6mYVHa5A0Dq2v4UW5lX8Tz+ZCq8kRdzRlx68cXpj++uAg==
X-Received: by 10.107.16.195 with SMTP id 64mr32597326ioq.194.1462857690813;
        Mon, 09 May 2016 22:21:30 -0700 (PDT)
Received: from localhost.localdomain (user-12l3c5v.cable.mindspring.com. [69.81.176.191])
        by smtp.gmail.com with ESMTPSA id vu8sm458336igb.1.2016.05.09.22.21.29
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 09 May 2016 22:21:30 -0700 (PDT)
X-Mailer: git-send-email 2.8.2.530.g51d527d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294088>

This series modernizes t1500; it takes an entirely different approach
than [1][2] and is intended to replace that series. Whereas [1][2]
dropped the systematic function-driven testing of git-rev-parse in favor
of dozens of nearly identical copy/paste tests, this series retains the
structure of the existing script and instead updates the tests to set up
their own needed state rather than relying upon transient and fragile
manipulation of global state.

Due to its systematic function-driven approach, the original script is
small at 87 lines, and easily understood. When [1] dropped the
systematic approach and replaced it with individual copy/paste tests,
the script ballooned to a whopping 573 lines; its v2 successor, while
smaller, still inflated it to 322 lines. Writing that amount of code
correctly (even when primarily copy/paste) is difficult; reviewing it
for correctness is tedious, mind-numbing, and error-prone, as evidenced
by [3].

This series, on the other hand, values the concision of the original and
only makes changes necessary to modernize it; the script size remains
about the same; it drops from 87 to 83 lines.

[1]: http://thread.gmane.org/gmane.comp.version-control.git/291087/focus=291088
[2]: http://thread.gmane.org/gmane.comp.version-control.git/291729/focus=291731
[3]: http://thread.gmane.org/gmane.comp.version-control.git/291729/focus=291745

Eric Sunshine (6):
  t1500: test_rev_parse: facilitate future test enhancements
  t1500: reduce dependence upon global state
  t1500: avoid changing working directory outside of tests
  t1500: avoid setting configuration options outside of tests
  t1500: avoid setting environment variables outside of tests
  t1500: be considerate to future potential tests

 t/t1500-rev-parse.sh | 116 +++++++++++++++++++++++++--------------------------
 1 file changed, 56 insertions(+), 60 deletions(-)

-- 
2.8.2.530.g51d527d
