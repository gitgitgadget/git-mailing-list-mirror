From: Ilya Bobyr <ilya.bobyr@gmail.com>
Subject: Re: [PATCH v3] rev-parse --parseopt: option argument name hints
Date: Fri, 21 Mar 2014 00:55:09 -0700
Message-ID: <532BF05D.8070104@gmail.com>
References: <532AA923.6030409@gmail.com>	<1395305092-1928-1-git-send-email-ilya.bobyr@gmail.com> <xmqqpplgyaud.fsf@gitster.dls.corp.google.com> <532B7774.30308@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 21 08:55:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQuId-0007dW-4m
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 08:55:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759361AbaCUHz1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2014 03:55:27 -0400
Received: from mail-pb0-f42.google.com ([209.85.160.42]:40908 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752456AbaCUHzZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2014 03:55:25 -0400
Received: by mail-pb0-f42.google.com with SMTP id rr13so2086462pbb.29
        for <git@vger.kernel.org>; Fri, 21 Mar 2014 00:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=jIY9Fu/fLzdCyifV9PGWLFY5dR/kvHRMXFq0YXTNXYk=;
        b=LMeiLK1PGDlmoI9OlqKrI/YReMw1XeOoCIMJeAYwUPfjy4Z+RlnoPJce7yAfVQpn/4
         bCN5+6KR6mhMKge9aebBIZ+GUACxkqY2NOzoqXzE3Ds43AJsMeCARV0ObcKv315TGjep
         llHZIA2D/dcId23/IbFppHNMuSSUGVgJjou+QsJQ3lc/x1Cb5kMck/NC6NLDB6Ftn7nZ
         44wowTN41Mp34/RZdzY0qih/S698VpnxnfIgII7n5V8XeiUxsqaHwS+kbYp1b0Js0mec
         0/Bga99aZGwXsgTUKYRu+UWFnI7SKvo+eCxY8kkutIjjtt8o8EXckGovpa4g6pugjirk
         cHPA==
X-Received: by 10.69.25.69 with SMTP id io5mr53198732pbd.22.1395388525466;
        Fri, 21 Mar 2014 00:55:25 -0700 (PDT)
Received: from [192.168.1.2] (c-50-136-172-14.hsd1.ca.comcast.net. [50.136.172.14])
        by mx.google.com with ESMTPSA id qx11sm22189603pab.35.2014.03.21.00.55.12
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Mar 2014 00:55:13 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:28.0) Gecko/20100101 Thunderbird/28.0
In-Reply-To: <532B7774.30308@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244676>

On 3/20/2014 4:19 PM, Ilya Bobyr wrote:
> On 3/20/2014 11:38 AM, Junio C Hamano wrote:
>> Ilya Bobyr <ilya.bobyr@gmail.com> writes:
>>
>>> [...]
>>>     ------------
>>> -<opt_spec><flags>* SP+ help LF
>>> +<opt_spec><flags>*<arg_hint>? SP+ help LF
>>>   ------------
>>>     `<opt_spec>`::
>>> @@ -313,6 +313,12 @@ Each line of options has this format:
>>>         * Use `!` to not make the corresponding negated long option
>>> available.
>>>   +`<arg_hint>`::
>>> +    `<arg_hing>`, if specified, is used as a name of the argument
>>> in the
>>> +    help output, for options that take arguments. `<arg_hint>` is
>>> +    terminated by the first whitespace. When output the name is
>>> shown in
>>> +    angle braces.  Underscore symbols are replaced with spaces.
>> The last part is troubling (and sounds not very sane).  Do we do
>> such a munging anywhere else, or is it just here?  If the latter I'd
>> prefer not to see such a hack.
>
> The following commands have spaces in argument names in the "-h"
> output for one or two arguments:
>   * clone
s/clone/checkout/
>   * commit
>   * merge
>
> A number of commands use dashes to separate words in arguments names.
>
> "git notes" is the only command that uses an underscore in one
> argument name.
>
> At the moment space is used to separate option specification from the
> help line.  As argument name hint is part of the option specification
> it ends at the first space.
>
> It seems a bit unfair if sh based commands would not be able to use
> spaces while the build-in ones can.
> As underscores are not used in the UI (at least that was my impression
> so far), I thought that to be a good option.
>
> Do you think a different kind of escaping should be used? Backslashes?
> Or no spaces?

"git merge" also uses equals sign in one of the argument names.  That
would not be possible for sh based commands either.

As a lot of commands are using dashes instead of spaces, so not
supporting spaces is probably fine.

Another option I can think of is to use (or just allow) angle brackets
around argument names.  That would look similar to the actual output.
"git shortlog" has some punctuation in an argument name, which braces
would make a bit easier to read.
This is how an option description would look like then:

OPTION_SPEC="\
...
S,gpg-sign?<key id>     GPG sign commit from "commit"
w?<w[,i1[,i2]]>         "shortlog" option with a complicated argument name
...
"

If there is interest in this, I could code it up and post for discussion.

> [...]
