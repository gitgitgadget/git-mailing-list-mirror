From: Brandon Casey <drafnel@gmail.com>
Subject: Re: [PATCH v3 5/5] attr.c: respect core.ignorecase when matching
 attribute patterns
Date: Mon, 10 Oct 2011 13:01:03 -0500
Message-ID: <CA+sFfMd9exQcGfTGLJFPXG3-bq-ukn7K4m1R=LvLKqc1-jDVQw@mail.gmail.com>
References: <VYN8m1JCy102-eaWWa-bsunEvt3zeXLJkVg7FZKZCtXT-Ww0vg7a8xA7NTvrZTiovKTnJ9Hlom0@cipher.nrlssc.navy.mil>
	<U4wiHVyDLLG1PhI-8iY3YhHT7CEcTMEfg9MCDSaeuwAkg0N1a5wRE5NXaKAVQx8kpEYt75REVpRavoc-HiKe6rLk2AUepzHWptkevo08MRbGyWxqBHT_rySLemcbi66NKLRXwFGtaRQ@cipher.nrlssc.navy.mil>
	<4E91BAC8.9060606@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Brandon Casey <casey@nrlssc.navy.mil>, gitster@pobox.com,
	git@vger.kernel.org, peff@peff.net, j.sixt@viscovery.net
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Oct 10 20:01:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDKA3-0004Go-C0
	for gcvg-git-2@lo.gmane.org; Mon, 10 Oct 2011 20:01:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753613Ab1JJSBG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Oct 2011 14:01:06 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:39376 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751761Ab1JJSBE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Oct 2011 14:01:04 -0400
Received: by yxl31 with SMTP id 31so5614324yxl.19
        for <git@vger.kernel.org>; Mon, 10 Oct 2011 11:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=0E23WRrq1w+W3Rht9dAwoQ0kMiLl0KD94+vwp5jMYto=;
        b=huhtxQqzDvgXd4/WP9hrxNzAJjKwv6jPiwazUeOqplCb3gzWrazbisYis4KuqcYqpm
         tFkb1LeOf8h8ctEw4R5dwJEYTqwFgURE15SujYcBTAA6pMFFLrVjpcOiX8edbU7CWSo1
         7IiMzZhtmDFH5xyaOMzRsuCc96roAg1w2pwrM=
Received: by 10.223.77.71 with SMTP id f7mr11906692fak.33.1318269663143; Mon,
 10 Oct 2011 11:01:03 -0700 (PDT)
Received: by 10.152.42.33 with HTTP; Mon, 10 Oct 2011 11:01:03 -0700 (PDT)
In-Reply-To: <4E91BAC8.9060606@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183249>

On Sun, Oct 9, 2011 at 10:16 AM, Michael Haggerty <mhagger@alum.mit.edu=
> wrote:
> On 10/06/2011 08:22 PM, Brandon Casey wrote:
>> The last set of tests is performed only on a case-insensitive filesy=
stem.
>> Those tests make sure that git handles the case where the .gitignore=
 file
>> resides in a subdirectory and the user supplies a path that does not=
 match
>> the case in the filesystem. =C2=A0In that case^H^H^H^Hsituation, par=
t of the
>> path supplied by the user is effectively interpreted case-insensitiv=
ely,
>> and part of it is dependent on the setting of core.ignorecase. =C2=A0=
git should
>> only match the portion of the path below the directory holding the
>> .gitignore file according to the setting of core.ignorecase.
>
> Isn't this a rather perverse scenario?

No argument here. :)

> It is hard to imagine that
> anybody *wants* part of a single filename to be matched
> case-insensitively and another part to be matched case-sensitively.
> ISTM that a person who is using a case-insensitive filesystem and has
> core-ignorecase=3Dfalse is (1) a glutton for punishment and (2) proba=
bly
> very careful to make sure that the case of all pathnames is correct. =
=C2=A0So
> such a person is not likely to benefit from this schizophrenic behavi=
or.
>
>> [...] =C2=A0If git instead built the attr
>> stack by scanning the repository, then the paths in the origin field=
 would
>> not necessarily match the paths supplied by the user. =C2=A0If someo=
ne makes a
>> change like that in the future, these tests will notice.
>
> Your decision to treat path names as partly case-insensitive...

You are giving more credit to this patch than it deserves.  It really
doesn't do much.  It's not a design decision that I made to treat path
names as case-insensitive.  That is a consequence of using a
case-insensitive file system.  When you give git the path A/b/c and
there exists a/.gitattributes, then on a case insensitive file system
git will try to read A/.gitattributes and the filesystem will return a
handle for a/.gitattributes and git won't be able to tell the
difference.  git will then apply the rules in the file to the paths
below a/ even when the path is supplied like A/.  So, at the moment,
regardless of the setting of core.ignorecase, the path above a
=2Egitignore file is treated as case-insensitive on a case-insensitive
filesystem.

The purpose of the tests are primarily to ensure that nothing special
needs to be done concerning paths leading up to a directory containing
a .gitignore file in the core.ignorecase=3D1 case.  For example, it is
_not_ necessary to use strncmp_icase instead of strncmp on the leading
portion of the path.

What I meant when I said "If someone makes a change like that in the
future, these tests will notice", is that they will notice that they
must now use strncmp_icase when comparing the portion of the path
above the .gitattributes file.

> will make
> this kind of improvement considerably more complicated.
> Therefore, weighing the negligible benefit of declaring this
> schizophrenic behavior against the potential big pain of remaining
> backwards-compatible with this behavior, I suggest that we either (1)
> declare that when core.ignorecase=3Dfalse then the *whole* filenames
> (including the path leading up to the .gitignore file) must match
> case-sensitively, or (2) declare the behavior in this situation to be
> undefined so that nobody thinks they should depend on it.

I do not plan to make git treat leading paths case-sensitively on a
case-insensitive file system when core.ignorecase=3D0 any more than I
plan to make git treat leading paths case-insensitively on a
case-sensitive file system when core.ignorecase=3D1.  For justification=
,
I refer back to your original comment about perversion. :)

So, #2 gets my vote.


Maybe my commit message is not clear that it is describing the current
behavior and not defining it.  Instead of

   git should only match the portion of the path below the directory
   holding the .gitignore file according to the setting of
   core.ignorecase.

maybe I should say

    git will currently only match the portion of the path...

I could also remove the following test from the CASE_INSENSITIVE_FS
tests since it is really a dontcare:

   attr_check A/b/h a/b/h "-c core.ignorecase=3D0"

We don't care what happens when the user supplies A/b/h and a/b/h
exists on disk when core.ignorecase=3D0, we only care that A/b/h is
interpreted correctly when core.ignorecase=3D1.

-Brandon
