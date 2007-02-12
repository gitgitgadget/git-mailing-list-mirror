From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: StGIT discards local commits on "stg pull"
Date: Mon, 12 Feb 2007 09:31:28 +0000
Message-ID: <b0943d9e0702120131r528fb29ete143b8ce5a0a99e9@mail.gmail.com>
References: <20070212022625.rvyyo0kc0wowgogc@webmail.spamcop.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Yann Dirson" <ydirson@altern.org>
To: "Pavel Roskin" <proski@gnu.org>
X-From: git-owner@vger.kernel.org Mon Feb 12 10:31:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGXXJ-0002Wg-RM
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 10:31:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964826AbXBLJbb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 04:31:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964818AbXBLJbb
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 04:31:31 -0500
Received: from wr-out-0506.google.com ([64.233.184.239]:7608 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964826AbXBLJba (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 04:31:30 -0500
Received: by wr-out-0506.google.com with SMTP id i21so1648021wra
        for <git@vger.kernel.org>; Mon, 12 Feb 2007 01:31:29 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=f7Foo0nryUPIKlX6Gk8xAvFrB9Qby3Yoo/Xi2zJM/S4zpoOtZW7YAoNql4X0dqR1dRMAAz1u1ZYx+HY+pad39YtYJEDDvbufgAQN02p0i93GX6+O3mUnD26egnOGVSBpy2w86cSrM+rBifRnfjDS+EFxo51cC8JC8e2hRsDzKcQ=
Received: by 10.114.182.1 with SMTP id e1mr6633778waf.1171272688876;
        Mon, 12 Feb 2007 01:31:28 -0800 (PST)
Received: by 10.115.110.12 with HTTP; Mon, 12 Feb 2007 01:31:28 -0800 (PST)
In-Reply-To: <20070212022625.rvyyo0kc0wowgogc@webmail.spamcop.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39387>

On 12/02/07, Pavel Roskin <proski@gnu.org> wrote:
> I have been bitten by a strange bug/feature of StGIT, and it looks like
> it's not only counterintuitive, but also inconsistent with git.
>
> I have a repository available over ssh and I push to it from several
> places. Sometimes I make a commit and forget to push it.  Then I run "stg
> pull" to make sure my repository is up to date.
>
> The result is that the repository is rebased back to the last remote
> commit. It's very easy to miss.  There is no warning.  Everything looks
> just like an update from the remote.
>
> The example below shows that git-pull keeps my commit, but "stg pull"
> discards it by rebasing back to the remote ID.

I think this is a "feature" but we should've probably leave the
original behaviour as the default. Maybe we should also have this
per-branch rather than per-repository.

In StGIT 0.12, git-fetch is used by default rather than git-pull and
StGIT performs the rebasing. We had some discussions on whether this
would break existing workflows and we thought it wouldn't (I don't
usually mix git-commit with stg commands).

The solution would be to define the following in your gitconfig file
(either ~/.gitconfig or .git/config; a full example in StGIT's
examples/gitconfig):

[stgit]
	pullcmd = git-pull
	pull-does-rebase = no

The last line would tell StGIT not to do the rebasing and let git-pull
handle it.

I agree that for the rebasing case, we should have some warning if
fast-forwarding of the stack's base is not possible so that you could
run 'stg uncommit'.

-- 
Catalin
