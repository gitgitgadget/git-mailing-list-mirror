Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70413C4332F
	for <git@archiver.kernel.org>; Mon, 17 Oct 2022 15:47:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbiJQPrM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Oct 2022 11:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbiJQPrK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2022 11:47:10 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C50D5FF5B
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 08:47:08 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id b4so19144230wrs.1
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 08:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks.biz; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Dmlm08VCr35dlgmqJBe3QO8JUf4mNOMGbmZGGFtxwEs=;
        b=blSBsmNFXL73KsTM/s7xbAWcu1Iezv7q83Jb2Eo+1BfJ94es6C9zCwj/Z3W9xLhHwy
         PE+J9KrNRGeuqAH6l7Iv8QlXhFRIw2ebfa4HxNp1Zd4dVcHUwYrSq05TC1GiafRZyFb0
         c7EoSI9v7UoMvak+p9o8SyyQ6dJuu+vIsnLI4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dmlm08VCr35dlgmqJBe3QO8JUf4mNOMGbmZGGFtxwEs=;
        b=R1+HZmXor2P1VcwSKDgnu8SGVn45Ubg+Em+6i3yYwoP4KOZqV/pXpkV9Hrkgm5ukRW
         OnG9cPkEY/BMgkg2MMRFlnJdnN1HdH/QL9W/UOUYpP1uhJ2d1hB+EZWfkay0zPn0FcrL
         5qTjbTdDG0W+FDGd3UkAFmwtcSCPJ997iEI8vtUXoeEgfPqy97D1uiIj8oI7oO6y5f99
         19ExfmljYtJCDqOvRI7sj+ZWtGBKd4T4zA2yUyufU/EDdueLvk2RCowM9Dpx/TylSGk+
         ccPGEFE4YLbmryFET19ZYHTvpcm4sP7SedM+r+WmbfJiK3E+cJwIWI6Y9kroW5I8Ekrh
         TLvA==
X-Gm-Message-State: ACrzQf3d2waUpbWyYlGgf8xLCrjQSGp/lewi/cFoxFy1kJnw4CR9OGQ/
        3J8qmNxDtGQXIF7noNg90A8isR72Zsx6S+Xb2emsdW8TFBkIEw==
X-Google-Smtp-Source: AMsMyM4YR4kQzMyHtsq8TqiEFq2vT9Jzq6SO3Iqf8WiokO00yxCMZLcuEixDj1zqIrUGG1jZevcm2spjP0/7RSZOVbA=
X-Received: by 2002:a17:906:7952:b0:787:a14d:65a7 with SMTP id
 l18-20020a170906795200b00787a14d65a7mr9431693ejo.108.1666021616066; Mon, 17
 Oct 2022 08:46:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAPMMpogcnwJDUazw82OB0DvdgvNS6hpUN9Qs69ppTFb1QFbLSg@mail.gmail.com>
 <220930.86r0ztufwd.gmgdl@evledraar.gmail.com> <YznhYzWztkPc9pJk@tapette.crustytoothpaste.net>
 <CAPMMpojy8OMxYT0WuZCOZjwvufmVucvoHPtvLHatopXvuk9K5Q@mail.gmail.com>
 <CABPp-BHaMCcLjdx2m4CALZQiTRQy_LovWfbdrga6XWhQJhoxWQ@mail.gmail.com>
 <CAPMMpojvDj7Yc27HKQU4seSqg5Tx61RY3LOgMfkK=a0J25QYQw@mail.gmail.com>
 <CABPp-BEFoco4wg4BVE_aPz95cfMwAmbwU19eFyUOJTKj3q6wJA@mail.gmail.com> <CAPMMpoictABXUhVCASZOiYZ4nydGtqiDYRpAELEBvbPn_5jRWA@mail.gmail.com>
In-Reply-To: <CAPMMpoictABXUhVCASZOiYZ4nydGtqiDYRpAELEBvbPn_5jRWA@mail.gmail.com>
From:   Tao Klerks <tao@klerks.biz>
Date:   Mon, 17 Oct 2022 17:46:44 +0200
Message-ID: <CAPMMpognADkh7ZJ+qYwE2GOoQ+knAthXJC-K6QAjN8qLwuS=7Q@mail.gmail.com>
Subject: Re: icase pathspec magic support in ls-tree
To:     Elijah Newren <newren@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git <git@vger.kernel.org>
Content-Type: multipart/mixed; boundary="0000000000009d8c6c05eb3ce25b"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--0000000000009d8c6c05eb3ce25b
Content-Type: text/plain; charset="UTF-8"

Thanks again for the code samples above!

I've spent some time productizing this for my environment, and I think
it's pretty close to optimal for my environment at least.

In case this can be of value to anyone else, I've attached the final thing.

