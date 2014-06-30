From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [RFC/PATCH] notes-util.c: replace git_config with git_config_get_string
Date: Mon, 30 Jun 2014 17:56:13 +0200
Message-ID: <53B1889D.3010506@gmail.com>
References: <1403520105-23250-1-git-send-email-tanayabh@gmail.com>	<1403520105-23250-4-git-send-email-tanayabh@gmail.com>	<CAPig+cRcbamkpeaoCMQ9yXtYeMEEL-ve--VWKg4MAWeS08Lqyg@mail.gmail.com>	<53ABD78E.3050800@gmail.com> <CAPig+cSRBk5Q2amvFXyjH4dpoP83qbYUEUizE7v38Wh8Ofnfpw@mail.gmail.com> <53B16748.8080703@gmail.com> <53B17696.3060808@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Tanay Abhra <tanayabh@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Jun 30 17:56:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X1dwO-0007Bc-2x
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jun 2014 17:56:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755693AbaF3P4S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2014 11:56:18 -0400
Received: from mail-we0-f172.google.com ([74.125.82.172]:64369 "EHLO
	mail-we0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755679AbaF3P4Q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2014 11:56:16 -0400
Received: by mail-we0-f172.google.com with SMTP id u57so8327191wes.3
        for <git@vger.kernel.org>; Mon, 30 Jun 2014 08:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=egiD1brdiHERX9c7Rq0u05z/Q2f1PgYK/wbFNC2c9eQ=;
        b=SDyGU5dw8dx3HG8HyPepNBtmDnKjy8aV7WoexxMbNbqnXMibJMyRVAGnqZd/qv3FTh
         aiohk2O98ieOdnxZjl93h4jj/sQhkw6rGCyMz0LB9scl9dsSAOiXi+Jck8EC7fWgs8jN
         0uuWEnz+c+laP6UZmgcQ0MfFquenfHdp7mtjjeaf4q+Ws0SYpPHIPsARzWN9fjaghaNT
         eLb4SqrYiRBK24or+VRQgokwU3aNr1YZcFZ9WlbLTaaXdVz5SV3AJpH+xHIXD2D1DiUY
         hw2rEGf2KJfHtf62x9NGmAf7BgkVdusP6R6KquNJoX8qFgVGKcKg/+LuKvjRZ5yfwpnR
         oovQ==
X-Received: by 10.194.23.135 with SMTP id m7mr45761606wjf.2.1404143774550;
        Mon, 30 Jun 2014 08:56:14 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id d12sm8577148wjx.0.2014.06.30.08.56.13
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 30 Jun 2014 08:56:13 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <53B17696.3060808@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252676>

Am 30.06.2014 16:39, schrieb Tanay Abhra:
> 
> On 6/30/2014 7:04 PM, Karsten Blees wrote:
>> Am 29.06.2014 13:01, schrieb Eric Sunshine:
>>> On Thu, Jun 26, 2014 at 4:19 AM, Tanay Abhra <tanayabh@gmail.com> wrote:
>>>> On 6/25/2014 1:24 PM, Eric Sunshine wrote:
>>>>> On Mon, Jun 23, 2014 at 6:41 AM, Tanay Abhra <tanayabh@gmail.com> wrote:
>>>>>> Use git_config_get_string instead of git_config to take advantage of
>>>>>> the config hash-table api which provides a cleaner control flow.
>>>>>>
>>>>>> Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
>>>>>> ---
>>>>>>  notes-utils.c | 31 +++++++++++++++----------------
>>>>>>  1 file changed, 15 insertions(+), 16 deletions(-)
>>>>>>
>>>>>> diff --git a/notes-utils.c b/notes-utils.c
>>>>>> index a0b1d7b..fdc9912 100644
>>>>>> --- a/notes-utils.c
>>>>>> +++ b/notes-utils.c
>>>>>> @@ -68,22 +68,23 @@ static combine_notes_fn parse_combine_notes_fn(const char *v)
>>>>>>                 return NULL;
>>>>>>  }
>>>>>>
>>>>>> -static int notes_rewrite_config(const char *k, const char *v, void *cb)
>>>>>> +static void notes_rewrite_config(struct notes_rewrite_cfg *c)
>>>>>>  {
>>>>>> -       struct notes_rewrite_cfg *c = cb;
>>>>>> -       if (starts_with(k, "notes.rewrite.") && !strcmp(k+14, c->cmd)) {
>>>>>> -               c->enabled = git_config_bool(k, v);
>>>>>> -               return 0;
>>>>>> -       } else if (!c->mode_from_env && !strcmp(k, "notes.rewritemode")) {
>>>>>> +       struct strbuf key = STRBUF_INIT;
>>>>>> +       const char *v;
>>>>>> +       strbuf_addf(&key, "notes.rewrite.%s", c->cmd);
>>>>>> +
>>>>>> +       if (!git_config_get_string(key.buf, &v))
>>>>>> +               c->enabled = git_config_bool(key.buf, v);
>>>>>> +
>>>>>> +       if (!c->mode_from_env && !git_config_get_string("notes.rewritemode", &v)) {
>>>>>>                 if (!v)
>>>>>> -                       return config_error_nonbool(k);
>>>>>> +                       config_error_nonbool("notes.rewritemode");
>>>>>
>>>>> There's a behavior change here. In the original code, the callback
>>>>> function would return -1, which would cause the program to die() if
>>>>> the config.c:die_on_error flag was set. The new code merely emits an
>>>>> error.
>>>>
>>>> Is this change serious enough? Can I ignore it?
>>
>> IMO its better to Fail Fast than continue with some invalid config (which
>> may lead to more severe errors such as data corruption / data loss).
> 
> Noted but, what I am trying to do with the rewrite is emit an error and
> not set the value if the value found is a NULL.

If you don't set the value and continue, git will proceed with the variable's
default setting.

Which may not be too harmful in some cases, but if a user changes:

 gc.pruneexpire=4.weeks.ago

to

 gc.pruneexpire=4.monhts.ago

(note the typo), the next git-gc will warn the user and then happily throw
away data that the user intended to keep (default is 2.weeks.ago).

Thus I think git should die() if it encounters an invalid config setting.

> 
>> This, however, raises another issue: switching to the config cache looses
>> file/line-precise error reporting for semantic errors. I don't know if
>> this feature is important enough to do something about it, though. A
>> message of the form "Key 'xyz' is bad" should usually enable a user to
>> locate the problematic file and line.
>>
> 
> Hmn, but during the config cache construction we parse key-value pairs through
> git_config() which still warns users about semantic errors.

If I'm not mistaken you only detect _syntax_ errors when loading the file (i.e.
whether the config file is structurally correct).

The semantic value and correctness of a key (e.g. whether its a boolean or an
int or a string that denotes a known merge algorithm) is only checked when it is
accessed via git_config_get_<type>. And at this point, <file>:<line> information
is already lost.

With the callback approach, both syntactic (structure) and semantic (meaning)
errors were checked at load time, resulting in

  die("bad config file line %d in %s", cf->linenr, cf->name);

if the callback returned -1.
