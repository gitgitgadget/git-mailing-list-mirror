From: Frans Klaver <fransklaver@gmail.com>
Subject: Re: [PATCH] Use Python's "print" as a function, not as a keyword
Date: Wed, 21 Dec 2011 09:43:58 +0100
Message-ID: <CAH6sp9M3eMFA5a1CSidO4WsSBVkvUQCAqh1VD1S11V2RRiYHKA@mail.gmail.com>
References: <20111221021930.GA31364@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, srabbelier@gmail.com,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
To: Sebastian Morr <sebastian@morr.cc>
X-From: git-owner@vger.kernel.org Wed Dec 21 09:44:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RdHmQ-0001nL-Bi
	for gcvg-git-2@lo.gmane.org; Wed, 21 Dec 2011 09:44:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752930Ab1LUIoB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Dec 2011 03:44:01 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:47521 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752922Ab1LUIn7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Dec 2011 03:43:59 -0500
Received: by qcqz2 with SMTP id z2so4241429qcq.19
        for <git@vger.kernel.org>; Wed, 21 Dec 2011 00:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=jlDW1evNLvuxYTTEmxgsLbgKknGNHe1pWvU7y80GQlc=;
        b=TqpPzbnb8dffax9iiAgku1cRgB/jQ5iFp87N7KS5wtdx0Z+Sf6/WsDP70zTQrZe8nX
         KueZWN6JYFBeivfgEGLarCILkW98iY+KjW3T0d6Jx4/p9mXrlJ4nsPqDlQm5UYyz2k9W
         n6I42liH+0r3Ldi3Gh4vXAZhPY1gvrjYbVEks=
Received: by 10.224.52.68 with SMTP id h4mr6985061qag.71.1324457038930; Wed,
 21 Dec 2011 00:43:58 -0800 (PST)
Received: by 10.224.76.82 with HTTP; Wed, 21 Dec 2011 00:43:58 -0800 (PST)
In-Reply-To: <20111221021930.GA31364@thinkpad>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187558>

On Wed, Dec 21, 2011 at 3:19 AM, Sebastian Morr <sebastian@morr.cc> wro=
te:

> This has changed from Version 2.6 to Version 3.0. Replace all occurre=
nces of
>
> =C2=A0 =C2=A0print ...
>
> with
>
> =C2=A0 =C2=A0print(...)
>
> and all occurrences of
>
> =C2=A0 =C2=A0print >> output, ...
>
> with
>
> =C2=A0 =C2=A0output.write(... + "\n")

While it's good to look forward, you shouldn't forget about testing on
python 2.6. Lots of people still stick to that and maybe even to
earlier versions.


> =C2=A0if len(argv) < 2:
> - =C2=A0 =C2=A0 =C2=A0 print 'Usage:', argv[0], '<zipfile>...'
> + =C2=A0 =C2=A0 =C2=A0 print('Usage:', argv[0], '<zipfile>...')
> =C2=A0 =C2=A0 =C2=A0 =C2=A0exit(1)
>

Here I would use the % notation:
print('Usage: %s <zipfile>...' % argv[0])

Python 2.x would print a tuple:

>>> argv =3D ('import-zips.py',)
>>> print("Usage:", argv[0], '<zipfile>...')
('Usage:', 'import-zips.py', '<zipfile>...')

You could probably get away with

print('Usage: ' + argv[0] + ' <zipfile>...')

But that could probably become a readability issue. I would even
wonder if it's considered pythonic.

It happens a few times more:

> =C2=A0if verbose:
> - =C2=A0 =C2=A0print 'tip is', tip
> + =C2=A0 =C2=A0print('tip is', tip)

> @@ -176,27 +176,27 @@ for cset in range(int(tip) + 1):
> =C2=A0 =C2=A0 os.write(fdcomment, csetcomment)
> =C2=A0 =C2=A0 os.close(fdcomment)
>
> - =C2=A0 =C2=A0print '-----------------------------------------'
> - =C2=A0 =C2=A0print 'cset:', cset
> - =C2=A0 =C2=A0print 'branch:', hgbranch[str(cset)]
> - =C2=A0 =C2=A0print 'user:', user
> - =C2=A0 =C2=A0print 'date:', date
> - =C2=A0 =C2=A0print 'comment:', csetcomment
> + =C2=A0 =C2=A0print('-----------------------------------------')
> + =C2=A0 =C2=A0print('cset:', cset)
> + =C2=A0 =C2=A0print('branch:', hgbranch[str(cset)])
> + =C2=A0 =C2=A0print('user:', user)
> + =C2=A0 =C2=A0print('date:', date)
> + =C2=A0 =C2=A0print('comment:', csetcomment)
> =C2=A0 =C2=A0 if parent:
> - =C2=A0 =C2=A0 =C2=A0 print 'parent:', parent
> + =C2=A0 =C2=A0 =C2=A0 print('parent:', parent)
> =C2=A0 =C2=A0 if mparent:
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0print 'mparent:', mparent
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0print('mparent:', mparent)
> =C2=A0 =C2=A0 if tag:
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0print 'tag:', tag
> - =C2=A0 =C2=A0print '-----------------------------------------'
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0print('tag:', tag)
> + =C2=A0 =C2=A0print('-----------------------------------------')


