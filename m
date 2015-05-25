From: Christian Couder <christian.couder@gmail.com>
Subject: Re: Pushing and pulling the result of `git replace` and objects/info/alternates
Date: Mon, 25 May 2015 12:28:14 +0200
Message-ID: <CAP8UFD20u1OG88bvDAW4vsh=yPihp3TMjc95wDuD=nnr8esBgw@mail.gmail.com>
References: <CACHsx4Kz3_bMbKqd1O7-ZXLBUqJBs6hTsiRNAALNJhDV44v6Rw@mail.gmail.com>
	<CAP8UFD3G8_ChRX6HHtieFTksUJBiXu9FLNbewFQVj7qPyGh8EQ@mail.gmail.com>
	<5562F01D.8000601@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Stephen Kelly <steveire@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 25 12:28:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YwpcL-0000hH-D2
	for gcvg-git-2@plane.gmane.org; Mon, 25 May 2015 12:28:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751537AbbEYK2Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2015 06:28:16 -0400
Received: from mail-wg0-f43.google.com ([74.125.82.43]:32866 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751203AbbEYK2P (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 May 2015 06:28:15 -0400
Received: by wgez8 with SMTP id z8so69621222wge.0
        for <git@vger.kernel.org>; Mon, 25 May 2015 03:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=OBOrTdr4FErH2o4X5458iOhrvc1T6BrftzBq4x7QQoc=;
        b=WmW3ebUQFDPQgQTX5uq+YvsfRH0TKCwYDbIXT2skQN4FSoFRp+9ngKjN217kNpWhfs
         ZfjdEKT/siwN5fILUnojNG5vrIinzSBhaJKDI9xgFtMYp+07Gs+DNFiCT4t0koXi8h36
         H+VoL65SOkYRtaVN5hh1CBJIps+DbTu/IWT8Q+Uh5q++ITdAdWD2qAnZr0rTp+J/3KQk
         pGnAlXzE//KEy0FeVn9yxRklDA0mcm92UDstk6vnJIjIkWTEfSpLAIfNGj9i0stRXax6
         X9W/uz5ATo8k5uVlpyq/VRGySqMjoLfMfd26lanrKLfn/8dmDtT/rUPfHvS+HoLi3Vaw
         zRzA==
X-Received: by 10.180.88.99 with SMTP id bf3mr30072933wib.75.1432549694402;
 Mon, 25 May 2015 03:28:14 -0700 (PDT)
Received: by 10.194.40.8 with HTTP; Mon, 25 May 2015 03:28:14 -0700 (PDT)
In-Reply-To: <5562F01D.8000601@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269835>

On Mon, May 25, 2015 at 11:49 AM, Stephen Kelly <steveire@gmail.com> wrote:
> On 05/24/2015 07:28 AM, Christian Couder wrote:
>> Hi,
>>
>> On Fri, May 22, 2015 at 4:38 PM, Stephen Kelly <steveire@gmail.com> wrote:
>>> I have tried out using `git replace --graft` and
>>> .git/objects/info/alternates to 'refer to' the history in the origin
>>> repo instead of 'duplicating' it. This is similar to how Qt5 repos
>>> refer to Qt 4 history in a different repo.
>>>
>>> Question 1) Is this a reasonable thing to do for this scenario?
>> I think it should work without too much work, but see the answer to
>> the next question.
>
> Ok, thanks. The concern is that there is plenty of documentation for
> git-filter-branch, but no documentation or porcelain for info/alternates
> and little out on the internet about it or git replace and using them
> together.
>
> However, it seems to be a reasonable thing to do.

Yeah.

By the way it looks like I was wrong in my answer to your second question.

You might want to clone using the --reference option to automatically
set up .git/objects/info/alternates properly.

(There is an ongoing related thread on the list:

http://thread.gmane.org/gmane.comp.version-control.git/269537)

You might also be able to clone using an option like "--config
remote.origin.fetch = 'refs/replace/*:refs/replace/*'" to fetch the
replace ref when cloning.

So it looks like you might just need to clone with a few more options
than usual.

I haven't tested it so please tell me if it works :-)

>>> echo "../../calculator/objects" >
>>> ../.git/modules/compute/objects/info/alternates
>>> git replace --graft HEAD $extraction_sha
>> Maybe use the following instead of the above line:
>>
>> git fetch 'refs/replace/*:refs/replace/*'
>
> Thanks.
>
>>> # And now we see the history from the calculator repo. Great. But, it
>>> required user action after the clone.
>> Yeah, but if the 2 above commands are in a script maybe it's
>> reasonable to ask the user to launch the script once after cloning.
>
> Would it be possible to do this in a hook in the 'integration repo'
> which contains both submodules in the example I posted? Like a fetch
> hook or something?

It is possible to do whatever you want in a hook, but the question is
why would you do it in a hook as it looks like it needs to be done
only once?

Or maybe I am missing something?

Best,
Christian.
