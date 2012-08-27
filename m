From: "Todd A. Jacobs" <nospam+listmail@codegnome.org>
Subject: 'git --grep' doesn't grep notes?
Date: Mon, 27 Aug 2012 14:18:29 -0400
Message-ID: <CAPRhCbvnRqUpKcw_E383ekG_M0O2a+cTTixUQtU-0mtj3V=7uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 27 20:18:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T63tV-0006PV-FK
	for gcvg-git-2@plane.gmane.org; Mon, 27 Aug 2012 20:18:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752922Ab2H0SSb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Aug 2012 14:18:31 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:49640 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752656Ab2H0SSa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2012 14:18:30 -0400
Received: by ialo24 with SMTP id o24so8774111ial.19
        for <git@vger.kernel.org>; Mon, 27 Aug 2012 11:18:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:x-originating-ip:date:x-google-sender-auth
         :message-id:subject:from:to:content-type:x-gm-message-state;
        bh=ONjeJiLy3HuBmG7mmjhShXDbreZCEZICzQAoeWpl7qw=;
        b=LcxRq5aZ2/xjKYgjEdT8yhJXvaKrUJ/BpAzkyefrjc4lCl4vtFkt+99I0Nz4IsmeAW
         ivcWe4oInbLoPAeLr4lOeVu/U1bVkwcLUqz0xHEZx0HcxUuoRHQbNdg450P6NfdUsxCs
         4NHUPPW0dEQQRRAJ1s5Y4gbaDGI2uyx50G7Ydlhe2gpSwP5jqyFA4oYHLTnTRyj3yAv8
         YKQCx0f03CWl2IdNjLEVzUBv9epoxinvAyhsBt3cJn+tuWfAi+4l4H0wAupPqXo/pJZy
         FKB6yQ4caI1MW4/nCWHmB1InAc6avScO5Nvxk1xSLt77rcPtrdodbTxiqRztDBbididd
         Yf+w==
Received: by 10.50.47.161 with SMTP id e1mr11064249ign.11.1346091509743; Mon,
 27 Aug 2012 11:18:29 -0700 (PDT)
Received: by 10.231.6.90 with HTTP; Mon, 27 Aug 2012 11:18:29 -0700 (PDT)
X-Originating-IP: [74.107.73.157]
X-Google-Sender-Auth: atncXEQdqeQA8GZcdLEmkkg3eMw
X-Gm-Message-State: ALoCoQkI3KGN8RI3wtErf+VDaBeqNFQbWw8s/q2F/3eHTCsXxhuvoF1GBGbtWncxohQMhAIWSuF0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204364>

I have a note attached to a commit, but the text of the note isn't
treated as part of the commit for the purposes of grep. For example:

    mkdir /tmp/foo
    cd /tmp/foo
    git init
    git commit --allow-empty -m 'Blank commit.'
    git notes add -m 'Find me!'
    git log --show-notes --regexp-ignore-case --grep=find

This doesn't match anything. Expected behavior is that this will match
the commit that contains "Find me!" in the notes.

As an example use case, consider ticket integration, where you may
want to add a ticket ID to a commit long after it's been pushed. You
don't want to rewind the branch, or push a rebase, so a note seems
like a sensible place to store a ticket ID. However, if the notes
aren't part of the commit, this will break integration with tools like
Pivotal Tracker that search the commits, and it will also require you
to use an external grep and some custom parsing to find related commit
IDs.

I'm sure there are other use cases. This just happens to be mine right now.

What is the right way to include notes in log searches, especially if
the end goal is to find the related commit ID?
