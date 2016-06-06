From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [BUG?] trailer command with multiple keys
Date: Mon, 6 Jun 2016 19:07:37 +0200
Message-ID: <CAP8UFD3ZE3XooL02DNEvDO85uBK_+FpTiqb+cx5hZ83tWassNg@mail.gmail.com>
References: <b94e1666-2f89-619b-112c-023f72002d9d@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Jun 06 19:07:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b9y08-0002R9-GI
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jun 2016 19:07:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752080AbcFFRHk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2016 13:07:40 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33993 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751699AbcFFRHk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2016 13:07:40 -0400
Received: by mail-wm0-f66.google.com with SMTP id n184so18046460wmn.1
        for <git@vger.kernel.org>; Mon, 06 Jun 2016 10:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=VLmMKY353nvRxZIr6MyhTnqRGluDLX7kvS3RSrzUKJQ=;
        b=xoUzMMB/gw5M/tMSc6+URLwt1gqrT6GIpSKQyl91biY6YONftWBRRPdWD02l0DHO+v
         Wd6ISmD3gQ63v+9EQ/ryTY9PW3SGgBVs1zrPC5pcDG8F7Iwlg2PqA4Yx3WI9l1OuKf7F
         OG4VgvD3qrHxfG8QhMydobErXoh4rCkndQco3ndg3+DjC+wsuYttgr9NCNwAVm6z4227
         fxf3NB5dHswck7CeX2rOhgkHLGqd/sGtj37aRlhibiffRy/PzuWnJkOClq7OUaIQK78o
         YxNgXkAyIWYNT+tJHT3SxoPjhCh3vc3HuW3JOkfpI+kbZt+NzgEzqK8qnAHprzRaP4h4
         Z0OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=VLmMKY353nvRxZIr6MyhTnqRGluDLX7kvS3RSrzUKJQ=;
        b=U0rAkLjkgAqYM8+6Pu9s6i141XM2Ny6ttnAQ2s08i0RsRqZab/7xgAdn4+vb3CijY8
         exBGDLoWOcH5ivT5IiGUP9RUvwzXzhJ3YUnp8JyZ/HdADFhV3+o/CbF0UtGDoDN9TwJm
         ZgWRoHG6x+nvLQEmcpSV8tVhBMf8OQR2tXaUv7jnhQOMlunGQbaCKPLzwuMQuX8NHhno
         YfM2epUIt9nrH3iKIoMiIqe2ZPcWYiJrqph6z0U7sEwzxZuq/mfH1WmBXZuRkYUtcgek
         JGp5UOssMNVfbYspAKFLAymBULYGBb53xNf98FoNBmpM8DXOt49WPfZi47mhfRy0Cz+S
         hbFA==
X-Gm-Message-State: ALyK8tJbZnCjcaLyBO2Il6gJ6ppqwg5EZC/HCtPWH54WroEz4EnkgCkTPnJD9QCum1yu1Dr3+9Kiep9iQZ85sw==
X-Received: by 10.28.167.79 with SMTP id q76mr2961435wme.62.1465232858122;
 Mon, 06 Jun 2016 10:07:38 -0700 (PDT)
Received: by 10.194.148.146 with HTTP; Mon, 6 Jun 2016 10:07:37 -0700 (PDT)
In-Reply-To: <b94e1666-2f89-619b-112c-023f72002d9d@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296539>

On Mon, Jun 6, 2016 at 2:27 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> The command
>
> printf "body\n\ntest: foo\ntest: froz\n" | git -c
> trailer.test.key=tested -c trailer.test.command="echo by \$ARG"
> interpret-trailers
>
> gives:
>
> body
>
> tested: foo
> tested: froz
> tested: by froz
>
> I expected the command to be run on each "test" key, resulting in the
> output:
>
> body:
>
> tested: by foo
> tested: by froz
>
> (In a real life scenario, I would use ifexists replace.)[*]
>
> Maybe my expectation is wrong?

I wouldn't say that it is wrong, but for now trailer configuration
applies mostly to trailer passed as argument to `git
interpret-trailers`.

So you could perhaps get something close to what you want with:

--------
$ printf "body\n\n" | git -c trailer.test.key=tested -c
trailer.test.command="/home/christian/git/test/interpret-trailers/trailer-script.sh
\$ARG"  interpret-trailers --trim-empty --trailer='test: foo'
--trailer='test: frotz'
body

tested: by foo
tested: by frotz
--------

and:

--------
$ cat /home/christian/git/test/interpret-trailers/trailer-script.sh
#!/bin/sh
test -n "$1" && echo "by $1"
:
--------

> The code breaks out of the loop after the
> first matching in_tok, apparently intentionally so. But I'm not sure -
> the key is replaced for both instances.
>
> Simply replacing that "return 1" by a "ret = 1" etc. runs into problems
> with the way the freeing of in_tok and arg_tok is arranged there :|
>
> Basically, I expected the trailer command to work "grep/sed-like" on all
> key value pairs that have matching keys, passing the value to the
> command, and using the (each) command's output as the new value for each
> of these pairs.

Yeah, it could have been designed like that.

The problem is that something like:

               $ git config trailer.sign.key "Signed-off-by: "
               $ git config trailer.sign.ifmissing add
               $ git config trailer.sign.ifexists doNothing
               $ git config trailer.sign.command 'echo "$(git config
user.name) <$(git config user.email)>"'

and piping any commit message into "git interpret-trailers" should work too.

In short it's not very natural to have both of the following by default:

- a configured command should run once to get a chance to add a new
trailer, even it doesn't exist in the input file
- a configured command should run once per trailer in the input file

(especially because as I said above for now configuration applies
mostly to trailers on the command line).

One solution could be to add support for a new
trailer.<token>.commandMode config option that could take values like
"onceAnyway", "oncePerMatchingTrailerInInputFile",
"oncePerMatchingTrailerOnCommandLine" and it should be possible to use
one or more of those modes, like for example:

trailer.stuff.commandMode=onceAnyway,oncePerMatchingTrailerInInputFile

> [*] My prime use case: fill in reported-by etc. with short author names,
> completed the same way we complete --author=jun using a trailer command
> (interpret-trailers in the commit-msg hook):
>
> $ git help author
> `git author' is aliased to `!f() { a=$(git log -1 --all -i --format="%aN
> <%aE>" --author "$1"); echo ${a:-$1}; }; f'
>
> $ cat .git/hooks/commit-msg
> #!/bin/sh
> git interpret-trailers --in-place "$1"
>
> $ git config --get-regexp trailer
> trailer.report.key Reported-by
> trailer.report.command git author '$ARG'
> trailer.report.ifexists replace
> trailer.report.ifmissing doNothing

Yeah, it would be nice to be able to have things like that.
