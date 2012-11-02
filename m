From: Stefan Zager <szager@google.com>
Subject: Re: [PATCH] Enable parallelism in git submodule update.
Date: Fri, 2 Nov 2012 14:49:01 -0700
Message-ID: <CAHOQ7J_dDSgzr7SRoNG1kSfQCm6dv9ENEskCLpwsmCo-SyViDw@mail.gmail.com>
References: <5090168f.5e+7ZUFKdYL2Qnw7%szager@google.com>
	<CAHOQ7J-e=KBOsjoeTWsf1f+LNgaAxN974-FXNMeOy7B-FR0wyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jens Lehmann <jens.lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 02 22:49:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TUP79-0003gP-PS
	for gcvg-git-2@plane.gmane.org; Fri, 02 Nov 2012 22:49:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759304Ab2KBVtG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2012 17:49:06 -0400
Received: from mail-qa0-f53.google.com ([209.85.216.53]:53891 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757073Ab2KBVtD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2012 17:49:03 -0400
Received: by mail-qa0-f53.google.com with SMTP id s11so498048qaa.19
        for <git@vger.kernel.org>; Fri, 02 Nov 2012 14:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:x-system-of-record;
        bh=I0xnE0OS2J5eFE8nuJQm5mN7zTuKjUCXB55jdfiCgHI=;
        b=l41HMm74GaOtCJNmJmDNc01WLns70hDUGaT1+vl6IKX1jT4MAUNL5PQnr+sh4r2YLL
         w8ACVs/ax/ZbGB+4PrVGpWSoS3Govz8tq8oqZ2BQPOgeIu76J2Xy+covhjiJ3ZedeR/j
         WAZrBQ51flqiRYhiagQNHk8zjfe7CSWNKd4ROjEd+9t15uPcEA5nxx/rFxJJyBX6riJ6
         ++oxelmZdZMmrvAxLWWCz6vzIyyOHKWBLlMQSv/6SSuFxjyUS2ggfw7U3fzs5XTb8LiY
         7QeXatXTxhxrM0s5nWNq8z/Rc9k9eXzraeQrFw5eXY0RUuG41nPFVdqxZqvJDXCxU4Pt
         Hfkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:x-system-of-record:x-gm-message-state;
        bh=I0xnE0OS2J5eFE8nuJQm5mN7zTuKjUCXB55jdfiCgHI=;
        b=Fh8LmwutfzRP7t5w5bZVvrJMN/zqXn8T1PTkL52pGHMMmbghCkjY7EYg4gCS+jDUOO
         M+JTJM6fXzA0yUIcVo9rIwj28GDejk2V5mvy9WnzYEUYjOZH0hZcHEDqTcScEf34+kUS
         AogOGWJHKd/AiEFeGPNDX7i6vb9utxPEfH9LCGRmRqC2lj6H2r1FGRL3pXXZz2HlWjo6
         eoAzwQW6j8/7OM8Ut+MISrqv3MF5Q20fPgsDKx2XJNTiaYGyLGTtJcHzRIubidut0fKs
         5nHuPJ/v2T8i03qDsH/tLFkzg39F9q8x0/rkVYjT5xegITIvLLJBLdhGlVtHLrxp30p9
         1f0g==
Received: by 10.224.42.8 with SMTP id q8mr4270628qae.77.1351892941784; Fri, 02
 Nov 2012 14:49:01 -0700 (PDT)
Received: by 10.49.71.197 with HTTP; Fri, 2 Nov 2012 14:49:01 -0700 (PDT)
In-Reply-To: <CAHOQ7J-e=KBOsjoeTWsf1f+LNgaAxN974-FXNMeOy7B-FR0wyg@mail.gmail.com>
X-System-Of-Record: true
X-Gm-Message-State: ALoCoQnQ/x4+DDLgxHxTb/esCXUWaUd8MNfkslRlv6W5yB6GFtqXedFfQ4wnyok/QunrgjaIBYfRncvxO/EzgUqzaexaHw1IXoivrTFesBVBwXsDFaDwIQXBZxGHs+NdAGnv2SkJeJMczInzIDuIzNxcofEu3nt00BkAYPrUi5h5nqMBMkuQRcm49bDpXQRdpqYTIYnfJoGW
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208974>

ping?

On Tue, Oct 30, 2012 at 11:11 AM, Stefan Zager <szager@google.com> wrote:
> This is a refresh of a conversation from a couple of months ago.
>
> I didn't try to implement all the desired features (e.g., smart logic
> for passing a -j parameter to recursive submodule invocations), but I
> did address the one issue that Junio insisted on: the code makes a
> best effort to detect whether xargs supports parallel execution on the
> host platform, and if it doesn't, then it prints a warning and falls
> back to serial execution.
>
> Stefan
>
> On Tue, Oct 30, 2012 at 11:03 AM,  <szager@google.com> wrote:
>> The --jobs parameter may be used to set the degree of per-submodule
>> parallel execution.
>>
>> Signed-off-by: Stefan Zager <szager@google.com>
>> ---
>>  Documentation/git-submodule.txt |    8 ++++++-
>>  git-submodule.sh                |   40 ++++++++++++++++++++++++++++++++++++++-
>>  2 files changed, 46 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
>> index b4683bb..cb23ba7 100644
>> --- a/Documentation/git-submodule.txt
>> +++ b/Documentation/git-submodule.txt
>> @@ -14,7 +14,8 @@ SYNOPSIS
>>  'git submodule' [--quiet] status [--cached] [--recursive] [--] [<path>...]
>>  'git submodule' [--quiet] init [--] [<path>...]
>>  'git submodule' [--quiet] update [--init] [-N|--no-fetch] [--rebase]
>> -             [--reference <repository>] [--merge] [--recursive] [--] [<path>...]
>> +             [--reference <repository>] [--merge] [--recursive]
>> +             [-j|--jobs [jobs]] [--] [<path>...]
>>  'git submodule' [--quiet] summary [--cached|--files] [(-n|--summary-limit) <n>]
>>               [commit] [--] [<path>...]
>>  'git submodule' [--quiet] foreach [--recursive] <command>
>> @@ -146,6 +147,11 @@ If the submodule is not yet initialized, and you just want to use the
>>  setting as stored in .gitmodules, you can automatically initialize the
>>  submodule with the `--init` option.
>>  +
>> +By default, each submodule is treated serially.  You may specify a degree of
>> +parallel execution with the --jobs flag.  If a parameter is provided, it is
>> +the maximum number of jobs to run in parallel; without a parameter, all jobs are
>> +run in parallel.
>> ++
>>  If `--recursive` is specified, this command will recurse into the
>>  registered submodules, and update any nested submodules within.
>>  +
>> diff --git a/git-submodule.sh b/git-submodule.sh
>> index ab6b110..60a5f96 100755
>> --- a/git-submodule.sh
>> +++ b/git-submodule.sh
>> @@ -8,7 +8,7 @@ dashless=$(basename "$0" | sed -e 's/-/ /')
>>  USAGE="[--quiet] add [-b branch] [-f|--force] [--reference <repository>] [--] <repository> [<path>]
>>     or: $dashless [--quiet] status [--cached] [--recursive] [--] [<path>...]
>>     or: $dashless [--quiet] init [--] [<path>...]
>> -   or: $dashless [--quiet] update [--init] [-N|--no-fetch] [-f|--force] [--rebase] [--reference <repository>] [--merge] [--recursive] [--] [<path>...]
>> +   or: $dashless [--quiet] update [--init] [-N|--no-fetch] [-f|--force] [--rebase] [--reference <repository>] [--merge] [--recursive] [-j|--jobs [jobs]] [--] [<path>...]
>>     or: $dashless [--quiet] summary [--cached|--files] [--summary-limit <n>] [commit] [--] [<path>...]
>>     or: $dashless [--quiet] foreach [--recursive] <command>
>>     or: $dashless [--quiet] sync [--] [<path>...]"
>> @@ -500,6 +500,7 @@ cmd_update()
>>  {
>>         # parse $args after "submodule ... update".
>>         orig_flags=
>> +       jobs="1"
>>         while test $# -ne 0
>>         do
>>                 case "$1" in
>> @@ -518,6 +519,20 @@ cmd_update()
>>                 -r|--rebase)
>>                         update="rebase"
>>                         ;;
>> +               -j|--jobs)
>> +                       case "$2" in
>> +                       ''|-*)
>> +                               jobs="0"
>> +                               ;;
>> +                       *)
>> +                               jobs="$2"
>> +                               shift
>> +                               ;;
>> +                       esac
>> +                       # Don't preserve this arg.
>> +                       shift
>> +                       continue
>> +                       ;;
>>                 --reference)
>>                         case "$2" in '') usage ;; esac
>>                         reference="--reference=$2"
>> @@ -551,11 +566,34 @@ cmd_update()
>>                 shift
>>         done
>>
>> +       # Correctly handle the case where '-q' came before 'update' on the command line.
>> +       if test -n "$GIT_QUIET"
>> +       then
>> +               orig_flags="$orig_flags -q"
>> +       fi
>> +
>>         if test -n "$init"
>>         then
>>                 cmd_init "--" "$@" || return
>>         fi
>>
>> +       if test "$jobs" != 1
>> +       then
>> +               if ( echo test | xargs -P "$jobs" true 2>/dev/null )
>> +               then
>> +                       if ( echo test | xargs --max-lines=1 true 2>/dev/null ); then
>> +                               max_lines="--max-lines=1"
>> +                       else
>> +                               max_lines="-L 1"
>> +                       fi
>> +                       module_list "$@" | awk '{print $4}' |
>> +                       xargs $max_lines -P "$jobs" git submodule update $orig_flags
>> +                       return
>> +               else
>> +                       echo "Warn: parallel execution is not supported on this platform."
>> +               fi
>> +       fi
>> +
>>         cloned_modules=
>>         module_list "$@" | {
>>         err=
>> --
>> 1.7.7.3
>>
