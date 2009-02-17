From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: FETCH_HEAD question
Date: Tue, 17 Feb 2009 00:11:04 -0500
Message-ID: <76718490902162111o373065bwb74a187b016beb0a@mail.gmail.com>
References: <76718490902162043k78e615b5g7ba4b7ac95e73b18@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 17 06:13:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZIGW-00044e-WF
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 06:13:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751095AbZBQFLI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 00:11:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751072AbZBQFLH
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 00:11:07 -0500
Received: from rv-out-0506.google.com ([209.85.198.229]:37008 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750974AbZBQFLF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 00:11:05 -0500
Received: by rv-out-0506.google.com with SMTP id g37so1860211rvb.1
        for <git@vger.kernel.org>; Mon, 16 Feb 2009 21:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=S9g/Ecmd3vAyKwmSIVGHa5zCsqcvAp7DhIcCtj88vPY=;
        b=RQohq3mO/hkCntmFf75WEM01Vrva4D26OYy1SVlbyYNSX0177tvxjCpoPn/ILIWJ8y
         0crYLScGh089PQU2Rpq1POf85FOA7Kb6jrBzIHlkfB1sv462AcyvZU1veTi3vrl7WQ/O
         /Myaxh6pu9tiiFq3HggBVi9rD4sWwXCGpVSvU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=aSbptM51XGPANc5aYjKPErUIjeXe2TLKlNW4aJ7DL0U5/D4wMtEE8XuxKBnWl8wPu5
         IHe6BRFIgjl106bjBOHJoqVnZWtm+GkBLSelfLCSiHoEkCIMRQU2gjk+Jq+vRxazgTzt
         1o26z4ccT3Ouz25ERO4eAfUb/kYzFwWzOg7TY=
Received: by 10.141.96.19 with SMTP id y19mr3059366rvl.89.1234847464323; Mon, 
	16 Feb 2009 21:11:04 -0800 (PST)
In-Reply-To: <76718490902162043k78e615b5g7ba4b7ac95e73b18@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110308>

On Mon, Feb 16, 2009 at 11:43 PM, Jay Soffian <jaysoffian@gmail.com> wrote:
> I did this the other day out of mild curiosity:
>
> $ git fetch
> $ git merge FETCH_HEAD
>
> Which did something, but not something that was at all useful. It
> merges in the first ref listed in FETCH_HEAD. It does not appear to be
> an accident that it does this, as git merge has special treatment for
> FETCH_HEAD to generate the merge message.
>
> Why does this behavior exist? Historical?

To be clear, this seems only to be useful if you are only fetching a
single branch from remote. Otherwise the branch which you end up
merging (the first alphabetically) may very well not be what the
current checked-out branch is based on.

So to work correctly in the case of pulling multiple branches,
dwim_ref() would have to return the sha1 corresponding to the single
line in FETCH_HEAD that is not marked "not-for-merge" and git merge
would similarly need to use that line for the merge message. Or git
fetch would need to place the non-not-for-merge ref first in the file.

I found this in the archives, but it didn't really answer my question
about why it got implemented the current way:

http://thread.gmane.org/gmane.comp.version-control.git/42788/focus=42850

j.
