From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC/PATCH 0/3] Thinning the git toplevel directory
Date: Sat, 19 Feb 2011 05:11:03 -0600
Message-ID: <20110219111103.GA1841@elie>
References: <7vmxm4onwk.fsf@alter.siamese.dyndns.org>
 <1297304069-14764-1-git-send-email-pclouds@gmail.com>
 <20110218022701.GA23435@elie>
 <AANLkTik8wUrUnjTiUxUZbg3paaQEc7UERQ6J6jUzA2u5@mail.gmail.com>
 <20110218092518.GB30648@elie>
 <7vei75p3zr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org,
	Nicolas Pitre <nico@fluxnic.net>, Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 19 12:11:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pqkid-0002IG-DO
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 12:11:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753997Ab1BSLLP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Feb 2011 06:11:15 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:61651 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753961Ab1BSLLN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 06:11:13 -0500
Received: by iyj8 with SMTP id 8so4351556iyj.19
        for <git@vger.kernel.org>; Sat, 19 Feb 2011 03:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=C4LEe1PTT5Bdn12L2uYja79iEF1T5Plfce3oOInEueQ=;
        b=aahuV16O6ay2iWA+fLa3k6nwUEB2fWfgQiKFhDbeCL7F4tZ1nnf+ADkzV7xq9yhIeV
         teWu/LjD+T93mavi65G28bQBK2efM/H3XNoVTjgOmFSPC/qLiQNkmBcM55p7znBn/EAD
         lV2ORSLMav8fhZLiiKyIHtksZTDvEV3ICLEYo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=l8yY8odjENzwzMvzAye0aHFs412tkrqM01ga33+8npwxttrC/7LlvKOllN3yk+0j1c
         w+pkYyBWAkueEmQE+VguS8AtuBEiNDikLtpoKcg71DwOQLQnwpaSh0c+q0oIijZSfgVa
         K1G+zxFKjfvU96GTtKVk6yw9UgnsF9ZV2oUn8=
Received: by 10.231.199.198 with SMTP id et6mr1330077ibb.13.1298113873156;
        Sat, 19 Feb 2011 03:11:13 -0800 (PST)
Received: from elie (adsl-69-209-72-148.dsl.chcgil.ameritech.net [69.209.72.148])
        by mx.google.com with ESMTPS id d21sm2722111ibg.9.2011.02.19.03.11.11
        (version=SSLv3 cipher=OTHER);
        Sat, 19 Feb 2011 03:11:12 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vei75p3zr.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167269>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>>  git://repo.or.cz/git/jrn.git flatten-source
>
> Huh?  Did you mean deepen or unflatten?

The branch name was unflatten-source.  Sorry about that.

I've pushed some more simple tweaks.

 - remove the ".sh" suffix from most build helpers
 - rename scripts/ to build-helpers/.  Much nicer.
 - rename libgit/ to lib/.  The shorter pathnames this allows are much
   nicer.
 - move compat/ under the lib/ umbrella
 - merge builtins/ with commands/.  It never was clear to me why
   making a command builtin should require changing its filename.
 - rename gitk-git/ to gitk/
 - rename t/ to tests/, to get a sense for what that feels like

Some remaining details:

>>  - moved the http support mini-library to http/.
>
> I don't understand the motivation behind this---wouldn't it belong to
> "libgit/" and if not why not?

They are not linked into the main git binary, to avoid a dependency on
libcurl and libexpat.  So it might (or might not) be useful to keep
them in a subdir to avoid tempting people to use those functions when
not appropriate.

lib/http/, with a README explaining their special status?

>>  - renamed git_remote_helpers to python/, though I'm not very happy
>>    about that.
>
> I am not fond of naming a directory after a language _unless_ the contents
> of the directory is _all_ about laying the foundation of something else
> that happens to be implemented in that language.

"git remote-testgit" uses it for
 - basic utility functions (die, debug, warn)
 - accessing a git repository and listing its branches (GitRepo)
 - running git fast-export (GitExporter) and keeping a marks file
   between runs
 - running git fast-import (GitImporter) and keeping a marks file
   between runs
 - maintaining a mirror of a non-local git repo (NonLocalGit) to
   be able to run fast-export from it

I am guessing a longer term plan is for it to acquire subpackages with
analagous functionality accessing other version control systems.  It
would be tempting to do

 other-vcs/
	bazaar/
	git/
	mercurial/
	subversion/

(intermixing C and Python code) but that doesn't work because it does
not match the structure of the git_remote_helpers package.

Side note: I am not sure I like the git_remote_helpers name.  Wouldn't
a good goal be for these modules to be usable by other VCSes'
import/export scripts, too?

Thanks for the comments.
