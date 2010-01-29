From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] bash: support user-supplied completion scripts for
	user's git commands
Date: Fri, 29 Jan 2010 11:13:26 -0800
Message-ID: <20100129191326.GD22101@spearce.org>
References: <9b69cfcf1001290457s6b7fad6cs5a915f16a11f5782@mail.gmail.com> <20100129151127.GA21821@spearce.org> <7v4om4kdt3.fsf@alter.siamese.dyndns.org> <20100129175950.GE21821@spearce.org> <7vockciyb8.fsf@alter.siamese.dyndns.org> <20100129190642.GA31303@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	David Rhodes Clymer <david@zettazebra.com>,
	git@vger.kernel.org
To: SZEDER G?bor <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Fri Jan 29 20:13:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NawHi-0006bW-3K
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jan 2010 20:13:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754158Ab0A2TNb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2010 14:13:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753987Ab0A2TNb
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 14:13:31 -0500
Received: from mail-qy0-f182.google.com ([209.85.221.182]:63508 "EHLO
	mail-qy0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751239Ab0A2TNa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2010 14:13:30 -0500
Received: by qyk12 with SMTP id 12so1034315qyk.21
        for <git@vger.kernel.org>; Fri, 29 Jan 2010 11:13:29 -0800 (PST)
Received: by 10.224.66.220 with SMTP id o28mr537281qai.284.1264792409628;
        Fri, 29 Jan 2010 11:13:29 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 22sm1634849qyk.2.2010.01.29.11.13.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 29 Jan 2010 11:13:27 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100129190642.GA31303@neumann>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138340>

SZEDER G?bor <szeder@ira.uka.de> wrote:
> The bash completion script already provides support to complete
> aliases, options and refs for aliases (if the alias can be traced back
> to a supported git command by __git_aliased_command()), and the user's
> custom git commands, but it does not support the options of the user's
> custom git commands (of course; how could it know about the options of
> a custom git command?).  Users of such custom git commands could
> extend git's bash completion script by writing functions to support
> their commands, but they might have issues with it: they might not
> have the rights to modify a system-wide git completion script, and
> they will need to track and merge upstream changes in the future.
> 
> This patch addresses this by providing means for users to supply
> custom completion scriplets for their custom git commands without
> modifying the main git bash completion script.
> 
> Instead of having a huge hard-coded list of command-completion
> function pairs (in _git()), the completion script will figure out
> which completion function to call based on the command's name.  That
> is, when completing the options of 'git foo', the main completion
> script will check whether the function '_git_foo' is declared, and if
> declared, it will invoke that function to perform the completion.  If
> such a function is not declared, it will fall back to complete file
> names.  So, users will only need to provide this '_git_foo' completion
> function in a separate file, source that file, and it will be used the
> next time they press TAB after 'git foo '.
> 
> There are two git commands (stage and whatchanged), for which the
> completion functions of other commands were used, therefore they
> got their own completion function.
> 
> Signed-off-by: SZEDER G?bor <szeder@ira.uka.de>
> ---
> 
> How about something like this for subcommands (not aliases)?  It's a
> good code size reduction anyway.

Hmm, I like this.  I just didn't know how to implement it...  :-)

Acked-by: Shawn O. Pearce <spearce@spearce.org>

> +	local completion_func="_git_${command//-/_}"
> +	declare -F $completion_func >/dev/null && $completion_func

Yay for knowing bash.  :-)

-- 
Shawn.
