From: "Nigel Magnay" <nigel.magnay@gmail.com>
Subject: Re: git submodules and commit
Date: Wed, 16 Jul 2008 12:02:19 +0100
Message-ID: <320075ff0807160402s7429291ela288b42d99c1ec53@mail.gmail.com>
References: <320075ff0807160331j30e8f832m4de3e3bbe9c26801@mail.gmail.com>
	 <320075ff0807160332k5e49c256tb4191de628ecf41c@mail.gmail.com>
	 <487DD1C7.3070701@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Johannes Sixt" <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Jul 16 13:03:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJ4n9-0001Q0-IA
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 13:03:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755450AbYGPLC3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 07:02:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755247AbYGPLC2
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 07:02:28 -0400
Received: from yw-out-2324.google.com ([74.125.46.28]:29247 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754074AbYGPLC2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 07:02:28 -0400
Received: by yw-out-2324.google.com with SMTP id 9so2711147ywe.1
        for <git@vger.kernel.org>; Wed, 16 Jul 2008 04:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=rQn42DpGzrBJJMWpPh5QuAFg8VcIJsieYvksCIK4HxE=;
        b=VbWEXonV3K4oaLjwFTLcJ55AV84X0Fxvzq60RPjY8XBWdPTPhCwAcriBBoNEvgbgum
         8AEhGJ6DWmWJ56CacvKoBc2+CekJPm+sGZSH7OOOEFEZtkQ4/9hw3m6lwvfYcZIBxdOp
         7rbaIWk72T72ELjd4W1UHrC/xhV2VuFwH6JhQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Q7JsxumypHg68WPrPLbc8wD2PrsYrxgP/1hTY+R00r2L2Z+7KkNxCwptqnz++eNKQN
         W3PfGHzdE1TeC0CrmbTuU2nhA2G1ZZUyYsASoqaa7p1MOuC+hPvlP8d6k0uNseH/yEJM
         qCl+jcBe79eWu29RBg/Mg/5EaB7EU3YNjTpOs=
Received: by 10.103.192.2 with SMTP id u2mr782871mup.45.1216206139574;
        Wed, 16 Jul 2008 04:02:19 -0700 (PDT)
Received: by 10.103.246.15 with HTTP; Wed, 16 Jul 2008 04:02:19 -0700 (PDT)
In-Reply-To: <487DD1C7.3070701@viscovery.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88668>

On Wed, Jul 16, 2008 at 11:47 AM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> Nigel Magnay schrieb:
>> For me, in some really high proportion of cases, I think I want 'git
>> commit' to mean 'commit to any child repositories, any sibling
>> repositories, and any parent repositories (updating the submodule sha1
>> as appropriate). In other words, 'pretend like the whole thing is one
>> big repo'.
>
> And I think that this is the problem: If this way of commiting your
> changes is *required* in the *majority* of cases, then you are IMO outside
> the intended use-case of submodules. You are better served by really
> making this one big repo.
>

Hm - then my contention is that the scope of submodules needs to be
expanded (or something needs to be built on top).

One-big-repo doesn't fly - > 75% of the code volume (the 'other'
modules) are shared between multiple projects. In SVN these are just
svn:externals (which has it's own imperfections).

I think it's a common usecase. You have 'shared' modules and
'project-specific' modules[*]. The 'shared' modules you hope don't
change very much, but they are part of the overall project
configuration - it's really nice that you can branch so easily in git,
then get the module owner to merge those changes into the next release
at their leisure. The superproject then represents the correct
configuration of submodule trees to make a valid build.

The machinery has everything that's required, it's just the user
experience sucks :(

[*] actually there's more subtlety, there's 'shared', 'product' and
'project', so some 'specific' modules are potentially re-shared
elsewhere.
> IMO, submodules are to be used if you can afford to advance parent project
> and submodules at different paces; i.e. if the parent project can work
> with newer versions of the submodules (and possibly in a degraded mode
> even with outdated versions).
>
> -- Hannes
>
