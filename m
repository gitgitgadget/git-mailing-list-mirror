From: David Jeske <davidj@gmail.com>
Subject: ephemeral-branches instead of detached-head?
Date: Mon, 12 Aug 2013 00:25:44 -0700
Message-ID: <CA+CP9O6on2NXo6o4_0NoULnT8sgUD3pvvkFZvCTM5xKb38qOeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 12 09:26:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V8mWL-0001iL-BK
	for gcvg-git-2@plane.gmane.org; Mon, 12 Aug 2013 09:26:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753265Ab3HLH0Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Aug 2013 03:26:25 -0400
Received: from mail-ob0-f182.google.com ([209.85.214.182]:44328 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752867Ab3HLH0Z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Aug 2013 03:26:25 -0400
Received: by mail-ob0-f182.google.com with SMTP id wo10so8574132obc.41
        for <git@vger.kernel.org>; Mon, 12 Aug 2013 00:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=DV6an7ACEBuWSC6DPsqYtpZvvqCcVWwxcdG053LUFkk=;
        b=Q/a10wmFl36xdBNFNwdLaUl9AGDOBgmwfC8VBCdulqpGpc4UbpMGaIskYGAnljh7br
         c6ezKVUUCL8F9f+LdmFzGM4rLqE3LSaX6UCtG6iipA+QFBN+fEKr794HL+yUsoVKqC12
         t5wCpCFQlljYlE2Vuyag92iJyR30vRcrsCGNY2Jwma0Db5AjkBhuBdfT6GJlw1udXxwY
         JEhvyrO9X9ajySE3SUv5v0xiz0EXYkehXgQUQiG3Li3BMEWjLdTy+7yZ2cwVzTCZxpU/
         9k5fupge7TzBeCftPVaQgiKOMxLNr1bFjRLXdDgbzV4GXSipCKkyww38MAXgOathmoRA
         U6ow==
X-Received: by 10.60.95.229 with SMTP id dn5mr17481482oeb.26.1376292384631;
 Mon, 12 Aug 2013 00:26:24 -0700 (PDT)
Received: by 10.60.120.65 with HTTP; Mon, 12 Aug 2013 00:25:44 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232163>

Has there ever been any any discussion of creating an ephemeral-branch
name mechanism, instead of using detached HEADs?

By ephemeral, I mean that a branch-name could be created which would
live only so long as it is the only named way to reach a ref or the
ref is in the working directory. Ephemeral branch names would be
local-only and would never be pushed.

For example, if one performed "git checkout 2c29d...", one would not
get a detached head-state, but instead would get an ephemeral branch
name similar to "etmp/2c29d...". If no changes were checked into this
ephemeral branch, it would disappear as soon as it was no longer in
the working directory. If any changes were checked in on this branch,
it would survive until (a) the ref is given a non-ephemeral branch
name, (b) the changes are merged, (c) the ephemeral branch is
deleted/discarded.

I'm asking about (and proposing) this mechanism, because it would
prevent refs from ever being "accidentally lost", such as occurs in
the following scenerios..

1) forgetting to branch a detached head before checkin
2) forgetting a head is detached before moving away from it
3) forgetting about checkins before a submodule update

Also, these "etmp/####" branches would serve as an obvious visible
reminder in the branch list that a change was checked in that should
either be merged, named, or discarded.
