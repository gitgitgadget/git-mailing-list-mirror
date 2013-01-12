From: Manlio Perillo <manlio.perillo@gmail.com>
Subject: Re: [PATCH v5] git-completion.bash: add support for path completion
Date: Sat, 12 Jan 2013 15:52:56 +0100
Message-ID: <50F178C8.40806@gmail.com>
References: <1357930123-26310-1-git-send-email-manlio.perillo@gmail.com> <7v8v7zbcoi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, szeder@ira.uka.de, felipe.contreras@gmail.com,
	peff@peff.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 12 15:53:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tu2Sz-0003Fh-JM
	for gcvg-git-2@plane.gmane.org; Sat, 12 Jan 2013 15:53:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753616Ab3ALOx3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2013 09:53:29 -0500
Received: from mail-bk0-f51.google.com ([209.85.214.51]:36367 "EHLO
	mail-bk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753290Ab3ALOx2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2013 09:53:28 -0500
Received: by mail-bk0-f51.google.com with SMTP id ik5so1341095bkc.24
        for <git@vger.kernel.org>; Sat, 12 Jan 2013 06:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=2KUCWpZvcIuFHBViU5nIUqek/bP5JrR02V10tFkkfV8=;
        b=zMvXqngrORMDYAmmVS4L0hc8g1iRU58HGJVsZoK6PnIz8iGWumqxuDy+U2d05tEzpN
         CmoPjjGFWBQRtZNDSozX8+mI2L4XRO5STGguW/pOyNSKmGky1xtP3OzfpNjE/0amOf2m
         YD0ISreDx503W9SY96K+uwhMO5R5gmjtJGBZCdozs5qlDmUAPK7ZNIMScAQ7pkTdcP2e
         bg4TmlUNOQaJ/i6tamjKr+5o3IdckK1+4H3wXU8LjlDF7Nek3RyLYQH+QM2dfm2aV2EB
         zBBQ9qg4U7QeHoH72Fq8q3v3tPrb3WEQ03nGyZ3kr/2G7Z1YubE0ddxmUUT1EjrIZFd1
         mNaw==
X-Received: by 10.204.3.205 with SMTP id 13mr36865729bko.38.1358002407127;
        Sat, 12 Jan 2013 06:53:27 -0800 (PST)
Received: from [192.168.0.3] ([151.70.213.78])
        by mx.google.com with ESMTPS id e22sm6349910bke.14.2013.01.12.06.53.11
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 12 Jan 2013 06:53:26 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.16) Gecko/20121216 Icedove/3.0.11
In-Reply-To: <7v8v7zbcoi.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213286>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Il 11/01/2013 23:02, Junio C Hamano ha scritto:
> Manlio Perillo <manlio.perillo@gmail.com> writes:
> 
>> +# Process path list returned by "ls-files" and "diff-index --name-only"
>> +# commands, in order to list only file names relative to a specified
>> +# directory, and append a slash to directory names.
>> +__git_index_file_list_filter ()
>> +{
>> +	# Default to Bash >= 4.x
>> +	__git_index_file_list_filter_bash
>> +}
>> +
>> +# Execute git ls-files, returning paths relative to the directory
>> +# specified in the first argument, and using the options specified in
>> +# the second argument.
>> +__git_ls_files_helper ()
>> +{
>> +	# NOTE: $2 is not quoted in order to support multiple options
>> +	cd "$1" && git ls-files --exclude-standard $2
>> +} 2>/dev/null
> 
> I think this redirection is correct but a bit tricky;

It's not tricky: it is POSIX:
http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_10


> it is in
> effect during the execution of the { block } (in other words, it is
> not about squelching errors during the function definition).
> 

What do you mean by "squelching"?

Note that I originally wrote the code as

__git_ls_files_helper ()
{
	# NOTE: $2 is not quoted in order to support multiple options
	 { cd "$1" && git ls-files --exclude-standard $2 } 2>/dev/null
}

but then I checked the POSIX standard, noting that it is redundant.

> -- >8 --
> #!/bin/sh
> cat >t.sh <<\EOF &&
> echo I am "$1"
> t () { echo "Goes to stdout"; echo >&2 "Goes to stderr"; } 2>/dev/null
> t
> for sh in bash dash ksh zsh
> do
> 	$sh t.sh $sh
> done
> -- 8< --
> 

There is a missing EOF delimiter.
And I'm not sure to understand the meaning of && after EOF.

> Bash does (so do dash and real AT&T ksh) grok this correctly, but
> zsh does not seem to (I tried zsh 4.3.10 and 4.3.17; also zsh
> pretending to be ksh gets this wrong as well).  Not that what ksh
> does matters, as it won't be dot-sourcing bash completion script.
>

I have added tcsh to the sh list, but it fails with:
Badly placed ()'s.


> It however may affect zsh, which does seem to dot-source this file.
> Perhaps zsh completion may have to be rewritten in a similar way as
> tcsh completion is done (i.e. does not dot-source this file but ask
> bash to do the heavy-lifting).
> 

Ok, I was wrong on assuming all modern shells were POSIX compliant.
I will change the code to use a nested {} group.

> This function seems to be always called in an subshell (e.g. as an
> upstream of a pipeline), so the "cd" may be harmless, but don't you
> need to disable CDPATH while doing this?
> 

I don't know.

> [..]


>> +# Try to count non option arguments passed on the command line for the
>> +# specified git command.
>> +# When options are used, it is necessary to use the special -- option to
>> +# tell the implementation were non option arguments begin.
>> +# XXX this can not be improved, since options can appear everywhere, as
>> +# an example:
>> +#	git mv x -n y
> 
> If that is the case, it is a bug in the command line parser, I
> think.  We should reject it, and the command line completer
> certainly should not encourage it.
> 

$ mkdir y
$ git mv x -n y
Checking rename of 'x' to 'y/x'
Renaming x to y/x
$ git status
# On branch master
nothing to commit, working directory clean

I was assuming it to be "normal", given how complex Git command line
parsing is (IMHO).


Thanks  Manlio
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlDxeMgACgkQscQJ24LbaUTmaQCeMbZ0lRJxZIx3U31gMPmcqTLp
54sAmwYrjJVuvRYcsbGaMa3rb9/EKrBU
=ky30
-----END PGP SIGNATURE-----