This version is genericized a little - two specific specializations
for my environment not included here are:
* a specific strategy for determining the most-likely-correct upstream
branch to use as a default for "diff from" for new branches, to avoid
having to do a full-tree dupe search; in most environments choosing
"master" or "main" would likely be the right thing most of the time
* a specific list of branch paths that we should validate (vs others
that we should not)

Best regards,
Tao

On Sun, Oct 16, 2022 at 12:06 AM Tao Klerks <tao@klerks.biz> wrote:
>
> This seems to be working, thank you!!!
>
> Two updates I had to make, in case this is useful to anyone else:
>
> 1: I'm getting some weird behavior I can't explain yet, where some
> paths are returned from the ls-tree call twice: The input to ls-tree
> is all unique paths, but the output somehow includes a relatively
> small subset of paths twice.
> This mysterious issue is easily addressed by adding an extra "uniq"
> call to remove the "trivial dupes" before hunting for the
> "case-insensitive dupes" we're interested in:
>
> git diff --diff-filter=A --no-renames --name-only HEAD~1 HEAD |
> all-leading-dirs.py | xargs --no-run-if-empty git ls-tree --name-only
> -t HEAD | sort | uniq | uniq -i -d
>
> 2: The xargs call has issues with paths with spaces in them. Adding
> -d"\n" seems to be a clean way to fix this
>
> git diff --diff-filter=A --no-renames --name-only HEAD~1 HEAD |
> all-leading-dirs.py | xargs -d"\n" --no-run-if-empty git ls-tree --name-only
> -t HEAD | sort | uniq | uniq -i -d
>
>
> Not only does this approach seem to work well, but it also has far
> better performance characteristics than I was expecting!
>
> Simple small commit (10 files): 20ms
> Reasonably large commit (10,000 files): 250ms
> Diff from empty on a smaller branch (100,000 files): 2,800ms
> Diff from empty on a larger branch (200,000 files): 5,400ms
>
>
> It still makes sense to check the number of files/lines after doing
> the diff, and do a "simple" 800ms full-tree (no-pathspec) dupe check
> instead of this when your diff size goes past some file count
> threshold, but it looks like that threshold would be quite high in my
> environment - 30k files maybe?
>
> I will have a go at writing a full update hook, and (without knowing
> whether it will make sense from a performance perspective) I'd like to
> try to implement the "all-leading-dirs" logic in bash 4 using
> associative arrays, to remove the python dependency. If I make it work
> I'll post back here.
>
> This seems to cover what I needed icase pathspec magic for in ls-tree,
> without having to implement it - so thanks again!
>
> Tao
>
> On Fri, Oct 14, 2022 at 7:06 PM Elijah Newren <newren@gmail.com> wrote:
> >
> > On Fri, Oct 14, 2022 at 1:48 AM Tao Klerks <tao@klerks.biz> wrote:
> > >
> > > On Fri, Oct 14, 2022 at 9:41 AM Elijah Newren <newren@gmail.com> wrote:
> > > >
> > [...]
> > > > I don't see why you need to do full-tree with existing options, nor
> > > > why the ls-tree option you want would somehow make it easier to avoid.
> > > > I think you can avoid the full-tree search with something like:
> > > >
> > > > git diff --diff-filter=A --no-renames --name-only $OLDHASH $NEWHASH |
> > > > sed -e s%/[^/]*$%/% | uniq | xargs git ls-tree --name-only $NEWHASH |
> > > > \
> > > >    sort | uniq -i -d
> > > >
> > > > The final "sort | uniq -i -d" is taken from Torsten's suggestion.
> > > >
> > > > The git diff ... xargs git ls-tree section on the first line will
> > > > provide a list of all files (& subdirs) in the same directory as any
> > > > added file.  (Although, it has a blind spot for paths in the toplevel
> > > > directory.)
> > >
> > > The theoretical problem with this approach is that it only addresses
> > > case-insensitive-duplicate files, not directories.
> >
> > It'll catch some case-insensitive-duplicate directories too -- note
> > that I did call out that it'd print subdirs.  But to be more cautious,
> > you would need to carefully grab all leading directories of any added
> > path, not just the immediate leading directory.
> >
> > > Directories have been the problem, in "my" repo, around one-third of
> > > the time - typically someone does a directory rename, and someone else
> > > does a bad merge and reintroduces the old directory.
> > >
> > > That said, what "icase pathspec magic" actually *does*, is break down
> > > the pathspec into iteratively more complete paths, level by level,
> > > looking for case-duplicates at each level. That's something I could
> > > presumably do in shell scripting, collecting all the interesting
> > > sub-paths first, and then getting ls-tree to tell me about the
> > > immediate children for each sub-path, doing case-insensitive dupe
> > > searches across children for each of these sub-paths.
> > >
> > > ls-tree supporting icase pathspec magic would clearly be more
> > > efficient (I wouldn't need N ls-tree git processes, where N is the
> > > number of sub-paths in the diff), but this should be plenty efficient
> > > for normal commits, with a fallback to the full search
> > >
> > > This seems like a sensible direction, I'll have a play.
> >
> > If you create a script that gives you all leading directories of any
> > listed path (plus replacing the toplevel dir with ':/'), such as this
> > (which I'm calling 'all-leading-dirs.py'):
> >
> > """
> > #!/usr/bin/env python3
> >
> > import os
> > import sys
> >
> > paths = sys.stdin.read().splitlines()
> > dirs_seen = set()
> > for path in paths:
> >   dir = path
> >   while dir:
> >     dir = os.path.dirname(dir)
> >     if dir in dirs_seen:
> >       continue
> >     dirs_seen.add(dir)
> > if dirs_seen:
> >   # Replace top-level dir of "" with ":"; we'll add the trailing '/'
> > below when adding it to all other dirs
> >   dirs_seen.remove("")
> >   dirs_seen.add(':')
> >   for dir in dirs_seen:
> >     print(dir+'/')  # ls-tree wants the trailing '/' if we are going
> > to list contents within that tree rather than just the tree itself
> > """
> >
> > Then the following will catch duplicates files and directories for you:
> >
> > git diff --diff-filter=A --no-renames --name-only HEAD~1 HEAD |
> > all-leading-dirs.py | xargs --no-run-if-empty git ls-tree --name-only
> > -t HEAD | sort | uniq -i -d
> >
> > and it no longer has problems catching duplicates in the toplevel
> > directory either.  It does have (at most) two git invocations, but
> > only one invocation of ls-tree.  Here's a test script to prove it
> > works:
> >
> > """
> > #!/bin/bash
> >
> > git init -b main nukeme
> > cd nukeme
> > mkdir -p dir1/subdir/whatever
> > mkdir -p dir2/subdir/whatever
> > >dir1/subdir/whatever/foo
> > >dir2/subdir/whatever/foo
> > git add .
> > git commit -m initial
> >
> > mkdir -p dir1/SubDir/whatever
> > >dir1/SubDir/whatever/foo
> > git add .
> > git commit -m stuff
> >
> > git diff --diff-filter=A --no-renames --name-only HEAD~1 HEAD |
> > all-leading-dirs.py | xargs --no-run-if-empty git ls-tree --name-only
> > -t HEAD | sort | uniq -i -d
> > """
> >
> > The output of this script is
> > """
> > dir1/subdir
> > """
> > which correctly notifies on the duplicate (dir1/SubDir being the
> > other; uniq is the one that picks which of the two duplicate names to
> > print)

--0000000000009d8c6c05eb3ce25b
Content-Type: application/octet-stream; 
	name="case-insensitive-duplicate-check-update-hook.bash"
Content-Disposition: attachment; 
	filename="case-insensitive-duplicate-check-update-hook.bash"
Content-Transfer-Encoding: base64
Content-ID: <f_l9cy80cq0>
X-Attachment-Id: f_l9cy80cq0

IyEvYmluL2Jhc2gKClVQREFUSU5HX1JFRj0iJDEiCkZST01fSEFTSD0iJDIiClRPX0hBU0g9IiQz
IgoKIyBHRU5FUkFMIFByb2JsZW0gQmFja2dyb3VuZDoKIyAtIEluIGdpdCwgcmVwbyBwYXRocyBh
cmUgaW5oZXJlbnRseSBjYXNlLXNlbnNpdGl2ZQojIC0gSW4gdHdvIG9mIHRoZSB0aHJlZSBtYWpv
ciBkZXYgd29ya3N0YXRpb24gT1NzIChXaW5kb3dzLCBPU1gpLCBmaWxlc3lzdGVtcyBhcmUgdHlw
aWNhbGx5IGNhc2UtaW5zZW5zaXRpdmUKIyAtIFdoZW4gZmlsZXMgYXJlIGFkZGVkIGluIHRoZSBy
ZXBvIHRoYXQgYXJlIGR1cGxpY2F0ZXMgaW4gdGhlIGZpbGVzeXN0ZW0sIGJ1dCBub3QgaW4gZ2l0
LCB1c2FiaWxpdHkgcHJvYmxlbXMgYWJvdW5kCiMgLSBBIHBhcnRpY3VsYXJseSBvbmVyb3VzIGlz
c3VlIG9jY3VycyB3aGVuIGNhc2UtaW5zZW5zaXRpdmUtZHVwbGljYXRlIGZpbGVzIGhhdmUgZGlm
ZmVyaW5nIGNvbnRlbnQ7IGFmdGVyIGEgY2hlY2tvdXQKIyAgICAgICBvZiBzdWNoIGEgdHJlZSwg
dGhlIGNhc2UtaW5zZW5zaXRpdmUgd29ya2luZyB0cmVlIGFsd2F5cyBsb29rcyBsaWtlIGl0IGhh
cyBhIGNoYW5nZSB0byBvbmUgb3IgdGhlIG90aGVyIG9mIHRoZQojICAgICAgIFZDUyBmaWxlcy4g
SW4gc3VjaCBhbiAidW5hdm9pZGFibHkvdW5maXhhYmx5IGRpcnR5IHRyZWUiIHN0YXRlLCBhIGNh
c3VhbCB1c2VyIGNhbm5vdCBldmVuICJwdWxsIiBhIGZpeGVkIGJyYW5jaAojICAgICAgIHN0YXRl
LCBhcyBnaXQgd2lsbCB3aWxsIHJlZnVzZSB0byBwdWxsIGluIGEgZGlydHkgd29ya2luZyB0cmVl
LgojIC0gR2l0IGN1cnJlbnRseSBvZmZlcnMgbm8gYnVpbHQtaW4gbWVjaGFuaXNtIHRvIHByZXZl
bnQgdGhpcwojIC0gSXQgaXMgcHJlZmVyYWJsZSB0byBhdm9pZCB0aGlzIGlzc3VlIGluIGEgc2Vy
dmVyIGhvb2ssIHJhdGhlciB0aGFuIGluIENJIHZhbGlkYXRpb25zIChhbHRob3VnaCB0aGUgbGF0
dGVyIGNhbiBhbHNvCiMgICAgICAgd29yaykgLSB0aGUgZWFybGllciB0aGUgaXNzdWUgaXMgIm5p
cHBlZCBpbiB0aGUgYnVkIiB0aGUgYmV0dGVyLgojIC0gVGhlcmUgaXMgYSByZWFzb25hYmx5IHRy
aXZpYWwgc2hlbGwgc2NyaXB0aW5nIHRlc3QgZm9yICJUcmVlIGhhcyBkdXBsaWNhdGVzIiwgYnV0
IHZhbGlkYXRpbmcgc2ltcGx5IG9uIHRoZSBiYXNpcyBvZgojICAgICAgIHRoaXMgdGVzdCBwcmVz
ZW50cyB0d28gY2hhbGxlbmdlczoKIyAgIC0gSXQgbWlnaHQgYmUgdG9vIGV4cGVuc2l2ZSB0byBy
dW4gb24gZXZlcnkgY29tbWl0IGluIGEgbGFyZ2UgcmVwbwojICAgLSBJdCBtaWdodCB0cmlnZ2Vy
ICJmYWxzZSBwb3NpdGl2ZXMiIHdoZW4gY3JlYXRpbmcgbmV3IHJlZnMgcG9pbnRpbmcgdG8gb2xk
IGFscmVhZHktcHJvYmxlbWF0aWMgY29tbWl0cwoKIyBTUEVDSUZJQyBQcm9ibGVtIFJlcG8gQmFj
a2dyb3VuZDoKIyAtIDIwMEsgZmlsZXMsIGluIGRlZXBseSBuZXN0ZWQgKGphdmEpIGZvbGRlciBz
dHJ1Y3R1cmVzICgrNTBrIGRpcmVjdG9yaWVzKQojIC0gRG9pbmcgYSAibmFpdmUiIGZ1bGwtdHJl
ZSBjYXNlLWluc2Vuc2l0aXZlIGR1cGxpY2F0ZSBzZWFyY2ggdGFrZXMgYXJvdW5kIDJzCiMgICAt
IFRoaXMgaXMgbm90IGEgcHJpY2Ugd2UncmUgd2lsbGluZyB0byBwYXkgb24gZXZlcnkgYnJhbmNo
IHVwZGF0ZQojIC0gQ2FzZS1pbnNlbnNpdGl2ZSBkdXBsaWNhdGVzIGFyZSBzb21ldGltZXMgZm9s
ZGVycywgc29tZXRpbWVzIGZpbGVzCiMgLSBSZXBvIGhhcyBsb3RzIG9mIHJlZnMgLSAxMTBrIC0g
c28gc2Nhbm5pbmcgdGhlbSBpcyBjb3N0bHkKIyAtIE5ldyByZWZzIGFyZSBjcmVhdGVkICp2ZXJ5
KiBvZnRlbiAtIG1vc3Qgb2Z0ZW4gYXMgImtlZXBhcm91bmQiIHJlZnMgaW4gR2l0TGFiCiMgICAt
IFZhbGlkYXRpb25zIGRvbid0IG1ha2Ugc2Vuc2UgLyBkb24ndCBhZGQgdmFsdWUgZm9yIHNvbWUg
b3IgbWFueSBjbGFzc2VzIG9mIHJlZiAodGhvc2UgY3JlYXRlZCBieSBhdXRvbWF0ZWQKIyAgICAg
ICBzeXN0ZW1zLCB3aGVyZSBhIHZpb2xhdGlvbiBpcyBub3QgdGhlICJmYXVsdCIgb2YgdGhlIHB1
c2hlcikKIyAtIFNvbWUgKGFjdGl2ZSkgYnJhbmNoZXMgYXJlIHZlcnkgZGlzdGFudCBmcm9tIGVh
Y2ggb3RoZXIgLSB0aGVyZSBpcyBubyBzaW5nbGUgIm1hc3RlciIKIAojIFRlc3QgQ2FzZXMgLyBz
aXR1YXRpb25zOgojIC0gU2luZ2xlICJub3JtYWwiIGNoYW5nZSwgYSBkb3plbiBhZGRlZCBmaWxl
cwojIC0gU2luZ2xlICJsYXJnZS1pc2giIGNoYW5nZSwgYSBmZXcgaHVuZHJlZCBhZGRlZCBmaWxl
cwojIC0gb24gYW4gZXhpc3RpbmcgYnJhbmNoIChlZyBzaW1wbGUgY2hhbmdlLCBtZXJnZSBmcm9t
IHVwc3RyZWFtKQojIC0gb24gYSBuZXcgYnJhbmNoLCB2YXJ5aW5nIHRoZSBvcmlnaW5hbC91cHN0
cmVhbSBicmFuY2gKIyAtIG9uIG5ldyByZWZzIHRoYXQgYXJlIGV4Y2x1ZGVkIGZyb20gdmFsaWRh
dGlvbiBieSBwYXRoL3BhdHRlcm4KCiMgRXhwZWN0ZWQgJiB0ZXN0ZWQgcGVyZm9ybWFuY2UgY2hh
cmFjdGVyaXN0aWNzIG9mIHRoaXMgaG9vayBzY3JpcHQ6CiMgLSBGb3Igbm9uLWJyYW5jaCBvciBv
dGhlcndpc2UgZGlzcXVhbGlmaWVkIHJlZnMsIGNsb3NlIHRvIG5vIG92ZXJoZWFkLgojIC0gRm9y
IHVwZGF0ZXMgdG8gZXhpc3RpbmcgcmVmcywgaXQgaXMgcmVhc29uYWJseSBvcHRpbWFsCiMgICAt
IFRoZXJlIGFyZSBmb3VyIG5vbi10cml2aWFsIG9wZXJhdGlvbnMsIHdoaWNoIGFsbCBzY2FsZSB3
aXRoIHRoZSBkaWZmIHNpemU6CiMgICAgIC0gRmluZGluZyB0aGUgZmlsZXMgYWRkZWQgaW4gdGhl
IHJlZiB1cGRhdGUgKGdpdCBkaWZmKQojICAgICAtIEZpbmRpbmcgYWxsIHRoZSBhbmNlc3Rvci1w
YXRocyBmb3IgdGhlc2UgZmlsZXMgKG91dHB1dF9hbGxfYW5jZXN0b3JfZ2l0cGF0aHMpCiMgICAg
ICAgLSBUaGlzICpjYW4qIGJlIG1hZGUgc2xpZ2h0bHkgbW9yZSBlZmZpY2llbnQgYnkgdXNpbmcg
ZWcgcHl0aG9uCiMgICAgIC0gRmluZGluZyBhbGwgaXRlbXMgaW4gdGhlc2UgcGF0aHMgKGdpdCBs
cy10cmVlKQojICAgICAtIFNvcnRpbmcgdGhlIHJlc3VsdGluZyBwYXRocy9pdGVtcyAoc29ydCkK
IyAgIC0gV2hlbiB0aGUgbnVtYmVyIG9mIGFkZGVkIGZpbGVzIGlzIHRvbyBoaWdoLCB3ZSBmYWxs
IGJhY2sgdG8gYSBmdWxsLXRyZWUgc2VhcmNoCiMgLSBGb3IgbmV3IG5vbi1kaXNxdWFsaWZpZWQg
cmVmcywgdGhlcmUgYXJlIGFkZGl0aW9uYWwgb3ZlcmhlYWRzOgojICAgLSBGaW5kaW5nIHRoZSBi
ZXN0L2Nsb3Nlc3QgInN0YW5kYXJkIGJyYW5jaCIgdG8gZGlmZiBmcm9tLCBmb3IgYSBuZXcgcmVm
LCBtaWdodCBiZSBub24tdHJpdmlhbCBpbiBzb21lIHJlcG9zCiMgICAgIC0gKGluIHRoZSBnZW5l
cmljIGltcGxlbWVudGF0aW9uLCBpdCBpcyBhIHRyaXZpYWwvY2hlYXAgY2hlY2sgZm9yICJtYXN0
ZXIiIGFuZCAibWFpbiIpCiMgICAtIERlcGVuZGluZyBvbiB0aGUgc3RyYXRlZ3kgdXNlZCB0byBm
aW5kIGEgImRpZmYgZnJvbSIgcmVmLCBkaWZmcyBvbiBuZXcgcmVmcyB3aWxsIGxpa2VseSBiZSBt
dWNoIGxhcmdlci9tb3JlIGV4cGVuc2l2ZSB0aGFuIHRoZXkgc2hvdWxkIGlkZWFsbHkgbmVlZCB0
byBiZQoKIyBGdXR1cmUgd29yayAvIHBvc3NpYmxlIGltcHJvdmVtZW50czoKIyAtIElmIGdpdCBw
cm92aWRlZCBhbiBlYXN5L2NoZWFwIHdheSB0byBkZXRlY3QgImNvbW1pdHMgbmV3IHRvIHRoaXMg
cmVwbyIgaW4gYW4gdXBkYXRlIGhvb2ssIHRoZSBkaWZmcyBjb3VsZCBiZSBjb25zaXN0ZW50bHkg
bXVjaCBzbWFsbGVyL21vcmUgZWZmaWNpZW50LgojICAgLSAoaXQgaXMgcG9zc2libGUgdG8gZmlu
ZCBvdXQgd2hldGhlciBhIGNvbW1pdCBpcyBuZXQtbmV3IHdpdGggc29tZXRoaW5nIGxpa2UgImdp
dCByZXYtbGlzdCBNWVJFRiAtLW5vdCAtLWV4Y2x1ZGUgTVlSRUYgLS1hbGwiLCBidXQgdGhpcyBp
cyAqZXhwZW5zaXZlKiBpbiBhIGxhcmdlIHJlcG8pCiMgLSBJZiAiZ2l0IGxzLXRyZWUiIHN1cHBv
cnRlZCBpY2FzZSBwYXRoc3BlYyBtYWdpYywgd2UgY291bGQgcGFzcyBpbiBmdWxsIGFkZGVkLWZp
bGUgcGF0aHNwZWNzLCBhbmQgc3Vic2VxdWVudCBkdXBlLWRldGVjdGlvbiBjb3VsZCBiZSBtb3Jl
IGVmZmljaWVudAojICAgLSAodGhlcmUgd291bGQgYmUgYSBmdW5jdGlvbmFsIGRpZmZlcmVuY2U6
IHRoZSBjdXJyZW50IHN0cmF0ZWd5IGZpbmRzIGR1cGUgZGlyZWN0b3JpZXMgZXZlbiBpZiB0aGV5
IGhhdmUgbm9uLW92ZXJsYXBwaW5nIGNvbnRlbnRzOyB0aGlzIG90aGVyIGFwcHJvYWNoIHdvdWxk
IG5vdCkKCiMgUmVxdWlyZW1lbnRzOgojIC0gQmFzaCA0IGZvciBhc3NvY2lhdGl2ZSBhcnJheXMK
CgojLS0tLS0tLS0tCiNGVU5DVElPTlMgLSBjYWxsZWQgdmlhIHN1YnNoZWxsCiMtLS0tLS0tLS0K
Cm91dHB1dF9hbGxfYW5jZXN0b3JfZ2l0cGF0aHMoKSB7CiAgZGVjbGFyZSAtQSBJTlRFUkVTVElO
R19QQVRIUwogIHdoaWxlIElGUz0gcmVhZCAtciBJTlBVVF9MSU5FOyBkbwogICAgQ1VSUkVOVF9Q
QVRIPSIkSU5QVVRfTElORSIKICAgIHdoaWxlIFsgIiRDVVJSRU5UX1BBVEgiICE9ICI6IiBdOyBk
bwogICAgICBbWyAiJENVUlJFTlRfUEFUSCIgPT0gKi8qIF1dIHx8IENVUlJFTlRfUEFUSD0iOi8k
Q1VSUkVOVF9QQVRIIgogICAgICBQQVJFTlRfUEFUSD0iJHtDVVJSRU5UX1BBVEglLyp9IgogICAg
ICBpZiBbICIke0lOVEVSRVNUSU5HX1BBVEhTWyIke1BBUkVOVF9QQVRIfS8iXX0iID0gIjEiIF07
IHRoZW4KICAgICAgICBicmVhawogICAgICBmaQogICAgICBJTlRFUkVTVElOR19QQVRIU1siJHtQ
QVJFTlRfUEFUSH0vIl09IjEiCiAgICAgIENVUlJFTlRfUEFUSD0iJFBBUkVOVF9QQVRIIgogICAg
ZG9uZQogIGRvbmUgPDw8ICIkMSIKICBmb3Iga2V5IGluICR7IUlOVEVSRVNUSU5HX1BBVEhTW0Bd
fTsgZG8gZWNobyAiJGtleSI7IGRvbmUKICBkZWJ1Z19sb2cgIkZPVU5EICR7I0lOVEVSRVNUSU5H
X1BBVEhTW0BdfSBJTlRFUkVTVElORyBQQVRIUyIgCn0KCmZpbmRfY2xvc2VzdF9zdGFuZGFyZF9i
cmFuY2goKSB7CiAgIyBTaW1wbGVzdCBpbXBsZW1lbnRhdGlvbiwgbG9vayBmb3IgIm1hc3RlciIg
b3IgIm1haW4iIG9yIGdpdmUgdXAuCiAgIyB0aGVyZSB3aWxsIGxpa2VseSBiZSBiZXR0ZXIgcmVw
by1zcGVjaWZpYyBzdHJhdGVnaWVzIGluIHNwZWNpZmljIHJlcG9zLgogIGdpdCBmb3ItZWFjaC1y
ZWYgLS1mb3JtYXQ9IiUocmVmbmFtZSkiIC0tY291bnQ9MSByZWZzL2hlYWRzL21hc3RlciByZWZz
L2hlYWRzL21haW4KfQoKU1RBUlRfVElNRT0iJChkYXRlICslcyVOKSIKZGVidWdfbG9nKCkgewog
IGlmIFsgLW4gIiRERUJVR19EVVBFX0hPT0siIF07IHRoZW4KICAgIENVUlJFTlRfVElNRT0iJChk
YXRlICslcyVOKSIKICAgIGVjaG8gIkRlYnVnIGF0ICQoKCQoKCRDVVJSRU5UX1RJTUUtJFNUQVJU
X1RJTUUpKS8xMDAwMDAwKSltczogJDEiID4mMgogIGZpCn0KCiMtLS0tLS0tLS0tLQojTUFJTiBT
Q1JJUFQKIy0tLS0tLS0tLS0tCgppZiBbIC16ICIkVE9fSEFTSCIgXTsgdGhlbgogICMgYnJhbmNo
IGRlbGV0aW9uLCBubyBwb3NzaWJpbGl0eSBvZiBuZXcgZHVwZXMKICBkZWJ1Z19sb2cgIkJSQU5D
SCBERUxFVElPTiAtIFNLSVBQSU5HIERVUEUgVkFMSURBVElPTiIKICBleGl0IDAKZmkKClZBTElE
QVRJTkdfUEFUSF9QUkVGSVhFUz0oInJlZnMvaGVhZHMvIikKUkVGX0lTX1ZBTElEQVRBQkxFPTAK
Zm9yIFBBVEhfUFJFRklYIGluICIke1ZBTElEQVRJTkdfUEFUSF9QUkVGSVhFU1tAXX0iCmRvCiAg
aWYgW1sgIiRVUERBVElOR19SRUYiID0gIiRQQVRIX1BSRUZJWCIqIF1dOyB0aGVuCiAgICBSRUZf
SVNfVkFMSURBVEFCTEU9MQogIGZpCmRvbmUKCmlmIFtbICIkUkVGX0lTX1ZBTElEQVRBQkxFIiA9
ICIwIiBdXTsgdGhlbgogICMgd2UncmUgbm90IGludGVyZXN0ZWQgaW4gdmFsaWRhdGluZyBmb3Ig
ZHVwZXMgb24gdGhpcyByZWYuCiAgZGVidWdfbG9nICJOT04tVkFMSURBVEFCTEUgUkVGIC0gU0tJ
UFBJTkcgRFVQRSBWQUxJREFUSU9OIgogIGV4aXQgMApmaQoKRlVMTF9TRUFSQ0g9ZmFsc2UKaWYg
WyAteiAiJEZST01fSEFTSCIgXTsgdGhlbgogICMgTmV3IHJlZjsgaW4gbW9zdCByZXBvcyBuZXcg
ImludGVyZXN0aW5nIiAobm90LWV4Y2x1ZGVkLWZyb20tZHVwZS1jaGVjaykKICAjIHJlZnMgd2ls
bCBsaWtlbHkgYmUgY2xvc2VseSByZWxhdGVkIHRvIG1hc3Rlci9tYWluIG1vc3Qgb2YgdGhlIHRp
bWUsIHNvCiAgIyBkaWZmIGZyb20gdGhlcmUgcmF0aGVyIHRoYW4gc3RhcnRpbmcgZnJvbSBzY3Jh
dGNoLgogIGRlYnVnX2xvZyAiTkVXIFJFRiAtIExPT0tJTkcgRk9SIFNUQU5EQVJEIEJSQU5DSCIK
ICBGUk9NX0hBU0g9JChmaW5kX2Nsb3Nlc3Rfc3RhbmRhcmRfYnJhbmNoICIkVE9fSEFTSCIpCmZp
CgppZiBbIC16ICIkRlJPTV9IQVNIIiBdOyB0aGVuCiAgIyBJZiB0aGlzIGlzIGEgbmV3IHJlZiBh
bmQgbm8gInN0YW5kYXJkIHVwc3RyZWFtIHJlZiIgd2FzIGZvdW5kLCBmYWxsIGJhY2sKICAjIHRv
IGZ1bGwgZHVwZSBzZWFyY2guCiAgZGVidWdfbG9nICJOTyBTVEFOREFSRCBVUFNUUkVBTSBSRUYg
Rk9VTkQ7IERPSU5HIEZVTEwgU0VBUkNIIgogIEZVTExfU0VBUkNIPXRydWUKZWxzZQogIGRlYnVn
X2xvZyAiQ0hFQ0tJTkcgRElGRjogZ2l0IGRpZmYgLS1kaWZmLWZpbHRlcj1BIC0tbm8tcmVuYW1l
cyAtLW5hbWUtb25seSAnJEZST01fSEFTSCcgJyRUT19IQVNIJyIKICBORVdfRklMRVM9JChnaXQg
ZGlmZiAtLWRpZmYtZmlsdGVyPUEgLS1uby1yZW5hbWVzIC0tbmFtZS1vbmx5ICIkRlJPTV9IQVNI
IiAiJFRPX0hBU0giKQogIE5FV19GSUxFX0xJTkVfQ09VTlQ9JCh3YyAtbCA8PDwgIiRORVdfRklM
RVMiKQogIAogIGlmIFsgIiRORVdfRklMRV9MSU5FX0NPVU5UIiAtbGUgIjEiIF0gJiYgWyAteiAi
JE5FV19GSUxFUyIgXTsgdGhlbgogICAgIyBubyBuZXdseSBhZGRlZCBmaWxlcywgbm8gcG9zc2li
aWxpdHkgb2YgbmV3IGR1cGVzCgkjIChjb3VudCAiMSIgY2FuIGJlIGFuIGVtcHR5IGxpbmUpCiAg
ICBkZWJ1Z19sb2cgIkVYSVRJTkcgV0lUSCAwIEFEREVEIEZJTEVTIgogICAgZXhpdCAwCiAgZmkK
CiAgaWYgWyAiJE5FV19GSUxFX0xJTkVfQ09VTlQiIC1ndCAxMDAwMCBdOyB0aGVuCiAgICAjIElm
IHRoZXJlIGFyZSB0b28gbWFueSBmaWxlcywgdGhlbiBnZW5lcmF0aW5nIGFsbCB0aGUgc3ViLXBh
dGhzIGFuZAogICAgIyBydW5uaW5nIGxzLXRyZWUgd2l0aCBhIGh1Z2UgcGF0aHNwZWMgd2lsbCBi
ZSBzbG93ZXIgdGhhbiBzaW1wbHkKICAgICMgY2hlY2tpbmcgdGhlIHdob2xlIHRyZWUuCiAgICBk
ZWJ1Z19sb2cgIkZJTEUgQ09VTlQgJE5FV19GSUxFX0xJTkVfQ09VTlQgT1ZFUiBMSU1JVDsgRE9J
TkcgRlVMTCBTRUFSQ0giCiAgICBGVUxMX1NFQVJDSD10cnVlCiAgZmkKZmkKCmlmIFsgIiRGVUxM
X1NFQVJDSCIgPSAidHJ1ZSIgXTsgdGhlbgogIGRlYnVnX2xvZyAiRE9JTkcgRlVMTCBEVVBFIFNF
QVJDSCIKICBEVVBFX1BBVEhTPSQoZ2l0IGxzLXRyZWUgLS1uYW1lLW9ubHkgLXIgIiRUT19IQVNI
IiB8IHNvcnQgfCB1bmlxIC1pIC1EKQplbHNlCiAgZGVidWdfbG9nICJET0lORyBESUZGIFNFQVJD
SCBPRiAkTkVXX0ZJTEVfTElORV9DT1VOVCBBRERFRCBGSUxFUyBCRVRXRUVOICRGUk9NX0hBU0gg
QU5EICRUT19IQVNIIgogIERVUEVfUEFUSFM9JChvdXRwdXRfYWxsX2FuY2VzdG9yX2dpdHBhdGhz
ICIkTkVXX0ZJTEVTIiB8IHNvcnQgfCB4YXJncyAtZCJcbiIgLS1uby1ydW4taWYtZW1wdHkgZ2l0
IGxzLXRyZWUgLS1uYW1lLW9ubHkgLXQgIiRUT19IQVNIIiB8IHNvcnQgfCB1bmlxIHwgdW5pcSAt
aSAtRCkKZmkKCmlmIFsgLXogIiREVVBFX1BBVEhTIiBdOyB0aGVuCiAgZGVidWdfbG9nICJFWElU
SU5HIC0gTk8gRFVQRVMgRk9VTkQiCiAgZXhpdCAwCmVsc2UKICBkZWJ1Z19sb2cgIkVYSVRJTkcg
V0lUSCBEVVBFUyBFUlJPUiIKICBlY2hvICJUaGlzIHJlZiBjYW5ub3QgYmUgYWNjZXB0ZWQgLSBk
dXBsaWNhdGUgZm9sZGVycyBvciBmaWxlcyBmb3VuZDoiCiAgZWNobyAiJERVUEVfUEFUSFMiCiAg
ZXhpdCAxCmZpCg==
--0000000000009d8c6c05eb3ce25b--
