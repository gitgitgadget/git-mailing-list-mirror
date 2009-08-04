From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: x86 SHA1: Faster than OpenSSL
Date: Tue, 4 Aug 2009 08:56:48 -0400
Message-ID: <9e4733910908040556t477dcb66u86a43e12148e3352@mail.gmail.com>
References: <9e4733910908032007td74ef9fp669d0d958df67c1@mail.gmail.com>
	 <20090804050138.13256.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: George Spelvin <linux@horizon.com>
X-From: git-owner@vger.kernel.org Tue Aug 04 14:57:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYJZZ-0001am-9v
	for gcvg-git-2@gmane.org; Tue, 04 Aug 2009 14:56:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755468AbZHDM4s convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Aug 2009 08:56:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755466AbZHDM4s
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Aug 2009 08:56:48 -0400
Received: from mail-yx0-f175.google.com ([209.85.210.175]:59954 "EHLO
	mail-yx0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755460AbZHDM4r convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Aug 2009 08:56:47 -0400
Received: by yxe5 with SMTP id 5so2872262yxe.33
        for <git@vger.kernel.org>; Tue, 04 Aug 2009 05:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=GJ4mxCon9BaRouTm940IBfGuip2VpTwjYesLLyX5BUk=;
        b=Ct+oLQonrJmB4EuW/cCsIf1vTDLUqretSY9VOMWDMNVR9NrPCEKwBM5bLmr2b0PhXt
         tLOivgQNCMZRwKYiwhtiwY7Ef1JZxKTawz7P0G7XW20FmvdUGgFugMO3sothbpriteed
         w2zIgci+JBfsWs6BHP9GuMZ/g86kR1vLg4i1Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Tt+1ekEnJDiDGCzNLFqNuKXJUENayVN36NeHOGzKUy9F4kZXmAh6M+UpfJzi5RSX5+
         3tOayMEEWO37435em+SqvLjTPaWBvqmCtqlxIyc+BjwLt2g6Ck9Ba+A8eMOffTDo3Nym
         ZSh8YN0HdYO3q5ChAt0u+Uqlf+r2qDUGRKNw4=
Received: by 10.101.70.17 with SMTP id x17mr8792682ank.25.1249390608195; Tue, 
	04 Aug 2009 05:56:48 -0700 (PDT)
In-Reply-To: <20090804050138.13256.qmail@science.horizon.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124784>

On Tue, Aug 4, 2009 at 1:01 AM, George Spelvin<linux@horizon.com> wrote=
:
>> Would there happen to be a SHA1 implementation around that can compu=
te
>> the SHA1 without first decompressing the data? Databases gain a lot =
of
>> speed by using special algorithms that can directly operate on the
>> compressed data.
>
> I can't imagine how. =A0In general, this requires that the compressio=
n
> be carefully designed to be compatible with the algorithms, and SHA1
> is specifically designed to depend on every bit of the input in
> an un-analyzable way.

A simple start would be to feed each byte as it is decompressed
directly into the sha code and avoid the intermediate buffer. Removing
the buffer reduces cache pressure.

> Also, git normally avoids hashing objects that it doesn't need
> uncompressed for some other reason. =A0git-fsck is a notable exceptio=
n,
> but I think the idea of creating special optimized code paths for tha=
t
> interferes with its reliability and robustness goals.

Agreed that there is no real need for this, just something to play
with if you are trying for a speed record.

I'd much rather have a solution for the rebase problem where one side
of the diff has moved to a different file and rebase can't figure it
out.

>



--=20
Jon Smirl
jonsmirl@gmail.com
