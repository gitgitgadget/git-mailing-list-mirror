From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] Add new @ shortcut for HEAD
Date: Tue, 30 Apr 2013 12:47:57 -0500
Message-ID: <CAMP44s0PcB7nu_67p=hfMy4Kb2iYTSp5ZT6y2Gn24OAtDzR_sw@mail.gmail.com>
References: <1367264106-2351-1-git-send-email-felipe.contreras@gmail.com>
	<CACsJy8D_gPpprETkAxf+eYp5DMt7uVt6nanCwthZO=vVfBT28Q@mail.gmail.com>
	<7vppxcdjd1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jon Seymour <jon.seymour@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 30 19:48:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXEf2-0001WB-EG
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 19:48:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760692Ab3D3RsA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 13:48:00 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:41184 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758517Ab3D3Rr6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 13:47:58 -0400
Received: by mail-la0-f46.google.com with SMTP id fs13so681291lab.19
        for <git@vger.kernel.org>; Tue, 30 Apr 2013 10:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=CCgRa0vtPyGHXCqE8VVluusx0muxlGzcphhvHc/J3f4=;
        b=TMeChbzQBSyjevBIr9M0MUA/h46y8Jz8DR4WBBVO7gPYjpNuU3o4t0KdyJxcZ+H3gj
         g+TD68/x22OgUb7A4Yh0KnBt6nc4EIAiQOXyhJxQWOAxmI4NtPahfdEGgfJP68Ly71s0
         cJHUkXUO8ChkKkD0y6VGXzxSR9QFEKIKehgXTeTFZYvo8VZ17XM5NpUX7M9nmuC3FFR2
         t6Thm7E373WsnDoenmWZ83qwMYRTwt/lL+d9cWHaOOP04AziloUDc1p6BcmB71LbdMD5
         HZJZIAgWu7cpfAv+9lW8ED+/ugYIkcnPRq/w+XR3V2HGmg8ZHtcnKD9rmPsTMfauldih
         i2IA==
X-Received: by 10.152.22.168 with SMTP id e8mr8507135laf.20.1367344077193;
 Tue, 30 Apr 2013 10:47:57 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Tue, 30 Apr 2013 10:47:57 -0700 (PDT)
In-Reply-To: <7vppxcdjd1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222967>

On Tue, Apr 30, 2013 at 12:22 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> On Tue, Apr 30, 2013 at 2:35 AM, Felipe Contreras
>> <felipe.contreras@gmail.com> wrote:
>>> So we can type '@' instead of 'HEAD@', or rather 'HEAD'. So now we can
>>> use 'git show @~1', and all that goody goodness.
>>
>> I like this. I haven't spent a lot of time on thinking about
>> ambiguation. But I think we're safe there. '@' is not overloaded much
>> like ':', '^' or '~'.
>>
>>> This patch allows 'HEAD@' to be the same as 'HEAD@{0}', and similarly with
>>> 'master@'.
>>
>> I'm a bit reluctant to this. It looks like incomplete syntax to me as
>> '@' has always been followed by '{'. Can we have the lone '@' candy
>> but reject master@ and HEAD@? There's no actual gain in writing
>> master@ vs master@{0}.
>
> Originally I was going to say the same, but after thinking about it
> a bit more, I changed my mind.
>
> If you accept only "@" but not "master@", that behaviour needs a
> wrong world model to understand and justify (one of which is "@ is a
> synonym for HEAD").  If your rule is "In $anything@{$n}, you can
> drop {$n} when $n==0", then HEAD@{0} becomes HEAD@ and master@{0}
> becomes master@, and @{0} becomes @ naturally.
>
> We should make sure that the code rejects "git update-ref @ foo"
> because that is "git update-ref @{0} ref", by the way.  I didn't
> check with Felipe's patch.

Hmm, with or without my patch 'git update @ foo' does nothing, same
with 'git update blah foo'. No error, no non-zero exit code, just
doesn't do anything.

>>> +'@'::
>>> +  '@' alone is a shortcut for 'HEAD'
>>> +
>
> I think this explanation sends a wrong message, hinting as if you
> can expect "update-ref @ master", "symbolic-ref @ refs/heads/next"
> etc. to do something sensible to HEAD.

Why would it? This is Documentation/revisions.txt, 'update-ref' has
nothing to do with that.

This hints that the user can do "update-ref @" as much as the
paragraph below thins that that user can do "update-ref
master@{today}".

Cheers.

-- 
Felipe Contreras
