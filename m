From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v5 25/27] refs: add LMDB refs storage backend
Date: Fri, 19 Feb 2016 09:54:32 +0700
Message-ID: <CACsJy8AEOzSi-yJo3eJLSv5s6RW1sZBw+G2Y7cypGb2b+p0QLg@mail.gmail.com>
References: <1455772670-21142-1-git-send-email-dturner@twopensource.com>
 <1455772670-21142-26-git-send-email-dturner@twopensource.com>
 <20160218085023.GA30049@lanh> <1455827001.7528.87.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Feb 19 03:55:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWbDr-0008Cp-4X
	for gcvg-git-2@plane.gmane.org; Fri, 19 Feb 2016 03:55:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992752AbcBSCzF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2016 21:55:05 -0500
Received: from mail-lf0-f54.google.com ([209.85.215.54]:34623 "EHLO
	mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992749AbcBSCzD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2016 21:55:03 -0500
Received: by mail-lf0-f54.google.com with SMTP id j78so45300562lfb.1
        for <git@vger.kernel.org>; Thu, 18 Feb 2016 18:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=jgncnJZxMexkObXUvFLhaJ+Bn/Ub3UJVW9bTTlQTgCc=;
        b=zfk/+1uvGyDDRQ+l0J6wWw3jdlQFiHqvOkci8Lco8c1diAKgBHq2SSYZyJYDfQiRMC
         wwsnHoC8463uoggo4M/DYgSmIcOxD0iKvt0v2BmruwTTFSmSy4kSolkWRyRF9+8mo451
         Z8la8JQMUAQ67T9WByAAJXxObNQTPbuyVLejNS2ozc9wRIhm2kxj7fyhGVljx8GGTH/c
         g8RmthzUVc+Jdy8mPSlWq2iUYRSnomGtpQmaxWXUUIIVLeFIIz9eZayJ395SyuwnI+4i
         P5i0d/myiWASGsf1rJ/TPyOjg4bAbeYOchcoyuU0d84xBmWxdFWOPL9c+uB8AkcdVJe5
         ckcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=jgncnJZxMexkObXUvFLhaJ+Bn/Ub3UJVW9bTTlQTgCc=;
        b=jpYInrOQoBokQ/HgKtlY6zXvmLniwcC1U1eCUaPmmYcgJizyNuaIpamVo6md6NsKhF
         aheP58qzs+ded+XD+34rtNi2+/OXTXPVJOG6RwAVvmf6a3FXGUVCHB0vMetBJllx16sO
         krWpRr7/QbYnsIwOKOLvGDQzziP936dJBotmpf4xkrHTillM123M9pb1am7WdtuLPFO/
         yb0jRpyUqmxF/mFOYnqj8bj3w6K3lwQI8n8aQ6XD98NiKJDVjfLMrobTGjQGMrZ+1U+3
         j4tToIfY3NCK8fDNsaXrshbpkr3+kcH/uhwOlq0DF7bX+M0peAjWl5QkzOETbV+Yf7+h
         8B0Q==
X-Gm-Message-State: AG10YOS2Z/pwYwZirD761B0iNtWalL+JDq7X0+Y914IW2RPPZQTGlm404n3Gdj7jOaZlTvsAfRK5T4EOngX4CQ==
X-Received: by 10.25.212.197 with SMTP id l188mr4478063lfg.118.1455850501800;
 Thu, 18 Feb 2016 18:55:01 -0800 (PST)
Received: by 10.112.97.72 with HTTP; Thu, 18 Feb 2016 18:54:32 -0800 (PST)
In-Reply-To: <1455827001.7528.87.camel@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286653>

On Fri, Feb 19, 2016 at 3:23 AM, David Turner <dturner@twopensource.com> wrote:
>> > +static int read_per_worktree_ref(const char *submodule, const char
>> > *refname,
>> > +                            struct MDB_val *val, int
>> > *needs_free)
>>
>> From what I read, I suspect these _per_worktree functions will be
>> identical for the next backend. Should we just hand over the job for
>> files backend? For all entry points that may deal with per-worktree
>> refs, e.g. lmdb_resolve_ref_unsafe, can we check ref_type() first
>> thing, if it's per-worktree we call
>> refs_be_files.resolve_ref_unsafe()
>> instead?  It could even be done at frontend level,
>> e.g. refs.c:resolve_ref_unsafe().
>>
>> Though I may be talking rubbish here because I don't know how whether
>> it has anything to do with transactions.
>
> The reason I did it this way is that some ref chains cross backend
> boundaries (e.g. HEAD -> refs/heads/master).  But if we have other
> backends later, we could generalize.

Crossing backends should go through frontend again, imo. But I don't
really know if it's efficient.

>> > +static int lmdb_create_symref(const char *ref_target,
>> > +                         const char *refs_heads_master,
>> > +                         const char *logmsg)
>> > +{
>> > +
>> ...
>> > +   mdb_put_or_die(&transaction, &key, &val, 0);
>> > +
>> > +   /* TODO: Don't create ref d/f conflicts */
>>
>> I'm not sure I get this comment. D/F conflicts are no longer a thing
>> for lmdb backend, right?
>
> I'm trying to avoid the lmdb backend creating a set of refs that the
> files backend can't handle.  This would make collaboration with other
> versions of git more difficult.

It already is. If you create refs "foo" and "FOO" on case sensitive
file system and clone it on a case-insensitive one, you face the same
problem. We may have an optional configuration knob to prevent
incompatibilities with files backend, but I think that should be done
(and enforced if necessary) outside backends.
-- 
Duy
