From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH/WIP v2 04/19] am: implement patch queue mechanism
Date: Mon, 15 Jun 2015 18:46:27 +0800
Message-ID: <CACRoPnS3QwoWoebDpz_aBeoGx91pdP68f63Qp5KxLk9BCvc7DQ@mail.gmail.com>
References: <1434018125-31804-1-git-send-email-pyokagan@gmail.com>
	<1434018125-31804-5-git-send-email-pyokagan@gmail.com>
	<CAGZ79kbLneLygPiDtL+nqwsxdvZEhT95vj0z9MbN0QrqvAmebA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Mon Jun 15 12:46:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4RuT-0002Gx-Qn
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jun 2015 12:46:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754077AbbFOKq3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2015 06:46:29 -0400
Received: from mail-la0-f54.google.com ([209.85.215.54]:36758 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754046AbbFOKq2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2015 06:46:28 -0400
Received: by lacny3 with SMTP id ny3so35060681lac.3
        for <git@vger.kernel.org>; Mon, 15 Jun 2015 03:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Z8uAktVZ3X+7FAaDHc0EyfVMA+iTiP6n/SWhRc515xA=;
        b=0/bf9U+bV8xV8LyI3x7u8EYrWcL5+cfqCldEeF48hosuUPBria0Qh0bpR3IdGmAPcb
         BIljpbs9IgcRS/61M2F7LRONFZoEogS5DkS9j8qfZc0Ek2M61+kRmgFYKGV+goV/G1m4
         ljZQ0ZCN4z5upsoKqcfilTG94HCX06v1UZ0po+gQ016AD6b/kEULSBxoGzFlBhnF8Ynh
         f7oqfXbX8YakCDjNu+TQlGLq9d2pywxTYv50e/6aKmPwq9n1S+FVGvsF/8YQ71G5ft75
         wWVeYBK4fU3YhgWJ+2s4RNOJnHN8PqKU1VjcftIEmdd5kjh0Lc7ZioYjj5cu9wJO4jp2
         Qx+g==
X-Received: by 10.112.171.101 with SMTP id at5mr26861724lbc.66.1434365187391;
 Mon, 15 Jun 2015 03:46:27 -0700 (PDT)
Received: by 10.112.74.133 with HTTP; Mon, 15 Jun 2015 03:46:27 -0700 (PDT)
In-Reply-To: <CAGZ79kbLneLygPiDtL+nqwsxdvZEhT95vj0z9MbN0QrqvAmebA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271671>

On Fri, Jun 12, 2015 at 1:39 AM, Stefan Beller <sbeller@google.com> wrote:
> On Thu, Jun 11, 2015 at 3:21 AM, Paul Tan <pyokagan@gmail.com> wrote:
>> Notes:
>>     v2
>>
>>     * Declare struct am_state as static
>>
>>  builtin/am.c | 164 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 164 insertions(+)
>>
>> diff --git a/builtin/am.c b/builtin/am.c
>> index 0ccbe33..f061d21 100644
>> --- a/builtin/am.c
>> +++ b/builtin/am.c
>> @@ -6,6 +6,154 @@
>>  #include "cache.h"
>>  #include "builtin.h"
>>  #include "exec_cmd.h"
>> +#include "parse-options.h"
>> +#include "dir.h"
>> +
>> +struct am_state {
>
> Did you mean to declare all the functions below to be static or the
> struct as well?

Well, everything in this file, with the exception of the cmd_am()
entry point, should have static linkage.

The changelog comment was referring to [1], but I should have made it
clearer. Sorry if it was confusing.

[1] http://thread.gmane.org/gmane.comp.version-control.git/270048/focus=270205

> Reading further, you declared it static below. I thought maybe it'd be
> useful to have definition
> and declaration up here, but having all declarations further below may
> be even better.

Right, I aimed to have a strict separation between "git-am: the
functionality" and "git-am: the command-line interface", where the
latter depends on the former, and not the other way round (or have
circular dependencies). The former perhaps could even be moved into
libgit.a in the future.

Thanks,
Paul
