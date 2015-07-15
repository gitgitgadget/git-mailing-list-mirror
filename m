From: Junio C Hamano <gitster@pobox.com>
Subject: A few "linked checkout" niggles
Date: Wed, 15 Jul 2015 16:13:35 -0700
Message-ID: <xmqqoajdui8w.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 16 01:13:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZFVs0-00021D-QC
	for gcvg-git-2@plane.gmane.org; Thu, 16 Jul 2015 01:13:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753621AbbGOXNj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jul 2015 19:13:39 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:34560 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753556AbbGOXNi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jul 2015 19:13:38 -0400
Received: by iebmu5 with SMTP id mu5so44421105ieb.1
        for <git@vger.kernel.org>; Wed, 15 Jul 2015 16:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:user-agent:mime-version
         :content-type;
        bh=DeoY3dknPNo6XyinMkuBGla7KVHlr/85Dh/zuSVSKfc=;
        b=vUw3He91Iao455O76WY3+HKTe5ZdN3/h83Krntd79e7mwZKbvHHYaismBKLx7UOHch
         XutHYnVWOh36MC7HpyXqrLmzXEAw7anOsfeNB3fwnTMlPZlY+n3G4Hs2aZq51NrDdsbO
         8sn798kOHTua1YqhCSMuUaMfWxthKcIod6Yyt278ZH7JnuzWxAZEqgxA6+38W4Y1h9R1
         HxJcU83PKYyxnkrqgqVZmJwR59+ErSYKt04m+bi0uZhKx6oKbMSj6dkxRlve97uVVTIh
         98f7qD8RDHVblqwKai86NFqcQ939U+hw07o+iqddC4L+2Hz90a58KphCcNSmtcBBt1UQ
         UbWA==
X-Received: by 10.50.225.40 with SMTP id rh8mr608381igc.39.1437002018171;
        Wed, 15 Jul 2015 16:13:38 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:91d4:b530:378d:909b])
        by smtp.gmail.com with ESMTPSA id rr5sm127236igb.7.2015.07.15.16.13.36
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 15 Jul 2015 16:13:36 -0700 (PDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274001>

I've tried to set up a non-bare clone of git.git at ~/w/src and
attached one of its branches to a separate work tree at ~/w/rerere

 ~/w/src$ git worktree add ../rerere jc/rerere

Then I tried the "multiple checkout not allowed".

 ~/w/src$ git checkout jc/rerere
 fatal: 'jc/rerere' is already checked out at '/home/gitster/w/rerere/.git'

You see the first "niggle" above.  Do we need "/.git" at the end?
That is hopefully merely cosmetic and I am guessing that we can
unconditionally drop "/.git" from the end, but maybe there are
subtle reasons why it may not be a good idea (e.g. introduces some
ambiguities?)

There is another, a more serious one.

 ~/w/src$ git fetch ../git.git jc/rerere:jc/rerere

This succeeds, without checking if there is a work tree that has it
checked out.  I think the safety in "git fetch" that can be disabled
by "--update-head-ok" option should be updated to reuse the same
protection used by the updated "git checkout".

Something to work on for 2.5.x maintenance track, aiming for 2.5.1.

Thanks.
