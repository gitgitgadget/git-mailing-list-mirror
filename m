From: Alexey Shumkin <Alex.Crezoff@gmail.com>
Subject: [PATCH resent] send-email: Honor multi-part email messages
Date: Fri, 25 Jan 2013 19:28:53 +0400
Message-ID: <cover.1359126360.git.Alex.Crezoff@gmail.com>
Cc: Alexey Shumkin <Alex.Crezoff@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Krzysztof Mazur <krzysiek@podlesie.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 25 16:30:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TylEa-0004Jv-M8
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 16:30:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757066Ab3AYPaA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2013 10:30:00 -0500
Received: from mail-lb0-f174.google.com ([209.85.217.174]:61475 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757170Ab3AYP3F (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2013 10:29:05 -0500
Received: by mail-lb0-f174.google.com with SMTP id l12so910711lbo.5
        for <git@vger.kernel.org>; Fri, 25 Jan 2013 07:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rarus.ru; s=google;
        h=x-received:sender:from:to:cc:subject:date:message-id:x-mailer;
        bh=3SINe8JfTHALqqHBMPjkcTJoipNChpxQapcMINRSdlA=;
        b=mi0ccyWpT24V+uS4P3DhY8cZAgE6+g26HnlaH6IDwwV22xr7+2R2RIe2fUg+zz2LVT
         urOj+N4c+ga58dI0oeufVYAgpm616yvJK2wLbRSyNIQkfsKpcEBys4MWLn5ybRscSinT
         xqGTH7LeNG1Kcj7zE9rvAkEp5gMYh7Kp8YMis=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:sender:from:to:cc:subject:date:message-id:x-mailer;
        bh=3SINe8JfTHALqqHBMPjkcTJoipNChpxQapcMINRSdlA=;
        b=ASoa4i2+uEQ0ejVnuRty9NirpKjtWbqsgG09aUBro70CRRILOZe2orWVzpA0oIj2e+
         dePgL+7fvbqvjqa9e0MBH5l/k4oHwKOPh8i8j/5Bwygfx1xI7p5JYpSmtWfPeHzR7kz9
         kMGaTg7qtigGcuXHx+C//ZP5ISXgInT5/Ja9f2Zq9619LjTik1+gQBcxhfKa0zJ0ZI1b
         H1hLGMh3Zkj+HBfXc9TUI1v6PZ9w6Kkt8tm7Zlk30b70btBkvyxgphCHWNIwNM8N8/RX
         mgrGOqrUf8+vyDRvPPopvW73kROn/DH6K3xRRoihtCf+M1fH3KnbhxihzMRxBYKlg8+G
         XiHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:sender:from:to:cc:subject:date:message-id:x-mailer
         :x-gm-message-state;
        bh=3SINe8JfTHALqqHBMPjkcTJoipNChpxQapcMINRSdlA=;
        b=L/GErIwt9eT1Ri8jreV9bsedS5fvK7yEJPTw00XQGEof0GiYp4PyoVEbVa3GuKbcU9
         uDEYkP9GtdyJ7cRdHwBL1AN0AOwS3OJWO+NiJqG1TdAboEIPxZziFJuT4+IfmDW238W/
         Gf73NiEzgEzmZQInZiPsVNowTdLn3ZllcWmfKhaj4sDSn0cFLXb/vZhwMlb4Q+sU1UuN
         xf6GMA8JCNyiSlhDskXkN4FIYJH5YqJs8X9//Ywunl6JP4lc8jv0s7jOnGhA8so9qHFS
         Eh3/RtquJC/8d0DNpckrol24fXyXTFkoi6MObNWfACsfsIV7bBDRqJbgei378U8/BqSn
         b+6A==
X-Received: by 10.112.14.6 with SMTP id l6mr2337468lbc.81.1359127743793;
        Fri, 25 Jan 2013 07:29:03 -0800 (PST)
Received: from localhost ([85.21.218.130])
        by mx.google.com with ESMTPS id f8sm708478lbg.2.2013.01.25.07.29.01
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 25 Jan 2013 07:29:02 -0800 (PST)
X-Mailer: git-send-email 1.8.1.1.10.g9255f3f
X-Gm-Message-State: ALoCoQmFAofFD0GYYaBEaQMSRBmd2iJIx9GYM7+p2jTUPJwDbXa+iQktBHir6Rm3E0ng4L9K+otG
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214559>

Let's try to involve Krzysztof Mazur <krzysiek@podlesie.net>
who have met the similar problem recently
(according to this thread http://thread.gmane.org/gmane.comp.version-control.git/208297/focus=208310)
I recitate myself:
>Well, as I understand "current" algorithm:
>1. It assumes that file is one-part email message
>2. Function searches non-ASCII characters in Subject header
>3. If none then it looks non-ASCII characters at message body
>
>my changes are to skip looking at message body of a multi-part
>message as it has parts with their own Content-Type headers
>
>The said above in details:
>1. To set flag when we meet Content-Type: multipart/mixed header
>2. After we processed all headers and did not found non-ASCII characters
>in a Subject we take a look at this flag and exit with 0
>if it is a multi-part message


>>I think your patch is wrong.  What happens when we see a Subject:
>>line with a non-ascii on it that causes an early return of the loop
>>before your new code has a chance to see Content-Type: header?
This function is used to determine "broken" (non-ASCII) headers (to be encode them)
The problem is if "Subject" is not broken, but message body contains non-ASCII chars,
subject is marked as broken and encoded again.

P.S.
To involved: the beginning of thread is here http://thread.gmane.org/gmane.comp.version-control.git/181743

Alexey Shumkin (1):
  send-email: Honor multi-part email messages

 git-send-email.perl   |  5 ++++
 t/t9001-send-email.sh | 66 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 71 insertions(+)

-- 
1.8.1.1.10.g9255f3f
