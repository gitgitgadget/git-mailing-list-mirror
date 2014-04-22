From: Ilya Bobyr <ilya.bobyr@gmail.com>
Subject: Re: [RTC/PATCH] Add 'update-branch' hook
Date: Mon, 21 Apr 2014 23:05:23 -0700
Message-ID: <535606A3.8040704@gmail.com>
References: <1398047016-21643-1-git-send-email-felipe.contreras@gmail.com> <53558AD0.3010602@gmail.com> <53558a663ea74_604be1f30c2c@nysa.notmuch> <53558F6F.7080306@gmail.com> <53558f285f379_640076f2f094@nysa.notmuch> <CADcHDF+XcWEkvyP3tL4ibicnaMVJpixUZu1Ces0BXWkzPGsodw@mail.gmail.com> <53559a8333aaa_6c39e772f07f@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 22 08:05:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcTpo-0000sd-Ms
	for gcvg-git-2@plane.gmane.org; Tue, 22 Apr 2014 08:05:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752125AbaDVGFc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2014 02:05:32 -0400
Received: from mail-pb0-f42.google.com ([209.85.160.42]:59341 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751998AbaDVGFb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2014 02:05:31 -0400
Received: by mail-pb0-f42.google.com with SMTP id un15so593989pbc.1
        for <git@vger.kernel.org>; Mon, 21 Apr 2014 23:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=5ilshYULBn9TcIZJ4xObVsOIPAJY9tFL5N6j9oz9Cog=;
        b=JU5/2XpNaQz0S3TlNuph7NrtdSYrLxLXJYNhJXT4MzuxmNjj44JpGOIDgawitKSYgS
         r3d4zQZvygB3O4LYppFuLCz2JAcX0O2gghXIIpKTkyFiMHEuHFBF6E5uF7w0r92tv5bP
         xNnutmHhj15+DVUEiCrpLxQSWKYYsYUzRi1WeEtUmEGCHr3ENAV6ncWc3LcK0C1mAN9Y
         RIzm4K2yFvm54Ku08Ick8j3tvQc5SGVS49Yb+CeT1fXlQIS1JcefthdTU36JwC/3Rhwm
         1HTqS3l8EXjTofhVePeW5brXbk6vEwjj54ugUeaXjLK8dwYgNMhqOTkyp3Ca5zPXdpRN
         0Qaw==
X-Received: by 10.68.196.202 with SMTP id io10mr7123664pbc.149.1398146731405;
        Mon, 21 Apr 2014 23:05:31 -0700 (PDT)
Received: from [192.168.1.2] (c-50-136-172-14.hsd1.ca.comcast.net. [50.136.172.14])
        by mx.google.com with ESMTPSA id my6sm82238604pbc.36.2014.04.21.23.05.30
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Apr 2014 23:05:30 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:28.0) Gecko/20100101 Thunderbird/28.0
In-Reply-To: <53559a8333aaa_6c39e772f07f@nysa.notmuch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246698>

On 4/21/2014 3:24 PM, Felipe Contreras wrote:
> Ilya Bobyr wrote:
>> On Mon, Apr 21, 2014 at 2:35 PM, Felipe Contreras <
>> felipe.contreras@gmail.com> wrote:
>>> Ilya Bobyr wrote:
>>>> test_expect_success 'setup' "
>>>>       mkdir -p .git/hooks &&
>>>>       cat > .git/hooks/update-branch <<-\\EOF &&
>>>>       #!/bin/sh
>>>>       echo \$@ > .git/update-branch.args
>>>>       EOF
>>>>       chmod +x .git/hooks/update-branch &&
>>>>       echo one > content &&
>>>>       git add content &&
>>>>       git commit -a -m one
>>>> "
>>> That is not maintainable at all.
>> Maybe you could explain how is this less maintainable, compared to a separate
>> function?
> Do I really have to explain that manually escaping a shell script is not
> maintainable?

This is rude.

Here is how you can do it without escaping:

test_expect_success 'setup' '
	mkdir -p .git/hooks &&
	cat > .git/hooks/update-branch <<-\EOF &&
	#!/bin/sh
	echo $@ > .git/update-branch.args
	EOF
	chmod +x .git/hooks/update-branch &&
	echo one > content &&
	git add content &&
	git commit -a -m one
'

It is not different from most of the tests, I think.

>> This is how it is suggested by t/README and how it is done in the other
>> test suites.
>> I can not see how your case is different, but I might be missing something.
> Let's take a cursoy look at `git grep -l "'EOF'" t`.
>
> [...]

So the point is that some existing tests violate best practices?
I do not think this is a good justification to do the same for new tests.

> In fact my version is actually cleaner than these, because the code that is run
> outside the cage is clearly delimited by a function.

It depends on the perspective.
If it fails, the failure would be missed regardless of if it is in a
function or not.
Most examples that you quoted only create files outside test_expect_success.
Even that is not necessary.

I am not telling you how you should write it.
I am just saying that you are breaking one of the recommendations on how
to write tests.
There are different options that adhere to the suggestions in t/README.
