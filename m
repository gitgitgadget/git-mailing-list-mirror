From: David Cowden <dcow90@gmail.com>
Subject: Re: Git-hooks pre-push script does not receive input on stdin
Date: Sun, 23 Mar 2014 12:21:00 -0700
Message-ID: <CAC1XvcOCx36yQ0jKwYdRLUBRnac1XmmtORAeoYnocMd8oPbYXg@mail.gmail.com>
References: <CAC1XvcPshKQXuRPDd8reb6fsDU3BNOsBAUKO25_dVBD331=yRQ@mail.gmail.com>
	<532E8B13.9060402@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun Mar 23 20:21:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WRnxH-0006Fp-63
	for gcvg-git-2@plane.gmane.org; Sun, 23 Mar 2014 20:21:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751585AbaCWTVE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 23 Mar 2014 15:21:04 -0400
Received: from mail-qa0-f44.google.com ([209.85.216.44]:59339 "EHLO
	mail-qa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751368AbaCWTVA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 23 Mar 2014 15:21:00 -0400
Received: by mail-qa0-f44.google.com with SMTP id f11so4513376qae.3
        for <git@vger.kernel.org>; Sun, 23 Mar 2014 12:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=lypOHxaAvx5PWNTCLutoLmTOyYrp+8+jw8tvVUdmXlI=;
        b=JQrw982AJ3FjFAOUYqI4zdefw39o9narA0WZlmw3UZRJpR8afvGhT9s+MrvHmdi7SB
         YK/WKdIrOHUL4KC4H2EthhyNKUditBPDu07Ls6VaWDzH97G+Zo+Ck6pHEO0qf2bDBEeM
         zGd8hCOXb9A3kvEjdvqMhyKB9Q8s/VjiId+V18p1uB0LOJtOPhIs8/gypG7vdSa7R3PC
         So1YbuiY55SWlub/ipoZ7S4LW69TuySlHrAx2GfwhUGmmNFJP0KSnbjzkbhvHdAD9aiA
         ndCZnHLLX5SKc7n9MrQlG8b7z+qg/MUJPnz4JI+hsMcsbGcfUgUFCPR8DqrOxopoRbxs
         1uWw==
X-Received: by 10.224.80.201 with SMTP id u9mr69980168qak.5.1395602460227;
 Sun, 23 Mar 2014 12:21:00 -0700 (PDT)
Received: by 10.140.91.14 with HTTP; Sun, 23 Mar 2014 12:21:00 -0700 (PDT)
In-Reply-To: <532E8B13.9060402@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244800>

You are correct, it was a misunderstanding on my part.  I have
suggested a patch to clarify the pre-push documentation in a separate
thread.

Thanks for pointing that out!

On Sun, Mar 23, 2014 at 12:19 AM, Torsten B=F6gershausen <tboegi@web.de=
> wrote:
> On 2014-03-23 01.44, David Cowden wrote:
>> http://stackoverflow.com/questions/22585091/git-hooks-pre-push-scrip=
t-does-not-receive-input-via-stdin
>>
>> Is this a bug in git?  Or am I just a shell noob?
>>
>> Thanks in advance,
>>
>> David
>
> I assume that you have the right version of Git ?
> You can look into the source of Git, to be more exact the test suite:
> t/t5571-pre-push-hook.sh
>
> When I play a little but with the script,
> (Replace the diff with test_cmp, add a line:
> diff --git a/t/t5571-pre-push-hook.sh b/t/t5571-pre-push-hook.sh
> index 6f9916a..01db2fb 100755
> --- a/t/t5571-pre-push-hook.sh
> +++ b/t/t5571-pre-push-hook.sh
> @@ -42,6 +42,7 @@ export COMMIT2
>  write_script "$HOOK" <<'EOF'
>  echo "$1" >actual
>  echo "$2" >>actual
> +echo hello >>actual
>  cat >>actual
>  EOF
> -------------
> and finally run it like this:
>
> debug=3Dt verbose=3Dt ./t5571-pre-push-hook.sh  2>&1 | less
> I get something like this:
>
> --- expected    2014-03-23 07:15:58.000000000 +0000
> +++ actual      2014-03-23 07:15:58.000000000 +0000
> @@ -1,3 +1,4 @@
>  parent1
>  repo1
> +hello
>  refs/heads/master 139b20d8e6c5b496de61f033f642d0e3dbff528d refs/head=
s/foreign d79ce1670bdcb76e6d1da2ae095e890ccb326ae9
> not ok 4 - push with hook
> #
> #               git push parent1 master:foreign &&
> #               test_cmp expected actual
> #
> --------------------------------------------
> So the question is, if your push simply doesn't have anything to push=
,
> because everything is up to date?
> And in this case there is nothing on STDIN?
>
> If the problem still exists, feel free to post a script how to reprod=
uce it
> here to the list, t5571 may be a source of inspiration.
>
