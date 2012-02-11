From: Tom Grennan <tmgrennan@gmail.com>
Subject: =?UTF-8?q?Re=3A=20=5BRFC/PATCH=5D=20tag=3A=20make=20list=20exclude=20!=3Cpattern=3E?=
Date: Fri, 10 Feb 2012 18:16:54 -0800
Message-ID: <1328926618-17167-1-git-send-email-tmgrennan@gmail.com>
References: <20120210185516.GA4903@tgrennan-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com, krh@redhat.com,
	jasampler@gmail.com
To: pclouds@gmail.com
X-From: git-owner@vger.kernel.org Sat Feb 11 03:17:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rw2X1-0002eq-Kz
	for gcvg-git-2@plane.gmane.org; Sat, 11 Feb 2012 03:17:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754821Ab2BKCRO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Feb 2012 21:17:14 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:35436 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753546Ab2BKCRN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Feb 2012 21:17:13 -0500
Received: by qcqw6 with SMTP id w6so2034153qcq.19
        for <git@vger.kernel.org>; Fri, 10 Feb 2012 18:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=jcOQ+Iz42BFe0bNlYj4eT81bDQO/LA3v93W0gaKhqZA=;
        b=a5EyqyL3ghFD/AD0Ne3+awporAxnQJ+/n1SL2it/2+2t2tiHz1m96SF8Ik2hVua+pR
         XqDh2jKSu9XJZspwsKNtA7ceZO9QQf2xPyYsFZvZxLAqs92CymPU3JKju8UG2+9vZy2A
         GWYpcrD4MzwM7AQSWj0pYrv+JwASryu4s7hsA=
Received: by 10.224.180.67 with SMTP id bt3mr1594676qab.6.1328926632766;
        Fri, 10 Feb 2012 18:17:12 -0800 (PST)
Received: from tgrennan-laptop.lab.redback.com ([129.192.185.163])
        by mx.google.com with ESMTPS id fd1sm16844239qab.1.2012.02.10.18.17.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 10 Feb 2012 18:17:11 -0800 (PST)
X-Mailer: git-send-email 1.7.8
In-Reply-To: <20120210185516.GA4903@tgrennan-laptop>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190475>

On Fri, 10 Feb 2012 10:55:16 -0800, Tom Grennan wrote:
>On Fri, Feb 10, 2012 at 01:34:26PM +0700, Nguyen Thai Ngoc Duy wrote:
>>On Fri, Feb 10, 2012 at 2:43 AM, Tom Grennan <tmgrennan@gmail.com> wr=
ote:
>>> Please see the following patch which filters the tag list of "!" pr=
efaced
>>> patterns. =C2=A0If this is deemed desirable and correct, I'll resub=
mit with updated
>>> documentation and unit tests.
>>
>>git-branch, git-tag and git-for-each-ref are in the same family. I
>>think it's good to that all three commands share things, like this
>>pattern matching.
>
>Yes, git-branch and git-tag could now use a common match_patterns() bu=
t
>git-for-each-ref needs some rearranging; as will: git-describe,
>git-replace, git-ls-remote, git-name-rev, and git-show-branch.
>
>If we pursue this, it may be best to first add match_patterns() to ./r=
efs.[ch]
>then incrementally modify these builtin commands to use it.

The following series implements !<pattern> with: git-tag, git-branch, a=
nd
git-for-each-ref.

This still requires Documentation and unit test updates but I think the=
se are
close to functionally complete.

>>About the '!' for exclusion, maybe it's better to move from fnmatch()
>>as matching machinery to pathspec. Then when git learns negative
>>pathspec [1], we have this feature for free.
>>
>>[1] http://thread.gmane.org/gmane.comp.version-control.git/189645/foc=
us=3D190072

After looking at this some more, I don't understand the value of replac=
ing
libc:fnmatch().  Or are you just referring to '--exclude' instead of
[!]<pattern> argument parsing?

---

Tom Grennan (4):
  refs: add common refname_match_patterns()
  tag: use refs.c:refname_match_patterns()
  branch: use refs.c:refname_match_patterns()
  for-each-ref: use refs.c:refname_match_patterns()

 Documentation/git-tag.txt |   10 ++++++----
 builtin/branch.c          |   16 ++--------------
 builtin/for-each-ref.c    |   23 +++--------------------
 builtin/tag.c             |   15 ++-------------
 refs.c                    |   14 ++++++++++++++
 refs.h                    |    8 ++++++++
 6 files changed, 35 insertions(+), 51 deletions(-)

--=20
1.7.8
