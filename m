From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH v14 01/16] test: add test cases for relative_path
Date: Tue, 25 Jun 2013 15:02:48 +0800
Message-ID: <CANYiYbErGwRFHk=_d42ffMBAzHVKR=ytyDt5Ki9b4Bp-tFYgjQ@mail.gmail.com>
References: <cover.1372087065.git.worldhello.net@gmail.com>
	<85c9aa4d05dba4320a7cc85eae7570e0f450e58e.1372087065.git.worldhello.net@gmail.com>
	<7vli5z8ha0.fsf@alter.siamese.dyndns.org>
	<CANYiYbEK-vc2h64rfNDL5k5yhRsxQR=8xtNJJQwUXmyVHH4Cng@mail.gmail.com>
	<7v38s66b3i.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Git List <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 25 09:02:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrNHC-0000Vg-2p
	for gcvg-git-2@plane.gmane.org; Tue, 25 Jun 2013 09:02:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751592Ab3FYHCu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Jun 2013 03:02:50 -0400
Received: from mail-wi0-f174.google.com ([209.85.212.174]:61114 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751028Ab3FYHCt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Jun 2013 03:02:49 -0400
Received: by mail-wi0-f174.google.com with SMTP id k10so414470wiv.7
        for <git@vger.kernel.org>; Tue, 25 Jun 2013 00:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=aWdE4U3tnETR7pWDFu7FN5RgA6Jzj2TP7vqnbJ2BUao=;
        b=UjwAHoiwHrJgh3hSYNmxZqVoqiwVaL6pKc4dp+4sq6isLIRGPcr9KiBrUCDWzMSsN+
         1AtQ6gW4QxmId7rNsT+BjE7AOIBHHaMx29xLMgFaIDspgSs/mbDB7LSpk7bA31ZW03A/
         Q4be22pWTk2PwQv0KgpUBvwVTiJz6jzkkU0L0RjQas5yx+Xhyxvtkr+9gCdEhBvgyaSp
         PHbK/PU5M0RIVX9ZHjEQLRddWuLTfIiWhyBzSR7U+YMXi+oVtJmuA274mZgZZChw7IQN
         71S9XHvjCzs2zLMoynWq/SYEFZZ07VHljTdGhJ1HNZH48cdI6SBvMqRYbITNAWWhpxZN
         lbFw==
X-Received: by 10.194.249.129 with SMTP id yu1mr19465540wjc.10.1372143768557;
 Tue, 25 Jun 2013 00:02:48 -0700 (PDT)
Received: by 10.194.176.129 with HTTP; Tue, 25 Jun 2013 00:02:48 -0700 (PDT)
In-Reply-To: <7v38s66b3i.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228945>

2013/6/25 Junio C Hamano <gitster@pobox.com>:
>> Add prefix _ to workaround the absolute path rewritten issue in
>> msysGit is interesting, but these test cases have already been
>> tested in Linux, right?
>
> The most important thing is what we want to test in these tests.
> The special test program is to try running the underlying
> relative_path() by driving it directly, but the only real caller is
> in setup_work_tree(), where two return values from real_path() is
> compared.  On POSIX systems, we know we are feeding paths that both
> begin with /.  Now, on Windows systems, what do we get back from
> real_path()?  C:\git\Documentation?  /git/Documentation?
>

Confirm that on Windows real_path() returns absolute path in
Windows style, such as: C:/msysgit/git/.git

> Unlike relative_path() used in setup.c:setup_work_tree(), for
> path_relative() from quote.c, IIRC, the expected inputs are both
> full pathnames within the working tree.  A typical question the
> callers to this function asks is like "The current directory
> obtained from prefix is the Documentation/ directory and we need to
> show that compat/mkdir.c is modified, relative to the current
> directory.  ../compat/mkdir.c is what I want to show."  So in that
> sense, it does not matter if /a/b/c is given as /a/b/c or C:\a\b\c
> as we do not care the leading common part (either / or C:\) very
> much.  On the other hand, the test vector you preoared in the first
> test that all begin with / may not be very useful to make sure that
> the function behaves the same way before and after your rewrite.
>

Yes, I should add more test cases without the leading '/'.

-- 
Jiang Xin
