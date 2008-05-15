From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: Migrating a git repository to subversion
Date: Thu, 15 May 2008 19:19:13 -0400
Message-ID: <32541b130805151619y7dcb3812i1440ebbb0def98ad@mail.gmail.com>
References: <42dc968d0805151608q2ed89fc8madcd8d341a4ed1df@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Alf Mikula" <amikula@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 16 01:20:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jwmk3-0002Ka-Fm
	for gcvg-git-2@gmane.org; Fri, 16 May 2008 01:20:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752450AbYEOXTR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2008 19:19:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754662AbYEOXTQ
	(ORCPT <rfc822;git-outgoing>); Thu, 15 May 2008 19:19:16 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:23711 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751645AbYEOXTP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2008 19:19:15 -0400
Received: by fg-out-1718.google.com with SMTP id 19so500013fgg.17
        for <git@vger.kernel.org>; Thu, 15 May 2008 16:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=ftQlCnb0w2Kv+93ilLD12NxDCaCSp5MQm/hpLm85rOA=;
        b=dHZ7cMtMaVVD9kk/SBHVc+ucr0fQmgGCiF44HobDJmQSLtEjpfZtsaXLQ1NHGlsdlxAXrXRy233U6sMcX/gHPXuAkWEjvPlY2AjkHxOfbP53Z9bUGAje66E19A+NXvMr2oebAyQ5l9kJHDBzqoStzwfc/2kSaLPkXZDhk9dA/Ps=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WPgUoQpLDx7mskFJs/mwGgIMFsnJWx8RELzqRG3H9QSUQKCJUv9zRHZGM2UJgAsBbKiF3lAO+1fH8I0rzNq5ADzaAuCMIX5ro/tZjUG6vChGzvJu/krP6KtQBXULm6jK0VuXwoMwUzamyjeilpfhPO/ALuCdIoX6nTUD/qBrPoU=
Received: by 10.82.120.18 with SMTP id s18mr399911buc.82.1210893553367;
        Thu, 15 May 2008 16:19:13 -0700 (PDT)
Received: by 10.82.100.5 with HTTP; Thu, 15 May 2008 16:19:13 -0700 (PDT)
In-Reply-To: <42dc968d0805151608q2ed89fc8madcd8d341a4ed1df@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82241>

On 5/15/08, Alf Mikula <amikula@gmail.com> wrote:
>  1. Create a new, empty subversion project with trunk/tags/branches subdirs.
>  2. git svn clone http://myhost.com/path/to/project --stdlayout
>  3. git pull ../git_project
>  4. git svn dcommit
>
>  This put all my files into Subversion, but under a single commit. [...]

Step 3 created a "merge commit", which connected the (presumably, but
not necessarily, empty) repository from step 2 to the other one in
step 3.  git-svn doesn't know how to break apart a merge into its
parts (mostly because it's theoretically impossible to do in the
general case :)) so it just makes a single svn commit.

The way people usually deal with this when using git-svn is they use
"git rebase" to simplify their history and eliminate the need for
merge commits.  This makes git-svn much happier, but unfortunately
makes future git merging a bit more complicated.

Anyway, to answer your question: add a new step 3.5 that's something like:

  git rebase WHATEVER

Where WHATEVER is the name of the last commit git-svn created in step 2.

Have fun,

Avery
