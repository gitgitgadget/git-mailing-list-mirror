From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Fwd: Problem: git doesn't update working dir (always) when checkout'ing other branch
Date: Mon, 21 May 2007 10:16:54 +0100
Message-ID: <200705211016.58067.andyparkins@gmail.com>
References: <566574ef0705210157j14cb7c56h62392c6193472a98@mail.gmail.com> <566574ef0705210159m69d4e32cjd4bc5db66c1677b1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Stian Haklev" <shaklev@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 21 11:17:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hq40v-00017u-VM
	for gcvg-git@gmane.org; Mon, 21 May 2007 11:17:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754445AbXEUJRH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 May 2007 05:17:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754540AbXEUJRH
	(ORCPT <rfc822;git-outgoing>); Mon, 21 May 2007 05:17:07 -0400
Received: from nz-out-0506.google.com ([64.233.162.238]:60269 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754445AbXEUJRF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2007 05:17:05 -0400
Received: by nz-out-0506.google.com with SMTP id z3so255405nzf
        for <git@vger.kernel.org>; Mon, 21 May 2007 02:17:04 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=IYGD9kjiYrdg5Bj4ob6Ef7GdD2yinky7frAKgoXIPflxpI/JeU2hYaBhQpuWZxg3UmVEKYs76yXUmwybRStbHRAGcl+miTGAPJIPskOVO87H0KEfca0hr/2zZT4X2sY8AjFt9tEMcAKmUJ4tYDgML9SdrZpBjJE89cJOmKM23EQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Mkx6XMvkGZHMyFzVhjrz7OyzEb18Of3FuaSrA6Zw6vkNiLdZ1NrM6b8O/L61Z9TFqXISenlbBDR5gfJ5i6gtmld6eR+loXHu5nht5xzKoc//d+j9elz80cFaZTKqRM2LabSar14/QPf11GbGISuMbPjtHDTZMF/yIK5Jl+2R6AY=
Received: by 10.65.114.11 with SMTP id r11mr10351700qbm.1179739024256;
        Mon, 21 May 2007 02:17:04 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id e19sm6388305qba.2007.05.21.02.17.02;
        Mon, 21 May 2007 02:17:02 -0700 (PDT)
User-Agent: KMail/1.9.6
In-Reply-To: <566574ef0705210159m69d4e32cjd4bc5db66c1677b1@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47999>

On Monday 2007 May 21, Stian Haklev wrote:

What does "git --version" say?

> ~wiki/> git checkout trying-new-feature
> checked out
> ~wiki/> git status
> no files updated
> ~wiki/> git checkout master
> checked out
> ~wiki/> git status
> it then puts me directly into commit mode, with every file having a
> ton of differences - because the files are still from
> trying-new-feature and the index is pointing at master.

Something has gone very wrong here.  You are right to be confused, that is not 
what one would expect from git.  After a git-checkout you should expect that 
the index is clean.

Did you get any error messages during any of those operations?

Are you sure you aren't doing something like
  git checkout trying-new-feature -- list of files
As that would update the working tree but not the current HEAD, and would 
therefore appear as changes to master.

When you do the final git-status, are the files being listed in the "Changed 
but not updated" section or the "Changes to be committed" section?

Can you make a minimal test case? e.g.
 mkdir testing-git; cd testing-git
 git init
 date > file1
 git add file1
 git commit -a -m "step1"
 date >> file1
 git commit -a -m "step2"
 git checkout -b newbranch HEAD^
 date >> file1
 git commit -a -m "step3"
 git checkout master
 git checkout newbranch
 git status



Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
