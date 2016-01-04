From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: Feature request: git bisect merge to usable base
Date: Mon, 4 Jan 2016 10:15:11 -0800
Message-ID: <CALCETrUO2Gx9vRqkGLaGWLsuMs98k5d3PKEPfx3RZf4+fpko4Q@mail.gmail.com>
References: <CALCETrUgsawpwkkjO_BpPHyOaH7NsJNU-4mF97a6NAxCMB5aUA@mail.gmail.com>
 <xmqqsi2jem15.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Andy Lutomirski <luto@kernel.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 04 19:15:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aG9fM-00021W-9j
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jan 2016 19:15:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751678AbcADSPd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jan 2016 13:15:33 -0500
Received: from mail-ob0-f176.google.com ([209.85.214.176]:36312 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751561AbcADSPb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jan 2016 13:15:31 -0500
Received: by mail-ob0-f176.google.com with SMTP id ba1so254543134obb.3
        for <git@vger.kernel.org>; Mon, 04 Jan 2016 10:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=R1JB86ZOY/KYQ/HwC7cOQKtNxUAMXMpGy8GBzH6gfPI=;
        b=EaV1QpxHqyfve4TOMyBtctYcSvV0VRgABGAA4rXbFpQXFGEhqwJuTKPXD4Mx3CCKRY
         9EYQE+DqH4xQzy60SUYIkHsCpIcCuuG1/Z0DPYAeQmCvLLFedzbgKTW+3dT6M8afsWoq
         dbZ1G1/YVHxEelu9SVHKaimzkYqImE+vFkvGgAJFJJOVhGqYQTH2kj13eDzXG0IgFS5g
         Wkw45PikOg+BipBHrrzZv2BGhZzjuzCZYwivGCF9qSewbU0an6/rfi4Yb7P6fHLN7pzM
         Fq1J7pi3fNVB8AURT4gJlwZgB6c876z2rbCet/WIPKu8+NRwSjXRjWuJv9lDK0y0LlEh
         Jk3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=R1JB86ZOY/KYQ/HwC7cOQKtNxUAMXMpGy8GBzH6gfPI=;
        b=W4Ru4tt7GPJbISjgjyJ5JaAAx0gRbHKFJki7vMA2qRwbNLYPGkEix2glRcQgckQTqU
         qLCrSGRdSBFuIfZU2EyUxoHzCfGjjPzju5frC5cWXwRZiqZvL1Hg376H5PHUo7N9J3GR
         4W6pm66BNQPyEAxzX0WSHGlcLqszackSPDtSHLBTmP+iOlh1iRn8OPyYl/Y60S1U3S+F
         pXkvi4z4kZ+GaKKeIHOtfwt72jlRvlg0sPf1hS0I6r0bpxGN+iVCDNf22cpKGYw5CueB
         IcMftmF6z/OsFXKq1FCI4U5V1W+bnU4bIWJMHxTO0ymDzqDIWDjNWa+hkm8I7agz6HC5
         LYjg==
X-Gm-Message-State: ALoCoQmsbbM2ZiX6KOPZIHiOzMGK3b5kH6dHPCFK4uyXD1PkSCUISyp2oRTqmHwAsFypSzLiieTDqCyu8f6l8thA3UxJbras9A==
X-Received: by 10.182.171.105 with SMTP id at9mr65629031obc.49.1451931330904;
 Mon, 04 Jan 2016 10:15:30 -0800 (PST)
Received: by 10.202.102.231 with HTTP; Mon, 4 Jan 2016 10:15:11 -0800 (PST)
In-Reply-To: <xmqqsi2jem15.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283313>

On Wed, Dec 30, 2015 at 12:09 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Andy Lutomirski <luto@kernel.org> writes:
>
>> I'm currently bisecting a Linux bug on my laptop.  The starting good
>> commit is v4.4-rc3 and the starting bad commit is v4.4-rc7.
>> Unfortunately, anything much older than v4.4-rc3 doesn't boot at all.
>>
>> I'd like to say:
>>
>> $ git bisect merge-to v4.4-rc3
>>
>> or similar.  The effect would be that, rather than testing commits in
>> between the good and bad commits, it would test the result of merging
>> those commits with v4.4-rc3.
>>
>> Obviously the syntax could be tweaked a lot, but I think the concept
>> could be quite handy.
>
> I do not think such an option or "concept" belongs to "git bisect".
>
> When "git bisect" checks out a commit to test, it is entirely up to
> you how to decide if the commit is good or bad.  Your example is to
> work on the Linux kernel project, so the way to test might be "make
> mrproper && make bzImage && ... && reboot" to see if the result
> boots.
>
> There is nothing that prevents you from changing the test procedure
> to be prefixed by "if the version to test is older than version X,
> merge the commit to version X first before doing anything else".
>
> The key thing to realize is that "merge the version X" is not
> universally useful "fixup" to deal with unbuildable or untestable
> commit.  In some situations, "I have this fix-up patch I need to
> apply for versions that are older than Y before I can test" may be a
> lot more appropriate "fixup".  So "merge-to" does not deserve to be
> the first-class "concept".
>
> "Here is a script to fix up the tree that 'git bisect' tells me to
> test" instead might be a general enough concept, and you might say
>
>         $ git bisect --fixup "./my-fixup-script"
>
> and have "git merge --no-commit v4.4-rc3" in "my-fixup-script",
> perhaps.
>
> But at that point, it would be as easy as adding whatever you would
> write in my-fixup-script at the beginning of the script you are
> already using (and if you aren't, read up on "git bisect run") to
> perform the test.  So...

git bisect run is great, but it's not so great when the test process
is "sudo make modules_install && sudo make install && reboot", then
boot new kernel, then run emacs, then see if it worked...  There
doesn't appear to be a 'git bisect run' option to pause and wait for
an explicit user request to continue, unfortunately.

--Andy
