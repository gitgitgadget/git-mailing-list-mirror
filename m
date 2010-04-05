From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: How to keep different version numbers in different branches?
Date: Mon, 5 Apr 2010 14:51:35 -0400
Message-ID: <y2i32541b131004051151v8f4b8774q360c04ecdb046778@mail.gmail.com>
References: <hpcscv$umg$3@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Stephen Kelly <steveire@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 05 20:52:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyrP6-0005Lg-4L
	for gcvg-git-2@lo.gmane.org; Mon, 05 Apr 2010 20:52:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756181Ab0DESv6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Apr 2010 14:51:58 -0400
Received: from mail-yx0-f191.google.com ([209.85.210.191]:38733 "EHLO
	mail-yx0-f191.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755879Ab0DESv5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Apr 2010 14:51:57 -0400
Received: by yxe29 with SMTP id 29so2214023yxe.4
        for <git@vger.kernel.org>; Mon, 05 Apr 2010 11:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type;
        bh=6M6vYfDQpU8DnBL8HYa0aWciUxSUr8tiu3+FYL0dS0U=;
        b=P8kNktJM4sFUbgbE/GwSHZ0LTRwQVYrMN8xMBW3Doqf1vrvUTqnl+d9FvN7FuJOq5y
         6y2wd9MeKTSgb5s418znQN1dMSUre4JTlKdexMtgEqoPO71J0QGW49yEwrIM2isvcgvJ
         YAl/QWhNQJnoUvVwrqBxRmPA45hQFyc4admS0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=kUR51hmmGT+/26eczUakY1qZ3bEfBvNPMkOFISnJuC3uZD2tIrtuLivPfK/9TAdKX5
         9/tuAZRTnOoNHF8LcBjMeF5S0aywye+MHfweHcdT0xKBcomv+zgjSR3lJ/p+Hj4RSGMa
         0n8lCTIRMfejeNo1dS6PT4xOGTM2Zps8bDz3M=
Received: by 10.150.199.19 with HTTP; Mon, 5 Apr 2010 11:51:35 -0700 (PDT)
In-Reply-To: <hpcscv$umg$3@dough.gmane.org>
Received: by 10.150.193.14 with SMTP id q14mr6934408ybf.140.1270493515641; 
	Mon, 05 Apr 2010 11:51:55 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144045>

On Mon, Apr 5, 2010 at 10:34 AM, Stephen Kelly <steveire@gmail.com> wrote:
> I want to make a 0.1 release, so that would mean creating a 0.1 branch and
> updating files contained in the branch such as the README file and the CMake
> files and the api documentation to report version 0.1.0, and creating the
> 0.1.0 tag. The next tag on that branch would be 0.1.1 etc. Simultaneously,
> the version number in those files is changes to 0.2.0 in the master branch.
>
> However, now I have changes in my maintenance branch (0.1) which should not
> be merged into master (that is, the commits which change the version
> number).
>
> How are you supposed to handle that with git? Simply merge and resolve the
> conflict on master by keeping its version number? Am I missing some other
> way of doing it here?

I've used that method.  it works fine, and the conflicts are only
whenever the maintenance branch version number changes, which is very
rare (and easy to see).

As someone else suggested, doing it the way git.git does (using
essentially 'git describe HEAD') is another method, though you then
depend on having your source code built from the git repo unless you
do even fancier stuff (like git.git does).

> Additionally, I have some stuff currently in master that should not be in
> the 0.1 release, but should be in the 0.2 release. If I branch and then
> remove those files from the 0.1 branch, a merge will then remove them from
> master too? How do I keep them on master but delete them on 0.1 and still be
> able to merge from 0.1 into master?
>
> The only option I can think of are to do the merge, then revert the commit
> sha on master that does the delete.

That method will work fine.  You could also squash the revert commit
into your merge commit if you want, so that you never have a commit on
master that has the unwanted changes.  (That'll help when bisecting.)
To do that, just revert using "git revert -n", then commit it with
"git commit -a --amend".

Have fun,

Avery
