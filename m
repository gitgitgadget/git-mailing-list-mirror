From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v4 09/10] config: add core.untrackedCache
Date: Fri, 8 Jan 2016 18:52:31 +0100
Message-ID: <CAP8UFD2eJjR4QxtE0x8BbKOAGwi4cwERG7bF89apPbJye356AQ@mail.gmail.com>
References: <1451372974-16266-1-git-send-email-chriscool@tuxfamily.org>
	<1451372974-16266-10-git-send-email-chriscool@tuxfamily.org>
	<xmqqlh8cg9y2.fsf@gitster.mtv.corp.google.com>
	<CAP8UFD0pOiqa5ZxwM0Vfzr_wMJ+HDrXyhzJ+TmRDED5GH+koMw@mail.gmail.com>
	<xmqqbn97cyh3.fsf@gitster.mtv.corp.google.com>
	<CAP8UFD35VZ3QCLg525RCpacDrRHqt7EhxV1MeL-9xxHf8BCZ+A@mail.gmail.com>
	<xmqqd1thp683.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 08 18:52:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aHbDL-0003kf-Gj
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jan 2016 18:52:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755977AbcAHRwf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2016 12:52:35 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:36364 "EHLO
	mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755865AbcAHRwd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2016 12:52:33 -0500
Received: by mail-lf0-f67.google.com with SMTP id t141so2270898lfd.3
        for <git@vger.kernel.org>; Fri, 08 Jan 2016 09:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=7KgOVmRzSODpQ5wO66UK/Bfmvvj1gihngAviIGtcHCY=;
        b=iGYYqSHXt2+5akxsQ7a7hXKy6bYe45V0NNpuZohPKmgW/Q8KhFxXvFe3b2pEz+Qnql
         FoF24/0NVkHpkDl2hfFFOWxoeIQQk+EepUD/qrx6hoVWtDK3o7vy8JK/RsnZHwttwVYo
         Q5Dyru+QXdttpMGuHePHWB8JRutU+wipZ+uhvyPkgftcnPgN+VzPX4/tUFTEF2DuZvDa
         dUt3GWCXFTPJw5e2tWeWw6D/gzeO5/9mg01YAAwBqylR3qreHZl+gXSJoNjSZJMYStYI
         ZHJ+wnp49eyCzzyclTyRpnhQ0lmQBjvk9P1LJrc2M9FP9n7t+xsoP3gWt8Pm1J577clD
         B/WA==
X-Received: by 10.25.39.200 with SMTP id n191mr40745751lfn.7.1452275551929;
 Fri, 08 Jan 2016 09:52:31 -0800 (PST)
Received: by 10.25.216.143 with HTTP; Fri, 8 Jan 2016 09:52:31 -0800 (PST)
In-Reply-To: <xmqqd1thp683.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283569>

On Mon, Jan 4, 2016 at 7:09 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>>>
>>> The real question is what are the problems in implementing this in
>>> the way Duy suggested in the previous discussion.  The answer may
>>> fall into somewhere between "that approach does not work in such and
>>> such cases, so this is the best I could come up with" and "I know
>>> that approach is far superiour, but I have invested too much in this
>>> inferiour approach and refuse to rework it further to make it better."
>>
>> My question is why should I invest time thinking about and testing
>> another approach when the current approach seems simpler, less bug
>> prone, faster and without any downside?

I just tried Duy's approach by moving into read_index_from() the code
I had put in wt_status_collect_untracked() and it doesn't work because
"git status" calls read_index_from() before calling
git_default_core_config().

The interesting parts of the backtraces for both calls are the following:

#0  read_index_from (istate=0x8660a0 <the_index>, path=0x868b90
".git/index") at read-cache.c:1626
#1  0x0000000000530ba3 in read_index (istate=0x8660a0 <the_index>) at
read-cache.c:1404
#2  0x00000000005743e1 in gitmodules_config () at submodule.c:188
#3  0x0000000000431ed0 in status_init_config (s=0x83aa20 <s>,
fn=0x434edd <git_status_config>) at builtin/commit.c:186

#0  git_default_core_config (var=0x86ac00 "core.untrackedcache",
value=0x86ac60 "true") at config.c:695
#1  0x00000000004be761 in git_default_config (var=0x86ac00
"core.untrackedcache", value=0x86ac60 "true", dummy=0x0) at
config.c:1016
#2  0x00000000004cfeba in git_diff_basic_config (var=0x86ac00
"core.untrackedcache", value=0x86ac60 "true", cb=0x0) at diff.c:277
#3  0x00000000004cfc9b in git_diff_ui_config (var=0x86ac00
"core.untrackedcache", value=0x86ac60 "true", cb=0x0) at diff.c:230
#4  0x000000000043524a in git_status_config (k=0x86ac00
"core.untrackedcache", v=0x86ac60 "true", cb=0x83aa20 <s>) at
builtin/commit.c:1313
#5  0x00000000004bf183 in configset_iter (cs=0x8495e0
<the_config_set>, fn=0x434edd <git_status_config>, data=0x83aa20 <s>)
at config.c:1305
#6  0x00000000004bf206 in git_config (fn=0x434edd <git_status_config>,
data=0x83aa20 <s>) at config.c:1317
#7  0x0000000000431ee3 in status_init_config (s=0x83aa20 <s>,
fn=0x434edd <git_status_config>) at builtin/commit.c:187

You can see that in status_init_config(), gitmodules_config() is
called just before git_config().
And unfortunately gitmodules_config() indirectly calls read_index_from().

So indeed it seems very bug prone to me to rely on read_index_from()
being called before git_default_core_config().
