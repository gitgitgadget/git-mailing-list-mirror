From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 3/3] git-p4: fixing --changes-block-size handling
Date: Mon, 08 Jun 2015 09:02:22 -0700
Message-ID: <xmqqk2vecho1.fsf@gitster.dls.corp.google.com>
References: <55747A05.3070704@diamand.org>
	<1433712905-7508-1-git-send-email-luke@diamand.org>
	<1433712905-7508-4-git-send-email-luke@diamand.org>
	<CALM2SnZShkETQoQuNc8e0GsPWzODQACzwjh1qCGeajiN+5sjaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Luke Diamand <luke@diamand.org>, Git Users <git@vger.kernel.org>
To: Lex Spoon <lex@lexspoon.org>
X-From: git-owner@vger.kernel.org Mon Jun 08 18:02:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1zVO-0004A9-5R
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 18:02:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752355AbbFHQC0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 12:02:26 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:36948 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751955AbbFHQCY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2015 12:02:24 -0400
Received: by igbsb11 with SMTP id sb11so60534856igb.0
        for <git@vger.kernel.org>; Mon, 08 Jun 2015 09:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=CSKOY4iupac7WjA+U4tQzBfO0m0RSoLm8Fuiybluszc=;
        b=KQV/DwW6g3/oT5CpfE64kROBPUZVBCUN4arwvKJKMtGCGQiR3zzXviwsVMiApG4tnj
         TIxxzc8rbEGeDaexkJraBiywIoK+3fQ565WymFOtwOSkdSE+WDyxHxbjA80oXHkWBjib
         ZIEEAQy72/4ogJ0YC4oVRFmRJoME2aiypavoCuVkAbuXbYTsrsAK52MAg+1Ng+ujLMKC
         /teP9tuUntvwtwxFr4YSx59fHIDqQPwRnZy+uSc4P/RDePh3GbLMLqymjjhov7sdjGUB
         10ogkWUAVgx7mAIq4eHV/FCL2lXB+YjjsE+s8rWUzvlC0IDB/ctic0sh7LPTgm9YWKTC
         xInA==
X-Received: by 10.42.161.74 with SMTP id s10mr24153942icx.5.1433779344228;
        Mon, 08 Jun 2015 09:02:24 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:d91a:edb1:b738:fb03])
        by mx.google.com with ESMTPSA id d81sm1985313ioe.12.2015.06.08.09.02.23
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 08 Jun 2015 09:02:23 -0700 (PDT)
In-Reply-To: <CALM2SnZShkETQoQuNc8e0GsPWzODQACzwjh1qCGeajiN+5sjaw@mail.gmail.com>
	(Lex Spoon's message of "Sun, 7 Jun 2015 18:58:15 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271061>

Lex Spoon <lex@lexspoon.org> writes:

> Unless I am reading something wrong, the "new_changes" variable could
> be dropped now. It was needed for the -m version for detecting the
> smallest change number that was returned. Otherwise it looks good to
> me.

Meaning that I should squash this in to 3/3, right?



diff --git a/git-p4.py b/git-p4.py
index f201f52..7009766 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -780,10 +780,8 @@ def p4ChangesForPaths(depotPaths, changeRange, block_size):
             cmd = ['changes']
             cmd += ["%s...@%d,%d" % (p, changeStart, end)]
 
-            new_changes = []
             for line in p4_read_pipe_lines(cmd):
                 changeNum = int(line.split(" ")[1])
-                new_changes.append(changeNum)
                 changes[changeNum] = True
 
             if end >= changeEnd:
-- 
2.4.3-495-gcb7a0d9
