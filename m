From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH v2 12/19] read-cache: read index-v5
Date: Wed, 07 Aug 2013 10:13:42 +0200
Message-ID: <87mwotrk95.fsf@gmail.com>
References: <1373650024-3001-1-git-send-email-t.gummerer@gmail.com> <1373650024-3001-13-git-send-email-t.gummerer@gmail.com> <CACsJy8C6HRCYMR3Q=j-D=2kgzvA7=0tauSnwrjpXzSPZWe+VZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>,
	Thomas Rast <trast@inf.ethz.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 07 10:13:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6ysX-0007g8-I3
	for gcvg-git-2@plane.gmane.org; Wed, 07 Aug 2013 10:13:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755679Ab3HGINx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Aug 2013 04:13:53 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:54070 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755587Ab3HGINs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Aug 2013 04:13:48 -0400
Received: by mail-pa0-f53.google.com with SMTP id lb1so1855522pab.40
        for <git@vger.kernel.org>; Wed, 07 Aug 2013 01:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version:content-type;
        bh=GSTazaiiCoQpThDstfEqD+wHimglq+2FU1o/d9R6BvM=;
        b=h3//jmfs5SmoHlO5PP0b3fV39DtDDv1w6Q+OlZjkIPUxvJ6L2lMzG9WTnWk9g4iyXx
         2o4R4VykSs+ZY56xrvqJGj6sLLS97WOGjuQbRWbXz7qSeK/QmEWSkKyuY9Po/doypjBO
         Eg9f2V/aowtcBC3mL6ze8i4dGqigRBiT089r1dZAH+ZexpzF+0+GB/irTTUHTy9ZEERS
         3gvORr4q40saCIeJmMVLNRu2swiQM0g439RxbTtQ/ZNUAuktiDlsMP9RCZi/S5lGU0er
         sIlVbGh6p0rZOiFBqIXmKt9rfp2UUxvw2c+5SGEBqa+/D5tLnMHtGRJIXqCDiyzfOtLB
         YipQ==
X-Received: by 10.66.121.234 with SMTP id ln10mr3125088pab.20.1375863227501;
        Wed, 07 Aug 2013 01:13:47 -0700 (PDT)
