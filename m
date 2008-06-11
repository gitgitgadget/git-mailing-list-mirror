From: "Nigel Magnay" <nigel.magnay@gmail.com>
Subject: Re: Project's repository infrastructure (sunbtree and submodules)
Date: Wed, 11 Jun 2008 19:42:33 +0100
Message-ID: <320075ff0806111142g83d5ad4s4737d49b8af2dbf4@mail.gmail.com>
References: <20080609194203.06698e01@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Armen Baghumian" <armen@opensourceclub.org>
X-From: git-owner@vger.kernel.org Wed Jun 11 20:43:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6VIU-0003C1-7N
	for gcvg-git-2@gmane.org; Wed, 11 Jun 2008 20:43:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757608AbYFKSmh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2008 14:42:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754772AbYFKSmh
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jun 2008 14:42:37 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:37791 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757596AbYFKSmg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2008 14:42:36 -0400
Received: by yx-out-2324.google.com with SMTP id 31so371280yxl.1
        for <git@vger.kernel.org>; Wed, 11 Jun 2008 11:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=itDCZFygFt60/ckRmd8XGAMiYaDhe+Fc9XsOODEv60w=;
        b=NNG0SuAA4Yjq0kegipbIXRBYB5AtMw19FT9UjTRnNqtrzwWT5URzmnar/NCKRTyGAe
         L/P8e8B8iYT/5N65Xt+QgblEZL+KYyf3qDYiAA3ZMpqyB1vgsUPOKTs1MavSv1HRDWnU
         Eb+Ps2lfRjSvorBfLG8EH6FurjJQKAc5mlgsY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=tQYWcyDJetPnm15Uiiv4in86zyu3PcFja34MKCp8HkqHxU81Ja1isP9GTUslqDxQfK
         +x+w24m6qAac6PFdVZI91nXqGjz5V7+rEJB8WTy5r+JKL43sBfey+2MFFgQ2n4huVOyF
         RSJkbdUAWpJRxNv5o/4IOUrXtk0h9RhwZHi1E=
Received: by 10.151.145.17 with SMTP id x17mr718144ybn.102.1213209753306;
        Wed, 11 Jun 2008 11:42:33 -0700 (PDT)
Received: by 10.150.217.18 with HTTP; Wed, 11 Jun 2008 11:42:33 -0700 (PDT)
In-Reply-To: <20080609194203.06698e01@debian>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84635>

On Mon, Jun 9, 2008 at 4:12 PM, Armen Baghumian
<armen@opensourceclub.org> wrote:
> Hi,
>
> I have several projects which each project contains several modules.
> modules are shared between projects.
>
> For example let say there is three modules A, B, and C, and two
> project called P1 and P2. P1 uses A and B modules and P2 uses B and C.
>
> I want to have centralized place to clone/pull/push in P1 and P2 and it
> would be nice to push changes in modules(A,B,C) from projects
> (P1,P2) so when changes in B pushed from P1 it could be pulled from P2
> (think B as a shared module between P1 and P2).
>
> As far as modules are not big enough I don't want to push changes
> directly in to those repositories.
>
> To solve the problem I just create three separated repositories for
> each modules (A,B,C) and create two other repositories for each project
> and use git-submodule to add modules in each repository.
>
> pushing changes to modules(A,B,C) are really error prone and annoying
> so I searched for a better way to solve that problem.
>
> Seems subtree merge[1] is other choice but I'm not sure.
>
> 1) What is best way to solve such situation?
> 2) If subtree is best choice how to push changes to modules(A,B,C) from
> projects?
>

What we do (and I'm not sure it's best - but it works for us), is as
you describe :- repositories for the modules A,B,C, and use those as
submodules in projects P1 and P2.

In each project P1, A, B there's a branch 'p1', and in each project
P2, B, C there's a branch 'p2'. That way changes can be committed to B
independently, and not conflict. The 'owner' of B is responsible for
merging back to 'master' (which is the basis for any future project
P3).

The git submodule commands are, however, quite verbose. There's a lot
of typing, especially compared to svn, and it's particularly annoying
for the user to update P1, and find A, B are no longer on branch p1,
but have been reset to (no branch). That said, the infrastructure is
there, it just needs someone to think for a bit to work out what
scripts would help most people's workflow (e.g : treat a superproject
as if the subprojects don't really exist).