>
> =C2=A0 =C2=A0 # checkout the parent if necessary
> =C2=A0 =C2=A0 if cset !=3D 0:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 if hgbranch[str(cset)] =3D=3D "branch-" +=
 str(cset):
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0print 'creating new branch=
', hgbranch[str(cset)]
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0print('creating new branch=
', hgbranch[str(cset)])
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 os.system('git checkout -b =
%s %s' % (hgbranch[str(cset)], hgvers[parent]))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 else:
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0print 'checking out branch=
', hgbranch[str(cset)]
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0print('checking out branch=
', hgbranch[str(cset)])
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 os.system('git checkout %s'=
 % hgbranch[str(cset)])
>
> =C2=A0 =C2=A0 # merge
> @@ -205,7 +205,7 @@ for cset in range(int(tip) + 1):
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 otherbranch =3D hgbranch[mp=
arent]
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 else:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 otherbranch =3D hgbranch[pa=
rent]
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0print 'merging', otherbranch, 'into', hg=
branch[str(cset)]
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0print('merging', otherbranch, 'into', hg=
branch[str(cset)])
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 os.system(getgitenv(user, date) + 'git me=
rge --no-commit -s ours "" %s %s' % (hgbranch[str(cset)], otherbranch))
>
> =C2=A0 =C2=A0 # remove everything except .git and .hg directories
> @@ -229,12 +229,12 @@ for cset in range(int(tip) + 1):
>
> =C2=A0 =C2=A0 # delete branch if not used anymore...
> =C2=A0 =C2=A0 if mparent and len(hgchildren[str(cset)]):
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0print "Deleting unused branch:", otherbr=
anch
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0print("Deleting unused branch:", otherbr=
anch)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 os.system('git branch -d %s' % otherbranc=
h)
>
> =C2=A0 =C2=A0 # retrieve and record the version
> =C2=A0 =C2=A0 vvv =3D os.popen('git show --quiet --pretty=3Dformat:%H=
').read()
> - =C2=A0 =C2=A0print 'record', cset, '->', vvv
> + =C2=A0 =C2=A0print('record', cset, '->', vvv)
> =C2=A0 =C2=A0 hgvers[str(cset)] =3D vvv
>
> =C2=A0if hgnewcsets >=3D opt_nrepack and opt_nrepack !=3D -1:
> @@ -243,7 +243,7 @@ if hgnewcsets >=3D opt_nrepack and opt_nrepack !=3D=
 -1:
> =C2=A0# write the state for incrementals
> =C2=A0if state:
> =C2=A0 =C2=A0 if verbose:
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0print 'Writing state'
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0print('Writing state')
> =C2=A0 =C2=A0 f =3D open(state, 'w')
> =C2=A0 =C2=A0 pickle.dump(hgvers, f)
>
> diff --git a/contrib/p4import/git-p4import.py b/contrib/p4import/git-=
p4import.py
> index b6e534b..144fafc 100644
> --- a/contrib/p4import/git-p4import.py
> +++ b/contrib/p4import/git-p4import.py
> @@ -26,11 +26,11 @@ if s !=3D default_int_handler:
> =C2=A0def die(msg, *args):
> =C2=A0 =C2=A0 for a in args:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg =3D "%s %s" % (msg, a)
> - =C2=A0 =C2=A0print "git-p4import fatal error:", msg
> + =C2=A0 =C2=A0print("git-p4import fatal error:", msg)
> =C2=A0 =C2=A0 sys.exit(1)
>

I think that's it for the print(...,...) stuff. I might have misssed
one or two though.


> diff --git a/git-remote-testgit.py b/git-remote-testgit.py
> index 3dc4851..9803214 100644
> --- a/git-remote-testgit.py
> +++ b/git-remote-testgit.py
> @@ -81,9 +81,9 @@ def do_capabilities(repo, args):
> =C2=A0 =C2=A0 """Prints the supported capabilities.
> =C2=A0 =C2=A0 """
>
> - =C2=A0 =C2=A0print "import"
> - =C2=A0 =C2=A0print "export"
> - =C2=A0 =C2=A0print "refspec refs/heads/*:%s*" % repo.prefix
> + =C2=A0 =C2=A0print("import")
> + =C2=A0 =C2=A0print("export")
> + =C2=A0 =C2=A0print("refspec refs/heads/*:%s*" % repo.prefix)
>
> =C2=A0 =C2=A0 dirname =3D repo.get_base_path(repo.gitdir)
>
> @@ -92,11 +92,11 @@ def do_capabilities(repo, args):
>
> =C2=A0 =C2=A0 path =3D os.path.join(dirname, 'testgit.marks')
>
> - =C2=A0 =C2=A0print "*export-marks %s" % path
> + =C2=A0 =C2=A0print("*export-marks %s" % path)
> =C2=A0 =C2=A0 if os.path.exists(path):
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0print "*import-marks %s" % path
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0print("*import-marks %s" % path)
>
> - =C2=A0 =C2=A0print # end capabilities
> + =C2=A0 =C2=A0print() # end capabilities

print("") here. 2.x:

>>> print()
()



>
>
> =C2=A0def do_list(repo, args):
> @@ -109,16 +109,16 @@ def do_list(repo, args):
>
> =C2=A0 =C2=A0 for ref in repo.revs:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 debug("? refs/heads/%s", ref)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0print "? refs/heads/%s" % ref
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0print("? refs/heads/%s" % ref)
>
> =C2=A0 =C2=A0 if repo.head:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 debug("@refs/heads/%s HEAD" % repo.head)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0print "@refs/heads/%s HEAD" % repo.head
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0print("@refs/heads/%s HEAD" % repo.head)
> =C2=A0 =C2=A0 else:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 debug("@refs/heads/master HEAD")
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0print "@refs/heads/master HEAD"
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0print("@refs/heads/master HEAD")
>
> - =C2=A0 =C2=A0print # end list
> + =C2=A0 =C2=A0print() # end list

print("")

Lots more to do, I'm afraid.

Cheers,
=46rans
