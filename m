From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC PATCH 00/12] Sparse checkout
Date: Thu, 24 Jul 2008 22:01:23 +0200
Message-ID: <200807242201.23991.jnareb@gmail.com>
References: <20080723145518.GA29035@laptop> <m3tzefvd3q.fsf@localhost.localdomain> <fcaeb9bf0807240358l6584c063u85179196bd6db30a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 24 22:02:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KM71F-0001w5-S3
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 22:02:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751872AbYGXUBe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 16:01:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751873AbYGXUBe
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 16:01:34 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:22770 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751855AbYGXUBd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 16:01:33 -0400
Received: by nf-out-0910.google.com with SMTP id d3so1160096nfc.21
        for <git@vger.kernel.org>; Thu, 24 Jul 2008 13:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=rEIVm8tzE93PQAC9YGxvkwIcMtd3jGuNeGAw5IURSvE=;
        b=wxEucD/SmMq2K8r2wfrVj70zB0LEg8mJaOPffJxNrW7I3YOGsbCQisRAY2B+Q+l0f9
         Bw8TUwIZMNWnoDM+yd+QoOyENI4BtloqQYZP2Ht4Kweg0synHup6+XczmHvEqBEsK6+I
         ArnAG1oWtEYnZJWW3zR71rKNz87a9q9Kxc2ks=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=xmTBW+VrHAjjE+16k/xKgrbJCdFUawEH038ZoUIJ6JoAH4WUF/eRopAkLBZTKIzfJ7
         dH+BF1WNKFdk0Hh0OiEVhw9gbGtCdB3aazT10Tnh/NTArscTe7kF7jh7TbSJaoaB++ol
         y2rzNG1LQ6CO88mO3MSFOZTsW7e4SkJ8p6Jec=
Received: by 10.210.141.4 with SMTP id o4mr850388ebd.59.1216929691430;
        Thu, 24 Jul 2008 13:01:31 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.208.47])
        by mx.google.com with ESMTPS id d24sm27070680nfh.39.2008.07.24.13.01.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 24 Jul 2008 13:01:30 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <fcaeb9bf0807240358l6584c063u85179196bd6db30a@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89952>

On Thu, 24 Jul 2008, Nguyen Thai Ngoc Duy wrote:
> On 7/24/08, Jakub Narebski <jnareb@gmail.com> wrote:
> >
> >  Second, I think you can simply special case .git* files (.gitignore,
> >  .gitattributes, .gitmodules), and always check them out for all
> >  intermediate directories (unless configured otherwise, of course).
> >  So for example if you have the following directory structure:
> >
> >   A/.gitignore
> >   A/a
> >   A/B1/.gitignore
> >   A/B1/b
> >   A/B2/.gitignore
> >   A/B2/c
> >
> >  and you are checking out only subdirectory 'B1' (and all files in it;
> >  if subdirectories are checked out recursively it depends on
> >  configuration), and if for example there is .gitignore in every
> >  directory, then checked out tree would look like this:
> >
> >   A/.gitignore
> >   A/B1/.gitignore
> >   A/B1/b
> >
> >  The ability to do this is one of advantages of 'sparse' checkout over
> >  'subtree' checkout.
> 
> Or teach git to use index version of those files. Or collect all those
> files, combine them and put the result to .git/info/exclude (and
> similar places). Anyway well organized repos won't have this problem.
> 
> Checking some files out as read-only (like this case) may be
> interesting. Though I do not how much complicated it can be.

I think teaching git to use index version of .git* files (.gitignore,
.gitattributes, .gitmodules) would be much more work than adding
default rule that .git* files in leading directories are by default
checked out, just like leading directories are checked out.  This
would limit modifying git code, I think, and chances for errors.

Having "leading" directories and files read-only would be a good idea,
I think.

I don't understand the sentence "well organized repos won't have this
problem". I think well organized repos _would_ have this problem,
because of maintained and distributed top-level .gitignore and
.gitattributes.

P.S. I hope that 'sparse checkout' feature would be ready for 1.7.0
-- 
Jakub Narebski
Poland
