From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: renames in StGIT
Date: Tue, 24 Oct 2006 09:48:44 +0100
Message-ID: <b0943d9e0610240148s15d6ec5ch6114360a603fcd71@mail.gmail.com>
References: <20061022013943.GA16341@diana.vm.bytemark.co.uk>
	 <b0943d9e0610230947j79449a4dm8736f480f039c230@mail.gmail.com>
	 <20061023125344.f82426ad.seanlkml@sympatico.ca>
	 <20061024081732.GA29265@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sean <seanlkml@sympatico.ca>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 24 10:48:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GcHxo-00035n-TN
	for gcvg-git@gmane.org; Tue, 24 Oct 2006 10:48:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030227AbWJXIsp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 24 Oct 2006 04:48:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030232AbWJXIsp
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Oct 2006 04:48:45 -0400
Received: from nz-out-0102.google.com ([64.233.162.195]:31264 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1030227AbWJXIsp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Oct 2006 04:48:45 -0400
Received: by nz-out-0102.google.com with SMTP id z3so651896nzf
        for <git@vger.kernel.org>; Tue, 24 Oct 2006 01:48:44 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sdHunPFfjrtuwLI68E/ucT+N0MnFWqY7TukUW3PiS5kETZx11Klct5xWdm5Ra+TsRPagF06EBQuQ8ReXEdKYYe+uJutT+jZsqbI13DiRpp43O6CJLHcgw8158uuwETGnPXT3jYFiq+OgDtuxyfl/lfN2Uxbpjm3K7uwiDsNl3J8=
Received: by 10.35.8.13 with SMTP id l13mr8434975pyi;
        Tue, 24 Oct 2006 01:48:44 -0700 (PDT)
Received: by 10.35.103.18 with HTTP; Tue, 24 Oct 2006 01:48:44 -0700 (PDT)
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
In-Reply-To: <20061024081732.GA29265@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29947>

On 24/10/06, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> On 2006-10-23 12:53:44 -0400, Sean wrote:
> > There are some situation where it would be really quite handy. The
> > performance of the human having to hand resolve a failed push
> > because of renames is often worse ;o) If it does become a
> > performance problem, perhaps you could make it an optional paramete=
r
> > to "stg push".
>
> Yes, this is my opinion too, both for patch generation and pushing.
> Having it always on is a bad idea at least for patch generation for
> obvious reasons, and may be a bad idea for pushing for performance
> reasons, but I definitely think there should be a flag to enable it.

Actually, it might not be a big performance impact. For diff
generation in the export and mail commands, we should have a flag.

The push operation might not need a flag since it will only checks
renames if all the other operations failed. A push with merge
detection has the steps below (if one succeeds, push is finished):

1. check (exact) patch merges by reverse-applying the diff
2. apply the diff with git-diff | git-apply since this is faster than
a three-way merge
3. try a three-way merge between head, bottom and top

Step 3 above is handled per file by the stgit.gitmergeonefile.merge()
function. This is the place where we should have the rename detection.
Since, the majority of the patches don't rename files and, in most
cases, the push finishes at step 2, it is probably safe to extend this
function and the users won't notice a speed difference.

I'll add it to the TODO list.

--=20
Catalin
