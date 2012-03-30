From: Chris Harris <ryguasu@gmail.com>
Subject: Re: Is the "text" attribute meant *only* to specify end-of-line
 normalization behavior, or does it have broader implications?
Date: Fri, 30 Mar 2012 10:49:42 -0700
Message-ID: <CANSc5vGaodyv4H5qp2ZkjY7q6ot7_JG0jdvNDFRBFW1+p7v4sw@mail.gmail.com>
References: <CANSc5vG0o_eAn7X39XhCzUoN4ab52pGCP+PvzOQCyTV31R8LGg@mail.gmail.com>
 <4F7555BC.1000804@viscovery.net> <20120330072546.GC30656@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 30 19:50:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDfxj-00009e-5L
	for gcvg-git-2@plane.gmane.org; Fri, 30 Mar 2012 19:50:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759637Ab2C3RuG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Mar 2012 13:50:06 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:40903 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759344Ab2C3RuE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Mar 2012 13:50:04 -0400
Received: by wejx9 with SMTP id x9so516567wej.19
        for <git@vger.kernel.org>; Fri, 30 Mar 2012 10:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=PJUqUf3nE7FC3unuXBulTTWyTGB6EkcGFeBID7gqjEI=;
        b=FEkLLqvFNm4HlfdRExxWHItcM7boghk5sAwBjYV+AzyXO1aBfLWPZXkCNRIgGgAQyQ
         INo5ApomHJIPJVEju5XtTXC3eUO8xBLTm6BsqBTBEhbT6wEL4PrSYwR2QcL7YLeNtejx
         n+AdzBmBlN93Et1UPgigwcj3eQPm8Xth9GtimefT/wZiWCv3WoYS8uoQgmSCwhHTkPOj
         JypAE+NAVkmqnLBxZudn0KaP3NHLFtAjsFPJnI6xI89PPkSFQLCcGkED8FcdqlkwXSbo
         OJ7m0gTn/tHDzga0bfi2e0xAn87t5t1G6hq5Pvn5Vnd9f3btWLQmWmD8LQymEfpceU9A
         fTQg==
Received: by 10.180.81.166 with SMTP id b6mr388936wiy.0.1333129802484; Fri, 30
 Mar 2012 10:50:02 -0700 (PDT)
Received: by 10.223.144.207 with HTTP; Fri, 30 Mar 2012 10:49:42 -0700 (PDT)
In-Reply-To: <20120330072546.GC30656@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194382>

On Fri, Mar 30, 2012 at 12:25 AM, Jeff King <peff@peff.net> wrote:
> On Fri, Mar 30, 2012 at 08:42:04AM +0200, Johannes Sixt wrote:
>
>> Am 3/30/2012 4:19, schrieb Chris Harris:
>> > I'm starting a new repository for a Windows-only project where I d=
on't
>> > think I want git to do any end-of-line normalization on my text fi=
les.
>> > (I'm totally happy to have CRLFs both in the repo and in all the
>> > working copies.)
>>
>> The question is rather: Are you happy if someone commits a file that=
 does
>> *not* have CRLF, but only LF?
>>
>> Because if you don't care, you are better off setting no attributes =
and no
>> core.autocrlf and no core.eol at all. The git will take the file
>> unmodified. If someone's editor changes the eol style of a file, it =
will
>> be noticed because the diff will show that the entire file has chang=
ed.
>> Your team mates should better have enough discipline not to ignore s=
uch a
>> hint that something's gone awry, of course.
>
> I think it may be slightly more complex than that. He may be OK with
> "git does nothing" and assuming everybody's editor does the sane thin=
g.
> But he may _not_ be OK with a stray core.autocrlf setting in a projec=
t
> member's git config normalizing all line endings whenever they touch =
a
> file. Setting "-text" prevents the latter.

Yes, avoiding stray core.autocrlf settings was indeed one of my main
motivations. Johannes is right that ideally a teammate is going to
notice if all of us a sudden a whole file has changed. But I also
believe that, if there's an easy way to prevent people from
accidentally doing the wrong thing when they're tired/hurried/whatever
and it has no bad side-effects, why not enable it?

The problem is slightly intensified for users of msysgit on Windows;
the msysgit installer guides one toward picking core.autocrlf=3Dtrue as
your system default. Making sure that every last teammate disables
autocrlf seems potentially error-prone.

> However, I find the behavior of "Git Extensions" to be questionable. =
I
> can see the rationale for thinking that "-text" means more than just
> handling line-endings, but I think "-diff" is probably a better choic=
e
> for seeing if something is binary (or even checking the "binary" macr=
o).
> Those are what git uses itself.
>
> Perhaps it was a mistake to call it "text", as it invites this sort o=
f
> confusion.

Ok, thanks. That's helpful.

A related point of confusion: I've noticed that, if you start with a
question along the lines of "how can I explicitly tell git that a file
is binary", then the web currently gives a slightly confusing array of
answers. For example:
* The Pro Git Book (http://progit.org/book/ch7-2.html) tells you to
use either "binary" or "-crlf -diff"
* http://www.bluishcoder.co.nz/2007/09/git-binary-files-and-cherry-pick=
ing.html
tells you to use "-crlf -diff -merge"
* http://www.dont-panic.cc/capi/2009/02/16/how-to-force-git-to-consider=
-a-file-as-binary/
tells you to use "-crlf"
* "man gitattributes" has helpful info, but it's scattered across
different sections. In the section "Marking files as binary", it says
"The simplest way to mark a file as binary is to unset the diff
attribute in the .gitattributes file". (Note: This implies that there
are other ways you might also want to consider.) Under "Performing a
three-way merge" you also learn that "-merge" is "suitable for binary
files that do not have a well-defined merge semantics". You learn
about the "binary" attribute only under the section "Defining Macro
Attributes", which says that it means "-text -diff", but not in what
cases you might want to use it. The section describing "text"/"-text"
does not contain the word "binary" at all, so you have to infer
whether it's a helpful setting for binary files.

It makes me wonder if the documentation could be improved a little on
this count, though I don't yet feel solid enough in my understanding
to propose a particular patch.

> PS I think one could potentially work around the whole issue by setti=
ng
> =A0 "-crlf", which git treats equivalently to "-text" these days (and
> =A0 hopefully isn't also checked by Git Extensions).

Yes, that sounds like a plausible way to go.
