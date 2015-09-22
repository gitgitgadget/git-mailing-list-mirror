From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 1/2] git-p4: add test case for "Translation of file content failed" error
Date: Mon, 21 Sep 2015 18:10:25 -0700
Message-ID: <xmqqbncv6yym.fsf@gitster.mtv.corp.google.com>
References: <1442829701-2347-1-git-send-email-larsxschneider@gmail.com>
	<1442829701-2347-2-git-send-email-larsxschneider@gmail.com>
	<xmqqio73abl0.fsf@gitster.mtv.corp.google.com>
	<E47DE9F0-6017-4E96-AC29-E6C60C4D85CB@gmail.com>
	<CAPig+cRV-RCdcmAHG+bRL6_yYYNCRqQPQ+v3KCXwC81StGKibg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Lars Schneider <larsxschneider@gmail.com>,
	Git List <git@vger.kernel.org>,
	Luke Diamand <luke@diamand.org>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Sep 22 03:10:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZeC6K-0004VI-7A
	for gcvg-git-2@plane.gmane.org; Tue, 22 Sep 2015 03:10:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757536AbbIVBK2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2015 21:10:28 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:33884 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754284AbbIVBK1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2015 21:10:27 -0400
Received: by padhy16 with SMTP id hy16so131615742pad.1
        for <git@vger.kernel.org>; Mon, 21 Sep 2015 18:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=3AJdHkpaQ9Y8EGv8ZVsCX6J1kqKgJcSZTil9Stwyk9I=;
        b=iLtpRdTGW47jp7Mxghv+wOBbHDbK3MkTito6l45GLem8YOGnVrPDii6r5gkFNX4aNH
         7q52xPzgy5taF6BA7xBS6ERsTk9CUEaBTjeitDTIwz11VrCQFe+IoCG/dFey61InuYeD
         oNFTwy7dxMX6K9YlCK67K7L/BFWCvFrJoPv1qWmo9NRIHo5XPBInaBon9/6vPUoFZhPU
         XDuWd8hKjSf9OiQt1uPVZV8m7/mRC5B/46FhDUtFvs2D5kNmUmWLnd4aSCdt98pcfSUI
         H3SIRDPGyREcbOrL2VEKFwEpnYuqSiORnWTtqbGNBND3dRBzY4DwsT6XUSsuYPNEcY+j
         7txQ==
X-Received: by 10.66.145.97 with SMTP id st1mr28140845pab.145.1442884226987;
        Mon, 21 Sep 2015 18:10:26 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:89f8:25c:a9fe:f701])
        by smtp.gmail.com with ESMTPSA id yk5sm27012797pab.31.2015.09.21.18.10.26
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Mon, 21 Sep 2015 18:10:26 -0700 (PDT)
In-Reply-To: <CAPig+cRV-RCdcmAHG+bRL6_yYYNCRqQPQ+v3KCXwC81StGKibg@mail.gmail.com>
	(Eric Sunshine's message of "Mon, 21 Sep 2015 19:54:29 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278373>

Eric Sunshine <sunshine@sunshineco.com> writes:

> Yes, it's because $d is a variable reference, even within double
> quotes.

s/even/especially/ ;-)

Here is what I queued as SQUASH???

diff --git a/t/t9825-git-p4-handle-utf16-without-bom.sh b/t/t9825-git-p4-handle-utf16-without-bom.sh
index 65c3c4e..735c0bb 100644
--- a/t/t9825-git-p4-handle-utf16-without-bom.sh
+++ b/t/t9825-git-p4-handle-utf16-without-bom.sh
@@ -22,8 +22,8 @@ test_expect_success 'init depot with UTF-16 encoded file and artificially remove
 		cd "db" &&
 		p4d -jc &&
 		# P4D automatically adds a BOM. Remove it here to make the file invalid.
-		sed -e "$ d" depot/file1,v >depot/file1,v.new &&
-		mv -- depot/file1,v.new depot/file1,v &&
+		sed -e "\$d" depot/file1,v >depot/file1,v.new &&
+		mv depot/file1,v.new depot/file1,v &&
 		printf "@$UTF16@" >>depot/file1,v &&
 		p4d -jrF checkpoint.1
 	)
