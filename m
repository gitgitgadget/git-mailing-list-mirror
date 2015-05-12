From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v5 3/3] cat-file: add --follow-symlinks to --batch
Date: Tue, 12 May 2015 18:36:44 -0400
Organization: Twitter
Message-ID: <1431470204.16652.52.camel@ubuntu>
References: <1431384645-17276-1-git-send-email-dturner@twopensource.com>
	 <1431384645-17276-4-git-send-email-dturner@twopensource.com>
	 <xmqqoalpzn3s.fsf@gitster.dls.corp.google.com>
	 <1431455779.16652.20.camel@ubuntu>
	 <xmqqk2wdzlfm.fsf@gitster.dls.corp.google.com>
	 <1431456922.16652.26.camel@ubuntu>
	 <xmqqlhgtftw0.fsf@gitster.dls.corp.google.com>
	 <xmqqd225fsw8.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, David Turner <dturner@twitter.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 13 00:36:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsInI-0003iZ-Lv
	for gcvg-git-2@plane.gmane.org; Wed, 13 May 2015 00:36:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934130AbbELWgt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2015 18:36:49 -0400
Received: from mail-qg0-f51.google.com ([209.85.192.51]:34228 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932856AbbELWgr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2015 18:36:47 -0400
Received: by qgfi89 with SMTP id i89so12569327qgf.1
        for <git@vger.kernel.org>; Tue, 12 May 2015 15:36:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=8lyh8V7Q5rv4/OW5BKe6gkwanFuPeDJk5HUijWJVUD0=;
        b=VNfEqnMKVHgz4DSdgj40C4Tr7PB0TBpxSCTnDmExEIgeLCk7N+yvBNbYQv/UVtKTSn
         xQ4if7eouqAoG2oqOpxwMdkz/6hFvPldT8IEzFOdKpbEhOs8C9CSQXltKi/lwxIIDLPl
         TrV1l8P3Gjr41Mysxt4DVJBAQAzmgy+W01CcbMN+5djb4udZHOmFO5pMNqtleYHONL5t
         2i/huuBBDJ2NdM4B54bhEAwPTiUcxLmaUloQvenVONBigCE+g9lWVzbsIwEYtr5iJmrl
         x2QiVoR2WuM4DQWBSZycI5OULINZAlOtKva2BIMf2AlFDVg8d8NVi4bPzZ8ALmdBd7TK
         kSeQ==
X-Gm-Message-State: ALoCoQmuRze4Mwi2qOCB8ebsegiTvC6uYFvk3zR+p/zuNDbsoxR3SpSQEu4RjYA27ymPznA3xDRI
X-Received: by 10.140.81.135 with SMTP id f7mr22828433qgd.33.1431470206763;
        Tue, 12 May 2015 15:36:46 -0700 (PDT)
Received: from [172.22.38.222] ([192.133.79.147])
        by mx.google.com with ESMTPSA id o65sm14382477qge.34.2015.05.12.15.36.45
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128/128);
        Tue, 12 May 2015 15:36:45 -0700 (PDT)
In-Reply-To: <xmqqd225fsw8.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268901>

