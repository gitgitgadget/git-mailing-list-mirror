From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: Intricacies of submodules
Date: Fri, 18 Apr 2008 14:30:03 -0400
Message-ID: <32541b130804181130s21e6ea5bm38ea0b35cd009d3e@mail.gmail.com>
References: <47F15094.5050808@et.gatech.edu> <1207970038.10408.8.camel@ginkgo>
	 <7vlk3jlkrr.fsf@gitster.siamese.dyndns.org>
	 <1208202740.25663.69.camel@work.sfbay.sun.com>
	 <7vd4or7wdt.fsf@gitster.siamese.dyndns.org>
	 <1208317795.26863.91.camel@goose.sun.com>
	 <87lk3c4ali.fsf@jeremyms.com>
	 <alpine.LFD.1.00.0804171158360.2879@woody.linux-foundation.org>
	 <7vmynsnt7x.fsf@gitster.siamese.dyndns.org>
	 <32541b130804181128j57d76edcsbbd5fb8d4c782ae7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Junio C Hamano" <gitster@pobox.com>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 19 11:06:08 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmvML-0005z4-IE
	for gcvg-git-2@gmane.org; Fri, 18 Apr 2008 20:30:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759762AbYDRSaG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Apr 2008 14:30:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759712AbYDRSaG
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Apr 2008 14:30:06 -0400
Received: from fk-out-0910.google.com ([209.85.128.191]:4849 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759581AbYDRSaF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Apr 2008 14:30:05 -0400
Received: by fk-out-0910.google.com with SMTP id 19so835661fkr.5
        for <git@vger.kernel.org>; Fri, 18 Apr 2008 11:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=P6FH6tgj1E1StjZOOt2UCf1VZM9W3JKmUhahqJEVhhM=;
        b=oXm1xkDFLvFXg2fnsPNSvfoyVcSrkaQrsId7SMDThuvzlEBL7IuLNIOVpA3s8tJaV7C47/arkzeO9NtgKyj7DpwsdUv4Bg/SBOdeWb6rc0phZyYVf5VnZOC/nzDuzgq4RyrW079RabP7Pkb/VMdTBPFIx5ZR3/379jHKrR2/BCw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rB/kQ6sSFITEl50AeNN5+LkeUuGOWZHHPTJTDHJswgrfkjKIieteSWR3pTHrwsgYD+6IjREw6t5ByRP6vNMKUCzs5XuqNoSpsSO4smFTR/b+eVuuQNdW9TbFCuYGxDSYumluPa/UhqTqjZPB6c439dOHPUThej33TPw6lEEM39E=
Received: by 10.82.139.20 with SMTP id m20mr5273786bud.16.1208543403501;
        Fri, 18 Apr 2008 11:30:03 -0700 (PDT)
Received: by 10.82.166.12 with HTTP; Fri, 18 Apr 2008 11:30:03 -0700 (PDT)
In-Reply-To: <32541b130804181128j57d76edcsbbd5fb8d4c782ae7@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79878>

On 4/17/08, Junio C Hamano <gitster@pobox.com> wrote:
> Linus Torvalds <torvalds@linux-foundation.org> writes:
>  > So if we do end up doing a "tracked config file", I'd personally very much
>  > prefer it be limited in some way. For example, we obviously track the
>  > .gitignore and .gitattributes files, but they are much more limited in
>  > their effects. Maybe we could have a "limited config file" that allows for
>  > *some* config options to be set?
>
> Yes, that's all what I have been trying to say ;-)

How about this: we know that *most* options are harmless, at least
from a security point of view.  AFAIK it's really just the ones where
you specify shell commands that are unsafe.

Why not have a list of "safe" config options in git, and when reading
.gitconfig, error out if any of the options in that file are unsafe.
(Alternatively: silently ignore the unsafe ones, or warn and then
ignore the unsafe ones.)  A more advanced variation of the same would
be to have .git/config options that list specific exceptions to the
safe list, so if .gitconfig causes an error, you can *explicitly* git
config set to let .gitconfig override them.

Another possibility would be to have an "unsafe" list instead of a
"safe" list, but that sounds rather error-prone to me.

Have fun,

Avery
