From: Chris Salzberg <csalzberg@degica.com>
Subject: Bug in git 2.1.0 when cloning to directory with same name as repository
Date: Tue, 23 Sep 2014 16:49:55 +0900
Message-ID: <CAMoD=Bi41mB3QRn3JdZL-FGHs4w3C2jGpnJB-CqSndO7FMtfzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 23 09:50:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XWKrI-00042u-OP
	for gcvg-git-2@plane.gmane.org; Tue, 23 Sep 2014 09:50:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754022AbaIWHt5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2014 03:49:57 -0400
Received: from mail-wg0-f45.google.com ([74.125.82.45]:59420 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753080AbaIWHt4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2014 03:49:56 -0400
Received: by mail-wg0-f45.google.com with SMTP id x13so3366521wgg.4
        for <git@vger.kernel.org>; Tue, 23 Sep 2014 00:49:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=MR0sa4/HlDaWhzKwe1V5cBJpEfl0EbGprYHzDozOJ00=;
        b=MqhNDSeen1ePs3uRPJFlroZ8TJRQerKSaX84BJiu0toBbiw+HT8EFawg0ftsdojEfC
         wKwXOGWXFTQC05kyG1dvbqJ0O6MzOLx86ZpLMDZ4jM8kclx4uxOfc8P2jVWWfB18TltV
         YxBwXIPa1X8hq5f/mUaINJtMi5yEEf6zhRzCJZ5jl47ayOjFOJZMbblQ7XLtdZIPI0e1
         qc2ZMYYuItp7ohNuhtg/RxVkhvjK7/95YOKVy0cOphObf9WiunDVVJbG2rSCxPqzyRrE
         sxvgrLqZDSJmysAfj1uzTCbLsBkli1cCuBJ2IBbNiwKjF2Lvc6ZipsTnIm4x+EYwQOyQ
         JvOw==
X-Gm-Message-State: ALoCoQlxUXk0+JJXR8P1nVr4dX2caYuBb0dnSxIz99t4Xhtgfrvvxq05Ss5qrZ5SUfwPsfwSIuM5
X-Received: by 10.194.232.232 with SMTP id tr8mr25974692wjc.21.1411458595071;
 Tue, 23 Sep 2014 00:49:55 -0700 (PDT)
Received: by 10.216.150.8 with HTTP; Tue, 23 Sep 2014 00:49:55 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257397>

I've found what looks like a bug wherein if you are using an ssh alias
for a git remote, and that remote has a dash in its name, and you
specify the target path as the name of the url itself, git complains
about refs not being valid packed references.

To reproduce, in git 2.1.0 and with a repository using ssh config and
which has a dash in the name, e.g.:

> git clone github:nixme/pry-nav "github:nixme/pry-nav"
Cloning into 'github:nixme/pry-nav'...
done.
  ror: internal error: refs/remotes/origin/master is not a valid
packed reference!
error: internal error: refs/tags/v0.0.1 is not a valid packed reference!
error: internal error: refs/tags/v0.0.2 is not a valid packed reference!
error: internal error: refs/tags/v0.0.3 is not a valid packed reference!
error: internal error: refs/tags/v0.0.4 is not a valid packed reference!
error: internal error: refs/tags/v0.1.0 is not a valid packed reference!
error: internal error: refs/tags/v0.2.0 is not a valid packed reference!
error: internal error: refs/tags/v0.2.1 is not a valid packed reference!
error: internal error: refs/tags/v0.2.2 is not a valid packed reference!
error: internal error: refs/tags/v0.2.3 is not a valid packed reference!
error: internal error: refs/tags/v0.2.4 is not a valid packed reference!
error: Trying to write ref refs/heads/master with nonexistent object
f0e17451f0bd508f408d4fdda97e3a131d11f696
fatal: Cannot update the ref 'HEAD'

The ssh config for github (not that it matters, but for completeness) is:

Host github
user git
hostname github.com

I have confirmed that if the repository url does not have a dash, this
works as expected. I have also downgraded to 2.0.4 and found that
again, this works as expected. Beyond this I have not narrowed the
scope.

For now, I've downgraded my version of git and so have not tested beyond this.

Chris Salzberg