On Tue, 2015-05-12 at 13:22 -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Ahh, that would also give us "missing", so in that sense you are
> > being consistent.
> >
> > But I do not think that consistency is useful.  Showing just
> > "missing" instead is losing information and that is what bothers me.
> >
> > Showing "symlink 6 nosuch" to this "link points at a target that
> > would be in-tree but there is no such object in the tree" symbolic
> > link instead of "missing" would make it more useful, and I do not
> > offhand think of a downside, but maybe I am missing something.
> >
> > For a link that points outside, the code already gives
> >
> >     $ ln -s ../outside outlink
> >     $ git add outlink
> >     $ echo "$(git write-tree):outlink" |
> >       git cat-file --batch --follow-symlinks
> >
> > "symlink ../outside", so the script reading from the batch output
> > already has to be prepared to handle "symlink" and understand it as
> > saying "the link does not point an object that is inside the tree".
> 
> Having said all that, I think we can make readers' life easier by
> classifying various reasons why --follow-symlinks cannot pretend
> as if the in-tree pointee were given as its input and signal it
> differently:
> 
>  * A link points outside the original tree (or the index, once we
>    support "cat-file :RelNotes").
> 
>    I think your "symlink <size> LF <target> LF" already does this.
> 
>  * A link points (directly or indirectly) at itself.
> 
>    This would be your "loop <size> LF <target> LF", which I think is
>    good.
> 
>  * A link does not step outside the original tree, but the pointee
>    does not exist in the original tree.
> 
>    I think you currently say "<object name for HEAD:link> missing",
>    but I do not think it is useful.  That object does exist, but it
>    merely cannot be dereferenced.  Perhaps introducing a new one,
>    e.g. "dangling <size> LF <target> LF" similar to symlink/loop,
>    would help the reader better?
> 
> Are there other cases?  The only other case I think of is when the
> link resolves cleanly inside the tree, which you already handle.
> 
> Thanks.
On Tue, 2015-05-12 at 13:22 -0700, Junio C Hamano wrote:
Junio C Hamano <gitster@pobox.com> writes:
> 
> > Ahh, that would also give us "missing", so in that sense you are
> > being consistent.
> >
> > But I do not think that consistency is useful.  Showing just
> > "missing" instead is losing information and that is what bothers me.
> >
> > Showing "symlink 6 nosuch" to this "link points at a target that
> > would be in-tree but there is no such object in the tree" symbolic
> > link instead of "missing" would make it more useful, and I do not
> > offhand think of a downside, but maybe I am missing something.
> >
> > For a link that points outside, the code already gives
> >
> >     $ ln -s ../outside outlink
> >     $ git add outlink
> >     $ echo "$(git write-tree):outlink" |
> >       git cat-file --batch --follow-symlinks
> >
> > "symlink ../outside", so the script reading from the batch output
> > already has to be prepared to handle "symlink" and understand it as
> > saying "the link does not point an object that is inside the tree".
> 
> Having said all that, I think we can make readers' life easier by
> classifying various reasons why --follow-symlinks cannot pretend
> as if the in-tree pointee were given as its input and signal it
> differently:
> 
>  * A link points outside the original tree (or the index, once we
>    support "cat-file :RelNotes").
> 
>    I think your "symlink <size> LF <target> LF" already does this.
> 
>  * A link points (directly or indirectly) at itself.
> 
>    This would be your "loop <size> LF <target> LF", which I think is
>    good.
> 
>  * A link does not step outside the original tree, but the pointee
>    does not exist in the original tree.
> 
>    I think you currently say "<object name for HEAD:link> missing",
>    but I do not think it is useful.  That object does exist, but it
>    merely cannot be dereferenced.  Perhaps introducing a new one,
>    e.g. "dangling <size> LF <target> LF" similar to symlink/loop,
>    would help the reader better?
> 
> Are there other cases?  The only other case I think of is when the
> link resolves cleanly inside the tree, which you already handle.

While updating the tests, I noticed another two cases:
1. HEAD:broken-link/file

I am inclined to describe this as "dangling" as well.  (It is not useful
to tell users that "file" is the remaining bit to be resolved, because
due to chains of symlinks, users have no idea what file would be
relative to).  I think the filesystem returns ENOENT in the equivalent
case.

2. HEAD:link-to-file/file

This should be "notdir", I think, in that it is a distinct way of
failing that the user might care to know. The filesystem returns ENOTDIR
in the equivalent case.

In addition, I would like to have the format for the dangling, loop, and
notdir cases match the missing case.  In other words, "HEAD:link
missing", "HEAD:link dangling", etc.  Users already need to parse the
missing case, so we might as well make the others match.  It's true that
this parsing is impossible in the case of filenames containing newlines,
but git cat-file --batch cannot accept those filenames as input anyway
(presumably, a -0 flag would be needed, if anyone actually used such
filenames, and at that point we could make the -0 output unambiguously
parseable).
