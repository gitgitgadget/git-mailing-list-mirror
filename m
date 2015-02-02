From: =?UTF-8?B?UsOpbWkgUmFtcGlu?= <remirampin@gmail.com>
Subject: Re: [git-gui] bug report: "Open existing repository" dialog fails on submodules
Date: Mon, 2 Feb 2015 10:59:41 -0500
Message-ID: <CAMto89CHf4OT_S05SaRrVRZvF-PH2_6DrcEpdGiUfaRGutJQHw@mail.gmail.com>
References: <CAMto89Dvz-u+at4CPLGQRak4niOJk1trSCn2wQugLUnD1h=Fjw@mail.gmail.com>
 <CAFOYHZBpVf0Dk=aM3hbpVjwc-f_WtZx+Myaja6=V2KXCDijsQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GIT <git@vger.kernel.org>
To: Chris Packham <judge.packham@gmail.com>,
	Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Mon Feb 02 17:00:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YIJQ0-0002Mv-77
	for gcvg-git-2@plane.gmane.org; Mon, 02 Feb 2015 17:00:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754187AbbBBQAD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2015 11:00:03 -0500
Received: from mail-ob0-f176.google.com ([209.85.214.176]:37815 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753950AbbBBQAB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2015 11:00:01 -0500
Received: by mail-ob0-f176.google.com with SMTP id wo20so8652877obc.7
        for <git@vger.kernel.org>; Mon, 02 Feb 2015 08:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=X+3ewgqLR6643flsuiGaf9QgJNjfq0UDA+8KQHw2gqI=;
        b=PDWlqFmwxEfcAXHVG50SsosfKmWmY6hW5ju2K8QaIiC+Hi9fWJG1VnJpAfS9f9R3pp
         vrXJTVYjsL88RL5erRysJgtvm5dz/5V3PSUx+LggDrvYcAkxyoof9l9xrJ2H+ICv1zgk
         +vJW1g5aEpbgyfpkNUeqfJcLwLNZDjt+zBvjzrEIa7tZ5nbbENuaPc/u/8mfiybmsVHd
         a4M/ThcSl1wxRK+pX7IHO3qgKQ4i+u1+xaxvNDTiQr4cyFVLoin2CTxzSm4W4t/9e2Uh
         mkA4fBR318C1h86E54aEZBRG/JAcIvR+5HlTztS21RAj80ZJfjaw7JV2BAeEQq6y/Xl4
         VgTw==
X-Received: by 10.182.165.202 with SMTP id za10mr12188410obb.8.1422892801377;
 Mon, 02 Feb 2015 08:00:01 -0800 (PST)
Received: by 10.182.112.166 with HTTP; Mon, 2 Feb 2015 07:59:41 -0800 (PST)
In-Reply-To: <CAFOYHZBpVf0Dk=aM3hbpVjwc-f_WtZx+Myaja6=V2KXCDijsQA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263259>

2015-02-02 3:41 UTC-05:00, Chris Packham <judge.packham@gmail.com>:
> [...]
> But it actually looks like git rev-parse --resolve-git-dir $path needs
> to be run inside a git repository _any_ git repository, which seems a
> bit backwards to me.
> [...]

Indeed, looking at git-rev-parse(1), the correct option might be
--show-toplevel, which will print the cwd if it is the top-level of a
non-bare repository:

    cd $candidate && test $(git rev-parse --show-toplevel) = $candidate

or

    test $(git --git-dir=$candidate rev-parse --show-toplevel) = $candidate

Of course Git will resolve symlinks at this point, so $candidate has
to be resolved first for the equality to make sense.

Other solution is to parse the "gitdir: ..." format and recurse, which
is not exactly hard (provided you speak Tcl).
