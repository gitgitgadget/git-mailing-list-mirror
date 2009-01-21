From: Jonathan del Strother <maillist@steelskies.com>
Subject: Merging adjacent deleted lines?
Date: Wed, 21 Jan 2009 19:20:50 +0000
Message-ID: <57518fd10901211120n62f8d0e9ya8595fc9baa6476c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jan 21 20:22:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPieY-0007Ba-5Y
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 20:22:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750939AbZAUTUy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2009 14:20:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbZAUTUx
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 14:20:53 -0500
Received: from fg-out-1718.google.com ([72.14.220.153]:25223 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750750AbZAUTUw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2009 14:20:52 -0500
Received: by fg-out-1718.google.com with SMTP id 19so1880593fgg.17
        for <git@vger.kernel.org>; Wed, 21 Jan 2009 11:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:date
         :x-google-sender-auth:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=KMnP71w4cB6Azx8KkzVgbfpzNbcvVJm60JrnQZ+ERPo=;
        b=gbmKCtSa+wkN6AllBiPC4FBgd1v42eIb6Zi35eaumD8v2h9tCxkWQXIOlxsf9EgjiQ
         3s0VLKcTwmSiGVpz2Tac5xMc3OMtlM1ijU079T7eFNGo2pQ1f9kO0rQ6o3xw0oQhZozT
         QJUaSUQhGjj3V16xP5SRFPEfGbvNJ0kYEGbn8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        b=OcPtNNRzMJgrHSI6SSm0uWZ2FUD9wer9w5jRtIISD1iosLb9EwKBdh3PH//vGvLtPE
         C1pbNSOW5o/q3E0o+1qJeyNW+3aqAeptqIYmiMDBJkMNvQeo+w4y5B91go2LZj7ID5RY
         bjfgub1H08lu4msozRRqqGaObzQT+BroI9zN4=
Received: by 10.223.113.193 with SMTP id b1mr3021828faq.78.1232565650494; Wed, 
	21 Jan 2009 11:20:50 -0800 (PST)
X-Google-Sender-Auth: 4c6311ccb9300ac5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106652>

Say I have a file that started out with the following content :

line1
line2
line3
line4


I create a branch, which deletes line2.  Someone else's branch deletes line 3.

When I merge those two branches, the conflict looks like :

line1
<<<<<<< HEAD:lines
line3
=======
line2
>>>>>>> SomeoneElse:lines
line4



Which in my cursory overview, looked an awful lot like the obvious
merge resolution ought to be

line1
line3
line4

After all - I know I want to delete line 2, and wasn't aware of the
other person deleting line 3.

It was only later that we discovered that the merge was broken and
both lines should have been deleted.  Thinking about it, I guess that
the conflict if the other branch _hadn't_ deleted line 3 would have
looked something like

line1
<<<<<<< HEAD:lines
=======
line2
>>>>>>> SomeoneElse:lines
line3
line4

 - which wouldn't have resulted in a conflict anyway.


So, it looks like I need to be way more careful when merging
conflicts.  Which leads me to - what tools do you use when studying
conflicts like that?  git blame seems the obvious one, for getting the
context of each deletion, but it seems like I need to run it once as
git blame HEAD lines, and once as git blame MERGE_HEAD lines.  Is
there something a little more integrated for comparing the origin of
each change from both merge branches simultaneously?

Would welcome any thoughts on how you guys approach conflict-resolution
-Jon
