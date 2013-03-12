From: Phil Hord <phil.hord@gmail.com>
Subject: Re: [PATCH v4] submodule: add 'deinit' command
Date: Tue, 12 Mar 2013 11:39:40 -0400
Message-ID: <CABURp0pC2FELxM5aUwxuTqS1roZm+fwkCQA+BoXjrd0+yQMmbg@mail.gmail.com>
References: <5112C6F6.4030607@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Marc Branchaud <marcnarc@xiplink.com>,
	"W. Trevor King" <wking@tremily.us>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Mar 12 16:40:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFRJY-0004mc-H1
	for gcvg-git-2@plane.gmane.org; Tue, 12 Mar 2013 16:40:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932065Ab3CLPkD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Mar 2013 11:40:03 -0400
Received: from mail-ve0-f171.google.com ([209.85.128.171]:61640 "EHLO
	mail-ve0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755196Ab3CLPkC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Mar 2013 11:40:02 -0400
Received: by mail-ve0-f171.google.com with SMTP id b10so3593637vea.2
        for <git@vger.kernel.org>; Tue, 12 Mar 2013 08:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=A99/oiHy43lh3+H+rUcNJuoOo6gx6ZCnqLmZJ/GVl5w=;
        b=JZsL6KpWnlHal5e/iEc5NTnHybkjk7Quv++rDv540ZuIvN/oEPkxUz3v1WXAYcdg2n
         YVp7vxQhlOJFoH117dHCr6oonk7Dej9rUsexNnNA16/uEHepRRzrl9pVXA45JucKSoqQ
         OPnZWaPm1Ci6lz3I1bX2EtKktYpr2ivABEmcFt/d8BFGQmLMUXGez6khyFgHaAgwAXNh
         f2RQ2lSeR279WBcSg0B5LZfrKX6+wCJpjCYEzp9V6bg+cxnn4uya+Yvde+4Iw7Vel6c5
         qBVFjaghaylrvTKmchkD03LlJ91fXRBZD1BxxGUB7DZDxOgsMD93dQHEc9gt3bfDJBDC
         WFeA==
X-Received: by 10.52.68.116 with SMTP id v20mr5775842vdt.126.1363102801595;
 Tue, 12 Mar 2013 08:40:01 -0700 (PDT)
Received: by 10.58.201.103 with HTTP; Tue, 12 Mar 2013 08:39:40 -0700 (PDT)
In-Reply-To: <5112C6F6.4030607@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217967>

On Wed, Feb 6, 2013 at 4:11 PM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
> With "git submodule init" the user is able to tell git he cares about one
> or more submodules and wants to have it populated on the next call to "git
> submodule update". But currently there is no easy way he could tell git he
> does not care about a submodule anymore and wants to get rid of his local
> work tree (except he knows a lot about submodule internals and removes the
> "submodule.$name.url" setting from .git/config together with the work tree
> himself).
>
> Help those users by providing a 'deinit' command. This removes the whole
> submodule.<name> section from .git/config either for the given
> submodule(s) or for all those which have been initialized if '.' is
> given. Fail if the current work tree contains modifications unless
> forced. Complain when for a submodule given on the command line the url
> setting can't be found in .git/config, but nonetheless don't fail.
>
> Add tests and link the man pages of "git submodule deinit" and "git rm"
> to assist the user in deciding whether removing or unregistering the
> submodule is the right thing to do for him.
>
> Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>


Probably because I was new to this command, I was confused by this output.

  $ git submodule deinit submodule
  rm 'submodule'
  Submodule 'submodule' (gerrit:foo/submodule) unregistered for path 'submodule'

  $ git rm submodule
  rm 'submodule'


This line is confusing to me in the deinit command:

  rm 'submodule'

It doesn't mean what git usually means when it says this to me.  See
how the 'git rm' command says the same thing but means something
different in the next command.

In the deinit case, git removes the workdir contents of 'submodule'
and it reports "rm 'submodule'".  In the rm case, git removes the
submodule link from the tree and rmdirs the empty 'submodule'
directory.

I think this would be clearer if 'git deinit' said

    rm 'submodule/*'

or maybe

    Removed workdir for 'submodule'

Is it just me?

Phil
