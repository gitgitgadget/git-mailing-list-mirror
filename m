From: "Eric Raible" <raible@gmail.com>
Subject: Bug? - Unexpected lock file error
Date: Fri, 5 Sep 2008 16:22:58 -0700
Message-ID: <279b37b20809051622q6b3ab37tec3f1726c71952e4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Sep 06 01:24:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbkfK-00053l-Jl
	for gcvg-git-2@gmane.org; Sat, 06 Sep 2008 01:24:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752651AbYIEXXA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Sep 2008 19:23:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752761AbYIEXXA
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Sep 2008 19:23:00 -0400
Received: from wf-out-1314.google.com ([209.85.200.173]:49594 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752651AbYIEXW7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Sep 2008 19:22:59 -0400
Received: by wf-out-1314.google.com with SMTP id 27so649195wfd.4
        for <git@vger.kernel.org>; Fri, 05 Sep 2008 16:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=Ld4h6AU6Ab4YqshyfOzM6PjZE+xfzXPgybRR0VHZha0=;
        b=mV+uqu/8DVAKYt0SyaQdY/tgKXs0MstQkyuI8GnDiohjfNCMCbJ1pVvIcL2FNq6wbC
         hSs/EX0kGB6ki0NQFvgSVMIpv0nPgb8l35JpUk6nFKxSTWnpVVaZGLVBla9SaWBP8RWO
         rxqzux+RFAI+JIRspu0kyTVq8q1+8MQQqaCDw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=pTe5/hwL5KzM4yYi3GVoMIj5bB6mdD06WQb5DPymASDYKz3lpGnZH16HmeMzapmKJk
         3YSsORqZo7epm1dpDqOiGif1a9iH3kZWv6VnGFHW0aQnLifEzYdcS4f+yBRmoogCkBZn
         BH/zHpMD0omzWhK7OYieDSXk2xPDmx9QlszyE=
Received: by 10.142.251.9 with SMTP id y9mr4274624wfh.46.1220656978474;
        Fri, 05 Sep 2008 16:22:58 -0700 (PDT)
Received: by 10.142.177.12 with HTTP; Fri, 5 Sep 2008 16:22:58 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95048>

In playing around with creating new unatached branches
I came across a seemingly bogus
"fatal: unable to create '.git/index.lock': File exists"
error message.

Now I understand that the final merge below is a no-op at best
but the resulting error message is less than intuitive.

This is in "git version 1.6.0.1.319.g9f32b.dirty"
(msysgit/devel, but I doubt that makes a difference).

Comments?

# Make a couple of versions of 'a' in main repo
mkdir foo
cd foo
git init -q
touch a
for i in a b c; do echo $i > a && git add a && git commit -q -m $i; done

# Make a new repo and push it into main repo (to make an unattached branch)
mkdir empty
cd empty
git init -q
git commit -q --allow-empty -m empty
git push .. master:empty

# Trigger "fatal: unable to create '.git/index.lock': File exists" error
cd ..
git merge empty

If 'empty' has any commits then the merge happens as expected.
Is this just another special case involving initial commits that I
should just get over?  Or is there something more substantive
going on here?

- Eric
