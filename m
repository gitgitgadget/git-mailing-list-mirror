From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH] checkout: indicate when a detached head is checked out
 for a branch
Date: Fri, 18 Jul 2014 23:54:37 +0200
Message-ID: <1405720477.13250.8.camel@spirit>
References: <35dbe7e3f3e4566d775bea19d816adc44db8ed5c.1405676303.git.git@drmicha.warpmail.net>
	 <xmqqr41imuwk.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org,
	=?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= Duy 
	<pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 18 23:54:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X8G72-00073b-Pj
	for gcvg-git-2@plane.gmane.org; Fri, 18 Jul 2014 23:54:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934840AbaGRVyl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2014 17:54:41 -0400
Received: from mail-we0-f182.google.com ([74.125.82.182]:59579 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932112AbaGRVyk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2014 17:54:40 -0400
Received: by mail-we0-f182.google.com with SMTP id k48so3907342wev.41
        for <git@vger.kernel.org>; Fri, 18 Jul 2014 14:54:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-type:mime-version:content-transfer-encoding;
        bh=ZYxWiAeEKw7OLvc6r28HDhqp7p91ymJuLHzrg4mwTnI=;
        b=OayzS2ytKCDBZqybX6lp3t01jONahEGmpyUOX4BoyjqJhpiLbxoCVvTa19DdL6v9la
         TPhy+56CYb07FlUaTB8aqpbOyOnLE4TVXzhBAYDZ97lGohrlK2dbbJ6lrCyUQqFFPis9
         OxszIko1LxxJQUmdRM9wjtWvE2PUb7BltCJFSWD8rGZRrG3NX729oISgXVgejEdPCzEi
         MUOFr8/V53yRfEUJLwtvtMq2iDuN3ue2cloD7ZfYLzeiZlVZ3dyWRcAVTSqBHa68xz4w
         IN33Z/G6+XpAaMl/RrMbHqaGNKKmOFqeBZbKyNi5+g1f8vOzsHKOO1YhQR1AKjxelQKe
         OGvg==
X-Gm-Message-State: ALoCoQljfiUquo9mOamEW5wpXnzSQRO707qhO6zjD782DDHxLiqe15/dVFcZxERnC1TnoTUV3VcN
X-Received: by 10.180.211.71 with SMTP id na7mr34369647wic.55.1405720479383;
        Fri, 18 Jul 2014 14:54:39 -0700 (PDT)
Received: from [10.42.1.3] (195-240-45-142.ip.telfort.nl. [195.240.45.142])
        by mx.google.com with ESMTPSA id n2sm17116232wjf.40.2014.07.18.14.54.37
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 18 Jul 2014 14:54:38 -0700 (PDT)
In-Reply-To: <xmqqr41imuwk.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.10.4-0ubuntu1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253851>

On vr, 2014-07-18 at 10:36 -0700, Junio C Hamano wrote:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
> > I really like the new --to feature and will convert all my "new workdir"
> > checkouts to that. But that detached checkout is so easy to miss - in fact
> > I noticed it only when I compared "new-workdir" to "checkout --to" for a
> > test repo with one branch, to see what a converter would need to do.
> >
> > I'm even wondering whether we should do this DWIMmery at all, given how
> > "dangerous" a detached head is for those who are not aware of it
> > before gc kicks in.
> 
> As long as the amount of warning about 'detached HEAD' is about the
> same between this case and a "git checkout v1.2.3" in a normal
> repository, I do not think there is no additional "danger" you need
> to be worried about.
> 
> But I do agree that there should not be any DWIM here.
> 
> The reason to introduce this new set of rather intrusive changes is
> so that working trees can be aware of branches other working trees
> have checked out.  And the whole point of wanting to have that
> mutual awareness is to enable us to forbid users from mucking with
> the same branch from two different places.
> 
> But Git is not in the position to dictate which alternative action
> the user would want to take, when her "git checkout foo" is
> prevented by this mechanism.  In one scenario, she may say "I only
> wanted to take a peek" and run "git checkout foo^0" instead.  In
> another, she may say "Ah, I forgot I already was doing this change
> in the other one" and run "cd ../foo".  There may be other classes
> of alternative actions.
> 
> Don't make it easier for the first class of scenario and make it
> less useful and more dangerous for the second class, especially the
> second class involve forgetful users who are likely to forget seeing
> the "we've warned you that we detached without being asked" message.
> 
> Please fix it to always just error out.

I really would appreciate it if it wouldn't always error out. Erroring
out by default is fine, but please keep it overridable. 

My use case for this is checking out the same branch (or commit, so
already on a detached HEAD) in multiple different places to run
independent actions (e.g. make test with different compiler options, or
creating several different packages) and I would really appreciate it if
that would keep working.

-- 
Dennis Kaarsemaker
www.kaarsemaker.net
