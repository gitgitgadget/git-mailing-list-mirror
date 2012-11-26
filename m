From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Re: git bundle format
Date: Tue, 27 Nov 2012 10:08:21 +1100
Message-ID: <CAH5451mB0_5r6pK43OBxoo8HVAteRgv3fKrE0iCu3c=tcZt_nA@mail.gmail.com>
References: <871B6C10EBEFE342A772D1159D13208537ABF5AB@umechphj.easf.csd.disa.mil>
 <1745253724.103630.1353963384110.JavaMail.root@genarts.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "Jason J CTR Pyeron (US)" <jason.j.pyeron.ctr@mail.mil>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Stephen Bash <bash@genarts.com>
X-From: git-owner@vger.kernel.org Tue Nov 27 00:09:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Td7nO-0007wR-In
	for gcvg-git-2@plane.gmane.org; Tue, 27 Nov 2012 00:08:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932409Ab2KZXIn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2012 18:08:43 -0500
Received: from mail-qc0-f174.google.com ([209.85.216.174]:41884 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932337Ab2KZXIn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2012 18:08:43 -0500
Received: by mail-qc0-f174.google.com with SMTP id o22so8395304qcr.19
        for <git@vger.kernel.org>; Mon, 26 Nov 2012 15:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=4dS7XPBltwU6CByITEHmK6K3QojjqkCwjhGko8PRmA0=;
        b=V2uS+8/myW0yTfUczsNCP0vTSYaM7OWjR/4F4sHm8dX/h0pm6KyVSgxms4G0Gb35Uv
         pRGiq5jqJ/mVVQ5fuuu+A1NSADfdvbYLJN3+mtt1T9xEg1oRXz5/aIl+AwVWtS+C5fXd
         jU82EKAd1OBG5TWvNAdg5upJ7ZI+jbdjyEIAZkjDa+kQPTwO0g8XXf8qGTgoYYMxBpFB
         DffqHb6jNYGNNqoTkBft1B13zJPjSckIqgOHsnL/4m3TDDzK2J0SUIas5h1XrH5mrpuW
         Ggq47emkqNlRG59n5eCPCtV5PsFRpOf0WbM9mUZ5D0i/kwfwxjr0meTxqkV9+Bqlrw/+
         qsyg==
Received: by 10.229.69.85 with SMTP id y21mr3196296qci.75.1353971322022; Mon,
 26 Nov 2012 15:08:42 -0800 (PST)
Received: by 10.49.119.65 with HTTP; Mon, 26 Nov 2012 15:08:21 -0800 (PST)
In-Reply-To: <1745253724.103630.1353963384110.JavaMail.root@genarts.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210511>

On 27 November 2012 07:56, Stephen Bash <bash@genarts.com> wrote:
> ----- Original Message -----
>> From: "Jason J CTR Pyeron (US)" <jason.j.pyeron.ctr@mail.mil>
>> Sent: Monday, November 26, 2012 2:24:54 PM
>> Subject: git bundle format
>>
>> I am facing a situation where I would like to use git bundle but at
>> the same time inspect the contents to prevent a spillage[1].
>
> As someone who faced a similar situation in a previous life, I'll offer my $0.02, but I'm certainly not the technical expert here.
>
>> Given we have a public repository which was cloned on to a secret
>> development repository. Now the developers do some work which should
>> not be sensitive in any way and commit and push it to the secret
>> repository.
>>
>> Now they want to release it out to the public. The current process is
>> to review the text files to ensure that there is no "secret" sauce
>> in there and then approve its release. This current process ignores
>> the change tracking and all non-content is lost.
>>
>> In this situation we should assume that the bundle does not have any
>> content which is already in the public repository, that is it has
>> the minimum data to make it pass a git bundle verify from the public
>> repositories point of view. We would then take the bundle and pipe
>> it though the "git-bundle2text" program which would result in a
>> "human" inspectable format as opposed to the packed format[2]. The
>> security reviewer would then see all the information being released
>> and with the help of the public repository see how the data changes
>> the repository.
>>
>> Am I barking up the right tree?
>
> First, a shot out of left field: how about a patch based workflow? (similar to the mailing list, just replace email with sneakernet)  Patches are plain text and simple to review (preferable to an "opaque" binary format?).


I would propose a slightly different workflow as well, which might
make this process lightly easier. Maybe you are already doing
something like this, but I'll lay it out just in case.

The first step would be to create a 'to-be-publicly-released' branch
within the secret repository, starting from the head of the original
public repository. Rebase all non-secret work to this branch, and
organise it in whatever fashion necessary. This could be, for example,
one single commit representing the sum of all non-secret changes, or
it could be an approximation of the actual history of these changes.

Once this branch has been prepared, you can verify that it branched
from the public repository and that it contains no secret information
using standard git tools or even a patch view of the entire branch.
You can even add a signed tag to the branch once verified to record
who is verifying these changes, and ensuring nothing else gets added
by someone else.

Then you can use 'git bundle fromVerifiedTag.bundle
verifiedTag..public/master' to create a bundle containing just those
commits on the release branch and their associated objects. You can
verify what was included using 'git bundle list-heads
fromVerifiedTag.bundle' to verify what was included.

Perhaps there is a further need to look into the packed objects to
verify nothing else is included, but this workflow should provide more
confidence in the bundled objects in the first place. As for actually
verifying the bundled data after the bundle, I don't know so you would
have to look to the other answers.

Regards,

Andrew Ardill
