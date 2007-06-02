From: "Dana How" <danahow@gmail.com>
Subject: Re: [PATCH] always start looking up objects in the last used pack first
Date: Sat, 2 Jun 2007 07:53:35 -0700
Message-ID: <56b7f5510706020753r200fe608wf55a338870f9f1ea@mail.gmail.com>
References: <alpine.LFD.0.99.0705302152180.11491@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org,
	danahow@gmail.com
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Sat Jun 02 16:54:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HuUzS-0003hy-J3
	for gcvg-git@gmane.org; Sat, 02 Jun 2007 16:54:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759868AbXFBOxi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Jun 2007 10:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759966AbXFBOxi
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jun 2007 10:53:38 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:54499 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759868AbXFBOxh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jun 2007 10:53:37 -0400
Received: by ug-out-1314.google.com with SMTP id j3so420441ugf
        for <git@vger.kernel.org>; Sat, 02 Jun 2007 07:53:36 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XTrTFgqYxhbUVFJMKEbwpFd9jPa6oxT7lrMpCFPZfcb5dDVGSkeGjyiKEA7qmRMTUfMw8B5PY3OF7qxaK2usDuUI18H44rwxPv64bg1Q1qGqRnw+eCv5QtruEqfiEkdnk/EvcU7TINLWQteWcnAiG1RRh2rlPSkHEGq0fCPF4fc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tuqcPYMfPLpHbruys3EvFt9MC1VqrXPT6urYWaa1cOjnuMwt/Kk11HLvX1B8666vNNDZ8wBSyb13WhbxPWVLxgtgB1wVKd+MkrC2DH+XYhb0ySb6jdTY/ZEvm9keb+/iu4z0Nz735q7cw5oVoyLLjTf41FpfPR8/MNrPaTwK2kA=
Received: by 10.78.201.2 with SMTP id y2mr1543960huf.1180796015980;
        Sat, 02 Jun 2007 07:53:35 -0700 (PDT)
Received: by 10.78.90.18 with HTTP; Sat, 2 Jun 2007 07:53:35 -0700 (PDT)
In-Reply-To: <alpine.LFD.0.99.0705302152180.11491@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48931>

On 5/30/07, Nicolas Pitre <nico@cam.org> wrote:
> Jon Smirl said:
> | Once an object reference hits a pack file it is very likely that
> | following references will hit the same pack file. So first place to
> | look for an object is the same place the previous object was found.
>
> This is indeed a good heuristic so here it is.  The search always start
> with the pack where the last object lookup succeeded.  If the wanted
> object is not available there then the search continues with the normal
> pack ordering.

Nice numbers for performance,
especially your later email showing this makes
split packs almost as quick as one pack.

> Note: the
> --max-pack-size to git-repack currently produces packs with old objects
> after those containing recent objects.  The pack sort based on
> filesystem timestamp is therefore backward for those.  This needs to be
> fixed of course, but at least it made me think about this variable for
> the test.

Yes,  I was intending to submit a patch to builtin-pack-objects.c
to reverse the timestamps when split packs were created.
Haven't got around to it yet.
-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell
