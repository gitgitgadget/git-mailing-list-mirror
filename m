From: "Jay Soffian" <jaysoffian@gmail.com>
Subject: Re: [RFC PATCH 1/2] git-branch: allow --track to work w/local branches
Date: Sat, 16 Feb 2008 02:07:30 -0500
Message-ID: <76718490802152307h37796d32tfccb7571d48a3221@mail.gmail.com>
References: <1203133557-50013-1-git-send-email-jaysoffian@gmail.com>
	 <7v7ih5fpve.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 16 08:08:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQH9c-0007oU-Fs
	for gcvg-git-2@gmane.org; Sat, 16 Feb 2008 08:08:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751065AbYBPHHd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Feb 2008 02:07:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751047AbYBPHHd
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Feb 2008 02:07:33 -0500
Received: from wa-out-1112.google.com ([209.85.146.176]:6424 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750935AbYBPHHc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Feb 2008 02:07:32 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1575697wah.23
        for <git@vger.kernel.org>; Fri, 15 Feb 2008 23:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=i+Qdy1D04AlC+akcz6XJZpkmQo9EDZNGP62sN/sChkk=;
        b=IRAG7yibh/c30AecyHbfHUTVaeSC+1QxAzAWjW5PTKd6Julu6bO5HEkBqRxavX6OVOYFNL4yRvQF3mzaAVqg8JgCu1wtQVZoO4aThBKZwYEMJ/PsyQhkHFrHar4NFGhNIl44Jo+t7grUqCz+CmjL5ypTGtOhwYPkJ786+B12NLo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qUbEyrtTmiC0eCN18K+lKVdgxES6tDX3hg9OTbVy9BvwoZSkuF2+M1XQDL0bsnTeymgJt1k682bGV5qy+KNfKnDcV9dgIyymdXpWrEgFp9QQwcjV+ZajdUZWmibDvnouWFnCsmWMRQzIqYIVEn0hAjO0YHkOLSEjLvWLq7LBq5c=
Received: by 10.115.93.16 with SMTP id v16mr1064790wal.126.1203145650543;
        Fri, 15 Feb 2008 23:07:30 -0800 (PST)
Received: by 10.114.255.11 with HTTP; Fri, 15 Feb 2008 23:07:30 -0800 (PST)
In-Reply-To: <7v7ih5fpve.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74022>

On Feb 16, 2008 12:10 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Although I am not so familiar with this area, the patch somehow
> did not feel right, so I ended up doing a bit of digging.
>
> After the context of the patch, we have this:
>
>         if (tracking.matches == 1) {
>                 sprintf(key, "branch.%s.remote", new_ref);
>                 git_config_set(key, tracking.remote ?  tracking.remote : ".");
>                 sprintf(key, "branch.%s.merge", new_ref);
>                 git_config_set(key, tracking.src);
>
> So it looks to me that the code already has intention to set the
> "branch.*.remote" variable to "." when certain condition is met.
> And the condition is "when tracking.remote is NULL, or it is
> already a dot".

I was confused by the use of the ternary operator. I couldn't figure
out how tracking.remote could be NULL. I chalked it up to bit-rot
but them forget to mention that in my email. I'm glad you took
another look, but I still don't understand how tracking.remote can
be NULL and tracking.matches == 1.

> So if there is a remote whose name is "." (or NULL, but I do not
> know when that can happen --- remote.c::make_remote() does not
> allow creating such a remote as far as I can tell), that would
> be found without the added extra code, wouldn't it?
>
> I did a bit of experiment and with this in .git/config:
>
>         [remote "."]
>                 fetch = refs/*:refs/*
>
> it turns out that you do not have to patch the code at all.  The
> above manual configuration feels somewhat like an ugly hack but
> perhaps we should make the above two lines implied?

Hmm, that just causes tracking.remote to be set to ".", not to NULL?
Right?

j.
