From: Armin Kunaschik <megabreit@googlemail.com>
Subject: t5601-clone.sh failures
Date: Mon, 9 May 2016 19:10:22 +0200
Message-ID: <CALR6jEhTTo-6fgy3_TnGseXJr2OZM+cK+t4BCVEzpCZNfhn5Bg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 09 19:18:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azohU-0004oz-Ml
	for gcvg-git-2@plane.gmane.org; Mon, 09 May 2016 19:10:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751049AbcEIRKX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2016 13:10:23 -0400
Received: from mail-yw0-f178.google.com ([209.85.161.178]:33204 "EHLO
	mail-yw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750974AbcEIRKX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2016 13:10:23 -0400
Received: by mail-yw0-f178.google.com with SMTP id t10so292742291ywa.0
        for <git@vger.kernel.org>; Mon, 09 May 2016 10:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to;
        bh=6KI3PW02Ku/H7is3hkrSp8BPBTBUSCCn9P13aijCRB4=;
        b=YdzXwHCaJ+HDDdBek1B5DOpJLBmGIFb5OB7j/ZglnoNcB4gA5F9O5XchkrZnClV48H
         Kk5cdga0x54KhAqddjvTyi7LXrHsWqxksJQ0HGHq9QFu8ixgnSA/89XMlkDoEbr48iPU
         2ceuGhu5Teaesha1kJESoOMZYixczFkt0xaCIpV+t8wlf4UA7IkFakcJkwJncbzfxn11
         TsBsf/4N1gHcyZhUn7WyQOxI6XnCbeERCdA2DBG6mtqioTJIGC00/bgVJuztUn4LPDx6
         0SRyJVdL3dCVEzO6+ligJnzSIC6sSP2i5gx7OnCSrPPWiO4JvpPADkwXFQ0qvok2oNx3
         N0bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=6KI3PW02Ku/H7is3hkrSp8BPBTBUSCCn9P13aijCRB4=;
        b=kHT5SXUr1C/f1UB7sgseiv+4272VsS1hmu2zQ/xurr2R1wVkfF59cV1mxyCNOXC9PX
         k7VM7MwwrKZbqlwcoUXdmwXR88jWKNpgl2jVDEKLmHBaZu5EE1oXDOM4m+qQ+5nstX9K
         qUmjbfz+kqt92CkWIHIp0b75aTpDUSnT0aLzBmAtI1Wz523jUdb5yAC5a3gkJI6RqlxP
         1tHibkt79oWcY1OlspHAMsWoR46A7y/LCG5Ls0keTrdpXNrJQCkdlCCmLajTNxlLR1ZQ
         PU59VlBqB987Cvqb7BvR4L0X5qqpfFp/Y70QwIJ58rBjo/zE9kkxTjCw9UX1L5fF92W2
         k9ww==
X-Gm-Message-State: AOPr4FUkJuBJPm0fWeLD+7ik3O19Kl9x8Tz0gpNEKk90k7HdpvsIg5SMMAevP+h9rK6Q8q0knDgg70dJzPFH+A==
X-Received: by 10.129.160.74 with SMTP id x71mr20284222ywg.131.1462813822054;
 Mon, 09 May 2016 10:10:22 -0700 (PDT)
Received: by 10.129.45.132 with HTTP; Mon, 9 May 2016 10:10:22 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294020>

Hi list,

eight t5601 tests don't run with my version of sed.
The reason is a trailing space in the sed expression. See below:

#IPv6
for tuah in ::1 [::1] [::1]: user@::1 user@[::1] user@[::1]:
[user@::1] [user@::1]:
do
        ehost=$(echo $tuah | sed -e "s/1]:/1]/ "| tr -d "[]")
        test_expect_success "clone ssh://$tuah/home/user/repo" "
          test_clone_url ssh://$tuah/home/user/repo $ehost /home/user/repo
        "
done

I can not imagine a reason why there should be a space character...
The tests run fine here without the space.
When there isn't any reason, the trailing space should be removed.

Armin
