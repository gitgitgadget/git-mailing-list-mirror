From: Anders Ro <anders.ronnbrant@gmail.com>
Subject: Re: [PATCH/RFC] Pinning of submodules
Date: Tue, 8 Sep 2015 01:27:49 +0200
Message-ID: <55EE1D75.1030109@gmail.com>
References: <55E78522.1030107@gmail.com> <55E78780.2040801@gmail.com>
 <CAPig+cQ6Ls1iasVsTwbpqGWt9=7gBuWjWAPmSMJCStsdPUwCgg@mail.gmail.com>
 <55ECB956.1080909@gmail.com>
 <CAPig+cRwAjTF6_rT8+nhbsZTYcZqneWSZ_LTCo9z2m5+SEGwWg@mail.gmail.com>
 <55EDEFDC.3040605@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Mark Levedahl <mlevedahl@gmail.com>,
	"W. Trevor King" <wking@tremily.us>
To: Jens Lehmann <Jens.Lehmann@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Sep 08 01:28:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZZ5pn-0004rf-Tn
	for gcvg-git-2@plane.gmane.org; Tue, 08 Sep 2015 01:28:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751197AbbIGX1w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Sep 2015 19:27:52 -0400
Received: from mail-la0-f41.google.com ([209.85.215.41]:33364 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751135AbbIGX1w (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Sep 2015 19:27:52 -0400
Received: by lamp12 with SMTP id p12so57226982lam.0
        for <git@vger.kernel.org>; Mon, 07 Sep 2015 16:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-type:content-transfer-encoding;
        bh=QVs9uLqnBNJ05INpnNxQ2oEKfMglDXAy7AWgn6pz8O8=;
        b=fNI0KdGIROlXdgJBpUPQKcMkM075YJ4Om6ja21vwZF2RE8VAnGgHW0g3TAuJa/2/EL
         jonXnf1p7+6ekSiR10+VKWwmqwGFwOkgXfqVWAwoS1NKTj6FAyqvRAQ0VtceDzOUFOXU
         cr99rR+f/ZytFf2BiE7HK3aM5FDkBD2IX6L5W3/CwapWB3MGjtoH5/gxUHZFYUFVkQiX
         WdumKtLRZH79TXnHH+yOg5O7PKUpkLDjaCZCKO+LBEFoO0Gru38rE8n1DrzCAY2Ih6PX
         vL2szP77HEAbBf1wHGWElEkYZMK3r5m6fx0kPI9rUAYIMEWp3B7qRSjYg+IGpX4xMoRR
         PeTg==
X-Received: by 10.112.161.232 with SMTP id xv8mr19238700lbb.123.1441668470496;
        Mon, 07 Sep 2015 16:27:50 -0700 (PDT)
Received: from [192.168.1.20] (h-176-10-249-254.na.cust.bahnhof.se. [176.10.249.254])
        by smtp.gmail.com with ESMTPSA id si3sm394716lbb.32.2015.09.07.16.27.49
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Sep 2015 16:27:49 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
In-Reply-To: <55EDEFDC.3040605@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277479>

On 07/09/15 22:13, Jens Lehmann wrote:
> Am 07.09.2015 um 01:43 schrieb Eric Sunshine:
>> On Sun, Sep 6, 2015 at 6:08 PM, Anders Ro <anders.ronnbrant@gmail.com>
>> wrote:
>>> On 04/09/15 07:02, Eric Sunshine wrote:
>>>> On Wed, Sep 2, 2015 at 7:34 PM, Anders Ro
>>>> <anders.ronnbrant@gmail.com> wrote:
>>>>> git-submodule.sh: pin submodule when branch name is '@'
>>>>>
>>>>> Setting branch name to '@' for a submodule will disable 'git submodule
>>>>> update --remote' calls for that specific submodule. I.e. instead of
>>>>> follow the unspecified default choice of master, nothing is being
>>>>> updated. This is useful when multiple submodules exist but not all
>>>>> should follow the remote branch head.
>>>>
>>>> With the disclaimer that I'm not a submodule user (to which the
>>>> answer might be obvious): What benefit is there in using a magic
>>>> value like this ("@") over, say, an explicit configuration setting?
>>>
>>>  From what I have understood (not a submodule expert yet) the '@' is an
>>> invalid branch name and should therefore not collide with any current
>>> branches. My idea was to disable the '--remote' option when the user
>>> have explicitly set an invalid branch name to not modify any current
>>> behaviour. Though having an explicit option is of course more
>>> clarifying. The current behaviour though is that empty branch name means
>>> "follow master" which is somewhat unintuitive.
>>
>> My concern in asking was that some future person might come up with
>> another scenario which also wants to use a "magic value" and would
>> have to invent / arrive at another "illegal" representation. Hence, an
>> explicit setting might be more appropriate. However, as stated, I
>> don't even use submodules, so I may be far off the mark. I've cc'd a
>> few of the submodule maintainers with the hope that they will chime
>> in.

Agree this is not a "future proof" solution. Though faily a quick one. I
started with a setting but realized it involved a bit more changes since
you should be able to tell the submodule command to pin a submodule
right from the start etc.

> 
> Added Trevor to the CC, who is the original author of --remote (see
> 06b1abb5b).
> 
> While I believe that adding such functionality makes perfect sense,
> I do not find it terribly obvious that setting the branch to '@' will
> make --remote skip this submodule. I wouldn't care so much if we'd
> only use this value internally, but this is user visible (and has to
> be set by the user if she wants to skip a submodule in --remote).
> 
> Setting the branch to an empty value feels a bit more natural, but
> I'm not so sure our config handling supports that well (we seem to
> assume in quite some places that empty equals unset). So I tend to
> prefer a new option for that.

I started out that way, thinking that would solve my initial problem of
having 4 submodules which should follow branch 'develop' and one
submodule that should stay put until explicitly changed. Instead having
empty an branch name gave me 'master' on that module, which was way off
current status of the code to say the least. This was all executed by
Jenkins which either gives you "update remote branches" or "not update
remote branches". Thus no other choice than to change the code.

The current 'git submodule add' takes option '-b' as branch and last
time I tried providing '@' as branch name it did not work. That
indicates that there should be a '-p' option for pinning the submodule
from the start. Having to fiddle with the .gitmodules file after the
fact is not really user friendly (though it have worked for me for a
while). I will have a go at an explicit setting in a week or two and get
back for comments on that. Perhaps some maintainers can give some hints
on adding a new option etc meanwhile. How about option '-p, ---pinned'
and setting 'submodule.<branch>.pinned = true|false'?

Cleaned-up the test code according to Eric's comments, looks a bit more
stylish actually :).
