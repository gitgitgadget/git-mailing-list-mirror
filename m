From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] t4202 (log): add failing test for log with subtree
Date: Mon, 22 Apr 2013 17:59:25 +0530
Message-ID: <CALkWK0nMgbZY7E-wPNj2C7W98Y4HtQ7Hss6uMKngajB5iJrjDw@mail.gmail.com>
References: <1366632487-28153-1-git-send-email-artagnon@gmail.com> <vpqa9oqpxx7.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Avery Pennarun <apenwarr@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Apr 22 14:30:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUFss-0007yX-T2
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 14:30:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753085Ab3DVMaI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 08:30:08 -0400
Received: from mail-ia0-f174.google.com ([209.85.210.174]:41160 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752806Ab3DVMaH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Apr 2013 08:30:07 -0400
Received: by mail-ia0-f174.google.com with SMTP id h23so697396iae.33
        for <git@vger.kernel.org>; Mon, 22 Apr 2013 05:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=UcIdYAsf8QvfMNojB+xNAi3JxT+XN7NJFy26v+dlCAk=;
        b=XmtWTRq4UitS1/d+JAhlkAwgoYQmaer7kWm/vqtbPZx+Qj/jqdNmuEAmq1wIveVdne
         kPpeqd/qmdxU+QkUUA0HUuBQcs/TCd/Cfy0kOdgvOQnLYkiY0UDfNTblPJ2WvH1FwucI
         TfeHRRQsiiQEB2CurCL8/yXvMMn75ZUc6fwgLJnpmUbXAay5ihLOg++5cOS0wged6pFV
         1Xqkaz3g0HPRP3n7Y+SK3CoWo8/Dlj9/62x8G79AQF2y3IIujmhih1JDqyRqQ6B4BFof
         cyzlclpj2NIYdGZijyYG0Ly859peAQIAIXSrCNhHnOYTbki2jxsfwWlRdSdheZYK2Izo
         RJ3g==
X-Received: by 10.50.50.71 with SMTP id a7mr21129841igo.14.1366633806194; Mon,
 22 Apr 2013 05:30:06 -0700 (PDT)
Received: by 10.64.63.48 with HTTP; Mon, 22 Apr 2013 05:29:25 -0700 (PDT)
In-Reply-To: <vpqa9oqpxx7.fsf@grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222009>

Matthieu Moy wrote:
> This is somehow expected: the subtree merge changed the filename during
> merge (it is subtree/file.txt after the merge, and just file.txt
> before), so "git log" without --follow just considers the file appeared.

No, a merge does not "change" any filenames.  The history of the file
is very much present: run a git log HEAD^2 to see the entire history
of the subtree.  Even a git blame (without -M or -C) works just fine.

> OTOH, I think this is a known limitation of "git log --follow" that it
> does not follow renames done by subtree merges.

Um, no.  I think --follow is entirely orthogonal to the issue: unless
I'm mistaken, it looks for other blobs in history with heuristically
similar content.

The real issue has nothing to do with log itself: it has to do with
how rev-parse handles pathspecs.  A 'git rev-parse
HEAD:subproject/README' works fine, but 'git rev-parse
HEAD^2:subproject/README' fails.  However, 'git rev-parse
HEAD^2:README' works, but it is assuming that the path README is
present in /, when it is actually present in subproject/.  Now, I'm
not sure rev-parse is doing something unexpected, which is why I filed
the bug in log.
