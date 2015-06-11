From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] git-rebase--interactive.sh: add config option for
 custom instruction format
Date: Thu, 11 Jun 2015 16:40:35 +0200
Organization: gmx
Message-ID: <fc77a32f3e571e012591f992ba37bf5a@www.dscho.org>
References: <1433986244-76038-1-git-send-email-rappazzo@gmail.com>
 <1433986244-76038-2-git-send-email-rappazzo@gmail.com>
 <dabb4e8e3a864b26c002e9ef966bdf85@www.dscho.org>
 <CANoM8SW13UYazBQgXn6BSDa-rz+jqj19CO3b0K82CV5Ab6HmKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Mike Rappazzo <rappazzo@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 11 16:41:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z33fh-0002mH-T0
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jun 2015 16:41:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754800AbbFKOl3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2015 10:41:29 -0400
Received: from mout.gmx.net ([212.227.17.20]:61829 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752301AbbFKOku (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2015 10:40:50 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0LpObx-1ZYWKU49ZN-00fE0f; Thu, 11 Jun 2015 16:40:36
 +0200
In-Reply-To: <CANoM8SW13UYazBQgXn6BSDa-rz+jqj19CO3b0K82CV5Ab6HmKw@mail.gmail.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:/MXNQ41D41hxdNlrGZ7x5N/4U++aAEFtkNrYfkUlPmlh6fRBnHD
 4AGWoaHtO1j7bA/yZjTm5+NAalI+mPmmJIoduUAruZvqrde0Ui5WntCl8lXtrc12JQ5h1RQ
 3c38uWB4MZPX0lD28pNsbCxhpK0wWL3feuauuoAHLg8ZjgO0uQt3vvtizStUumsyKGwghwP
 91OyCbaTjI19vWts5CrDg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271410>

Hi Mike,

On 2015-06-11 16:02, Mike Rappazzo wrote:
> On Thu, Jun 11, 2015 at 9:40 AM, Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
>>
>> On 2015-06-11 03:30, Michael Rappazzo wrote:
>>
>>> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
>>> index dc3133f..6d14315 100644
>>> --- a/git-rebase--interactive.sh
>>> +++ b/git-rebase--interactive.sh
>>> @@ -740,10 +740,19 @@ collapse_todo_ids() {
>>>  # "pick sha1 fixup!/squash! msg" appears in it so that the latter
>>>  # comes immediately after the former, and change "pick" to
>>>  # "fixup"/"squash".
>>> +#
>>> +# Note that if the config has specified a custom instruction format
>>> +# each log message will be re-retrieved in order to normalize the
>>> +# autosquash arrangement
>>>  rearrange_squash () {
>>>       # extract fixup!/squash! lines and resolve any referenced sha1's
>>> -     while read -r pick sha1 message
>>> +     while read -r pick sha1 todo_message
>>>       do
>>> +             message=${todo_message}
>>
>> Why not just leave the `read -r pick sha1 message` as-is and simply write
>>
>>                 # For "autosquash":
>>                 test -z "$format" ||
>>                 message="$(git log -n 1 --format="%s" $sha1)"
>>
>> here?
> 
> I did notice that I am not using '$todo_message' in the first loop at
> all, so I will adjust it.  In the second loop, I do use both the
> original and the reformatted.  I will apply your suggestion there if
> applicable.

It might make sense to use

                 if test -z "$format"
                 then
                         oneline="$message"
                 else
                         oneline="$(git log -n 1 --format="%s" $sha1)"
                 fi

in the instances where you need to compare against the original oneline, and then only adjust the "message" variable name in places that require the original oneline.

>> [The two test functions are] copied almost verbatim, except for the commit message. The code would be easier to maintain if it did not repeat so much code e.g. by refactoring out a function that takes the commit message as a parameter.
> 
> Makes sense.  I'll implement that.

Thank you,
Johannes
