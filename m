From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: question: connecting to multiple remote svn projects
Date: Mon, 9 Nov 2009 13:43:46 -0500
Message-ID: <32541b130911091043k78ac009dmb49ecdb0beaa597f@mail.gmail.com>
References: <hd1nv2$79e$1@ger.gmane.org> <32541b130911061151q68ddcc58w209acf28c5eec2f@mail.gmail.com> 
	<hd8smd$79e$2@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Dave Rodgman <dav1dr@eml.cc>
X-From: git-owner@vger.kernel.org Mon Nov 09 19:45:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7ZDq-0007eU-7X
	for gcvg-git-2@lo.gmane.org; Mon, 09 Nov 2009 19:44:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751913AbZKISoB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Nov 2009 13:44:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751821AbZKISoB
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Nov 2009 13:44:01 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:58862 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751682AbZKISoA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Nov 2009 13:44:00 -0500
Received: by yxe17 with SMTP id 17so2799705yxe.33
        for <git@vger.kernel.org>; Mon, 09 Nov 2009 10:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=hwLG6g1JwU7clAbGvqXb1ujyeahMV4Yd0LYgD6n3C8I=;
        b=VXNzC2l/CPvE/ohNoeY3rYJI5fwwtfI6xhg2etJgW678/LEwuBDY2kpRFpIpsEYfLn
         qaGy/K6xEvyVimaeq4w/Zc4tPj1dDjh6j3RuXx5Et7cBHLMRtsAppqwPDi5dGUv/yuFK
         MqKJIeFlYX1IZMw5GUayjdGBSEBpdJQwApy9w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=COxRrl++LB5NcIpHuKIRrl/kWVdNUeYe0NEJcnys/o/fD5Pnl3eTDgxNX/kt1qHHFB
         y7jWJ1kbOZQaXwn+dPE/tcIuz4Qsuw5MmSA2hvXzgZDTAP6FfGMjG34X9CClmnvXheWx
         9rBO7I1jdicIta1GGtK4A3C1fAjNdJ9W0pmbs=
Received: by 10.150.107.4 with SMTP id f4mr13872562ybc.286.1257792246078; Mon, 
	09 Nov 2009 10:44:06 -0800 (PST)
In-Reply-To: <hd8smd$79e$2@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132506>

On Mon, Nov 9, 2009 at 5:59 AM, Dave Rodgman <dav1dr@eml.cc> wrote:
> As far as I can understand, git-submodule pulls in a specific commit,
> as does git subtree? I've experimented a little but with not much success.

Well, they both pull in a specific commit *and* all the history
leading up to it, although the two of them do it in slightly different
ways.

> I want "git svn rebase" (or some equivalent command, or series of
> commands) to update the contents of module1/work to the latest commit
> into this branch, and similarly "git svn dcommit" should also commit into
> module1, module2, etc. Basically, I want my working copy to have the same
> functionality as if moduleX/work was the actual layout in subversion. I'm
> using git as a client for a svn repository, rather than doing a one-time
> import. Is this possible?

Yes.  Both tools will work for two-way svn import/export, although
submodules will probably be a bit more convenient.

Essentially, you create one branch (and one git-svn remote entry) for
each svn subproject, and one branch for the combined project.  In the
combined project, your .gitmodules should use '.' as the submodule
repository path (since all your submodule objects are in the same
local repo).

Then you 'git svn fetch' to retrieve the latest from each svn project.

Then, in each submodule, you can 'git pull .. git-svn-branchname' to
get the latest stuff from git-svn for that branch.

Then, in the combined project, you 'git commit' to lock in those commits.

It's a little screwy, but it works :)

Avery
