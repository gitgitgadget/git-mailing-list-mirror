From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: Git commit path vs rebase path
Date: Thu, 17 May 2012 19:30:15 +0100
Message-ID: <4FB543B7.6000506@ramsay1.demon.co.uk>
References: <CAAXzdLU6bQ7ta4_-WfGJVaJgt1R5tX=4PW2sq3SdjAB+F72w+Q@mail.gmail.com>	<7vaa1j7vg1.fsf@alter.siamese.dyndns.org>	<4FA8BBB0.1080406@viscovery.net>	<CAAXzdLVaDAQkd_9qjnmTRoy8ccpyrZvwvBJQAfkp7LkYa7Li2A@mail.gmail.com>	<4FA8C5DB.5060002@viscovery.net>	<CAAXzdLW9_O+feVpBhDSXQH_SFRdrct1tjadpFoJ5d7-Qd1LWEg@mail.gmail.com>	<7vhavqwqpz.fsf@alter.siamese.dyndns.org>	<7v1umuwpo9.fsf@alter.siamese.dyndns.org>	<CAAXzdLVj0szCgpdOSdhnLdkBKAM+e6vrQpvrsz4HeUo+Nh1K6A@mail.gmail.com>	<4FAC047A.4010001@ramsay1.demon.co.uk> <CAAXzdLXbYp5YW9cZXxmRJk0MP=6PU897f4nuTe4ipLqk+EH9PQ@mail.gmail.com> <4FB03CA1.4030703@ramsay1.demon.co.uk> <4FB09FF2.70309@viscovery.net> <4FB2931A.1080504@ramsay1.demon.co.uk> <4FB340A9.60607@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Steven Penny <svnpenn@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu May 17 20:30:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SV5T1-0005pq-Oy
	for gcvg-git-2@plane.gmane.org; Thu, 17 May 2012 20:30:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967512Ab2EQSaX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 May 2012 14:30:23 -0400
Received: from lon1-post-3.mail.demon.net ([195.173.77.150]:56562 "EHLO
	lon1-post-3.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932633Ab2EQSaW (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 May 2012 14:30:22 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-3.mail.demon.net with esmtp (Exim 4.69)
	id 1SV5St-0001bW-d0; Thu, 17 May 2012 18:30:20 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <4FB340A9.60607@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197924>

Johannes Sixt wrote:
> Am 5/15/2012 19:32, schrieb Ramsay Jones:
>>     ++ GIT_SEQUENCE_EDITOR=args
>>     ++ eval args '"$@"'
>>     +++ args /usr/home/ramsay/git/.git/rebase-merge/git-rebase-todo
>>     argv[0] = 'C:\msysgit\msysgit\home\ramsay\bin\args.exe'
>>     argv[1] = 'C:/msysgit/msysgit/home/ramsay/git/.git/rebase-merge/git-rebase-todo'
> ...
>> So, the msys "path munging" of program arguments saves the day!
> 
> Absolutely. This path munging is an essential detail in the process.
> 
> I don't know whether Cygwin has a similar feature, but I suppose not,
> otherwise we wouldn't have received this issue report.

Yes, but I keep forgetting about this msys feature (I don't know why!).
I've had this "slap forehead" moment 3 or 4 times already (why do you
think I have the args program close to hand? :-D ).

As you surmised, cygwin does not have this feature. On cygwin you are
encouraged to use the cygpath utility in scripts. (Also, cygwin does
provide an API to convert to/from POSIX/win32 paths from your own
programs. eg. cygwin_conv_to_[full]_win32_path() and cygwin_conv_to_\
[full]_posix_path().)

>From the cygwin user guide, in a section titled "Using Cygwin effectively
with Windows", we find this:

    "Windows programs do not understand POSIX pathnames, so any arguments
    that reference the filesystem must be in Windows (or DOS) format or
    translated. Cygwin provides the cygpath utility for converting
    between Windows and POSIX paths. A complete description of its options
    and examples of its usage are in Section 3.7.2, including a shell script
    for starting Windows Explorer in any directory. The same format works
    for most Windows programs, for example

        notepad.exe "$(cygpath -aw "Desktop/Phone Numbers.txt")"

    A few programs require a Windows-style, semicolon-delimited path list,
    which cygpath can translate from a POSIX path with the -p option. For
    example, a Java compilation from bash might look like this:

        javac -cp "$(cygpath -pw "$CLASSPATH")" hello.java

    Since using quoting and subshells is somewhat awkward, it is often
    preferable to use cygpath in shell scripts."

Just as an exercise, I created a script to use the windows PSPad editor
(included below), using it to create a commit and also run this rebase:

    GIT_EDITOR=pspad git rebase -i master uname

Both git commands launched the editor (and completed their task) just fine.

Note that the script can be improved greatly, but it only took ten minutes
to create and is sufficient to this task. (PSPad supports more than one file
on the command line, despite what it's help file says, although all options
apply to all files. You should be able to "bundle" the options ...).


ATB,
Ramsay Jones

-- >8 --
#!/bin/sh

file=
opts=

while test $# != 0
do
    case "$1" in
	-[hH])
	    # open file in hex editor
	    opts="$opts /H"
	    ;;
	-[rR])
	    # open file in read-only mode
	    opts="$opts /R"
	    ;;
	-[0-9]*)
	    # open file and goto line n
	    opts="$opts /${1:1}"
	    ;;
	-*)
	    echo "option '$1' not supported"
	    exit 1
	    ;;
	*)
	    if test -n "$file"; then
		    echo "only one filename allowed"
		    exit 1
	    fi
	    file="$1"
	    ;;
    esac
    shift
done

if test -n "$file"; then
	file="$(cygpath -aw "$file")"
fi

"C:/Program Files/PSPad editor/PSPad.exe" "$file" $opts

-- 8< --