Received: from localhost ([2a02:27e8:10:1047:0:dacb:1376:714a])
        by mx.google.com with ESMTPSA id bs3sm6723295pbc.42.2013.08.07.01.13.44
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 07 Aug 2013 01:13:46 -0700 (PDT)
In-Reply-To: <CACsJy8C6HRCYMR3Q=j-D=2kgzvA7=0tauSnwrjpXzSPZWe+VZw@mail.gmail.com>
User-Agent: Notmuch/0.15.2+119~gf0dfda5 (http://notmuchmail.org) Emacs/24.3.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231809>

Duy Nguyen <pclouds@gmail.com> writes:

> On Sat, Jul 13, 2013 at 12:26 AM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
>> +struct directory_entry {
>> +       struct directory_entry *next;
>> +       struct directory_entry *next_hash;
>> +       struct cache_entry *ce;
>> +       struct cache_entry *ce_last;
>> +       struct conflict_entry *conflict;
>> +       struct conflict_entry *conflict_last;
>> +       unsigned int conflict_size;
>> +       unsigned int de_foffset;
>> +       unsigned int de_cr;
>> +       unsigned int de_ncr;
>> +       unsigned int de_nsubtrees;
>> +       unsigned int de_nfiles;
>> +       unsigned int de_nentries;
>> +       unsigned char sha1[20];
>> +       unsigned short de_flags;
>> +       unsigned int de_pathlen;
>> +       char pathname[FLEX_ARRAY];
>> +};
>> +
>> +struct conflict_part {
>> +       struct conflict_part *next;
>> +       unsigned short flags;
>> +       unsigned short entry_mode;
>> +       unsigned char sha1[20];
>> +};
>> +
>> +struct conflict_entry {
>> +       struct conflict_entry *next;
>> +       unsigned int nfileconflicts;
>> +       struct conflict_part *entries;
>> +       unsigned int namelen;
>> +       unsigned int pathlen;
>> +       char name[FLEX_ARRAY];
>> +};
>> +
>> +struct ondisk_conflict_part {
>> +       unsigned short flags;
>> +       unsigned short entry_mode;
>> +       unsigned char sha1[20];
>> +};
>
> These new structs should probably be in read-cache-v5.c, or read-cache.h

Makes sense, thanks.

>>  #define cache_entry_size(len) (offsetof(struct cache_entry,name) + (len) + 1)
>> +#define directory_entry_size(len) (offsetof(struct directory_entry,pathname) + (len) + 1)
>> +#define conflict_entry_size(len) (offsetof(struct conflict_entry,name) + (len) + 1)
>
> These are used by read-cache-v5.c only so far. I'd say move them to
> read-cache.h or read-cache-v5.c together with the new structs.

Thanks.

>> +struct ondisk_cache_entry {
>> +       unsigned short flags;
>> +       unsigned short mode;
>> +       struct cache_time mtime;
>> +       unsigned int size;
>> +       int stat_crc;
>> +       unsigned char sha1[20];
>> +};
>> +
>> +struct ondisk_directory_entry {
>> +       unsigned int foffset;
>> +       unsigned int cr;
>> +       unsigned int ncr;
>> +       unsigned int nsubtrees;
>> +       unsigned int nfiles;
>> +       unsigned int nentries;
>> +       unsigned char sha1[20];
>> +       unsigned short flags;
>> +};
>
> Perhaps use uint32_t, uint16_t and friends for all on-disk structures?

We got this in the makefile, so I think we should be fine without it.
It still makes sense for clarity though I think.

         ifdef NO_UINTMAX_T
	       BASIC_CFLAGS += -Duintmax_t=uint32_t
         endif

While at it I'll make the code for v[234] use them too.

>> +static struct directory_entry *read_directories(unsigned int *dir_offset,
>> +                               unsigned int *dir_table_offset,
>> +                               void *mmap,
>> +                               int mmap_size)
>> +{
>> +       int i, ondisk_directory_size;
>> +       uint32_t *filecrc, *beginning, *end;
>> +       struct directory_entry *current = NULL;
>> +       struct ondisk_directory_entry *disk_de;
>> +       struct directory_entry *de;
>> +       unsigned int data_len, len;
>> +       char *name;
>> +
>> +       /*
>> +        * Length of pathname + nul byte for termination + size of
>> +        * members of ondisk_directory_entry. (Just using the size
>> +        * of the struct doesn't work, because there may be padding
>> +        * bytes for the struct)
>> +        */
>> +       ondisk_directory_size = sizeof(disk_de->flags)
>> +               + sizeof(disk_de->foffset)
>> +               + sizeof(disk_de->cr)
>> +               + sizeof(disk_de->ncr)
>> +               + sizeof(disk_de->nsubtrees)
>> +               + sizeof(disk_de->nfiles)
>> +               + sizeof(disk_de->nentries)
>> +               + sizeof(disk_de->sha1);
>> +       name = ptr_add(mmap, *dir_offset);
>> +       beginning = ptr_add(mmap, *dir_table_offset);
>> +       end = ptr_add(mmap, *dir_table_offset + 4);
>> +       len = ntoh_l(*end) - ntoh_l(*beginning) - ondisk_directory_size - 5;
>> +       disk_de = ptr_add(mmap, *dir_offset + len + 1);
>> +       de = directory_entry_from_ondisk(disk_de, name, len);
>> +       de->next = NULL;
>> +
>> +       data_len = len + 1 + ondisk_directory_size;
>> +       filecrc = ptr_add(mmap, *dir_offset + data_len);
>> +       if (!check_crc32(0, ptr_add(mmap, *dir_offset), data_len, ntoh_l(*filecrc)))
>> +               goto unmap;
>> +
>> +       *dir_table_offset += 4;
>> +       *dir_offset += data_len + 4; /* crc code */
>> +
>> +       current = de;
>> +       for (i = 0; i < de->de_nsubtrees; i++) {
>> +               current->next = read_directories(dir_offset, dir_table_offset,
>> +                                               mmap, mmap_size);
>> +               while (current->next)
>> +                       current = current->next;
>> +       }
>> +
>> +       return de;
>> +unmap:
>> +       munmap(mmap, mmap_size);
>> +       die("directory crc doesn't match for '%s'", de->pathname);
>> +}
>
> You don't have to munmap when you die() anway.

Will change that in the re-roll.

> I'm not sure if flatten
> the directory hierarchy into a list (linked by next pointer) is a good
> idea, or we should maintain the tree structure in memory. Still a lot
> of reading to figure that out..
>
> I skipped from here..
>
>> +static void ce_queue_push(struct cache_entry **head,
>> +                            struct cache_entry **tail,
>> +                            struct cache_entry *ce)
>> +{
>
> ...
>
>> +static int read_conflicts(struct conflict_entry **head,
>> +                         struct directory_entry *de,
>> +                         void **mmap, unsigned long mmap_size)
>> +{
>
> till the end of this function. Not interested in conflict stuff yet.
>
>
>> +static struct directory_entry *read_head_directories(struct index_state *istate,
>> +                                                    unsigned int *entry_offset,
>> +                                                    unsigned int *foffsetblock,
>> +                                                    unsigned int *ndirs,
>> +                                                    void *mmap, unsigned long mmap_size)
>> +{
>
> Maybe read_all_directories is a better nam.

Makes sense, thanks.

>> +static int read_index_filtered_v5(struct index_state *istate, void *mmap,
>> +                                 unsigned long mmap_size, struct filter_opts *opts)
>> +{
>> +       unsigned int entry_offset, ndirs, foffsetblock, nr = 0;
>> +       struct directory_entry *root_directory, *de;
>> +       const char **adjusted_pathspec = NULL;
>> +       int need_root = 0, i, n;
>> +       char *oldpath, *seen;
>> +
>> +       ...
>> +
>> +       de = root_directory;
>> +       while (de) {
>> +               if (need_root ||
>> +                   match_pathspec(adjusted_pathspec, de->pathname, de->de_pathlen, 0, NULL)) {
>> +                       unsigned int subdir_foffsetblock = de->de_foffset + foffsetblock;
>> +                       unsigned int *off = mmap + subdir_foffsetblock;
>> +                       unsigned int subdir_entry_offset = entry_offset + ntoh_l(*off);
>> +                       oldpath = de->pathname;
>> +                       do {
>> +                               if (read_entries(istate, &de, &subdir_entry_offset,
>> +                                                &mmap, mmap_size, &nr,
>> +                                                &subdir_foffsetblock) < 0)
>> +                                       return -1;
>> +                       } while (de && !prefixcmp(de->pathname, oldpath));
>> +               } else
>> +                       de = de->next;
>> +       }
>
> Hm.. if we maintain a tree structure here (one link to the first
> subdir, one link to the next sibling), I think the "do" loop could be
> done without prefixcmp. Just check if "de" returned by read_entries is
> the next sibling "de" (iow the end of current directory recursively).

Yes, the tree-structure makes sense.  I've implemented it a bit
differently though, instead of using two pointers, I'm using one pointer
to an array of directory entries, which can be iterated over.

>> +       istate->cache_nr = nr;
>> +       return 0;
>> +}
>> +
>> +static int read_index_v5(struct index_state *istate, void *mmap,
>> +                        unsigned long mmap_size, struct filter_opts *opts)
>> +{
>> +       unsigned int entry_offset, ndirs, foffsetblock, nr = 0;
>> +       struct directory_entry *root_directory, *de;
>> +
>> +       if (opts != NULL)
>> +               return read_index_filtered_v5(istate, mmap, mmap_size, opts);
>> +
>> +       root_directory = read_head_directories(istate, &entry_offset,
>> +                                              &foffsetblock, &ndirs,
>> +                                              mmap, mmap_size);
>> +       de = root_directory;
>> +       while (de)
>> +               if (read_entries(istate, &de, &entry_offset, &mmap,
>> +                                mmap_size, &nr, &foffsetblock) < 0)
>> +                       return -1;
>> +       istate->cache_nr = nr;
>> +       return 0;
>> +}
>
> Make it call read_index_filtered_v5 with an empty pathspec instead.
> match_pathspec* returns true immediately if pathspec is empty. Without
> the removal of prefixcmp() in the "do" loop mentioned above,
> read_index_filtered_v5 can't be more expensive than this version.

Yes right, will change in the re-roll.

> That was it! Lunch time! Maybe I'll read the rest in the afternoon, or
> someday next week.

Thanks a lot for taking the time to review my code.
