From: Chris Packham <judge.packham@gmail.com>
Subject: Fwd: Uninit'ed submodules
Date: Mon, 6 May 2013 12:19:26 +1200
Message-ID: <CAFOYHZDKTYFNRHUwdas7kZKs8UbdrY=hAA0SVqbz48NjWsHKww@mail.gmail.com>
References: <CAFOYHZCfL2uqnUkb=7kSdpudKvYrfMo9saJ8eNsj5mYDQgHVuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: GIT <git@vger.kernel.org>, Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon May 06 02:19:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZ99T-0000e4-9W
	for gcvg-git-2@plane.gmane.org; Mon, 06 May 2013 02:19:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751880Ab3EFAT2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 May 2013 20:19:28 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:55014 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751773Ab3EFAT1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 May 2013 20:19:27 -0400
Received: by mail-oa0-f46.google.com with SMTP id j6so3031232oag.5
        for <git@vger.kernel.org>; Sun, 05 May 2013 17:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:content-type;
        bh=rQ5lemEsbTdQNM+M62px99wJfhOmLrOtIyjlpDaykhY=;
        b=lxrAzoB+WZh4Q92njxnTR2LT5FyBeJxKbnA+YYS3KEt9KfuB5M0sy459vwqXmsK8zU
         rGuhJbQBSP67kRw4i9N5gin8v/v7j+60IHFvd9BdMMoRkZHma/mqf3bpgIjgLFisGvJF
         tnO1tcMKU+bW12yVuchmpG7aiB8nOGrXgMKTNnXJMxEybEMwToBsM1cB+qJvcXuZ4iAr
         JfyF2yHLJGRlEI6dhQnGQMcDM3j6aGP3xmnXhbO8v7g6FERJnBoBXF3K56Rfy4x0ScMk
         NFdiUPE2H6uWcE09wk0GW03fcUNDSqTradavFj5teq/B9Fk7T26WnZaWG3TkfuE+IMzX
         J9WQ==
X-Received: by 10.182.46.228 with SMTP id y4mr4963024obm.28.1367799566991;
 Sun, 05 May 2013 17:19:26 -0700 (PDT)
Received: by 10.76.129.84 with HTTP; Sun, 5 May 2013 17:19:26 -0700 (PDT)
In-Reply-To: <CAFOYHZCfL2uqnUkb=7kSdpudKvYrfMo9saJ8eNsj5mYDQgHVuA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223425>

Hi,

[Jens, sorry for the re-send - trying to convince gmail to send plain text.]

Just ran into a submodules usability situation at $dayjob that might
be worth looking at.

An internal maintainer was going to pull changes in from a project
team into our repository which is arranged into submodules for various
components. The maintainer decided that the best thing for him would
be to create a new working area to do the merging so he re-cloned the
super project (with default settings of git 1.7.9.5).

What he then forgot to do is "git submodule update --init" but because
the empty submodules were real directories he was able to continue
with what he thought was the right procedure of "cd submodule && git
pull project/submodule.git". He did notice the no changes in common
message and a whole bunch of unexpected modifications at which point
he grabbed me so no harm done.

This did get me thinking. Why does an uninitialized submodule need to
have an empty directory? If it didn't the maintainer in question
probably would have realized that he needed to run "git submodule
update --init" when his "cd submodule" command failed.

I'm guessing there is a good reason for the empty directory - perhaps
so that git can notice the fact that it exists in the worktree but is
out of date?  If it does need to have some presence in the worktree
why not as a file? That way the cd command would still fail (albeit
with a different error) providing the necessary indication to the
user. The submodule update --init could then change from file -> dir
when it actually gets populated.

Thanks for reading,
Chris
