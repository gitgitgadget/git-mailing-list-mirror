From: Ville Walveranta <walveranta@gmail.com>
Subject: Re: Git 1.8.4.2: 'git-rev-parse --is-inside-git-dir' wrong output!
Date: Sat, 2 Nov 2013 14:42:04 -0500
Message-ID: <CACbqpSspsUvw3QXnSmOXA2boenh3y4DjHO-813OTna7cpSXkZQ@mail.gmail.com>
References: <CACbqpSvU4qxc0WtquP6Eq8bZGjLxTrVhtT2Nqw90wb23ESkfcw@mail.gmail.com>
	<20131102105816.GC24023@serenity.lan>
	<11593D3DCFCD4D24BB881B9E5FAB79C0@PhilipOakley>
	<20131102140656.GE24023@serenity.lan>
	<CE13C82CA4C24CA8B56380DA00A700A5@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Nov 02 20:42:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vch5I-00058m-1D
	for gcvg-git-2@plane.gmane.org; Sat, 02 Nov 2013 20:42:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754316Ab3KBTmI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Nov 2013 15:42:08 -0400
Received: from mail-ve0-f171.google.com ([209.85.128.171]:54183 "EHLO
	mail-ve0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754250Ab3KBTmG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Nov 2013 15:42:06 -0400
Received: by mail-ve0-f171.google.com with SMTP id pa12so522408veb.2
        for <git@vger.kernel.org>; Sat, 02 Nov 2013 12:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=iN9uS4i0uWMCi9ZgyFE5bde9R/cL0Io12UXzqaj74Vc=;
        b=uus8PZ35aHeyHN6dPNzlck9pLpqv+/Sr7vbrVjRHyojL4IbFgvWvBHGAK8L4vmLkPz
         jHhjt6u27H6A5gf7JFdgHDkgstcG5vpFUB1RUkDPnx3s6ktwIPsI9fFc3JQ4TA85mDjJ
         T9aPE/jYPl8khLNxBWqFi6r2lCR5zR94CNsLU1eqqwkiSdpLpk+P38WGofYiijsTM37w
         b4Gda8yNOkYNlepfeGGp432iu2QkR6o+h7g5+ukw/QjPuOjJ2ZDpj57aqaMrNx1xUqF6
         qRUwQV1dV2gUn1Nslp35U0/+0WNlHnYxY40JTyydYSPRAEPDG35Y6/kEBOmT7QRA8iGz
         0KvQ==
X-Received: by 10.52.37.36 with SMTP id v4mr46082vdj.54.1383421324654; Sat, 02
 Nov 2013 12:42:04 -0700 (PDT)
Received: by 10.58.2.133 with HTTP; Sat, 2 Nov 2013 12:42:04 -0700 (PDT)
In-Reply-To: <CE13C82CA4C24CA8B56380DA00A700A5@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237248>

Without the functionality such as that 1.7.9.5 still offered, it is
now not possible to use "git-rev-parse --is-inside-work-tree" to
detect whether the current location is controlled by a git repository
without emitting the "fatal: Not a git
repository (or any of the parent directories): .git" error message,
when it is not. There is no functional "--quiet" switch, and the usual
error/std redirection to /dev/null doesn't seem to work to squelch the
output.

If "--is-inside-git-dir" and "--is-inside-work-tree" are indeed not
supposed to emit "false" when outside of a git repository, perhaps
there is another way I can use (in a bash script) to cleanly detect
whether a specific path is part of a git repo or not?

Thanks for any insights on this! :-)

Ville

On Sat, Nov 2, 2013 at 12:03 PM, Philip Oakley <philipoakley@iee.org> wrote:
> From: "John Keeping" <john@keeping.me.uk>
> Sent: Saturday, November 02, 2013 2:06 PM
>
>> On Sat, Nov 02, 2013 at 01:47:02PM -0000, Philip Oakley wrote:
>>>
>>> From: "John Keeping" <john@keeping.me.uk>
>>> Sent: Saturday, November 02, 2013 10:58 AM
>>> > On Fri, Nov 01, 2013 at 06:19:51PM -0500, Ville Walveranta wrote:
>>> >> "git-rev-parse --is-inside-git-dir" outputs "fatal: Not a git
>>> >> repository (or any of the parent directories): .git", instead of
>>> >> "false" when outside of a git directory.  "--is-inside-work-tree"
>>> >> behaves the same way. Both commands work correctly (i.e. output
>>> >> "true") when inside a git directory, or inside a work tree,
>>> >> respectively.
>>> >
>>> > I think that's intentional - and it looks like the behaviour has
>>> > not
>>> > changed since these options were added.  With the current behaviour
>>> > you
>>> > get three possible outcomes from "git
>>> > rev-parse --is-inside-work-tree":
>>> >
>>> >    if worktree=$(git rev-parse --is-inside-work-tree 2>/dev/null)
>>> >    then
>>> >        if test "$worktree" = true
>>> >        then
>>> >            echo 'inside work tree'
>>> >        else
>>> >            echo 'in repository, but not in work tree'
>>> >        fi
>>> >    else
>>> >        echo 'not in repository'
>>> >    fi
>>> > --
>>>
>>>
>>> Shouldn't this case which produces "fatal:..." need to be documented
>>> in
>>> the man page?
>>> https://www.kernel.org/pub/software/scm/git/docs/git-rev-parse.html
>>> doesn't mention it.
>>
>>
>> I'm not sure where it should go in there.  The documentation for
>> --git-dir says:
>>
>>   If $GIT_DIR is not defined and the current directory is not detected
>>   to lie in a Git repository or work tree print a message to stderr
>> and
>>   exit with nonzero status.
>>
>> but there reality is that if you do not specify --parseopt
>> or --sq-quote
>> then the command expects to be run in a Git repository [1], so perhaps
>> it would be better to say something under "Operation Modes" or in the
>> description.
>>
>>
>> [1] After taking account of $GIT_DIR, $GIT_WORK_TREE, and arguments to
>>    the base "git" driver that affect these variables.
>>
>
> Yes, but given Ville's surprise and the need for special prior knowledge
> of the points you raised, I still think that some short note is needed.
>
> It can/could be read that you need to invoke --git-dir as an option
> before the mentioned die() exit is taken, rather than it applying to
> all(?) the path relevant options.
>
> Either the --git-dir condition needs to say it also applies
> to --is-inside-git-dir and --is-inside-work-tree
> (and --is-bare-repository?), or add a "see --git-dir preconditions." to
> each of those options. It's easy to be wise after the event hence my
> preference for a suitable note.
>
> regards
>
> Philip
>
>
