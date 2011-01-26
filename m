From: Julian Ibarz <julian.ibarz@gmail.com>
Subject: Re: Updating a submodule with a compatible version from another
 submodule version using the parent meta-repository
Date: Wed, 26 Jan 2011 15:43:38 -0500
Message-ID: <AANLkTimtHL3gLXgfvmWDg82tFCjW24srUN5vW92bTSx5@mail.gmail.com>
References: <AANLkTinN1XVsAZXGLqkuhysrJ8-TCtGm4pOu2RfCEVVp@mail.gmail.com>
	<AANLkTimvNaiieEw8-Y52xxDW6DQ6b16v9azCk+BDPxhe@mail.gmail.com>
	<4D407099.4010805@web.de>
	<AANLkTinMhvBNrBMJ8vQpJdYxP_NgJU2L7JEW0KhXGjhf@mail.gmail.com>
	<4D407875.7080607@web.de>
	<AANLkTik-XdgGM20kFu8KZ5k9ynfNAo8fvL9t7kL_JhQg@mail.gmail.com>
	<4D40849C.2050903@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Jan 26 21:43:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PiCDT-0005gC-07
	for gcvg-git-2@lo.gmane.org; Wed, 26 Jan 2011 21:43:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754052Ab1AZUnl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Jan 2011 15:43:41 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:32981 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753967Ab1AZUnk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jan 2011 15:43:40 -0500
Received: by wwa36 with SMTP id 36so1418004wwa.1
        for <git@vger.kernel.org>; Wed, 26 Jan 2011 12:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=DGyQwv15/P9K9uLu9sWJ95TcYG1wR2pDHhfIjRJJYrs=;
        b=ZhtbdGVevY1fLwYJcAfNeiFOTzcRmfPlH2RVjg/+UtnM5nXe4orzfHkb3qySFTF/+M
         d+52Ajy/n/sOp61oILUjpAshJZ7BnBJswUNgh0UkiwEMh8FgZO3krY6w9KDrvLek0xgq
         J1nEfPwDtvUEDp1k6d6lfHB633LRrviIoF+lE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=LorQQ3CGy70z3kCgh9DepFycfPYtFkZjrEQGPjaphczRkgTwmXXn2Rn/pQCjnTEri6
         HKFuRpDRTn9ih1j1I3Lu+9uXMAumGIzRxN4gdShpj3dwSoJwY4Y6HI5QzB0nVLKCm83W
         USVdZ3KCPzXhi8qJmiRPsTlfBAVDHg9PLiKEw=
Received: by 10.227.166.194 with SMTP id n2mr37830wby.172.1296074618808; Wed,
 26 Jan 2011 12:43:38 -0800 (PST)
Received: by 10.227.146.83 with HTTP; Wed, 26 Jan 2011 12:43:38 -0800 (PST)
In-Reply-To: <4D40849C.2050903@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165541>

> Am 26.01.2011 20:48, schrieb Julian Ibarz:
>> Basically my feature would work like this:
>>
>> in B:
>> git submodule checkout some_version
>>
>> This will checkout B but also change A and C so that it is compatible
>> with some_version of B. Basically it will find the commit in A that
>> has the closest parent commit of some_version in B. When this is done
>> it just does git submodule udate on other submodules.
>
> Thanks, now I understand what you are trying to achieve.
>
>> I see in gitk that there is a feature that has a common implementation
>> for what I want to do:
>>
>> For every commits you can see Follows and Precedes which lists the
>> closest label before this release and after. What I need is the same
>> thing: instead of finding a closest labeled commit, I need to find a
>> closest commit referenced by A that precedes current HEAD of B. When
>> this is done I know which commit A has to be and then just have to
>> call git submodule update in A (update every other submodules except
>> for B).
>
> I am not aware of something like that in current Git, But I see that
> such functionality would be helpful. Care to share your implementation
> idea?

Well actually the paragraph just above is what is my implementation
idea. I recognize it is really high level but it is still a start ;).
Basically the "complex" part is to find the precedent commit in B that
is referenced by A. Since gitk has this already but for labels, we
just need to reuse/copy their function that does this but instead as
input having a list of commit labels and find the closest precedent it
is instead the list of commits referenced by A. By the way, anyone
reading this knows where it is in the code of gitk? Or if there is
something like that already in the git code? I never looked into both
code projects.
