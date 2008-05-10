From: "Brandon Casey" <drafnel@gmail.com>
Subject: Re: git gc & deleted branches
Date: Fri, 9 May 2008 22:32:44 -0500
Message-ID: <ee63ef30805092032h18fe7ff7mda4233b08ae431ea@mail.gmail.com>
References: <48235D99.2040407@nrlssc.navy.mil>
	 <20080508213107.GA1016@sigill.intra.peff.net>
	 <48237344.6070405@nrlssc.navy.mil>
	 <20080508214454.GA1939@sigill.intra.peff.net>
	 <48237650.5060008@nrlssc.navy.mil>
	 <20080508224827.GA2938@sigill.intra.peff.net>
	 <loom.20080509T011318-478@post.gmane.org>
	 <7vabj0b1re.fsf@gitster.siamese.dyndns.org>
	 <ee63ef30805082105w7f04a2d1y65a4618aeb787cac@mail.gmail.com>
	 <7v1w4bb291.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 10 05:33:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jufq5-00035O-1K
	for gcvg-git-2@gmane.org; Sat, 10 May 2008 05:33:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751747AbYEJDcs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2008 23:32:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751563AbYEJDcs
	(ORCPT <rfc822;git-outgoing>); Fri, 9 May 2008 23:32:48 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:11712 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751457AbYEJDcq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2008 23:32:46 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1033118fgg.17
        for <git@vger.kernel.org>; Fri, 09 May 2008 20:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=TjUbe8q17UtW8SwWugW54n5sWhC5ram1NnpJdFRQfFM=;
        b=JUDItaprQcilmvEug/mXs7+b7x1n6RAfjO3pPjbhlMtvJRe5Nqy07d3/QnQc/zeQbLftWXP92EbK5yKfT4EF08FbXLvD47JDnD9u42zfQ2RIeBgCCzbmPcNVuzuWlwNG4iUvNi66cdbKu6hFs6sV1qGL+jVnFRac3CFOGiFIpFE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mHN9OMiClTmkwR+tZ7BZK8vxrhkNGUjLAQqJ3jfBHYSDJ3tszcL09B6C1gFcd9XiNvZO9lQShfSvjMnI2PR0JJE/QN+wmiMfNzBLL1kqPWv+sjiw5mfEjP2L0MhyCeuCdT0ItU9Z54yupV7tXDTTs5ZoDMLbkSF0MdKbvnkK2Eg=
Received: by 10.86.51.2 with SMTP id y2mr9654212fgy.52.1210390364712;
        Fri, 09 May 2008 20:32:44 -0700 (PDT)
Received: by 10.86.89.8 with HTTP; Fri, 9 May 2008 20:32:44 -0700 (PDT)
In-Reply-To: <7v1w4bb291.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81644>

I didn't read your email until now. It may sound strange, but I can't
read my personal email from work.

Also, looks like I inadvertantly took this message off-list.

On Fri, May 9, 2008 at 4:23 PM, Junio C Hamano <gitster@pobox.com> wrote:
> "Brandon Casey" <drafnel@gmail.com> writes:
>
>> Is this invocation of pack-objects that you commented on necessary
>> though? This is the section that is replacing an existing pack file
>> with a newly created pack file of the same name...
>
> Yuck, I failed to see it in the context.  You are right.  This won't do
> anything I suspect.

Now I'm confused. I hope you realized I said "pack-objects" when I
meant "unpack-objects".

It was only the first invocation of unpack-objects that I thought may
be unnecessary. This is because pack-objects (yes, pack) created a new
pack with
the same name as an existing pack which means (if I'm thinking about things
correctly) that none of the objects inside the pack are unreachable. So trying
to unpack-objects is a waste of time.

There is a second invocation of unpack-objects which is run on packs which
will be deleted. This one should unpack any unreferenced objects from each pack.

-brandon


The remainder of your email is below since the list has never seen it.


