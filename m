From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: RFD: best way to automatically rewrite a git DAG as a linear 
	history?
Date: Thu, 18 Feb 2010 13:38:49 -0500
Message-ID: <32541b131002181038x26093e3em250b46b5a6e9d97c@mail.gmail.com>
References: <2cfc40321002171835j107d2cdcr5f7667d769bf391e@mail.gmail.com> 
	<20100218051129.GD10970@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jon Seymour <jon.seymour@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 18 19:39:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiBHV-0005J1-Hb
	for gcvg-git-2@lo.gmane.org; Thu, 18 Feb 2010 19:39:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754365Ab0BRSjQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2010 13:39:16 -0500
Received: from mail-yw0-f197.google.com ([209.85.211.197]:45008 "EHLO
	mail-yw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754149Ab0BRSjP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2010 13:39:15 -0500
Received: by ywh35 with SMTP id 35so1279923ywh.4
        for <git@vger.kernel.org>; Thu, 18 Feb 2010 10:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=zFOUWWSJQXRgfbnBTxisuFmcWTyVrqmfvWZ79xK+ajI=;
        b=o1fycAdKceO0tuqMVXlFy5LFfffwVt/oTEZCy1fmTVXGRAo3zLP4IZkLn1U/z14neB
         kFBk9CjSRK85ITGt7oAkieNgFENEvHO+NwK0SaRTVw/G5Ih/iJd/oG2nWf3t34mrP7jI
         rjR3eqtpxm5Csg8JwCj7tKWlvklrr8JnySOsI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=jFvUgxguOf8s945GORpSytDJjmbHFnotPeURB6BIt3Z8LFw2QEuTO/fcEJsAuc6udq
         5wDaiGBtbTLMVJ9ph6LEmz8YYb8gelwkA3wYxZrcAzXwDMFRd0IybYsndUd1LsjE/5az
         o0pswxXWxRAN5Vf/FPnjMirvb9yMDGoIumqsM=
Received: by 10.150.251.7 with SMTP id y7mr703444ybh.89.1266518350686; Thu, 18 
	Feb 2010 10:39:10 -0800 (PST)
In-Reply-To: <20100218051129.GD10970@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140359>

On Thu, Feb 18, 2010 at 12:11 AM, Jeff King <peff@peff.net> wrote:
> One simple strategy would be to squash all side-branch development into
> a single commit.

Something like this (replace MY_START_BRANCH with your starting
branch, and do this in a clone of your repository so you don't destroy
anything by accident):

        parent=""
        git rev-list --first-parent --reverse  | while read commit; do
                if [ -z "$parent" ]; then
                        git checkout -f $commit
                        git clean -fdx
                else
                        git diff $parent $commit | git apply --index
                        git commit -C $commit
                fi
                parent=$commit
        done

Have fun,

Avery
