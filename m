From: Mikael Magnusson <mikachu@gmail.com>
Subject: Re: multiple source file extensions
Date: Tue, 5 May 2015 19:30:00 +0200
Message-ID: <CAHYJk3TzZd8N6E+=nNi1jR36Zc5A7be8ZPL9jLU7c8uAdQJYBw@mail.gmail.com>
References: <CACnwZYed_aHzLsbkJVm=OnydXw-CPi-Zm9V7928rzvpaFMNENw@mail.gmail.com>
	<CANuW5x3OBWNDnHeVbH7ZQaj5AUAingea6crJ0cF9AHFjcJE_bQ@mail.gmail.com>
	<20150502011100.GB5634@peff.net>
	<CACnwZYdGKcdzgu1=Ysd_pxqeuSBpZu41i1EJBvBi4FqHzvV-Hw@mail.gmail.com>
	<20150505034336.GA25194@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thiago Farina <tfransosi@gmail.com>,
	Josh Hagins <hagins.josh@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	=?UTF-8?B?RHV5IE5ndXnhu4Vu?= <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 05 19:30:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ypgfo-0007y9-Qt
	for gcvg-git-2@plane.gmane.org; Tue, 05 May 2015 19:30:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761048AbbEERaF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 May 2015 13:30:05 -0400
Received: from mail-ie0-f172.google.com ([209.85.223.172]:36578 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762005AbbEERaD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 May 2015 13:30:03 -0400
Received: by iebrs15 with SMTP id rs15so151121207ieb.3
        for <git@vger.kernel.org>; Tue, 05 May 2015 10:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=MM0RxIxjt3qoobyR/HG+EouRXXcFYdf8ZJ3elbYCA5I=;
        b=RomCW8UvOFGMm2pNCGsFuKN0IZZNVxBfSzXAf2P2SfzHOBBq3IntjDRw2Zyzl4A4qN
         0u5yVQ+Miw0lsHjJ7jZumRLycCwVLlUuAPyltxmyJr8DF4sfFzQPwRPt7x2pdvvgleG8
         ALQxsczz35P2hrahoeW3l9yZI5Eu6cyVf8EYVXKeNgxpWzEbofEMVsnLfaj366D+sj76
         8vKzp8XuxsXRMz5+W//6LlThheH33EsPBAR55mK1tdfCL5PSeelWzuy3a57H+rjTSQfu
         48wrfDofnm6NwxtFiLweAuYfs9Nsc01U25XZ4SdpLT1cIRIs+CH4hNqbW9p5jhRbx5FJ
         Zzlg==
X-Received: by 10.50.114.70 with SMTP id je6mr3188655igb.43.1430847001092;
 Tue, 05 May 2015 10:30:01 -0700 (PDT)
Received: by 10.36.143.136 with HTTP; Tue, 5 May 2015 10:30:00 -0700 (PDT)
In-Reply-To: <20150505034336.GA25194@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268399>

On Tue, May 5, 2015 at 5:43 AM, Jeff King <peff@peff.net> wrote:
> On Mon, May 04, 2015 at 07:12:45PM -0300, Thiago Farina wrote:
>
>> On Fri, May 1, 2015 at 10:11 PM, Jeff King <peff@peff.net> wrote:
>> > On Fri, May 01, 2015 at 08:49:14PM -0400, Josh Hagins wrote:
>> >
>> >> If you're using a recent version of bash, you could enable the
>> >> 'globstar' option:
>> >>
>> >>     $ shopt -s globstar
>> >>     $ git grep 'pattern' **/*.{cc,cpp,h}
>> >>
>> >> Does that work?
>> >
>> > That will only pick up files that are in the working tree. Which is fine
>> > for a stock "git grep" with no options, but would not be right for
>> > grepping in the index or an older tree. For that, you can ask git to
>> > glob for you:
>> >
>> >   git grep pattern -- '*.cc' '*.cpp' '*.h'
>> >
>> Is it possible to do a regex like the following?
>>
>> ".*\.[cChH]\(pp\)?"
>
> No, pathspecs are globs, not regexps. I think the idea has been floated
> for supporting regexps, which you would activate something like:
>
>   git grep pattern -- :(regexp)$your_regex_here
>
> but nobody has implemented it. I'm not sure it actually saves you any
> typing (besides which, your regexp does not match ".cc", which was in
> the original).

Remember that the more bells and whistles you add to pathspecs, the
less actual filenames can be conveniently tracked by git; *.c will be
expanded by the shell and passed literally to git, and if git then
interprets a bunch of stuff again, you could end up with a false
negative or positive match. Obviously files with * and ? in them are
already unsupported, try not to add more.

-- 
Mikael Magnusson
