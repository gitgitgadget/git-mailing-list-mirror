From: Stefan Beller <sbeller@google.com>
Subject: Introducing a test_create_repo_bare (was Re: [PATCHv2 6/6]
 t5543-atomic-push.sh: add basic tests for atomic pushes)
Date: Wed, 17 Dec 2014 15:20:22 -0800
Message-ID: <CAGZ79kY=TP31VJxPZnjb04og-vHU+-c4d+AgAkis2Q7yeDeXbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 18 00:20:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y1NtL-0003lw-Dg
	for gcvg-git-2@plane.gmane.org; Thu, 18 Dec 2014 00:20:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751342AbaLQXUX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2014 18:20:23 -0500
Received: from mail-ie0-f179.google.com ([209.85.223.179]:47764 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750983AbaLQXUW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2014 18:20:22 -0500
Received: by mail-ie0-f179.google.com with SMTP id rp18so66028iec.38
        for <git@vger.kernel.org>; Wed, 17 Dec 2014 15:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=Y0QSvJtYdaxMMMul0fqftGD5Lk/j79aCgbXhFN2b7KY=;
        b=GStgkbAoHjdH8MKJGrVlb5nIV5hx1DRqvOj8OCG27/G9MTwjPw7L7ucBYmBE1bDzXa
         jFe2sGeSZA0HlKe1sexKfdSwJwEGOW8kMBS0viKu4IkaSMvQekn6SUfaGg5A3TgIrxxH
         B8qjmPhusQcUZH19XG+lfFX7zg1PNH3zNXVWWWFlnBHiAVrQ4yBktRQo85eLjGQkL5ai
         rpeJ6XiG9Z2aeGTm+NZto0+a3dN7a56RfLqtwgqr8J34lwI+sxdR5ff9XUhYhwuNb5T4
         D363+4ihE+CRwVrWo/2/g81tBI0HW0dMgncMEaAAR8WVXo+7VUFxqVkaWELezIp/Df4n
         Eq2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc
         :content-type;
        bh=Y0QSvJtYdaxMMMul0fqftGD5Lk/j79aCgbXhFN2b7KY=;
        b=fypLhlwEkCykZ+srl8NyeEwJzlRoWnIggH8TLhqvjFphGbJNEOiagxbM8YuQyH8A0q
         hMUbujhQdbB0DBxDcuxIk1ajmUKwC9jSonYwRfGZsy8oBRNMM0xGPJ3+VUb92qSB4wuu
         OBLR3zNkIFscA62ySOMnZ6f+7ignnhCeoc6uf5z+NVLD/be+LYc4R+4cze0c2qhGMOmQ
         kNaNWtZrhWZM/JiqJy6TpAtvc/467mv3qqMiBTlQsfiKgHyJOY+qlC8IwDKMbFY2xpeY
         TOrXMsw+C1MAlPQTNFArpDJRC7jmKeOpAQMdc7xnGSqKlMBkwXEH5+JJbPnd/m8QPPuD
         CCPw==
X-Gm-Message-State: ALoCoQmH/4dz8kjD3BWQagiYfUvN1fI6cqxXkEJ8Mc0Aczt0IZfGgFLHOZ3gFSSrRkvBHjhYL/6s
X-Received: by 10.107.170.162 with SMTP id g34mr43048898ioj.2.1418858422211;
 Wed, 17 Dec 2014 15:20:22 -0800 (PST)
Received: by 10.107.31.8 with HTTP; Wed, 17 Dec 2014 15:20:22 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261505>

On Tue, Dec 16, 2014 at 11:46 AM, Junio C Hamano <gitster@pobox.com> wrote:

>> +     (
>> +             cd upstream && git config receive.denyCurrentBranch warn
>> +     ) &&
>
> I was wondering how you would do this part after suggesting use of
> test_create_repo, knowing very well that one of them was a bare one
> ;-).
>
> We might want to extend test_create_repo to allow creating a bare
> repository, but this is also OK.

So I searching through all the tests, where it would make sense to do that.
I searched for "denyCurrentBranch" and came up with this list where I think
it makes sense to replace (git init | test_create_repo | or alike) by a
test_create_repo_bare or add the --bare option to test_create_repo

places where test_create_repo_bare is easily introducable:
t5517-push-mirror.sh # setup an upstream repo
t5543-atomic-push.sh # setup an upstream repo
t5701-clone-local.sh # Test  'clone empty repository'

not as easy:
t5400-send-pack.sh # we commit to that repo while being inside
t5405-send-pack-rewind.sh # we commit to that repo while being inside
t5516-fetch-push.sh # we test the various denyCurrentBranch options

unsure:
t5522-pull-symlink.sh # just cloning the repo

So I think we don't need the test_create_repo_bare yet.

Thanks,
Stefan
