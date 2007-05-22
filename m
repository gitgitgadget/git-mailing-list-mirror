From: "Dana How" <danahow@gmail.com>
Subject: Re: [PATCH] Prevent megablobs from gunking up git packs
Date: Tue, 22 May 2007 11:07:32 -0700
Message-ID: <56b7f5510705221107m535fa7d2ob0dad6ebb25b9443@mail.gmail.com>
References: <46528A48.9050903@gmail.com>
	 <alpine.LFD.0.99.0705221329420.3366@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Git Mailing List" <git@vger.kernel.org>, danahow@gmail.com
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue May 22 20:07:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqYln-0000s6-Lt
	for gcvg-git@gmane.org; Tue, 22 May 2007 20:07:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758840AbXEVSHf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 May 2007 14:07:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759152AbXEVSHf
	(ORCPT <rfc822;git-outgoing>); Tue, 22 May 2007 14:07:35 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:41395 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755640AbXEVSHe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2007 14:07:34 -0400
Received: by ug-out-1314.google.com with SMTP id 44so370681uga
        for <git@vger.kernel.org>; Tue, 22 May 2007 11:07:32 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Q1DrxEElQ0z1hTGwvXu3jq2qfYTWI0mFDVNGsTGtAgRAlteWgBsZEIpfgWg8B6ElYxkQm5sQ+Cz+MtC/4HXFHJCXWqCNbvBJcMV4zaKH249Ymg+Q25EynXjufz2ZdUN5umW/vSw+wTB5Bn6qtxhVGE1cC7b6BcNuT2BBWdeY6JA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UcTScGhUw8xoYU55A3u099tu0ah6PJqJ/amO82XeOaNrqrEBGhniahTUxZLzH5UH3eRB+ZUcO8/kttLsgS/biGokGhOPzoUdYJExCMSYw2A4qojO0e2TYC6wZEiRKfGGbw5RwCvuiYAPQVPHqPw1svmHE18SiUwiPWnbFmoB2L0=
Received: by 10.78.160.4 with SMTP id i4mr1528577hue.1179857252848;
        Tue, 22 May 2007 11:07:32 -0700 (PDT)
Received: by 10.78.129.3 with HTTP; Tue, 22 May 2007 11:07:32 -0700 (PDT)
In-Reply-To: <alpine.LFD.0.99.0705221329420.3366@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48112>

On 5/22/07, Nicolas Pitre <nico@cam.org> wrote:
> On Mon, 21 May 2007, Dana How wrote:
> > This patch implements the following:
> > 1. git pack-objects takes a new --max-blob-size=N flag,
> >    with the effect that only blobs less than N KB are written
> >    to the packfiles(s).  If a blob was in a pack but violates
> >    this limit (perhaps the packs were created by fast-import
> >    or max-blob-size was reduced),  then a new loose object
> >    is written out if needed so the data is not lost.
> > 2. git repack inspects repack.maxblobsize .  If set,  its
> >    value is passed to git pack-objects on the command line.
> >    The user should change repack.maxblobsize ,  NOT specify
> >    --max-blob-size=N .
> > 3. No other caller of git pack-objects supplies this new flag,
> >    so other callers see no change.
> >
> > This patch is on top of the earlier max-pack-size patch,
> > because I thought I needed some behavior it supplied,
> > but could be rebased on master if desired.
>
> I think what this patch is missing is a test after all options have been
> parsed to prevent --stdout and --max-blob-size to be used together.
Yes.  I will also update the documentation.

Thanks,
-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell
