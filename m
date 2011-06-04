From: Michael Nahas <mike.nahas@gmail.com>
Subject: Command-line interface thoughts
Date: Sat, 4 Jun 2011 12:17:48 -0400
Message-ID: <BANLkTinTWG7YXGKZzmH0rqtt+Ob7X+2yMQ@mail.gmail.com>
References: <BANLkTikTWx7A64vN+hVZgL7cuiZ16Eobgg@mail.gmail.com>
Reply-To: mike@nahas.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 04 18:18:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QStY3-0005O7-L1
	for gcvg-git-2@lo.gmane.org; Sat, 04 Jun 2011 18:18:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751703Ab1FDQRv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 4 Jun 2011 12:17:51 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:40497 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751314Ab1FDQRu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Jun 2011 12:17:50 -0400
Received: by bwz15 with SMTP id 15so2431338bwz.19
        for <git@vger.kernel.org>; Sat, 04 Jun 2011 09:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=FBenFCMBDeg93XunyTGE2QKkwP9XEVe0dQZTgdMy2A0=;
        b=kg7cywH7z50/t7ZzE2FCVWrMB0d/rzweKZsp3jVj7fnCHhsHZOYYCo6ckbUM2UuoU1
         iQvp5Yx4vj2fo4ZAPN4VWnWz8Mkqoa0oXDQqRrUk34qPI09vHlfEnzGJn+EUT8mtSkIG
         bLQsEL65h6Sdw6/PB4EShoIhGg5p/wgsXxu08=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:content-type:content-transfer-encoding;
        b=vT8JBGRWEtlWqBYacEROaTL7XVT9qizbHR8pidbZcGsCWDLJfHudrB8CEjSx8sJxkW
         7Zc8jZYG0PhbRf/g3c/czfqJv9kChf2dgoPO1QdwJayfxdXicgRyPwemH+ui80KV9/Zh
         yAC+iC059+BBtKN3tiorX5zJrQGyfwZO5m3kg=
Received: by 10.204.14.144 with SMTP id g16mr1336739bka.34.1307204268115; Sat,
 04 Jun 2011 09:17:48 -0700 (PDT)
Received: by 10.204.100.80 with HTTP; Sat, 4 Jun 2011 09:17:48 -0700 (PDT)
In-Reply-To: <BANLkTikTWx7A64vN+hVZgL7cuiZ16Eobgg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175061>

Quick list of recommendations:

1. Pick aliases for the next commit and the working tree that act like
commits on the command-line.
2. Adopt a (semi-)formal notation for describing what commands do.
3. Move the operations "checkout -- <file>" and "reset -- <file>" to
their own command names
4. Deemphasize the "branch" command for creating branches.

A "normal" (long) email follows.=A0 At the end are examples of commands
in a not-quite-so-formal notation.

I AM NOT ON THE MAILING LIST - PLEASE CC ME ON REPLIES.


------------

I was the primary designer of the PAR2 open file format and write a
lot of big software (application-layer multicast, etc.).=A0 I've been
using Git for 2 months.=A0 I love it and I greatly admire the plumbing.
However, the default "porcelain" has at times been more confusing than
enlightening.

I had some ideas about the porcelain and decided they were worth
sending to the mailing list.=A0 I ran the ideas by the two Git gurus wh=
o
answer my questions and they agreed with them.=A0 I wish I had the time
to implement them but I did PAR2 when I had time off and I'm working
now.=A0 I apologize if any of these are repeats or have already been
discussed to death.


My recommendations are:

1. Pick aliases for the next commit and the working tree that act like
commits on the command-line.

