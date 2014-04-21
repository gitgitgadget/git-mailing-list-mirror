From: Ilya Bobyr <ilya.bobyr@gmail.com>
Subject: Re: [RTC/PATCH] Add 'update-branch' hook
Date: Mon, 21 Apr 2014 14:36:47 -0700
Message-ID: <53558F6F.7080306@gmail.com>
References: <1398047016-21643-1-git-send-email-felipe.contreras@gmail.com> <53558AD0.3010602@gmail.com> <53558a663ea74_604be1f30c2c@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 21 23:37:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcLtc-00050V-CU
	for gcvg-git-2@plane.gmane.org; Mon, 21 Apr 2014 23:37:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754532AbaDUVg4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Apr 2014 17:36:56 -0400
Received: from mail-pb0-f45.google.com ([209.85.160.45]:47417 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754493AbaDUVgz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Apr 2014 17:36:55 -0400
Received: by mail-pb0-f45.google.com with SMTP id uo5so4150103pbc.18
        for <git@vger.kernel.org>; Mon, 21 Apr 2014 14:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=TVLxb88kZ3FXUGmAmTduU9/SUQ7DsjnOadV4IRFcPgI=;
        b=l3rdwT4URUjn4ctTkg/Lg5MzzL3scx1AMaM5tPxPaE7N7/k/oF9gtNe/ZeJGvfPy9G
         P0GmvnvjDWFhMNcWWU+Iihmy3lsYKSKOMoQNRVFnb/huLCg98DDlMYrLZE26v34dzSSj
         IoXPkpYLoj3yVgN9nLH/SOp/ONXs4i3N6W1KNwH/HVWJeSNyUmUfUu21/YBWKmWL4g4q
         CJpvw3PwjRt+FmY+6mEj4eLT9YqNEw4GfmvKkd/5GlDl4eZAGnxE2wlFhckEdCJl1sCl
         mUZYOzCYmGeL/KnEVvkIukU6XBjlXBev/Hn/sUpGJQAOAq2ay+JWxl3x8ydwA4unc+nm
         uIog==
X-Received: by 10.68.240.68 with SMTP id vy4mr5583097pbc.127.1398116215229;
        Mon, 21 Apr 2014 14:36:55 -0700 (PDT)
Received: from [192.168.1.2] (c-50-136-172-14.hsd1.ca.comcast.net. [50.136.172.14])
        by mx.google.com with ESMTPSA id id10sm80198149pbc.35.2014.04.21.14.36.54
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Apr 2014 14:36:54 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:28.0) Gecko/20100101 Thunderbird/28.0
In-Reply-To: <53558a663ea74_604be1f30c2c@nysa.notmuch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246649>

On 4/21/2014 2:15 PM, Felipe Contreras wrote:
> Ilya Bobyr wrote:
>> On 4/20/2014 7:23 PM, Felipe Contreras wrote:
>>> [...]
>>>
>>> diff --git a/t/t5408-update-branch-hook.sh b/t/t5408-update-branch-hook.sh
>>> new file mode 100755
>>> index 0000000..d921c0e
>>> --- /dev/null
>>> +++ b/t/t5408-update-branch-hook.sh
>>> @@ -0,0 +1,39 @@
>>> +#!/bin/sh
>>> +
>>> +test_description='Test the update-branch hook'
>>> +
>>> +. ./test-lib.sh
>>> +
>>> +setup () {
>>> +	mkdir -p .git/hooks &&
>>> +	cat > .git/hooks/update-branch <<-'EOF' &&
>>> +	#!/bin/sh
>>> +	echo $@ > .git/update-branch.args
>>> +	EOF
>>> +	chmod +x .git/hooks/update-branch &&
>>> +	echo one > content &&
>>> +	git add content &&
>>> +	git commit -a -m one
>>> +}
>>> +
>>> +setup
>> According to t/README `setup` should be inside an assertion just as any
>> other test:
> I have a bunch of 'setup' calls outside such assertions already in other test
> scripts. If you know how to put single quotes inside of single quotes in a
> shell script, please share that knowledge, otherwise the setup must be outside.
>
> Of course we could do the extremely reduntant:
>
> test_expect_success 'setup' '
>   setup
> '

Setup does not look any different from the other tests.
If you need single quotes you could use double quotes outside.  Though,
you would have to quote other things as well.
t0000-basic.sh has a lot of tests that do that.
Like this, for example:

test_expect_success 'setup' "
	mkdir -p .git/hooks &&
	cat > .git/hooks/update-branch <<-\\EOF &&
	#!/bin/sh
	echo \$@ > .git/update-branch.args
	EOF
	chmod +x .git/hooks/update-branch &&
	echo one > content &&
	git add content &&
	git commit -a -m one
"
