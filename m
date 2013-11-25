From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH v3 18/24] read-cache: write index-v5
Date: Mon, 25 Nov 2013 16:37:13 +0100
Message-ID: <87li0co5li.fsf@gmail.com>
References: <1376854933-31241-1-git-send-email-t.gummerer@gmail.com> <1376854933-31241-19-git-send-email-t.gummerer@gmail.com> <CACsJy8BocjJqgyJwa8DzwiNdmpu-yJH9vVuEPunxjtRyr-rxYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>,
	Thomas Rast <trast@inf.ethz.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 25 16:37:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VkyDy-0002v6-2e
	for gcvg-git-2@plane.gmane.org; Mon, 25 Nov 2013 16:37:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755487Ab3KYPhR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Nov 2013 10:37:17 -0500
Received: from mail-la0-f46.google.com ([209.85.215.46]:57560 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754421Ab3KYPhP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Nov 2013 10:37:15 -0500
Received: by mail-la0-f46.google.com with SMTP id eh20so3124592lab.33
        for <git@vger.kernel.org>; Mon, 25 Nov 2013 07:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:in-reply-to:references:references:user-agent
         :user-agent:date:message-id:mime-version:content-type;
        bh=cjyJwFUbsQNT235asH8bOO2WswXnZ9dUKAufwErLPWw=;
        b=HJm5gPlwSPl9DR/+oky7qG0kPNolgwgKPsOkJ4twzcCkHVBLPUvqNdr0YujwY+Ulvz
         nPvxzLN10LVhm4rRp/EC0CXs1+6tZ5VmI3IJssy6BEQ8XDXdwsI7HTsIWRY6+G5xqRyp
         1c+ua1N6AS44VISTGnzW4qSEQlV91mBUGcFvF7093BC4eRom7YP23NgdPmNABS1vclvn
         dtKoyLJGQWXxH4e4Bh83pOlujsSo4wa66neq5Kzc1cgz74EGGIMIrfS3w4F8Gh93sOU4
         a07VYEMKTOjxEqviQbMXnAe6eRs+66V9S6s+ksAhhgue1mvgfR+nkJsrbkUNSpjeBBte
         SbbA==
X-Received: by 10.152.242.8 with SMTP id wm8mr59329lac.76.1385393833256;
        Mon, 25 Nov 2013 07:37:13 -0800 (PST)
Received: from localhost (213-66-41-37-no99.tbcn.telia.com. [213.66.41.37])
        by mx.google.com with ESMTPSA id c15sm674462lbq.11.2013.11.25.07.37.11
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Nov 2013 07:37:12 -0800 (PST)
In-Reply-To: <CACsJy8BocjJqgyJwa8DzwiNdmpu-yJH9vVuEPunxjtRyr-rxYA@mail.gmail.com>
References: <1376854933-31241-1-git-send-email-t.gummerer@gmail.com> <1376854933-31241-19-git-send-email-t.gummerer@gmail.com> <CACsJy8BocjJqgyJwa8DzwiNdmpu-yJH9vVuEPunxjtRyr-rxYA@mail.gmail.com>
User-Agent: Notmuch/0.15.2+119~gf0dfda5 (http://notmuchmail.org) Emacs/24.3.1 (x86_64-unknown-linux-gnu)
User-Agent: Notmuch/0.15.2+119~gf0dfda5 (http://notmuchmail.org) Emacs/24.3.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238317>


[sorry about taking so much time to get back to you, was too busy with
other stuff to work on git]

Duy Nguyen <pclouds@gmail.com> writes:

> On Mon, Aug 19, 2013 at 2:42 AM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
>> +char *super_directory(const char *filename)
>> +{
>> +       char *slash;
>> +
>> +       slash = strrchr(filename, '/');
>> +       if (slash)
>> +               return xmemdupz(filename, slash-filename);
>> +       return NULL;
>> +}
>> +
>
> Why is this function not static? There are a few other in this patch
> (I did not notice in others, but I wasn't looking for them..)

That's just an oversight, it should be static.  Will look for the others
and change them to static too.

> But isn't this what dirname() is?
>
> Another point about this function is it returns a new allocated
> string, but I see no free() anywhere in this patch. Leak alert!

Yes, you're right, I'll use dirname instead.  That also solves the free
problem, as dirname modifies the string.  I'll still use a wrapper
around it, because dirname returns "." when there is no super_directory,
but using NULL for that makes it simpler to check it.

>> +struct directory_entry *init_directory_entry(char *pathname, int len)
>> +{
>> +       struct directory_entry *de = xmalloc(directory_entry_size(len));
>> +
>> +       memcpy(de->pathname, pathname, len);
>> +       de->pathname[len] = '\0';
>> +       de->de_flags      = 0;
>> +       de->de_foffset    = 0;
>> +       de->de_cr         = 0;
>> +       de->de_ncr        = 0;
>> +       de->de_nsubtrees  = 0;
>> +       de->de_nfiles     = 0;
>> +       de->de_nentries   = 0;
>> +       memset(de->sha1, 0, 20);
>> +       de->de_pathlen    = len;
>> +       de->next          = NULL;
>> +       de->next_hash     = NULL;
>> +       de->ce            = NULL;
>> +       de->ce_last       = NULL;
>> +       de->conflict      = NULL;
>> +       de->conflict_last = NULL;
>> +       de->conflict_size = 0;
>> +       return de;
>> +}
>
> I think this function could be shortened to
>
> struct directory_entry *de = xcalloc(1, directory_entry_size(len));
> memcpy(de->pathname, pathname, len);
> de->de_pathlen = len;
> return de;

Makes sense, thanks.

>> +static struct directory_entry *get_directory(char *dir, unsigned int dir_len,
>> +                                            struct hash_table *table,
>> +                                            unsigned int *total_dir_len,
>> +                                            unsigned int *ndir,
>> +                                            struct directory_entry **current)
>> +{
>> +       struct directory_entry *tmp = NULL, *search, *new, *ret;
>> +       uint32_t crc;
>> +
>> +       search = find_directory(dir, dir_len, &crc, table);
>> +       if (search)
>> +               return search;
>> +       while (!search) {
>> +               new = init_directory_entry(dir, dir_len);
>> +               insert_directory_entry(new, table, total_dir_len, ndir, crc);
>> +               if (!tmp)
>> +                       ret = new;
>> +               else
>> +                       new->de_nsubtrees = 1;
>> +               new->next = tmp;
>> +               tmp = new;
>> +               dir = super_directory(dir);
>
> It feels more natural to create directory_entry(s) from parent to
> subdir. If you do so you could reset dir to the remaining of directory
> and perform strchr() and do not need to allocate new memory everytime
> you call super_directory (because it relies on NUL at the end of the
> string).

I'm creating them from subdir to parent because it saves a few calls
whenever a superdir is already in the hash_table.  And I'm using dirname
so the new memory allocations are not a problem anymore.

>> +               dir_len = dir ? strlen(dir) : 0;
>> +               search = find_directory(dir, dir_len, &crc, table);
>> +       }
>> +       search->de_nsubtrees++;
>> +       (*current)->next = tmp;
>> +       while ((*current)->next)
>> +               *current = (*current)->next;
>> +
>> +       return ret;
>> +}
>
>> +static struct directory_entry *compile_directory_data(struct index_state *istate,
>> +                                                     int nfile,
>> +                                                     unsigned int *ndir,
>> +                                                     unsigned int *total_dir_len,
>> +                                                     unsigned int *total_file_len)
>> +{
>> +       int i, dir_len = -1;
>> +       char *dir;
>> +       struct directory_entry *de, *current, *search;
>> +       struct cache_entry **cache = istate->cache;
>> +       struct conflict_entry *conflict_entry;
>> +       struct hash_table table;
>> +       uint32_t crc;
>> +
>> +       init_hash(&table);
>> +       de = init_directory_entry("", 0);
>> +       current = de;
>> +       *ndir = 1;
>> +       *total_dir_len = 1;
>> +       crc = crc32(0, (Bytef*)de->pathname, de->de_pathlen);
>> +       insert_hash(crc, de, &table);
>> +       conflict_entry = NULL;
>> +       for (i = 0; i < nfile; i++) {
>> +               if (cache[i]->ce_flags & CE_REMOVE)
>> +                       continue;
>> +
>> +               if (dir_len < 0
>> +                   || cache[i]->name[dir_len] != '/'
>
> Need a check to make sure name[dir_len] is not out of bound

Thanks.

>> +                   || strchr(cache[i]->name + dir_len + 1, '/')
>> +                   || cache_name_compare(cache[i]->name, ce_namelen(cache[i]),
>> +                                         dir, dir_len)) {
>
> In my opinon, "if (dir_len < 0 || !(must && be && a && subdirectory))"
> is easier to read..

Makes sense, will change.

>> +                       dir = super_directory(cache[i]->name);
>> +                       dir_len = dir ? strlen(dir) : 0;
>> +                       search = get_directory(dir, dir_len, &table,
>> +                                              total_dir_len, ndir,
>> +                                              &current);
>> +               }
>> +               search->de_nfiles++;
>> +               *total_file_len += ce_namelen(cache[i]) + 1;
>> +               if (search->de_pathlen)
>> +                       *total_file_len -= search->de_pathlen + 1;
>> +               ce_queue_push(&(search->ce), &(search->ce_last), cache[i]);
>> +
>> +               if (ce_stage(cache[i]) > 0) {
>> +                       struct conflict_part *conflict_part;
>> +                       if (!conflict_entry ||
>> +                           cache_name_compare(conflict_entry->name, conflict_entry->namelen,
>> +                                              cache[i]->name, ce_namelen(cache[i]))) {
>> +                               conflict_entry = create_conflict_entry_from_ce(cache[i], search->de_pathlen);
>> +                               add_conflict_to_directory_entry(search, conflict_entry);
>> +                       }
>> +                       conflict_part = conflict_part_from_inmemory(cache[i]);
>> +                       add_part_to_conflict_entry(search, conflict_entry, conflict_part);
>> +               }
>> +       }
>> +       return de;
>> +}
>> +
>
>> +static int write_directories(struct directory_entry *de, int fd, int conflict_offset)
>> +{
>> +       struct directory_entry *current;
>> +       struct ondisk_directory_entry ondisk;
>> +       int current_offset, offset_write, ondisk_size, foffset;
>> +       uint32_t crc;
>> +
>> +       /*
>> +        * This is needed because the compiler aligns structs to sizes multiple
>> +        * of 4
>> +        */
>> +       ondisk_size = sizeof(ondisk.flags)
>> +               + sizeof(ondisk.foffset)
>> +               + sizeof(ondisk.cr)
>> +               + sizeof(ondisk.ncr)
>> +               + sizeof(ondisk.nsubtrees)
>> +               + sizeof(ondisk.nfiles)
>> +               + sizeof(ondisk.nentries)
>> +               + sizeof(ondisk.sha1);
>> +       current = de;
>> +       current_offset = 0;
>> +       foffset = 0;
>> +       while (current) {
>> +               int pathlen;
>> +
>> +               offset_write = htonl(current_offset);
>> +               if (ce_write(NULL, fd, &offset_write, 4) < 0)
>> +                       return -1;
>> +               if (current->de_pathlen == 0)
>> +                       pathlen = 0;
>> +               else
>> +                       pathlen = current->de_pathlen + 1;
>> +               current_offset += pathlen + 1 + ondisk_size + 4;
>> +               current = current->next;
>> +       }
>> +       /*
>> +        * Write one more offset, which points to the end of the entries,
>> +        * because we use it for calculating the dir length, instead of
>> +        * using strlen.
>> +        */
>> +       offset_write = htonl(current_offset);
>> +       if (ce_write(NULL, fd, &offset_write, 4) < 0)
>> +               return -1;
>> +       current = de;
>> +       while (current) {
>> +               crc = 0;
>> +               if (current->de_pathlen == 0) {
>> +                       if (ce_write(&crc, fd, current->pathname, 1) < 0)
>> +                               return -1;
>> +               } else {
>> +                       char *path;
>> +                       path = xmalloc(sizeof(char) * (current->de_pathlen + 2));
>> +                       memcpy(path, current->pathname, current->de_pathlen);
>> +                       memcpy(path + current->de_pathlen, "/\0", 2);
>> +                       if (ce_write(&crc, fd, path, current->de_pathlen + 2) < 0)
>> +                               return -1;
>
> xmalloc without free

In the new version the pathname is included at the end of the ondisk
struct, for which I added a free.

>> +               }
>> +               current->de_foffset = foffset;
>> +               current->de_cr = conflict_offset;
>> +               ondisk_from_directory_entry(current, &ondisk);
>> +               if (ce_write(&crc, fd, &ondisk, ondisk_size) < 0)
>> +                       return -1;
>> +               crc = htonl(crc);
>> +               if (ce_write(NULL, fd, &crc, 4) < 0)
>> +                       return -1;
>> +               conflict_offset += current->conflict_size;
>> +               foffset += current->de_nfiles * 4;
>> +               current = current->next;
>> +       }
>> +       return 0;
>> +}
>> +
>> +static int write_entries(struct index_state *istate,
>> +                           struct directory_entry *de,
>> +                           int entries,
>> +                           int fd,
>> +                           int offset_to_offset)
>> +{
>> +       int offset, offset_write, ondisk_size;
>> +       struct directory_entry *current;
>> +
>> +       offset = 0;
>> +       ondisk_size = sizeof(struct ondisk_cache_entry);
>> +       current = de;
>> +       while (current) {
>
> A short comment a the beginning of this block saying this writes
> fileoffsets table would be nice.

Done, thanks.

>> +               int pathlen;
>> +               struct cache_entry *ce = current->ce;
>> +
>> +               if (current->de_pathlen == 0)
>> +                       pathlen = 0;
>> +               else
>> +                       pathlen = current->de_pathlen + 1;
>> +               while (ce) {
>> +                       if (ce->ce_flags & CE_REMOVE)
>> +                               continue;
>
> How come CE_REMOVE'd entries get here? I thought they were all ignored
> at compile_directory_data()

They don't, I've added this line unnecessarily.  Will remove it.

>> +                       if (!ce_uptodate(ce) && is_racy_timestamp(istate, ce))
>> +                               ce_smudge_racily_clean_entry(ce);
>> +                       if (is_null_sha1(ce->sha1))
>> +                               return error("cache entry has null sha1: %s", ce->name);
>> +
>> +                       offset_write = htonl(offset);
>> +                       if (ce_write(NULL, fd, &offset_write, 4) < 0)
>> +                               return -1;
>> +                       offset += ce_namelen(ce) - pathlen + 1 + ondisk_size + 4;
>> +                       ce = ce->next_ce;
>> +               }
>> +               current = current->next;
>> +       }
>> +       /*
>> +        * Write one more offset, which points to the end of the entries,
>> +        * because we use it for calculating the file length, instead of
>> +        * using strlen.
>> +        */
>> +       offset_write = htonl(offset);
>> +       if (ce_write(NULL, fd, &offset_write, 4) < 0)
>> +               return -1;
>> +
>> +       offset = offset_to_offset;
>> +       current = de;
>> +       while (current) {
>> +               int pathlen;
>> +               struct cache_entry *ce = current->ce;
>> +
>> +               if (current->de_pathlen == 0)
>> +                       pathlen = 0;
>> +               else
>> +                       pathlen = current->de_pathlen + 1;
>> +               while (ce) {
>> +                       struct ondisk_cache_entry ondisk;
>> +                       uint32_t crc, calc_crc;
>> +
>> +                       if (ce->ce_flags & CE_REMOVE)
>> +                               continue;
>> +                       calc_crc = htonl(offset);
>> +                       crc = crc32(0, (Bytef*)&calc_crc, 4);
>> +                       if (ce_write(&crc, fd, ce->name + pathlen,
>> +                                       ce_namelen(ce) - pathlen + 1) < 0)
>> +                               return -1;
>> +                       ondisk_from_cache_entry(ce, &ondisk);
>> +                       if (ce_write(&crc, fd, &ondisk, ondisk_size) < 0)
>> +                               return -1;
>> +                       crc = htonl(crc);
>> +                       if (ce_write(NULL, fd, &crc, 4) < 0)
>> +                               return -1;
>> +                       offset += 4;
>> +                       ce = ce->next_ce;
>> +               }
>> +               current = current->next;
>> +       }
>> +       return 0;
>> +}
>
>> +static int write_index_v5(struct index_state *istate, int newfd)
>> +{
>> +       struct cache_header hdr;
>> +       struct cache_header_v5 hdr_v5;
>> +       struct cache_entry **cache = istate->cache;
>> +       struct directory_entry *de;
>> +       struct ondisk_directory_entry *ondisk;
>> +       unsigned int entries = istate->cache_nr;
>> +       unsigned int i, removed, total_dir_len, ondisk_directory_size;
>> +       unsigned int total_file_len, conflict_offset, foffsetblock;
>> +       unsigned int ndir;
>> +       uint32_t crc;
>> +
>> +       if (istate->filter_opts)
>> +               die("BUG: index: cannot write a partially read index");
>> +
>> +       for (i = removed = 0; i < entries; i++) {
>> +               if (cache[i]->ce_flags & CE_REMOVE)
>> +                       removed++;
>> +       }
>> +       hdr.hdr_signature = htonl(CACHE_SIGNATURE);
>> +       hdr.hdr_version = htonl(istate->version);
>> +       hdr.hdr_entries = htonl(entries - removed);
>> +       hdr_v5.hdr_nextension = htonl(0); /* Currently no extensions are supported */
>> +
>> +       total_dir_len = 0;
>> +       total_file_len = 0;
>> +       de = compile_directory_data(istate, entries, &ndir,
>> +                                   &total_dir_len, &total_file_len);
>> +       hdr_v5.hdr_ndir = htonl(ndir);
>> +
>> +       /*
>> +        * This is needed because the compiler aligns structs to sizes multipe
>> +        * of 4
>> +        */
>> +       ondisk_directory_size = sizeof(ondisk->flags)
>> +               + sizeof(ondisk->foffset)
>> +               + sizeof(ondisk->cr)
>> +               + sizeof(ondisk->ncr)
>> +               + sizeof(ondisk->nsubtrees)
>> +               + sizeof(ondisk->nfiles)
>> +               + sizeof(ondisk->nentries)
>> +               + sizeof(ondisk->sha1);
>
> There is a similar statement in read code. This calls for a macro to
> share this sum.

This is no longer needed, as I switched the flag size to 32 bits, to
enable adding the pathname at the end of the struct.

>> +       foffsetblock = sizeof(hdr) + sizeof(hdr_v5) + 4
>> +               + (ndir + 1) * 4
>> +               + total_dir_len
>> +               + ndir * (ondisk_directory_size + 4);
>> +       hdr_v5.hdr_fblockoffset = htonl(foffsetblock + (entries - removed + 1) * 4);
>> +       crc = 0;
>> +       if (ce_write(&crc, newfd, &hdr, sizeof(hdr)) < 0)
>> +               return -1;
>> +       if (ce_write(&crc, newfd, &hdr_v5, sizeof(hdr_v5)) < 0)
>> +               return -1;
>> +       crc = htonl(crc);
>> +       if (ce_write(NULL, newfd, &crc, 4) < 0)
>> +               return -1;
>> +
>> +       conflict_offset = foffsetblock +
>> +               + (entries - removed + 1) * 4
>> +               + total_file_len
>> +               + (entries - removed) * (sizeof(struct ondisk_cache_entry) + 4);
>> +       if (write_directories(de, newfd, conflict_offset) < 0)
>> +               return -1;
>> +       if (write_entries(istate, de, entries, newfd, foffsetblock) < 0)
>> +               return -1;
>> +       if (write_conflicts(istate, de, newfd) < 0)
>> +               return -1;
>> +       return ce_flush(newfd);
>> +}

In the re-roll the conflicted and the resolve-undo entries will also be
written in an extension as you suggested in the other email.  I'll
re-roll the series with a POC for partial writing tomorrow if all goes
well.
