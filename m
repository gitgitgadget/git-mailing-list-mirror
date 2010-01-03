From: aaron smith <beingthexemplarylists@gmail.com>
Subject: Re: suppress fatal pathspec errors from "git add"?
Date: Sun, 3 Jan 2010 00:00:30 -0800
Message-ID: <d7ac1a681001030000n431d420ajb9b4733ad83ddecd@mail.gmail.com>
References: <d7ac1a680912311324i85b7a5anadaf2ac13f215873@mail.gmail.com>
	 <20100103074058.GB23031@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jan 03 09:00:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NRLO8-000768-QL
	for gcvg-git-2@lo.gmane.org; Sun, 03 Jan 2010 09:00:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751805Ab0ACIAc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Jan 2010 03:00:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751596Ab0ACIAc
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jan 2010 03:00:32 -0500
Received: from mail-pw0-f42.google.com ([209.85.160.42]:51680 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751435Ab0ACIAb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Jan 2010 03:00:31 -0500
Received: by pwj9 with SMTP id 9so8775643pwj.21
        for <git@vger.kernel.org>; Sun, 03 Jan 2010 00:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=bQM93d1GU2i5sDnlYNSTp0/+5fSp/J3xEVckhMzKfoY=;
        b=omPsX16SRVrgGRlsED4uWSyj5vzr6KMfjfcQgOqQl+o0m/rC225yZ+8YdeR3qNKt1x
         88jdLHeDvREeOKXmWec7EGdl5RwRG5nxxH451p9jJ6HZPg0X4mmMImvJCriyYZuSdQG/
         5pBexerV7+Dais/FfQigxzlZXzdQHew01jgu0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=joT08e0k6/f1O6WV+VthmmHaJAIL0ZpjcT0bMajVfQeih3hksbWpiY6iUT5PqxLzHa
         Ux8CS0A6G7O5mP53ceeVY4n8jn9LL0FCQX5UrWpt005sfS5xnfS0qkUBgHl9vo+uwfme
         jVkMzJjpaOlUGGIfcRUl5zDrroKXEZPHQLUk8=
Received: by 10.142.66.27 with SMTP id o27mr13917585wfa.216.1262505630814; 
	Sun, 03 Jan 2010 00:00:30 -0800 (PST)
In-Reply-To: <20100103074058.GB23031@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136069>

Hey Jeff, thanks for the reply.

Yeah you hit it right on the head, it would be useful to suppress the
errors if you're running a script to add the files. I can certainly
use that snippet u provided - thanks. It would even be useful in git
if you could suppress the errors, or maybe have a switch to list out
the files that failed, but add the ones that pass.. like "git add
--ignore-errors --list-failures" something like that. Anyway, thanks
for the input.



On Sat, Jan 2, 2010 at 11:40 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Dec 31, 2009 at 01:24:59PM -0800, aaron smith wrote:
>
>> I'm looking through the add documentation, I don't see a way to
>> suppress fatal pathspec errors? For example, if I'm adding 5 files,
>> but one of them is mis-spelled, can I have git just supress the erro=
rs
>> and add the other four?
>
> Hmm. I would have thought "git add --ignore-errors" would do what you
> want, but it only ignores errors in reading the file. If we can't sta=
t
> it, we will always die. IMHO that is an oversight in how
> "--ignore-errors" works (why should this one particular error be trea=
ted
> as fatal, when others are not?).
>
> However, I have to wonder what your workflow is to really want this. =
If
> you do:
>
> =A0$ ls
> =A0foo bar baz
> =A0$ git add foo bar bz
> =A0fatal: pathspec 'bz' did not match any files
>
> Then presumably your next command would be:
>
> =A0$ git add foo bar baz
>
> Using ignore-errors (if it worked), you would probably do:
>
> =A0$ git add baz
>
> Less typing, I suppose, but presumably you are using a shell that
> lets you just go back and edit the previous command line. I could see=
 it
> if your workflow were something like "in a script, add these N files =
if
> they exist, but it is not an error if they don't". But I still don't
> think you would want to ignore all errors; you would want to do
> something like:
>
> =A0$ git add $(for i in foo bar baz; do test -e $i && echo $i; done)
>
> instead. Am I missing something?
>
> -Peff
>
