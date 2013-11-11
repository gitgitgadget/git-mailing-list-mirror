From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v4 12/10] git-remote-testgit: support the new 'force' option
Date: Sun, 10 Nov 2013 21:57:16 -0600
Message-ID: <CAMP44s3P7mmBP7=g4ZZpQcqyzeyAcAeH6gNfusbNX8xeQ+0JVQ@mail.gmail.com>
References: <1382857521-7005-1-git-send-email-felipe.contreras@gmail.com>
	<1382908589-7000-1-git-send-email-rhansen@bbn.com>
	<526f74cf8307f_37cdfb1e7c31@nysa.notmuch>
	<52800CB7.7080905@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>
To: Richard Hansen <rhansen@bbn.com>
X-From: git-owner@vger.kernel.org Mon Nov 11 04:57:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vfid8-0006lM-PG
	for gcvg-git-2@plane.gmane.org; Mon, 11 Nov 2013 04:57:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751224Ab3KKD5U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Nov 2013 22:57:20 -0500
Received: from mail-la0-f45.google.com ([209.85.215.45]:58712 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751003Ab3KKD5S (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Nov 2013 22:57:18 -0500
Received: by mail-la0-f45.google.com with SMTP id el20so3515516lab.4
        for <git@vger.kernel.org>; Sun, 10 Nov 2013 19:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=2T4LJ0HNgVzt5Sw5U1EgfpXUa2MgbZbj1jtyTGWpIr4=;
        b=fBqxaM6ihYsTa5X79OY29/3Kb6WRaWqfKDNcdXyTF+PMg+NhY5PJCXi6G8bDc3Zgcu
         r/RNfLaGYgA5RVAfUhu0IYQIf9h0sf3X+UbRDe7ZyAkjwx1hAyqTDifYXrpn9ImwxCTv
         HFZJk3mcINS7TnLt5EpLd/Jn//wV/jB13oZqL/7ps8jXJUFM17mZ1eJMxVkGw/IfcBt0
         DvZDNb7dwbTbye7ZtyD/6OIuax/uGRLBPbKgLYPGbVC24sMR6DXFMCXYvm5MiY6n9gAO
         TAHYTunQLizMCfjeRKW8PLGb9dHMchPTREbnvk9x35ZDmuL5c1oXbELVhfUs6bQmpwDT
         XRWQ==
X-Received: by 10.152.170.133 with SMTP id am5mr21259433lac.9.1384142236705;
 Sun, 10 Nov 2013 19:57:16 -0800 (PST)
Received: by 10.114.201.69 with HTTP; Sun, 10 Nov 2013 19:57:16 -0800 (PST)
In-Reply-To: <52800CB7.7080905@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237596>

On Sun, Nov 10, 2013 at 4:46 PM, Richard Hansen <rhansen@bbn.com> wrote:
> On 2013-10-29 04:41, Felipe Contreras wrote:
>> Richard Hansen wrote:
>>> Signed-off-by: Richard Hansen <rhansen@bbn.com>
>>> ---
>>>  git-remote-testgit.sh | 18 ++++++++++++++++++
>>>  1 file changed, 18 insertions(+)
>>>
>>> diff --git a/git-remote-testgit.sh b/git-remote-testgit.sh
>>> index 6d2f282..80546c1 100755
>>> --- a/git-remote-testgit.sh
>>> +++ b/git-remote-testgit.sh
>>> @@ -6,6 +6,7 @@ url=$2
>>>
>>>  dir="$GIT_DIR/testgit/$alias"
>>>  prefix="refs/testgit/$alias"
>>> +forcearg=
>>>
>>>  default_refspec="refs/heads/*:${prefix}/heads/*"
>>>
>>> @@ -39,6 +40,7 @@ do
>>>              fi
>>>              test -n "$GIT_REMOTE_TESTGIT_SIGNED_TAGS" && echo "signed-tags"
>>>              test -n "$GIT_REMOTE_TESTGIT_NO_PRIVATE_UPDATE" && echo "no-private-update"
>>> +            echo 'option'
>>>              echo
>>>              ;;
>>>      list)
>>> @@ -93,6 +95,7 @@ do
>>>              before=$(git for-each-ref --format=' %(refname) %(objectname) ')
>>>
>>>              git fast-import \
>>> +                    ${forcearg} \
>>>                      ${testgitmarks:+"--import-marks=$testgitmarks"} \
>>>                      ${testgitmarks:+"--export-marks=$testgitmarks"} \
>>>                      --quiet
>>> @@ -115,6 +118,21 @@ do
>>>
>>>              echo
>>>              ;;
>>> +    option\ *)
>>> +            read cmd opt val <<EOF
>>> +${line}
>>> +EOF
>>
>> We can do <<-EOF to align this properly.
>
> Good point.  I personally avoid tabs whenever possible, and <<- only
> works with tabs, so I'm in the habit of doing <<EOF.

That looks very weird to me, plus <<-EOF is often used already in git tests.

>> Also, I don't see why all the variables are ${foo} instead of $foo.
>
> I'm in the habit of doing ${foo} because I like the consistency --

Sure, but with the price of less readibility. If consistency was the
priority, we would be doing the follwoing in C:

if (foo) {
  # single line
}

Since the if might contain multiple lines, but we don't do that,
because readibility is more important than consistency. So sometimes
it's with braces, sometimes without.

>>> +            case ${opt} in
>>> +                force)
>>
>> I think the convention is to align these:
>>
>> case $opt in
>> force)
>
> The existing case statement in this file indents the patterns the same
> amount as the case statement, so this should be aligned to match.
>
> In general I rarely see the case patterns indented at the same level as
> the case statement, possibly because Emacs shell-mode indents the
> patterns more than the case statement (by default).  The POSIX spec
> contains a mix of styles:
>   * the normative text documenting the format of a 'case' construct
>     indents the patterns more than the 'case' statement
>   * two of the four non-normative examples indent the patterns
>     more than the 'case' statements; the other two do not

The style in C has the cases at the same level, so I think it makes
sense to do the same in shell, but I'm not sure if that's followed
already.

>>> +                    case ${val} in
>>> +                        true) forcearg=--force; echo 'ok';;
>>> +                        false) forcearg=; echo 'ok';;
>>> +                        *) printf %s\\n "error '${val}'\
>>> + is not a valid value for option ${opt}";;
>>
>> I think this is packing a lot of stuff and it's not that readable.
>>
>> Moreover, this is not for production purposes, it's for testing purposes and a
>> guideline, I think this suffices.
>>
>>
>>       option\ *)
>>               read cmd opt val <<-EOF
>>               $line
>>               EOF
>>               case $opt in
>>               force)
>>                       test $val = "true" && force="true" || force=
>>                       echo "ok"
>>                       ;;
>>
>>                       echo "unsupported"
>>                       ;;
>>               esac
>>               ;;
>
> Works for me.

Good, the final code style can be decided later on, and perhaps update
Documentation/CodingGuidelines, but it's good the rest is more or less
settled.

Cheers.

-- 
Felipe Contreras
