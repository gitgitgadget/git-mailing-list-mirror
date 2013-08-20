From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH v3 15/24] read-cache: read index-v5
Date: Tue, 20 Aug 2013 22:59:23 +0200
Message-ID: <87wqng3wpg.fsf@gmail.com>
References: <1376854933-31241-1-git-send-email-t.gummerer@gmail.com> <1376854933-31241-16-git-send-email-t.gummerer@gmail.com> <CACsJy8A1NpYa6nr6vHKLd-Tap3PObabfUB34U90MH_OdfQJN9Q@mail.gmail.com>
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
X-From: git-owner@vger.kernel.org Tue Aug 20 22:59:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBt1m-0003kF-2C
	for gcvg-git-2@plane.gmane.org; Tue, 20 Aug 2013 22:59:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752120Ab3HTU7d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Aug 2013 16:59:33 -0400
Received: from mail-we0-f182.google.com ([74.125.82.182]:47500 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752091Ab3HTU7a (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Aug 2013 16:59:30 -0400
Received: by mail-we0-f182.google.com with SMTP id q59so875079wes.41
        for <git@vger.kernel.org>; Tue, 20 Aug 2013 13:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version:content-type;
        bh=TRtH0zwXI45tyVJ7cwVUXdiTF1HM8rh5OeMmfEqWk+E=;
        b=O9UzmJX5FYDxZwegnhKyNOxeLxueHAMIvBJd7mweOjQMDtODKdX2c6V0E8GFkWiuPf
         SHXS5S5I8GD3OxdE2CtakUMystkg1yEiYwWFtWCkynCxBmwkWwbYJt2YsHOc/9rG5MmJ
         +ub4+D/dpVQTJPEgBe0/Htg4g8NHDLHKjFHlPs3GxR32OqISL6wGmBXVpsJYzq672vM7
         uta+ixOFumzml+vhNFuuxnoVx7hyizF8r7jP2W2ku67g9sSuwvBJYnMOpha47vJmO6XW
         Atwr8ZPA1sVkhZIvWnJRG1KQeVhrVePU6xk/3QY1SpnRKilagwUy/w8OJLuw3sO+0Riu
         wlAQ==
X-Received: by 10.180.36.133 with SMTP id q5mr2863591wij.0.1377032368671;
        Tue, 20 Aug 2013 13:59:28 -0700 (PDT)
Received: from localhost ([2001:470:6d:596:7e6d:62ff:fe8c:90ce])
        by mx.google.com with ESMTPSA id gg10sm5458342wib.1.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 20 Aug 2013 13:59:27 -0700 (PDT)
In-Reply-To: <CACsJy8A1NpYa6nr6vHKLd-Tap3PObabfUB34U90MH_OdfQJN9Q@mail.gmail.com>
User-Agent: Notmuch/0.15.2+119~gf0dfda5 (http://notmuchmail.org) Emacs/24.3.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232646>

Duy Nguyen <pclouds@gmail.com> writes:

> General comment: a short comment before each function describing what
> the function does would be helpful. This only applies for complex
> functions (read_* ones). Of course verify_hdr does not require extra
> explanantion.

Yes, makes sense, I'll do that in the re-roll.

>  On Mon, Aug 19, 2013 at 2:42 AM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
>> +static struct directory_entry *directory_entry_from_ondisk(struct ondisk_directory_entry *ondisk,
>> +                                                  const char *name,
>> +                                                  size_t len)
>> +{
>> +       struct directory_entry *de = xmalloc(directory_entry_size(len));
>> +
>> +       memcpy(de->pathname, name, len);
>> +       de->pathname[len] = '\0';
>> +       de->de_flags      = ntoh_s(ondisk->flags);
>> +       de->de_foffset    = ntoh_l(ondisk->foffset);
>> +       de->de_cr         = ntoh_l(ondisk->cr);
>> +       de->de_ncr        = ntoh_l(ondisk->ncr);
>> +       de->de_nsubtrees  = ntoh_l(ondisk->nsubtrees);
>> +       de->de_nfiles     = ntoh_l(ondisk->nfiles);
>> +       de->de_nentries   = ntoh_l(ondisk->nentries);
>> +       de->de_pathlen    = len;
>> +       hashcpy(de->sha1, ondisk->sha1);
>> +       return de;
>> +}
>
> This function leaves a lot of fields uninitialized..
>
>> +static struct directory_entry *read_directories(unsigned int *dir_offset,
>> +                               unsigned int *dir_table_offset,
>> +                               void *mmap,
>> +                               int mmap_size)
>> +{
>> ....
>> +       de = directory_entry_from_ondisk(disk_de, name, len);
>> +       de->next = NULL;
>> +       de->sub = NULL;
>
> ..and two of them are set to NULL here. Maybe
> directory_entry_from_ondisk() could be made to call
> init_directory_entry() instead so that we don't need to manually reset
> some fields here, which leaves me wondering why other fields are not
> important to reset. init_directory_entry() is introduced later in
> "write index-v5" patch, you so may want to move it up a few patches.

The rest of the fields are only used for compiling the data that will be
written.  Using init_directory_entry() here makes sense anyway though,
thanks for the suggestion.

>> +static int read_entry(struct cache_entry **ce, char *pathname, size_t pathlen,
>> +                     void *mmap, unsigned long mmap_size,
>> +                     unsigned int first_entry_offset,
>> +                     unsigned int foffsetblock)
>> +{
>> +       int len, offset_to_offset;
>> +       char *name;
>> +       uint32_t foffsetblockcrc, *filecrc, *beginning, *end, entry_offset;
>> +       struct ondisk_cache_entry *disk_ce;
>> +
>> +       beginning = ptr_add(mmap, foffsetblock);
>> +       end = ptr_add(mmap, foffsetblock + 4);
>> +       len = ntoh_l(*end) - ntoh_l(*beginning) - sizeof(struct ondisk_cache_entry) - 5;
>
> It took me a while to check and figure out " - 5" here means minus NUL
> and the crc. A short comment would help. I think there's also another
> -5 in read_directories(). Or maybe just rename len to namelen.

Will add a short comment.

>> +struct conflict_entry *create_new_conflict(char *name, int len, int pathlen)
>> +{
>> +       struct conflict_entry *conflict_entry;
>> +
>> +       if (pathlen)
>> +               pathlen++;
>> +       conflict_entry = xmalloc(conflict_entry_size(len));
>> +       conflict_entry->entries = NULL;
>> +       conflict_entry->nfileconflicts = 0;
>> +       conflict_entry->namelen = len;
>> +       memcpy(conflict_entry->name, name, len);
>> +       conflict_entry->name[len] = '\0';
>> +       conflict_entry->pathlen = pathlen;
>> +       conflict_entry->next = NULL;
>
> A memset followed by memcpy and conflict_entry->pathlen = pathlen
> would make this shorter and won't miss new fields added in future.

Makes sense, thanks.

>> +static int read_entries(struct index_state *istate, struct directory_entry *de,
>> +                       unsigned int first_entry_offset, void *mmap,
>> +                       unsigned long mmap_size, unsigned int *nr,
>> +                       unsigned int foffsetblock)
>> +{
>> +       struct cache_entry *ce;
>> +       int i, subdir = 0;
>> +
>> +       for (i = 0; i < de->de_nfiles; i++) {
>> +               unsigned int subdir_foffsetblock = de->de_foffset + foffsetblock + (i * 4);
>> +               if (read_entry(&ce, de->pathname, de->de_pathlen, mmap, mmap_size,
>> +                              first_entry_offset, subdir_foffsetblock) < 0)
>> +                       return -1;
>
> You read one file entry, say abc/def...

You're not quite right here.  I'm reading def here, de is the root
directory and de->sub[subdir] is the first sub directory, named abc/

>> +               while (subdir < de->de_nsubtrees &&
>> +                      cache_name_compare(ce->name + de->de_pathlen,
>> +                                         ce_namelen(ce) - de->de_pathlen,
>> +                                         de->sub[subdir]->pathname + de->de_pathlen,
>> +                                         de->sub[subdir]->de_pathlen - de->de_pathlen) > 0) {
>
> Oh right the entry belongs the the substree "abc" so..

abc/ comes before def, so lets read everything in that directory first.

>> +                       read_entries(istate, de->sub[subdir], first_entry_offset, mmap,
>> +                                    mmap_size, nr, foffsetblock);
>
> you recurse in, which will add following entries like abc/def and abc/xyz...

Recurse in, add abc/def and abc/xyz, and increase nr in the recursion,
so the new entry gets added at the right place.

>> +                       subdir++;
>> +               }
>> +               if (!ce)
>> +                       continue;
>> +               set_index_entry(istate, (*nr)++, ce);
>
> then back here after recusion and add abc/def, again, after abc/xyz.
> Did I read this code correctly?

After the recursion add def to at the 3rd position in the index.  After
that it looks like:
abc/def
abc/xyz
def

I hope that makes it a little clearer.

>> +       }
>> +       for (i = subdir; i < de->de_nsubtrees; i++) {
>> +               read_entries(istate, de->sub[i], first_entry_offset, mmap,
>> +                            mmap_size, nr, foffsetblock);
>> +       }
>> +       return 0;
>> +}
>> +
>
>> +static int read_index_v5(struct index_state *istate, void *mmap,
>> +                        unsigned long mmap_size, struct filter_opts *opts)
>> +{
>> +       unsigned int entry_offset, ndirs, foffsetblock, nr = 0;
>> +       struct directory_entry *root_directory, *de, *last_de;
>> +       const char **paths = NULL;
>> +       struct pathspec adjusted_pathspec;
>> +       int need_root = 0, i;
>> +
>> +       root_directory = read_all_directories(istate, &entry_offset,
>> +                                             &foffsetblock, &ndirs,
>> +                                             mmap, mmap_size);
>> +
>> +       if (opts && opts->pathspec && opts->pathspec->nr) {
>> +               need_root = 0;
>
> need_root is already initialized at declaration.

Right, thanks.

>> +               paths = xmalloc((opts->pathspec->nr + 1)*sizeof(char *));
>> +               paths[opts->pathspec->nr] = NULL;
>> +               for (i = 0; i < opts->pathspec->nr; i++) {
>> +                       char *super = strdup(opts->pathspec->items[i].match);
>> +                       int len = strlen(super);
>> +                       while (len && super[len - 1] == '/' && super[len - 2] == '/')
>> +                               super[--len] = '\0'; /* strip all but one trailing slash */
>> +                       while (len && super[--len] != '/')
>> +                               ; /* scan backwards to next / */
>> +                       if (len >= 0)
>> +                               super[len--] = '\0';
>> +                       if (len <= 0) {
>> +                               need_root = 1;
>> +                               break;
>> +                       }
>> +                       paths[i] = super;
>> +               }
>> +       }
>> +
>> +       if (!need_root)
>> +               parse_pathspec(&adjusted_pathspec, PATHSPEC_ALL_MAGIC, PATHSPEC_PREFER_CWD, NULL, paths);
>> +
>> +       de = root_directory;
>> +       last_de = de;
>> +       while (de) {
>> +               if (need_root ||
>> +                   match_pathspec_depth(&adjusted_pathspec, de->pathname, de->de_pathlen, 0, NULL)) {
>> +                       if (read_entries(istate, de, entry_offset,
>> +                                        mmap, mmap_size, &nr,
>> +                                        foffsetblock) < 0)
>> +                               return -1;
>> +               } else {
>> +                       for (i = 0; i < de->de_nsubtrees; i++) {
>> +                               last_de->next = de->sub[i];
>> +                               last_de = last_de->next;
>> +                       }
>> +               }
>> +               de = de->next;
>
> I'm missing something here. read_entries is a function that reads all
> entries inside "de" including subdirectories and the first "de" is
> root_directory, which makes it read the whole index in.

It does, except when the adjusted_pathspec doesn't match the
root_directory.  In that case all the subdirectories of the
root_directory are added to a queue, which will then be iterated over
and tried to match with the adjusted_pathspec.

This has a bug not covered by the test suite described below when
checking against pathspecs with different levels.

> Because
> de->next is only set in this function, de->next after read_entries()
> is NULL, which termintates the loop and the else block never runs. It
> does not sound right..

If the subdirectory is read it does and the loop should terminate,
because the whole index is read.

It does have a bug in the following test case though, which is not
covered by the test suite.  I'll add this and the test and the fix to
the test-suite:

#!/bin/sh

test_description="Test index-v5 specific corner cases"

. ./test-lib.sh

test_set_index_version 5

test_expect_success 'setup' '
	mkdir -p abc/def def &&
	touch abc/def/xyz def/xyz &&
	git add . &&
	git commit -m "test commit"
'

test_expect_success 'ls-files ordering correct' '
	cat <<-\EOF >expected &&
	abc/def/xyz
	def/xyz
	EOF
	git ls-files abc/def/xyz def/xyz >actual &&
	test_cmp expected actual
'

test_done

This can be solved by the following:

diff --git a/read-cache-v5.c b/read-cache-v5.c
index 10960fd..9963d1f 100644
--- a/read-cache-v5.c
+++ b/read-cache-v5.c
@@ -661,7 +661,9 @@ static int read_index_v5(struct index_state *istate, void *mmap,
                                         foffsetblock) < 0)
                                return -1;
                } else {
+                       last_de = de;
                        for (i = 0; i < de->de_nsubtrees; i++) {
+                               de->sub[i]->next = last_de->next;
                                last_de->next = de->sub[i];
                                last_de = last_de->next;
                        }
