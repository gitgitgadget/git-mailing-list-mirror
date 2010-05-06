From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: What should be the CRLF policy when win + Linux?
Date: Thu, 6 May 2010 12:03:44 +0200
Message-ID: <k2x40aa078e1005060303xcd6aa177n73edc81e850d080e@mail.gmail.com>
References: <4BE141E3.2060904@gmail.com>
	 <t2wf3271551005050627jbe328d84q23a85a1e5dced082@mail.gmail.com>
	 <4BE28B6C.3070302@gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org,
	hasan.aljudy@gmail.com
To: mat <matthieu.stigler@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 06 12:03:56 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9xvv-0003YH-RH
	for gcvg-git-2@lo.gmane.org; Thu, 06 May 2010 12:03:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756105Ab0EFKDs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 May 2010 06:03:48 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:39325 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753646Ab0EFKDq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 May 2010 06:03:46 -0400
Received: by wyb35 with SMTP id 35so1022364wyb.19
        for <git@vger.kernel.org>; Thu, 06 May 2010 03:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:reply-to
         :in-reply-to:references:date:message-id:subject:from:to:cc
         :content-type;
        bh=kSnJAjs5uw0tWPTB2UDeTx85qMBgGS8f9+vQDNqsWrE=;
        b=e+fvCenmjMsVPTFsXs9BM69xos5o170LBeCVevODV4u9bnhXHv7iYWT9UxTpkbQAnF
         jOIMumtcyl70Tr7u94zm3Y4WkHwfp6oqzDxVYrIyT5MiRyPysFvCDKWLTFC++NDbqK6p
         aJU9hOYmh+//1qJUlisPP2QkwdftRavGXTu/A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        b=bbRIEjB+lin2Rx1udS3ZsbaQ7rCjMWrQ2iXNJMItQjA53zywCpomHmCISnoFANBIJu
         O5YQtfVlO2wuBAbawDdXeibIMBPQbrBBByld4yCW0z46uon14ZqXxim5UYs4GnvvI3Wm
         jFzG9F8F3xi+l7wj7VfLvOt0lNDQL3WOcpXNc=
Received: by 10.216.89.195 with SMTP id c45mr6861134wef.98.1273140224892; Thu, 
	06 May 2010 03:03:44 -0700 (PDT)
Received: by 10.216.51.79 with HTTP; Thu, 6 May 2010 03:03:44 -0700 (PDT)
In-Reply-To: <4BE28B6C.3070302@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146472>

On Thu, May 6, 2010 at 11:27 AM, mat <matthieu.stigler@gmail.com> wrote:
> Thanks for your answer!!
>
> I think what you suggest Ramkumar is indeed what I need, great! The
> suggestion from hasan to keep with those settings was not doable as the
> windows guy had the problem of that after even a clean cloning, git was
> signaling changes (see: http://help.github.com/dealing-with-lineendings/)
>

This is a symptom that someone checked in files with CRLF into the
repo with core.autocrlf disabled, and the Windows guy having
core.autocrlf enabled.

I don't quite agree with Hasen about checking out LF on Windows,
though. There's just too many tools that gets slightly confused (as
well as some getting REALLY confused) by this in my experience. It's
sometimes the best trade-off, but quite often not IMO.

What I'd do, is to set core.autocrlf to "input" on non-Windows
machines, and "true" on Windows-machines. This makes sure that no
machines will check in CRLF. If there's already files checked in with
CRLF (as seems to be the case with your repo), the Windows-people will
be annoyed. So you'd need to make sure that the repo only contained
CRLFs, and you have basically two options:
1) Just call dos2unix on all files and commit the changes. This will
still cause problems for the Windows users if they need to check out
commits older than the dos2unix one.
2) Use git filter-branch to rewrite the history to pretend no one ever
made the mistake of committing CRLFs. This will make trouble for
anyone who's working on a branch. But it's a one-time issue (unless
someone manages to commit CRLF-files again, that is).

-- 
Erik "kusma" Faye-Lund
