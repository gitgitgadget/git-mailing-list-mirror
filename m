From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: Git 1.8.4.2: 'git-rev-parse --is-inside-git-dir' wrong output!
Date: Sat, 2 Nov 2013 17:03:34 -0000
Organization: OPDS
Message-ID: <CE13C82CA4C24CA8B56380DA00A700A5@PhilipOakley>
References: <CACbqpSvU4qxc0WtquP6Eq8bZGjLxTrVhtT2Nqw90wb23ESkfcw@mail.gmail.com> <20131102105816.GC24023@serenity.lan> <11593D3DCFCD4D24BB881B9E5FAB79C0@PhilipOakley> <20131102140656.GE24023@serenity.lan>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Ville Walveranta" <walveranta@gmail.com>,
	"Git List" <git@vger.kernel.org>
To: "John Keeping" <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sat Nov 02 18:03:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VcebM-0001ur-KQ
	for gcvg-git-2@plane.gmane.org; Sat, 02 Nov 2013 18:03:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753979Ab3KBRDF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Nov 2013 13:03:05 -0400
Received: from out1.ip02ir2.opaltelecom.net ([62.24.128.238]:41084 "EHLO
	out1.ip02ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752614Ab3KBRDD (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 2 Nov 2013 13:03:03 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Al4GAFcvdVJZ8Y1P/2dsb2JhbABZgwc4iRm3N4EbF3RpgSEWAQQBAQUIAQEuHgEBIQsCAwUCAQMVAQIJDBkUAQQaBgcXBhMIAgECAwGFOAeCEiMJvSgEjQKCVhGDFoEOA4kIhhKaeYMmPA
X-IPAS-Result: Al4GAFcvdVJZ8Y1P/2dsb2JhbABZgwc4iRm3N4EbF3RpgSEWAQQBAQUIAQEuHgEBIQsCAwUCAQMVAQIJDBkUAQQaBgcXBhMIAgECAwGFOAeCEiMJvSgEjQKCVhGDFoEOA4kIhhKaeYMmPA
X-IronPort-AV: E=Sophos;i="4.93,622,1378854000"; 
   d="scan'208";a="445946561"
Received: from host-89-241-141-79.as13285.net (HELO PhilipOakley) ([89.241.141.79])
  by out1.ip02ir2.opaltelecom.net with SMTP; 02 Nov 2013 17:03:01 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237246>

From: "John Keeping" <john@keeping.me.uk>
Sent: Saturday, November 02, 2013 2:06 PM
> On Sat, Nov 02, 2013 at 01:47:02PM -0000, Philip Oakley wrote:
>> From: "John Keeping" <john@keeping.me.uk>
>> Sent: Saturday, November 02, 2013 10:58 AM
>> > On Fri, Nov 01, 2013 at 06:19:51PM -0500, Ville Walveranta wrote:
>> >> "git-rev-parse --is-inside-git-dir" outputs "fatal: Not a git
>> >> repository (or any of the parent directories): .git", instead of
>> >> "false" when outside of a git directory.  "--is-inside-work-tree"
>> >> behaves the same way. Both commands work correctly (i.e. output
>> >> "true") when inside a git directory, or inside a work tree,
>> >> respectively.
>> >
>> > I think that's intentional - and it looks like the behaviour has
>> > not
>> > changed since these options were added.  With the current behaviour
>> > you
>> > get three possible outcomes from "git
>> > rev-parse --is-inside-work-tree":
>> >
>> >    if worktree=$(git rev-parse --is-inside-work-tree 2>/dev/null)
>> >    then
>> >        if test "$worktree" = true
>> >        then
>> >            echo 'inside work tree'
>> >        else
>> >            echo 'in repository, but not in work tree'
>> >        fi
>> >    else
>> >        echo 'not in repository'
>> >    fi
>> > --
>>
>>
>> Shouldn't this case which produces "fatal:..." need to be documented
>> in
>> the man page?
>> https://www.kernel.org/pub/software/scm/git/docs/git-rev-parse.html
>> doesn't mention it.
>
> I'm not sure where it should go in there.  The documentation for
> --git-dir says:
>
>   If $GIT_DIR is not defined and the current directory is not detected
>   to lie in a Git repository or work tree print a message to stderr
> and
>   exit with nonzero status.
>
> but there reality is that if you do not specify --parseopt
> or --sq-quote
> then the command expects to be run in a Git repository [1], so perhaps
> it would be better to say something under "Operation Modes" or in the
> description.
>
>
> [1] After taking account of $GIT_DIR, $GIT_WORK_TREE, and arguments to
>    the base "git" driver that affect these variables.
>

Yes, but given Ville's surprise and the need for special prior knowledge
of the points you raised, I still think that some short note is needed.

It can/could be read that you need to invoke --git-dir as an option
before the mentioned die() exit is taken, rather than it applying to
all(?) the path relevant options.

Either the --git-dir condition needs to say it also applies
to --is-inside-git-dir and --is-inside-work-tree
(and --is-bare-repository?), or add a "see --git-dir preconditions." to
each of those options. It's easy to be wise after the event hence my 
preference for a suitable note.

regards

Philip
