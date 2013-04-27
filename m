From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH] clean: confirm before cleaning files and directories
Date: Sat, 27 Apr 2013 10:09:10 +0800
Message-ID: <CANYiYbEjcPMnzZvFgJON-K0WekucGOQVn0dk9_W9HkrNZJN3Lw@mail.gmail.com>
References: <1826d070612808b301f9295838e226e02d8097ad.1366963586.git.worldhello.net@gmail.com>
	<vpqfvydhfbx.fsf@grenoble-inp.fr>
	<CANYiYbFzEoEgJzKsB_hiKNy2JCxaTDX30wXNjnzComOzJJF_cw@mail.gmail.com>
	<7vbo91z30e.fsf@alter.siamese.dyndns.org>
	<vpqzjwl9se7.fsf@grenoble-inp.fr>
	<7vppxhxltk.fsf@alter.siamese.dyndns.org>
	<7vmwslw1py.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 27 04:09:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVua0-0005a3-3C
	for gcvg-git-2@plane.gmane.org; Sat, 27 Apr 2013 04:09:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752954Ab3D0CJN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Apr 2013 22:09:13 -0400
Received: from mail-we0-f171.google.com ([74.125.82.171]:38056 "EHLO
	mail-we0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751108Ab3D0CJM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Apr 2013 22:09:12 -0400
Received: by mail-we0-f171.google.com with SMTP id t57so2152328wey.16
        for <git@vger.kernel.org>; Fri, 26 Apr 2013 19:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=dHAqjSwCOFzCjEzi4NIKutO8PtdqQBkBSO+egJglFOI=;
        b=Fp0MqEpH1q0S5cpFQgmrqx+R+nwkCgcGGK6zcm9cE8Ez/9RjjB7JAxpX7rYkC9tg4S
         sLNPZUHP0zQCZlvfM9ADtNuYvwtDM8yIZKqLaipu2u6O9LhCVIW6F/wL5TpWGIQn3xbt
         8wmCZ30Nnqw1Cx6s9xOLpLtE1MGYm7ztwLFeNO9BiZFpm60OEY5uv8OxbuDQ3slDqwyG
         Wyr/pTa4iyGxPQpk2C148XAhVyEBK3mELFaduXM9nYFyPklo/9EXS3qPYvw5T6yEUpkS
         Zcc/cFx6/0sO/XGsF6i0Oq/1Y3T0cfqUACZ6L30CSMt96h2GxxpydGPxhxPeobaZNDdR
         pHFA==
X-Received: by 10.194.89.169 with SMTP id bp9mr85806928wjb.57.1367028550905;
 Fri, 26 Apr 2013 19:09:10 -0700 (PDT)
Received: by 10.194.175.72 with HTTP; Fri, 26 Apr 2013 19:09:10 -0700 (PDT)
In-Reply-To: <7vmwslw1py.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222614>

2013/4/27 Junio C Hamano <gitster@pobox.com>:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>>
>>> The nice thing with the confirmation dialog is that it shows the list
>>> before asking (and unlike 'rm -i', it asks only once).
>>
>> I wouldn't object to having "clean -i", which automatically defeats
>> the requireforce option.
>>
>> As to a huge single list you have to approve or reject as a whole, I
>> am on the fence.  When running "rm -i", I often wished to see
>> something like that, but I am fairly sure that I'll call it unusable
>> the first time I see a list with a few items I want to keep while
>> removing all others.
>
> Elaborating on this a bit more, hoping it would help people who want
> to design the "--confirm-before-doing" option...
>
> The primary reason I think the user will find "We are going to
> remove these.  OK?" irritating is that most of the time, there are
> only a few items that the user would want to keep.
>
>         $ rm --confirm-before-doing -r path
>         ... list of three dozens of items, among which
>         ... there may be two items that should be kept
>         Remove all? [Y/n]
>
> After seeing this prompt and saying 'n', the user would _not_ thank
> the command for reminding about these precious two items, because
> the only next step available to the user is to remove the remaining
> 34 items manually.
>
> "Confirm in bulk before doing" feature can become useful if it had a
> "line item veto" option in the confirmation time.  The interaction
> then could go like this:
>
>         $ rm --confirm-before-doing -r path
>         path/foo    path/frotz/nitfol    path/sotto
>         path/bar    path/frotz/xyzzy     path/trail
>         ...            ...               ...
>         Remove (list items you want to keep)? path/frotz
>
> and the user could instruct it to remove everything other than those
> inside path/fortz.  If the user do not want to remove anything,
> there is an option to ^C out of the command.

Agree. I will send a reroll latter.

-- 
Jiang Xin
