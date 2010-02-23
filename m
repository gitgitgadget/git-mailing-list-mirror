From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH] is_submodule_modified(): clear environment properly
Date: Tue, 23 Feb 2010 23:13:36 +0100
Message-ID: <cb7bb73a1002231413n3a38e344hce8188671763c17b@mail.gmail.com>
References: <4B844D07.8070406@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Feb 23 23:21:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nk383-0003MQ-K6
	for gcvg-git-2@lo.gmane.org; Tue, 23 Feb 2010 23:21:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754467Ab0BWWVI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2010 17:21:08 -0500
Received: from mail-ew0-f220.google.com ([209.85.219.220]:40115 "EHLO
	mail-ew0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754403Ab0BWWVB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2010 17:21:01 -0500
X-Greylist: delayed 423 seconds by postgrey-1.27 at vger.kernel.org; Tue, 23 Feb 2010 17:21:01 EST
Received: by ewy20 with SMTP id 20so494171ewy.1
        for <git@vger.kernel.org>; Tue, 23 Feb 2010 14:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=Hw93xrUoLz6BduMAigH9ZgJ6wGTIRO44kX7HMTM1fqA=;
        b=LN3f6rl79VbjDvxD9twKtp7+4RVQQM4qLdTKndUrWv9xcc++on0tZ+bTjH/GZ0BHSu
         Wu60Xcxv+LUvJoaV3BNRxzmnpg+k8AzQC0d4ms/RUa2poK8qLOGQrQPlsG0hpj8gnCFy
         xAJ/dTTDiT8WJy9TSZ3wBxwBZGotJptxAwd9M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=jVbp32oSiqESbe3YfBekXebKBYqCRAWMJoHai5GAZEzA/h9jMCRzumKe4S4qCLc8he
         UVGJmF517T2bphwBuF79w5GkWVasYTbhFw4L17amI/3dmcr5u1wOrDqGRKt6kpCkHpZS
         l3DWgqaqtGY9Wedlo5mJ7se85fdhk/mZPn3Ug=
Received: by 10.213.1.210 with SMTP id 18mr188102ebg.58.1266963236276; Tue, 23 
	Feb 2010 14:13:56 -0800 (PST)
In-Reply-To: <4B844D07.8070406@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140857>

On Tue, Feb 23, 2010 at 10:47 PM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
> Only GIT_INDEX_FILE was cleared until now, but other environment variables
> have to be cleared too before running git status in a submodule.
>
> And while at it, don't allocate a new strbuf for GIT_INDEX_FILE but use
> a string constant instead.
>
> Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
> ---
>
>
> I think it makes sense to clear the same environment variables here
> as Giuseppe Bilotta's patch did for the git shell commands, even
> though i am not aware of any bug reports yet.

I think this makes sense. This would be the third user of the "list of
repo-local vars", together with the shell function and the connect.c
code highlighted elsewhere, so I believe this really puts some more
pressure on a refactoring of the list generation. Maybe a static array
exportable via git-rev-parse?

Of course this third use-case has a difference in that GIT_DIR is
actually set to something else and not just cleared, but this
particular case could just deep-copy the array modifying the
appropriate entry.

-- 
Giuseppe "Oblomov" Bilotta
