From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] commit: Add -f, --fixes <commit> option to add Fixes: line
Date: Thu, 31 Oct 2013 13:28:44 +0700
Message-ID: <CACsJy8DVSpmmDw-jGJoJK171u5UeJR7GKPuX7QAK4=7yYn6n8Q@mail.gmail.com>
References: <20131024122255.GI9378@mwanda> <20131024122512.GB9534@mwanda>
 <20131026181709.GB10488@kroah.com> <20131027013402.GA7146@leaf>
 <526CA7D4.1070904@alum.mit.edu> <20131027071407.GA11683@leaf>
 <526E283A.1070801@alum.mit.edu> <CALKQrgfsk3fjyF77XL9+CPyJ_s-AfzkNAj4Eaj1LT-G0Ph=bfg@mail.gmail.com>
 <20131029020824.GE11861@sigill.intra.peff.net> <CALKQrge8T8R7roUUYyLcu_QnL1afeqTATOp+0n_OOsZZoJXF4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
	Josh Triplett <josh@joshtriplett.org>,
	Git mailing list <git@vger.kernel.org>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg KH <greg@kroah.com>,
	Linux Kernel mailing list <linux-kernel@vger.kernel.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Oct 31 07:29:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbllK-000732-Ax
	for gcvg-git-2@plane.gmane.org; Thu, 31 Oct 2013 07:29:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752284Ab3JaG3Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Oct 2013 02:29:16 -0400
Received: from mail-qe0-f52.google.com ([209.85.128.52]:47967 "EHLO
	mail-qe0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750855Ab3JaG3Q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Oct 2013 02:29:16 -0400
Received: by mail-qe0-f52.google.com with SMTP id w7so1493627qeb.11
        for <multiple recipients>; Wed, 30 Oct 2013 23:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=MarZf6fal/vh1d3qaxFyBrUyaNltDhKDyk98o5XoXbo=;
        b=fLYGVcxDewEDpZjZVMdgmCOCM4nvSfBuW2etxZhKChMRg2VGVmCF9/b/lNceLUOnOq
         SexVbtvjFFk4Td0ay2O5a+Y8HKj77Cto4TkME7ODEUn2bA1j3CCGcVUmfw76HhTz9u+8
         +Bxh8sN8+kDXa86Kkla9xwVO0FUwqVm+/8hdeyhx0GtTUKQTRUxSo+BLzaFYAzWZ8T4z
         9WWdUJKwo9EOswE7xhKu9NLfWvy/Z2ExYKbssTvMEFtGGChzHQXbcoZEB7eLY/qerBdP
         EPivUq8B7gYvdl7WSk2cYLeDRgFe8k+LJ++HjxIogxst+PJyjK6+tSSpx8x4vSAFBs+t
         bU4w==
X-Received: by 10.49.71.207 with SMTP id x15mr1794738qeu.49.1383200955037;
 Wed, 30 Oct 2013 23:29:15 -0700 (PDT)
Received: by 10.96.27.202 with HTTP; Wed, 30 Oct 2013 23:28:44 -0700 (PDT)
In-Reply-To: <CALKQrge8T8R7roUUYyLcu_QnL1afeqTATOp+0n_OOsZZoJXF4Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237078>

On Thu, Oct 31, 2013 at 1:12 AM, Johan Herland <johan@herland.net> wrote:
> Yes, we do lack a good infrastructure for managing Git hooks from
> multiple sources. It makes people afraid to use them, because they
> might conflict with hooks from another source. There are (off the top
> of my head):
>
>  - "personal" hooks ("I want this behaviour in my repo(s)")
>  - "project" hooks ("In this project we follow these conventions")
>  - "system" hooks ("This host runs gitolite (or whatever) which needs
> these hooks...")
>  - "default" hooks (Some of the core Git code could have be
> implemented as hooks (e.g. "--signoff"), but is instead put into core
> Git)
>
> Maybe if we solved that problem, we could actually make use of hooks
> instead of adding "code" to our git configs (by which I mean config
> directives that are flexible enough to encode all kinds of semantics
> and behaviors that are probably better expressed in real code...).

OK how about, if $GIT_DIR/hooks/something is a directory, then the
directory must contain a file named "index", listing all the hooks of
type "something". All the hooks in "index" will be executed in the
listing order. There could be directories inside .git/hooks/something
to help categorize the scripts, so project hooks stay in "project"
subdirectory and so on.

With this we could provide "git hook" command to manipulate hooks and
test out the new combination of hooks. We could even select what
scripts not to run for a particular run, say you don't want the s-o-b
hook active when you commit this thing, you could run

  git commit --exclude-hooks=pre-commit-msg/s-o-b

You could exclude hooks by pattern as well

  git commit --exclude-hooks="pre-commit-msg/projects/*"

Or run an unsinstalled hook just one time

  git commit --include-hooks=/path/to/my/hook

Hooks like "Fixes" may need input from the user. The hook could bail
out if the required input is not given. But it maybe a good idea for
git to check and reject before running hooks, if the input is not
specified (e.g. from command line). I guess those extra info has to be
in .git/config and be added to .git/config by "git hook" command,
unless we have some convention to express those without running the hook.

For old Git versions that does not support this scheme, as directories
usually have u+x, the hook directory should be mistaken as an
executable and rejected when executed (permission denied in my test),
which gives user a good warning that this repo should not be used with
this git version.
-- 
Duy
