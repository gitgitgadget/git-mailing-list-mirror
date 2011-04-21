From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [WRONG/PATCH 1/3] revisions: clarify handling of --no-walk and
 --do-walk
Date: Thu, 21 Apr 2011 16:30:14 -0500
Message-ID: <20110421213014.GB18418@elie>
References: <20110421102241.GA16185@elie>
 <20110421103926.GA16260@elie>
 <4DB02B24.4030503@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Pierre Habouzit <madcoder@madism.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Apr 21 23:30:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QD1SF-000428-LE
	for gcvg-git-2@lo.gmane.org; Thu, 21 Apr 2011 23:30:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754778Ab1DUVaV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Apr 2011 17:30:21 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:52164 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754722Ab1DUVaU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2011 17:30:20 -0400
Received: by gyd10 with SMTP id 10so38815gyd.19
        for <git@vger.kernel.org>; Thu, 21 Apr 2011 14:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=BWiEQFBYIqIB1zJhrEM22V9SAXr0FjqK2oXzahDFWA0=;
        b=ImaALYxNOu7bjUw2xJLg+VK2Ug4SsVyE/F6wYZ4P/wBuXvaa388R18Ds7C66vbgLRv
         tak4Wio9VwPPKGa/yqLyKQ9nDxOwPoSurFHLT5L82g9/NjmCpKiuAq0ZWNWLjOmbP+1L
         IhTmB8AcccFKJa6vfoSvn40GHj3vL8J+OFoNs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=c2lModf920HepAjoBftNejiVVltdMmfxF1B9F8Qg4VGwfq7bFcgeEh8uQNFQWm29tx
         1LAEz1yUIgePxPPt1uYWGmzdGjauP9zNXxsstHAnR98SNW2F6LLqN3733YqAk7cNvrWB
         07+h9Mjl3JbZghKQaDgOVS96RB8V3a7PAmHTc=
Received: by 10.151.145.17 with SMTP id x17mr847684ybn.411.1303421419799;
        Thu, 21 Apr 2011 14:30:19 -0700 (PDT)
Received: from elie (adsl-69-209-64-141.dsl.chcgil.sbcglobal.net [69.209.64.141])
        by mx.google.com with ESMTPS id p41sm2268834ybk.14.2011.04.21.14.30.17
        (version=SSLv3 cipher=OTHER);
        Thu, 21 Apr 2011 14:30:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4DB02B24.4030503@drmicha.warpmail.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171921>

Michael J Gruber wrote:

> This is not unrelated to the tip of gitster/mg/show-without-prune, i.e.
>
> 0c738b6 (builtin/show: do not prune by pathspec, 2011-04-01)

True.

> We should rethink the ui balance between deviating from the usual log
> option processing and the usefulness here.

Could you expand on that?  I think --no-walk being a positional
argument is just an ugly consequence of the code that permits

	git show -5 master
	git show maint..
	git show --do-walk master

while making sure

	git show master
	git show --do-walk --no-walk master

still show only one commit.  I'm not convinced it's meant to be useful
beyond that.

(Maybe "git log --no-walk maint..HEAD" should be an error because
meaningless, while "git rev-list --no-walk maint..HEAD" should be
accepted so people can continue write their own "git show"-like
commands.  Unfortunately the popular idiom of using git log
--format=... instead of

	git rev-list ... |
	git diff-tree -s --format=... --stdin

in scripts makes this porcelain-plumbing distinction more fuzzy than I
would like.)
