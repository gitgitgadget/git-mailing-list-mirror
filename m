From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 0/2] Hiding some refs in ls-remote
Date: Sat, 19 Jan 2013 12:50:10 +0700
Message-ID: <CACsJy8C4qx0P621imj5B+HdoJkow0_jaGLVDRvdCDw3YRnK98g@mail.gmail.com>
References: <1358555826-11883-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, spearce@spearce.org, mfick@codeaurora.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 19 06:53:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TwRNI-0000g7-Rp
	for gcvg-git-2@plane.gmane.org; Sat, 19 Jan 2013 06:53:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751172Ab3ASFul (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jan 2013 00:50:41 -0500
Received: from mail-ob0-f169.google.com ([209.85.214.169]:50535 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750895Ab3ASFuk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jan 2013 00:50:40 -0500
Received: by mail-ob0-f169.google.com with SMTP id v19so4488845obq.14
        for <git@vger.kernel.org>; Fri, 18 Jan 2013 21:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=ob+VUHotePnPFXNankVNUsR/hakFGj3+Saxu8NtDGb8=;
        b=SUyLjN5VBgyUchGHowOABBwA02ZaovNmfVd3koIjoFJDTrDuY8KlYqVle0Pmcm31dz
         gQegozIwSiMSQF0+KGRqOV/ZTY5451vSMDkozuOglMJA3R3A9aKI4zO7GKjqYmCDQGZA
         L/8Vgtb6TmsV1vALlwcXyFyGN7skz88uOJ7rDprm1/GC4C+SnqxTzrJAvYYhQVNeNP73
         Gjg08sbmj3nEYgSQhT3iLr1bW7/f6LObeh5OtYeQj8AGeLy7CseY2hsf6mXC8RIocwdB
         BEjNdqF1i1YNY7xMSfx7lL3jL2B7JCJIzOAR3yojJtr7U/lzDXP8hReF591Zkebag/Wg
         Xj3w==
X-Received: by 10.60.3.1 with SMTP id 1mr8812920oey.138.1358574640423; Fri, 18
 Jan 2013 21:50:40 -0800 (PST)
Received: by 10.182.153.69 with HTTP; Fri, 18 Jan 2013 21:50:10 -0800 (PST)
In-Reply-To: <1358555826-11883-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213956>

On Sat, Jan 19, 2013 at 7:37 AM, Junio C Hamano <gitster@pobox.com> wrote:
> This is an early preview of reducing the network cost while talking
> with a repository with tons of refs, most of which are of use by
> very narrow audiences (e.g. refs under Gerrit's refs/changes/ are
> useful only for people who are interested in the changes under
> review).  As long as these narrow audiences have a way to learn the
> names of refs or objects pointed at by the refs out-of-band, it is
> not necessary to advertise these refs.
>
> On the server end, you tell upload-pack that some refs do not have
> to be advertised with the uploadPack.hiderefs multi-valued
> configuration variable:
>
>         [uploadPack]
>                 hiderefs = refs/changes
>
> The changes necessary on the client side to allow fetching objects
> at the tip of a ref in hidden hierarchies are much more involved and
> not part of this early preview, but the end user UI is expected to
> be like these:
>
>         $ git fetch $there refs/changes/72/41672/1
>         $ git fetch $there 9598d59cdc098c5d9094d68024475e2430343182
>
> That is, you ask for a refname as usual even though it is not part
> of ls-remote response, or you ask for the commit object that is at
> the tip of whatever hidden ref you are interested in.

Should the client side learn how to list hidden refs too? I'm thinking
of an extreme case where upload-pack advertises nothing (or maybe just
refs/heads/master) and it's up to the client to ask for the ref
selection it's interested in. upload-pack may need more updates to do
that, I think.
-- 
Duy