> Perhaps we would want a new option --eject that causes pack-object write
> out unreachable packed objects in the loose format?  This would require a
> minor surgery to write_sha1_file() so that it won't pay attention to the
> return value of has_sha1_file(sha1), perhaps like this.
>
> This is a lunch-time hack and needs more serious work, such as fixing
> horrible "write_sha1_file_1" to something more sensible.
>
> Also it should add --eject as an independent and incompatible option
> instead of dropping --keep-unpacked support.
>
> ---
>
>  builtin-pack-objects.c |   56 ++++++++++++-----------------------------------
>  sha1_file.c            |    9 ++++++-
>  2 files changed, 22 insertions(+), 43 deletions(-)
>
> diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
> index 777f272..8240a4b 100644
> --- a/builtin-pack-objects.c
> +++ b/builtin-pack-objects.c
> @@ -1836,38 +1836,25 @@ struct in_pack {
>        struct in_pack_object *array;
>  };
>
> -static void mark_in_pack_object(struct object *object, struct packed_git *p, struct in_pack *in_pack)
> +static void eject_object(struct object *obj)
>  {
> -       in_pack->array[in_pack->nr].offset = find_pack_entry_one(object->sha1, p);
> -       in_pack->array[in_pack->nr].object = object;
> -       in_pack->nr++;
> -}
> -
> -/*
> - * Compare the objects in the offset order, in order to emulate the
> - * "git-rev-list --objects" output that produced the pack originally.
> - */
> -static int ofscmp(const void *a_, const void *b_)
> -{
> -       struct in_pack_object *a = (struct in_pack_object *)a_;
> -       struct in_pack_object *b = (struct in_pack_object *)b_;
> +       enum object_type type;
> +       unsigned long size;
> +       void *data;
> +       unsigned char sha1[20];
>
> -       if (a->offset < b->offset)
> -               return -1;
> -       else if (a->offset > b->offset)
> -               return 1;
> -       else
> -               return hashcmp(a->object->sha1, b->object->sha1);
> +       data = read_sha1_file(obj->sha1, &type, &size);
> +       assert(data && type == obj->type);
> +       if (write_sha1_file_1(data, size, typename(type), sha1, 1))
> +               die("cannot eject packed object %s", sha1_to_hex(obj->sha1));
> +       assert(!memcmp(sha1, obj->sha1));
>  }
>
> -static void add_objects_in_unpacked_packs(struct rev_info *revs)
> +static void eject_objects_in_unpacked_packs(struct rev_info *revs)
>  {
>        struct packed_git *p;
> -       struct in_pack in_pack;
>        uint32_t i;
>
> -       memset(&in_pack, 0, sizeof(in_pack));
> -
>        for (p = packed_git; p; p = p->next) {
>                const unsigned char *sha1;
>                struct object *o;
> @@ -1881,28 +1868,15 @@ static void add_objects_in_unpacked_packs(struct rev_info *revs)
>                if (open_pack_index(p))
>                        die("cannot open pack index");
>
> -               ALLOC_GROW(in_pack.array,
> -                          in_pack.nr + p->num_objects,
> -                          in_pack.alloc);
> -
>                for (i = 0; i < p->num_objects; i++) {
>                        sha1 = nth_packed_object_sha1(p, i);
>                        o = lookup_unknown_object(sha1);
> -                       if (!(o->flags & OBJECT_ADDED))
> -                               mark_in_pack_object(o, p, &in_pack);
> +                       if (o->flags & OBJECT_ADDED)
> +                               continue;
>                        o->flags |= OBJECT_ADDED;
> +                       eject_object(o);
>                }
>        }
> -
> -       if (in_pack.nr) {
> -               qsort(in_pack.array, in_pack.nr, sizeof(in_pack.array[0]),
> -                     ofscmp);
> -               for (i = 0; i < in_pack.nr; i++) {
> -                       struct object *o = in_pack.array[i].object;
> -                       add_object_entry(o->sha1, o->type, "", 0);
> -               }
> -       }
> -       free(in_pack.array);
>  }
>
>  static void get_object_list(int ac, const char **av)
> @@ -1938,7 +1912,7 @@ static void get_object_list(int ac, const char **av)
>        traverse_commit_list(&revs, show_commit, show_object);
>
>        if (keep_unreachable)
> -               add_objects_in_unpacked_packs(&revs);
> +               eject_objects_in_unpacked_packs(&revs);
>  }
>
>  static int adjust_perm(const char *path, mode_t mode)
> diff --git a/sha1_file.c b/sha1_file.c
> index 3516777..ce3a661 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -2102,7 +2102,7 @@ int hash_sha1_file(const void *buf, unsigned long len, const char *type,
>        return 0;
>  }
>
> -int write_sha1_file(void *buf, unsigned long len, const char *type, unsigned char *returnsha1)
> +int write_sha1_file_1(void *buf, unsigned long len, const char *type, unsigned char *returnsha1, int refresh)
>  {
>        int size, ret;
>        unsigned char *compressed;
> @@ -2120,7 +2120,7 @@ int write_sha1_file(void *buf, unsigned long len, const char *type, unsigned cha
>        filename = sha1_file_name(sha1);
>        if (returnsha1)
>                hashcpy(returnsha1, sha1);
> -       if (has_sha1_file(sha1))
> +       if (!refresh && has_sha1_file(sha1))
>                return 0;
>        fd = open(filename, O_RDONLY);
>        if (fd >= 0) {
> @@ -2185,6 +2185,11 @@ int write_sha1_file(void *buf, unsigned long len, const char *type, unsigned cha
>        return move_temp_to_file(tmpfile, filename);
>  }
>
> +int write_sha1_file(void *buf, unsigned long len, const char *type, unsigned char *returnsha1)
> +{
> +       return write_sha1_file_1(buf, len, type, returnsha1, 0);
> +}
> +
>  /*
>  * We need to unpack and recompress the object for writing
>  * it out to a different file.
>
