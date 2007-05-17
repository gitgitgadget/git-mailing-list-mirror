From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGIT PATCH] Don't use patches/<branch>/current
Date: Thu, 17 May 2007 21:51:19 +0100
Message-ID: <b0943d9e0705171351j1a86a4f4ge0283c522a351645@mail.gmail.com>
References: <20070506150852.8985.98091.stgit@yoghurt>
	 <b0943d9e0705150856n771cb696h6e8225a0bbd5d43d@mail.gmail.com>
	 <20070515182549.GB17851@diana.vm.bytemark.co.uk>
	 <b0943d9e0705151301r7412109qd73a6008b888f8bc@mail.gmail.com>
	 <20070516071130.GB7453@diana.vm.bytemark.co.uk>
	 <b0943d9e0705160507h2b3c4a34xe9895d007c41d91a@mail.gmail.com>
	 <20070516194002.GA17805@diana.vm.bytemark.co.uk>
	 <20070516204029.GB17805@diana.vm.bytemark.co.uk>
	 <b0943d9e0705170543g4d8c7542p6b44a4e6fa54676a@mail.gmail.com>
	 <20070517145724.GA905@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Thu May 17 22:51:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HomwY-0007j2-Q3
	for gcvg-git@gmane.org; Thu, 17 May 2007 22:51:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755450AbXEQUvX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 17 May 2007 16:51:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755439AbXEQUvW
	(ORCPT <rfc822;git-outgoing>); Thu, 17 May 2007 16:51:22 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:29402 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754329AbXEQUvV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 May 2007 16:51:21 -0400
Received: by ug-out-1314.google.com with SMTP id 44so417307uga
        for <git@vger.kernel.org>; Thu, 17 May 2007 13:51:20 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XqxBVeWTWE/NjgRMvD60trkY/azU6C6B2rZ4l9SlxDVUQE2OjXc+uScHVZSWJ9eGKZDzVUNLdlLyujaFuL9jqKRj0ots82HZITKY5jSTbK7Ksut33Q5byHj8hJnro+4+uYYKMWT4y1BKcraQLuFQxpgn3qExlADOB3F3ghorNe0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nFsiDOimAnThV48OfwkYhG4zkU/6VYt/BfSc7DUkZp34eXSU/Xza0YNZe8Gq9DAlShCuNloxHOcciiPQBcFHcEV3atgpKJ/DPS5Hnc4ttR707LiMnn2dwVkGhgY/Vzzy4Ic2JwFHKDU1wZkQMw7HKnKBXPe+bzBXY0K+B6AuG3c=
Received: by 10.66.220.12 with SMTP id s12mr526702ugg.1179435080069;
        Thu, 17 May 2007 13:51:20 -0700 (PDT)
Received: by 10.67.27.11 with HTTP; Thu, 17 May 2007 13:51:19 -0700 (PDT)
In-Reply-To: <20070517145724.GA905@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47557>

On 17/05/07, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> The only possibility I can think of that might explain this is that
> some of your unapplied patches are attached to a place in the commit
> DAG that's far away from the branch head (e.g. you have rebased to
> some entirely different place since you last had them applied), so
> that "git-rev-list patch ^branch" outputs a large part of the commit
> DAG.

That's probably the case. I have patches that I haven't rebased for
months but I keep them in case they might be needed in the future.
That's the reason for the hide/unhide commands. Anyway, I'm not yet
prepared to give up my current workflow.

I haven't tried to understand your patch yet but the unapplied patches
will never be in a linear DAG similar to the applied patches. Because
of this, we need to keep their order in a file anyway and we might not
need to run git-rev-list (BTW, how do you preserve the unapplied
patches order with the DAG implementation?).

> Could you put counters in unapplied_patches() and
> sort_applied_patches() to see how many lines each of them reads from
> git-rev-list? The expected number (if it had taken just a little time=
,
> like it did for me) is a small constant times the number of patches i=
n
> both cases.

I'll do this tomorrow to confirm but that's probably the cause of the s=
low-down.

--=20
Catalin
