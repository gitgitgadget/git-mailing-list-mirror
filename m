From: "Jay Soffian" <jaysoffian@gmail.com>
Subject: Re: Which freedesktop.org "design flaws" in git are still relevant?
Date: Fri, 29 Feb 2008 17:40:36 -0500
Message-ID: <76718490802291440x60896c93i26d8d0c2cf5678b2@mail.gmail.com>
References: <51419b2c0802291232w166b3100yabd30ba30df6ef1f@mail.gmail.com>
	 <m3hcfrjwnk.fsf@localhost.localdomain>
	 <alpine.LNX.1.00.0802291614230.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Jakub Narebski" <jnareb@gmail.com>,
	"Elijah Newren" <newren@gmail.com>, git@vger.kernel.org
To: "Daniel Barkalow" <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Fri Feb 29 23:41:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVDv4-0002sG-4r
	for gcvg-git-2@gmane.org; Fri, 29 Feb 2008 23:41:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759647AbYB2Wki (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Feb 2008 17:40:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760054AbYB2Wki
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Feb 2008 17:40:38 -0500
Received: from wa-out-1112.google.com ([209.85.146.181]:64903 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759647AbYB2Wkh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Feb 2008 17:40:37 -0500
Received: by wa-out-1112.google.com with SMTP id v27so5006924wah.23
        for <git@vger.kernel.org>; Fri, 29 Feb 2008 14:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=3DuqP9+10hxUhb0OOnWsb3EgY7c/NBvFlR73ferq0U8=;
        b=sRlAkB3CZaUVjsBOueq5+c9PsOqqBJvlGv6PPoTTP7/zaVN3Zg6tf2xkovuEbLklgsEA1+q2PHKa4fAfm9MsKU5oxR8zCxTxqGhQZ4nl3+AXx70OVkD6KJ0PXYSH4SrObUkrJNAG/m55/1/ks1oy5l1iIbuUcMsD2RfOcW54rDI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sRgKaM4nOUoRPTugYRT6hlXBK7oJXXPgTV4unanYbrLS60xQBuYqoRO1DCwCKGLJpDOu/Yq3jv4UUSmdEIMhSzKOjgnoF0ogz9FT4j7M4bF701Z3lvNc10PKoLfcBx1iWWRdyHxkKq1P8r0v1fSEIcWpVpL77e8SPzbknv1iDcc=
Received: by 10.115.47.1 with SMTP id z1mr283127waj.117.1204324836118;
        Fri, 29 Feb 2008 14:40:36 -0800 (PST)
Received: by 10.114.13.5 with HTTP; Fri, 29 Feb 2008 14:40:36 -0800 (PST)
In-Reply-To: <alpine.LNX.1.00.0802291614230.19665@iabervon.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75582>

On Fri, Feb 29, 2008 at 4:58 PM, Daniel Barkalow <barkalow@iabervon.org> wrote:

> I wonder if it would be nice to have per-branch aliases, so that you
> could have "git update" do whatever is appropriate to update this
> particular branch, whether it be "git pull --no-commit" or "git reset
> --hard origin/next && git merge" or "git rebase".

Well, you effectively have this via
branch.*.{merge,mergeoptions,rebase,remote}. e.g.:

To effect fetch + non-committing merge:

  branch.<name>.remote        = origin
  branch.<name>.merge         = refs/heads/<name>
  branch.<name>.mergeoptions  = --no-commit

To effect fetch + rebasing:

  branch.<name>.remote        = origin
  branch.<name>.merge         = refs/heads/<name>
  branch.<name>.rebase        = true

(Not sure if there is a way to get "rebase -m" though...)

To effect reset --hard origin/next, add another fetch line to your
remote. e.g.:

  [remote "origin"]
    url = git://git.kernel.org/pub/scm/git/git.git
    fetch = +refs/heads/*:refs/remotes/origin/*
    fetch = refs/heads/pu:/refs/heads/pu-readonly

Now "git pull" does the right thing whichever branch I'm on.

j.
