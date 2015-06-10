From: Christopher Dunn <cdunn2001@gmail.com>
Subject: Re: format-patch and submodules
Date: Wed, 10 Jun 2015 12:04:03 -0500
Message-ID: <CAD2z=MBSAzENvj1-WUMzrXznvudjCc3vyvYQQ+wMnPC3G3Go2Q@mail.gmail.com>
References: <CAD2z=MAu1qrr9=wwBnOJZZ3JCJOsmFWi=gDgKMQKU3_P-01e3g@mail.gmail.com>
	<557735E6.8040906@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Jun 10 19:04:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2jQB-0004xZ-VI
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jun 2015 19:04:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754294AbbFJREH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2015 13:04:07 -0400
Received: from mail-vn0-f43.google.com ([209.85.216.43]:36820 "EHLO
	mail-vn0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752367AbbFJREE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2015 13:04:04 -0400
Received: by vnbg1 with SMTP id g1so9161059vnb.3
        for <git@vger.kernel.org>; Wed, 10 Jun 2015 10:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=5JucbVKwjOYQJzVNUX7B3U1U47jldKnoBkPWz8M06sE=;
        b=esE8y0elM5cJkwO0YWztwrBjfuNFv6nhbiJHxVMXQR8F0G1BHuBxwn5/Taa/O4GGrf
         2o5gmozkDWM5+v9zavFcXZ2csDTVhPWS02+MaF+yCcs1IkAzzHLr/ouCL725fC5CO9kC
         dlP3/QST4nYWJ3cuX60iWLDDgM+YO9Q6+pER/6sTtfLEe1EalfIOIcEOgHJBhFx3t8b8
         jcLexzYBKYjcYo5rWU9cpSOjnI2fY0NPebQpyxjQF9W5lGiU+ZI02UnuEE3lHyIqNRCi
         8RD1qXxbJu7W7+8YGaLNhkj7M6hYRRWyquY4/L8CMThsjR+rPHF3yg77dpw124veB3s9
         PEIA==
X-Received: by 10.53.0.226 with SMTP id bb2mr8108425vdd.4.1433955844050; Wed,
 10 Jun 2015 10:04:04 -0700 (PDT)
Received: by 10.52.98.134 with HTTP; Wed, 10 Jun 2015 10:04:03 -0700 (PDT)
In-Reply-To: <557735E6.8040906@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271328>

Sorry. I thought empty patches were made to work in other cases.

'git-p4' needs to skip these. Wrong mailing list then.

On Tue, Jun 9, 2015 at 1:52 PM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
> Am 05.06.2015 um 01:20 schrieb Christopher Dunn:
>>
>> (Seen in git versions: 2.1.0 and 1.9.3 et al.)
>>
>> $ git format-patch --stdout X^..X | git apply check -
>> fatal: unrecognized input
>>
>> This fails when the commit consists of nothing but a submodule change
>> (as in 'git add submodule foo'), but it passes when a file change is
>> added to the same commit.
>>
>> There used to be a similar problem for empty commits, but that was
>> fixed around git-1.8:
>>
>>
>> http://stackoverflow.com/questions/20775132/cannot-apply-git-patch-replacing-a-file-with-a-link
>>
>> Now, 'git format-patch' outputs nothing for an empty commit. I suppose
>> that needs to be the behavior also when only submodules are changed,
>> since in that case there is no 'diff' section from 'format-patch'.
>>
>> Use-case: git-p4
>>
>> Of course, we do not plan to add the submodule into Perforce, but we
>> would like this particular command to behave the same whether there
>> are other diffs or not.
>
>
> Hmm, I'm not sure that this is a bug. It looks to me like doing a
>
> $ git format-patch --stdout X^..X | git apply check -
>
> when nothing is changed except submodules and expecting it to work
> is the cause of the problem.
>
> I get the same error when I do:
>
> $git format-patch --stdout master..master | git apply --check -
> fatal: unrecognized input
>
> No submodules involved, just an empty patch.
>
> I assume you want to ignore all submodule changes, so you should
> check if e.g. "git diff --ignore-submodules X^..X" returns anything
> before applying that? (From the command you ran I assume you might
> be able to drop the --ignore-submodules because you already did set
> "diff.ignoreSubmodules" to "all"?)