By "next commit", I mean "the commit that would be generated if the
"commit" command was run right now".=A0 "Next commit" is not the same a=
s
the index.=A0 The index is a _file_ that serves multiple purposes.
(Think of it's state during a conflicted merge.)=A0 But the index does
usually hold the files that change between HEAD and the next commit.

=46or the alias for the next commit and working tree, I suggest "NEXT"
and "WTREE".=A0 Creating these aliases will make the interface more
regular. It will remove oddities like "diff --cached FOO" and replace
them with "diff NEXT FOO" and mean that "diff" and "diff FOO" can be
explained as "diff WTREE NEXT" and "diff WTREE FOO".


2. Adopt a notation for describing what commands do.

I am sure in developer discussions there are descriptions of the
"commit" command as something like:
=A0=A0 HEAD =3D new(HEAD + (NEXT-HEAD))
=A0=A0 NEXT =3D HEAD

Where "-" creates a patch between versions and + applys a patch.=A0 Git
already has some operators like "^", which refers to the parent of a
commit. Those are useful for defining things like "commit --amend":
=A0=A0 HEAD =3D new(HEAD^ + (NEXT-HEAD^))
=A0=A0 NEXT =3D HEAD

Having this notation and using it in the man pages will make the exact
nature of the operation clear. (Right now, it takes a lot of reading
to figure out what happens to NEXT with the various command-line
options of "reset".)

Currently, to understand what commands do, I use "A Visual Git
Reference", which has been extremely valuable to me. Kuddos to Mark
Lodato for it.
http://marklodato.github.com/visual-git-guide/index-en.html

[I've included git commands in a not-formal-enough notation at the end
of this email.]


3. Move the operations "checkout -- <file>" and "reset -- <file>" to
their own command names

This is my biggest and most important suggestion.

"checkout -- foo.txt" copies foo.txt from NEXT to WTREE. Similarly,
"reset -- foo.txt" will copy foo.txt from HEAD to NEXT.

These are operations to designate/undesignate files in the next commit
and should be grouped with others like them: "add", "rm" and "mv". (In
fact, the man page for "reset -- <file>" even says that it is the
opposite of "add"!)

When these file-based operations are removed from "checkout" and
"reset", the purposes of those commands becomes clearer: "checkout"
changes HEAD to a new branch and "reset" moves the current branch
pointer to a different commit.=A0 These operations may share code with
the operations "checkout -- <file>" and "reset -- <file>", but they
serve different purposes from the user's perspective and the user
should have different names to refer to them.

As for naming these new commands, the "yet-another-porcelain" renames
"reset -- <file>" to "unadd", which I like very much.=A0 For the other,
my best suggestion is "head-to-next", but I'm sure someone can do
better.


4. Deemphasize the "branch" command for creating branches.

I assumed that the command "branch" was used for creating branches.
After all, that's how it is done in the "gittutorial(7)" man page.
However, after reviewing all the major commands, I find that it is the
_last_ way I want to create a branch. It creates a new branch, but it
doesn't switch HEAD to the new branch!

The commands that should be emphasized are "checkout -b <name>",
"commit -b <name>", and "stash branch".=A0 These make sense in normal
git usage. The "branch" command has its uses but it is not usually the
way you want to create a branch.


These are my suggestions.=A0 I wish i had time to implement them, but
I'm glad to help in the discussion of them.=A0 I'm not on the mailing
list, so PLEASE CC ME WITH ANY REPLIES.

Michael Nahas


----

These are just some commands written in a not-quite-formal notation.
This notation doesn't handle a detached head, adding directories, the
state after a conflicted "stash pop", etc.=A0 Still, as it is, I think
it's very informative to users for getting the gist of what command
does.

"add foo.txt"
=A0=A0 NEXT:foo.txt =3D WTREE:foo.txt
"rm foo.txt"
=A0=A0 delete(NEXT:foo.txt)
=A0=A0 delete(WTREE:foo.txt)
"rm --cached foo.txt"
=A0=A0 delete(NEXT:foo.txt)
"/bin/rm foo.txt"
=A0=A0 delete(WTREE:foo.txt)
"mv foo.txt bar.txt"
=A0=A0 WTREE:bar.txt =3D WTREE:foo.txt
=A0=A0 NEXT.bar.txt =3D WTREE:foo.txt
=A0=A0 delete(WTREE:foo.txt)
=A0=A0 delete(NEXT:foo.txt)
"checkout -- foo.txt"
=A0=A0 WTREE:foo.txt =3D NEXT:foo.txt
"reset -- foo.txt"
=A0=A0 NEXT:foo.txt =3D HEAD:foo.txt

"commit"
=A0=A0 HEAD =3D new(HEAD + (NEXT-HEAD))
=A0=A0 NEXT =3D HEAD
"commit --amend"
=A0=A0 HEAD =3D new(HEAD^ + (NEXT-HEAD^))
=A0=A0 NEXT =3D HEAD

"checkout FOO" (prequires WTREE=3D=3DNEXT=3D=3DHEAD)
=A0=A0 WTREE =3D FOO
=A0=A0 NEXT =3D FOO
=A0=A0 HEAD ::=3D FOO // changes the alias of HEAD to refer to FOO

"reset --soft FOO"
=A0=A0 HEAD =3D FOO // move branch; don't change alias
"reset --mixed FOO" (the default)
=A0=A0 NEXT =3D FOO
=A0=A0 HEAD =3D FOO // move branch; don't change alias
"reset --hard FOO"
=A0=A0 WTREE =3D FOO
=A0=A0 NEXT =3D FOO
=A0=A0 HEAD =3D FOO // move branch; don't change alias

"stash save"
=A0=A0 STASH =3D new(new(HEAD+(NEXT-HEAD))+WTREE-NEXT)
=A0=A0 NEXT =3D HEAD
=A0=A0 WTREE =3D HEAD
=A0=A0 push(STASH)
"stash pop"
=A0=A0 STASH =3D pop()
=A0=A0 WTREE =3D HEAD + (STASH-STASH^^)
=A0=A0 NEXT =3D HEAD + (STASH^-STASH^^)

"branch FOO"
=A0=A0 FOO =3D HEAD
"commit -b FOO"
=A0=A0 FOO =3D new(HEAD + (NEXT-HEAD))
=A0=A0 NEXT =3D FOO
=A0=A0 HEAD ::=3D FOO // change alias
"checkout -b FOO" (prequires WTREE=3D=3DNEXT=3D=3DHEAD)
=A0=A0 FOO =3D HEAD // create FOO and make it a copy of HEAD
=A0=A0 WTREE =3D FOO
=A0=A0 NEXT =3D FOO
=A0=A0 HEAD ::=3D FOO // change alias
"stash branch FOO"
=A0=A0 STASH =3D pop()
=A0=A0 FOO =3D STASH^^ // create FOO and make it a copy of STASH^^
=A0=A0 NEXT =3D STASH^
=A0=A0 WTREE =3D STASH
=A0=A0 HEAD ::=3D FOO // change alias

"merge FOO" (prequires NEXT=3DHEAD)
=A0=A0 [ANC is the nearest common ancestor]
=A0=A0 WTREE =3D ANC + (WTREE - ANC) + (FOO-ANC)
=A0=A0 NEXT =3D ANC + (HEAD - ANC) + (FOO-ANC)
=A0=A0 HEAD =3D new(HEAD + (NEXT-HEAD))
=A0=A0 NEXT =3D HEAD
"cherry-pick FOO" (prequires WTREE=3D=3DNEXT=3D=3DHEAD)
=A0=A0 HEAD =3D new(HEAD + (FOO - FOO^))
=A0=A0 NEXT =3D HEAD
=A0=A0 WTREE =3D HEAD
"rebase FOO" is basically a iterated application of "cherry-pick"
