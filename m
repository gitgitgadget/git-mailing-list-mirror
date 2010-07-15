From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v2] Add svnrdump
Date: Thu, 15 Jul 2010 21:02:20 +0200
Message-ID: <20100715190220.GI22574@debian>
References: <20100709142910.GB20383@debian>
 <20100713201105.GN13310@ted.stsp.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: "dev@subversion.apache.org" <dev@subversion.apache.org>,
	Bert Huijben <rhuijben@collab.net>,
	Daniel Shahaf <d.s@daniel.shahaf.name>,
	Will Palmer <wmpalmer@gmail.com>,
	David Michael B
X-From: git-owner@vger.kernel.org Thu Jul 15 21:00:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZTfo-0005y8-J8
	for gcvg-git-2@lo.gmane.org; Thu, 15 Jul 2010 21:00:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934368Ab0GOTAh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jul 2010 15:00:37 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:58898 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934314Ab0GOTAg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jul 2010 15:00:36 -0400
Received: by ewy23 with SMTP id 23so356441ewy.19
        for <git@vger.kernel.org>; Thu, 15 Jul 2010 12:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=DKJc6RQiB7aUcbVV9yQto1yOnOqB/7tZFbrC+qHSH/4=;
        b=Bjj/bacnvLNu24r3xiUKXm/JnewV4y1Ejp3y+DAG31GeXhaVfdw+y3HGWCrTrWZZc3
         wsIkWjhgue1qusNzcCUeUQJJXz5CAGAe74scCZ1U3wo56JPauH7ZygbUZX19Mkw7vvMU
         3TwqnUhSoPr/1YbYAiNgJz8pL8HM1fkvtLLzs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=S52L7GmsIFPS6ATvYddnzAqbazUdq2GYtFjJFwVL/VGfsTqxO1NL/bIS67FmOfJ+Ci
         Q6MXnX24oRl5PC+0Vk2I5WdRGwRFxJkl0hXx7XIIPmlF2QbrqNeBWbo+ov4830uJqouD
         qpPiE3bjU1vwMQSP646JPpWH0R44K08bP+EJY=
Received: by 10.213.2.201 with SMTP id 9mr126757ebk.35.1279220433604;
        Thu, 15 Jul 2010 12:00:33 -0700 (PDT)
Received: from debian (nat-wireless.itu.dk [130.226.142.243])
        by mx.google.com with ESMTPS id v8sm10498688eeh.8.2010.07.15.12.00.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 15 Jul 2010 12:00:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100713201105.GN13310@ted.stsp.name>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151108>

Hi Stefan,

Stefan Sperling writes:
> Review below.

First, thanks for the detailed review! I'll be travelling over the
next few days starting tomorrow, and didn't want to delay the response
to your review: I've marked some items "TODO" so that I can grep for
them when I'm back in India and fix them.

> This diff is needed to build svnrdump as part of svn on Unix:
> 
> Index: build.conf
> ===================================================================
> --- build.conf	(revision 963733)
> +++ build.conf	(working copy)
> @@ -167,6 +167,13 @@ libs = libsvn_wc libsvn_subr apriconv apr
>  install = bin
>  manpages = subversion/svnversion/svnversion.1
>  
> +[svnrdump]
> +description = Subversion remote repository dumper
> +type = exe
> +path = subversion/svnrdump
> +libs = libsvn_client libsvn_ra libvsvn_delta libsvn_subr apr
> +install = bin
> +
>  # Support for GNOME Keyring
>  [libsvn_auth_gnome_keyring]
>  description = Subversion GNOME Keyring Library

Thanks! Now included.

> Can you include the above bit in your diff, please, and create follow-up
> diffs relative to the root of a Subversion trunk working copy? Thanks.

Ah, I wasn't paying attention. `git diff` always produces diffs
relative to the root.

> Please also add a man page similar to the one of svnsync.
> Even though I don't like the fact that our man pages simply refer to
> the Subversion book rather than providing a small and useful subset of it,
> it's good to at least be consistent about it.

Fixed.

> > +struct dump_edit_baton {
> 
> Please add a comment here explaining what the stream is used for,
> for instance /* The output stream we write the dumpfile to. */
> 
> > +  svn_stream_t *stream;

Fixed.

> > +  svn_revnum_t current_rev;
> 
> This is only incremented by never used?

Fixed.

> > +
> > +  /* pool is for per-edit-session allocations */
> > +  apr_pool_t *pool;
> > +
> > +  /* Store the properties that changed */
> > +  apr_hash_t *properties;
> > +  apr_hash_t *del_properties; /* Value is always 0x1 */
> 
> Just say "value is undefined". Or use an apr_array_header_t.

Fixed.

> A comment here saying what propstring is for would be nice.
> 
> > +  svn_stringbuf_t *propstring;

Fixed.

> > +
> > +  /* Was a copy command issued? */
> > +  svn_boolean_t is_copy;
> 
> Copy of what and when? This baton is global for the entire edit...
> 
> Going through the code, I see that you're using this to indicate to
> dump_node() whether an add_directory() or add_file() was in fact a copy.
> Why not remove this field from the struct and add it as a parameter to
> dump_node instead?

TODO.

> > +
> > +  /* Path of changed file */
> > +  const char *changed_path;
> 
> The changed_path field seems to be unused.
> 
> According to comments in open_file() and add_file(), change_file_prop()
> and apply_textdelta() should be using this but they aren't.

TODO.

> > +  /* Temporary file to write delta to along with its checksum */
> > +  char *temp_filepath;
> 
> That's a poor variable name. What about delta_abspath?

Fixed.

> > +  svn_checksum_t *checksum;
> 
> And rename this to delta_checksum?

Actually, I figured this wasn't used and removed it.

> > +
> > +  /* Flags to trigger dumping props and text */
> > +  svn_boolean_t must_dump_props;
> > +  svn_boolean_t must_dump_text;
> 
> I'd call these dump_props and dump_text, but that's a matter of taste.

Fixed.

> > +  svn_boolean_t dump_props_pending;
> > +};
> > +
> > +struct dir_baton {
> > +  struct dump_edit_baton *eb;
> > +  struct dir_baton *parent_dir_baton;
> > +
> > +  /* is this directory a new addition to this revision? */
> > +  svn_boolean_t added;
> > +
> > +  /* has this directory been written to the output stream? */
> > +  svn_boolean_t written_out;
> > +
> > +  /* the absolute path to this directory */
> > +  const char *path;
> 
> In code written post-svn-1.6, we usually call absolute paths
> something_abspath. E.g. local_abspath is an absolute path in a
> filesystem on the client (but not in the repository).
> 
> Elsewhere, this is called 'full_path' which would be fine name
> for this field, too. (Though any full_path variable you see in svn
> most likely pre-dates the *_abspath convention.)

Renamed path to abspath.

> > +
> > +  /* the comparison path and revision of this directory.  if both of
> > +     these are valid, use them as a source against which to compare
> > +     the directory instead of the default comparison source of PATH in
> > +     the previous revision. */
> > +  const char *cmp_path;
> > +  svn_revnum_t cmp_rev;
> 
> These just seem to be used as regular copyfrom info, so let's name them
> as such: copyfrom_path and copyfrom_rev
> Then you can also shrink the comment above cause everyone knows what
> copyfrom info is: /* Copyfrom info for the node, if any. */

Fixed.

> > +
> > +  /* hash of paths that need to be deleted, though some -might- be
> > +     replaced.  maps const char * paths to this dir_baton.  (they're
> > +     full paths, because that's what the editor driver gives us.  but
> > +     really, they're all within this directory.) */
> > +  apr_hash_t *deleted_entries;
> 
> This is very well commented and well named.
> 
> > +
> > +  /* pool to be used for deleting the hash items */
> > +  apr_pool_t *pool;
> 
> Hmmm.. a pool does not delete anything. It provides storage.
> Why do you need this?

TODO.

> > +};
> > +
> > +struct handler_baton
> > +{
> > +  svn_txdelta_window_handler_t apply_handler;
> > +  void *apply_baton;
> > +  apr_pool_t *pool;
> 
> Yet another pool. What's it for?

See window_handler below :)

> > +
> > +  /* Information about the path of the tempoarary file used */
> 
> s/tempoarary/temporary/

Fixed.

> > +  char *temp_filepath;
> > +  apr_file_t *temp_file;
> > +  svn_stream_t *temp_filestream;
> 
> What's the temporary file used for? You're writing a delta to it,
> so maybe name it accordingly?

Fixed.

> You need the file name to stat it in close_file().
> You need the stream in the baton to write to the file.
> But you don't need the apr_file.
> Open the file. Then wrap it in the stream with disown=FALSE, and pass
> just the stream to the window handler via the baton. When the stream
> is closed, the file will be closed as well.

TODO. I want to validate and make sure that I don't break anything
else or leak memory before performing this change.

> > +
> > +  /* To fill in the edit baton fields */
> > +  struct dump_edit_baton *eb;
> 
> Just say /* Global edit baton. */ or even drop the comment.

Fixed.

> > +};
> > +
> 
> Needs a docstring.

Fixed. I noticed one more mistake: to_rev is unused. Looks like
there's a LOT of historical crufts that I didn't clean up. I wonder
why the compiler doesn't tell me about all this.

> > +/* Make a directory baton to represent the directory was path
> > +   (relative to EDIT_BATON's path) is PATH.
> 
> The above sentence doesn't parse.
> 
> > +
> > +   CMP_PATH/CMP_REV are the path/revision against which this directory
> > +   should be compared for changes.  If either is omitted (NULL for the
> > +   path, SVN_INVALID_REVNUM for the rev), just compare this directory
> > +   PATH against itself in the previous revision.
> 
> s/CMP/COPYFROM/ and tweak the docstring to say something like:
>   If the copyfrom information is valid, the directory will be compared
>   against its copy source. Else, it will be compared against itself in
>   the previous revision.

Another historical cruft: since svnrdump doesn't support non-deltified
dumps and doesn't have fs backing, I can't and don't ever (need to)
compare it against itself in the previous revision.

> > +   PARENT_DIR_BATON is the directory baton of this directory's parent,
> > +   or NULL if this is the top-level directory of the edit.  ADDED
> > +   indicated if this directory is newly added in this revision.
> 
> s/indicated/indicates/

Fixed.

> > +  apr_array_header_t *compose_path = apr_array_make(pool, 2,
> > +						    sizeof(const char *));
> 
> The above line contains tabs, please replace with spaces.
> And make sure to align function arguments like this (not sure if
> they appeared aligned in your editor or not):

Fixed.

> > +  if (pb) {
> 
> I've told you this on IRC before, but just for sake of completeness:
> Virtually all if blocks and loops in this patch have a "wrong" style
> of indentation.
> See
> http://subversion.apache.org/docs/community-guide/conventions.html#coding-style
> 
> (I personally prefer the indentation style you're using,
> but the project convention has been set looooong ago -- such is life.)

Ah, I missed this earlier- you have an svn-dev.el: I'll use it to fix
everything before re-submitting.

> > +    APR_ARRAY_PUSH(compose_path, const char *) = "/";
> > +    APR_ARRAY_PUSH(compose_path, const char *) = path;
> > +    full_path = svn_path_compose(compose_path, pool);
> 
> See svn_dirent_join_many().

Fixed.

> > +  }
> > +  else
> > +    full_path = apr_pstrdup(pool, "/");
> 
> Why allocate "/" in a pool? This can be static string unless you
> intend to write to it.

Frankly, working with APR pools was quite a nightmare for me- after
observing many cases of leaks and crashes, I jotted down some notes
about using them and I made it a point to follow them strictly. This
alloc adheres to those notes. I'll submit those notes to dev@ once
I've polished them- new devs will probably find it useful.

> > +/*
> > + * Write out a node record for PATH of type KIND under EB->FS_ROOT.
> > + * ACTION describes what is happening to the node (see enum svn_node_action).
> > + * Write record to writable EB->STREAM, using EB->BUFFER to write in chunks.
> > + *
> > + * If the node was itself copied, IS_COPY is TRUE and the
> > + * path/revision of the copy source are in CMP_PATH/CMP_REV.  If
> > + * IS_COPY is FALSE, yet CMP_PATH/CMP_REV are valid, this node is part
> > + * of a copied subtree.
> 
> Again, s/CMP/COPYFROM/

Fixed.

> > + */
> > +static svn_error_t *
> > +dump_node(struct dump_edit_baton *eb,
> > +          const char *path,    /* an absolute path. */
> > +          svn_node_kind_t kind,
> > +          enum svn_node_action action,
> > +          const char *cmp_path,
> > +          svn_revnum_t cmp_rev,
> > +          apr_pool_t *pool)
> > +{
> > +  /* Write out metadata headers for this file node. */
> 
> The node might as well be a directory, so the above comment is misleading.

Fixed.

> > +  /* Remove leading slashes from copyfrom paths. */
> > +  if (cmp_path)
> > +    cmp_path = ((*cmp_path == '/') ? cmp_path + 1 : cmp_path);
> 
> What if the copyfrom path is "/"?
> (If memory serves me right we've had a bug like this before somewhere...)

Right, I copied this out from somewhere I think. Fixed with:
if (copyfrom_path && strcmp(copyfrom_path, "/"))

> > +
> > +  switch (action) {
> > +    /* Appropriately handle the four svn_node_action actions */
> 
> Nuke the above comment. Don't put numbers that may change some day
> into comments.

Okay. Fixed.

> > +    if (!eb->is_copy) {
> > +      /* eb->dump_props_pending for files is handled in
> > +         close_file which is called immediately.
> > +         However, directories are not closed until
> > +         all the work inside them have been done;
> 
> s/have been/has been/

Fixed.

> > +         eb->dump_props_pending for directories is
> > +         handled in all the functions that can
> > +         possibly be called after add_directory:
> > +         add_directory, open_directory,
> > +         delete_entry, close_directory, add_file,
> > +         open_file and change_dir_prop;
> > +         change_dir_prop is a special case
> > +         ofcourse */
> 
> Please re-format the above using longer lines (up to column 78).

Fixed.

> > +static svn_error_t *open_root(void *edit_baton,
> > +			      svn_revnum_t base_revision,
> > +			      apr_pool_t *pool,
> > +			      void **root_baton)
> 
> tabs in above 3 lines

Fixed.

> > +{
> > +  /* Allocate a special pool for the edit_baton to avoid pool
> > +     lifetime issues */
> 
> I think you don't need this comment because this is already
> sort of documented in the docstring for open_root() in svn_delta.h.

It took me a while to grasp this even after reading the documentation
of open_root, and I think others will find it useful. Didn't remove
comment.

> > +  if (val)
> > +    /* Delete the path, it's now been dumped */
> > +    apr_hash_set(pb->deleted_entries, path, APR_HASH_KEY_STRING, NULL);
> 
> You don't need to set the value to NULL in the hash table.
> Doing so won't save any memory. I've say just remove the above 3 lines.

Oh, I'm not doing it to save memory. Although I'm not sure if I still
need it in my logic, this definitely makes debugging nicer.

> tabs again in the above line

Fixed.

> > +    APR_ARRAY_PUSH(compose_path, const char *) =
> > +	    svn_relpath_basename(path, pool);
> 
> and here is another tab 

Fixed.

> > +    cmp_path = svn_path_compose(compose_path, pool);
> 
> Again, see svn_dirent_join_many().
> If you need a svn_relpath_join_many() for some reason please write one.

Fixed. Yes, svn_relpath_join_many sounds like a good idea: I'll mark
that as a TODO for now.

> > +static svn_error_t *
> > +close_directory(void *dir_baton,
> > +                apr_pool_t *pool)
> > +{
> > +  struct dir_baton *db = dir_baton;
> > +  struct dump_edit_baton *eb = db->eb;
> > +  apr_hash_index_t *hi;
> > +  apr_pool_t *subpool = svn_pool_create(pool);
> 
> Please call this iterpool, not subpool.
> You're using it in a loop (so we prefer "iteration pool").

Right. Fixed.

> > +
> > +  /* Some pending properties to dump? */
> > +  SVN_ERR(dump_props(eb, &(eb->dump_props_pending), TRUE, pool));
> > +
> > +  /* Dump the directory entries */
> > +  for (hi = apr_hash_first(pool, db->deleted_entries); hi;
> > +       hi = apr_hash_next(hi)) {
> > +    const void *key;
> > +    const char *path;
> > +    apr_hash_this(hi, &key, NULL, NULL);
> > +    path = key;
> 
> See svn__apr_hash_index_key().

TODO.

> > +  apr_array_header_t *compose_path = apr_array_make(pool, 2,
> > +						    sizeof(const char *));
> 
> tabs

Fixed.

> > +  /* If the parent directory has explicit comparison path and rev,
> 
> s/comparison/copyfrom/

Fixed.

> > +     record the same for this one. */
> > +  if (pb && ARE_VALID_COPY_ARGS(pb->cmp_path, pb->cmp_rev)) {
> > +    APR_ARRAY_PUSH(compose_path, const char *) = pb->cmp_path;
> > +    APR_ARRAY_PUSH(compose_path, const char *) =
> > +	    svn_relpath_basename(path, pool);
> 
> one more tab

Fixed.

> > +  /* Write information about the filepath to hb->eb */
> 
> s/to hb->eb/from the handler baton to the edit baton/

Er, I did mean `hb->eb` literally (the editor baton in the handler
baton).

> > +  /* Cleanup */
> > +  SVN_ERR(svn_io_file_close(hb->temp_file, hb->pool));
> 
> As described above, you don't need to close the file,
> closing the stream is enough.

TODO.

> > +  /* Custom handler_baton allocated in a separate pool */
> > +  apr_pool_t *handler_pool = svn_pool_create(pool);
> > +  struct handler_baton *hb = apr_pcalloc(handler_pool, sizeof(*hb));
> > +  hb->pool = handler_pool;
> 
> It sucks that the window handler does not get pool arguments, so
> you have to stick a pool in the baton. But that isn't your fault.

Exactly.

> > +  hb->eb = eb;
> > +
> > +  /* Use a temporary file to measure the text-content-length */
> > +  SVN_ERR(svn_io_temp_dir(&tempdir, hb->pool));
> > +
> > +  hb->temp_filepath = svn_dirent_join(tempdir, "XXXXXX", hb->pool);
> > +  apr_err = apr_file_mktemp(&(hb->temp_file), hb->temp_filepath,
> > +          APR_CREATE | APR_READ | APR_WRITE | APR_EXCL,
> > +          hb->pool);
> > +  if (apr_err != APR_SUCCESS)
> > +    SVN_ERR(svn_error_wrap_apr(apr_err, NULL));
> 
> You can replace the above chunk with a simple call to
> svn_io_open_unique_file3().

TODO. If I recall correctly, someone else also suggested this on IRC,
but there seems to be some issue with it: I'll check this later.

> > +    SVN_ERR(svn_io_file_open(&temp_file, eb->temp_filepath,APR_READ,
> > +			     0600,pool));
> 
> tabs again

Fixed.

> > +  struct dump_edit_baton *eb = apr_pcalloc(pool,
> > +					   sizeof(struct dump_edit_baton));
> 
> more tabs

Fixed.

> > +static int verbose = 0;
> > +static apr_pool_t *pool = NULL;
> > +static svn_client_ctx_t *ctx = NULL;
> 
> You're only using the client context in open_connection.
> Make it a local variable there?

I was actually worried about lifetime issues. If ctx won't be read/
written after open_connection, this is okay. Otherwise, not. TODO.

> > +  struct replay_baton *replay_baton = apr_palloc(pool,
> > +						 sizeof(struct replay_baton));
> 
> more tabs

Fixed.

> > +  fprintf(out_stream,
> 
> Use svn_cmdline_fprintf()

Fixed.

> > +    "usage: svnrdump URL [-r LOWER[:UPPER]]\n\n"
> 
> This string needs to be marked for localisation like this: _("my string")

TODO. I'm missing some header: _ is undefined.

> > +    "Dump the contents of repository at remote URL to stdout in a 'dumpfile'\n"
> > +    "v3 portable format.  Dump revisions LOWER rev through UPPER rev.\n"
> 
> You don't need to mention the dumpfile format version in the help
> string.

Okay. I need to mention somewhere that svnrdump doesn't support
undeltified dumps though, don't I?

> > +    "LOWER defaults to 1 and UPPER defaults to the highest possible revision\n"
> > +    "if omitted.\n");
> > +  for (i = 1; i < argc; i++) {
> 
> Please use svn_cmdline__getopt_init() and apr_getopt_long().
> See svnsync for an example.

Ouch. Don't you think it's an overkill for the current svnrdump? There
are no subcommands and just a few command-line arguments.

> Please add a docstring.
> 
> > +void
> > +write_hash_to_stringbuf(apr_hash_t *properties,
> > +                        svn_boolean_t deleted,
> > +                        svn_stringbuf_t **strbuf,
> > +                        apr_pool_t *pool);
> > +

Fixed.

> Please add a docstring.
> 
> > +svn_error_t *
> > +dump_props(struct dump_edit_baton *eb,
> > +           svn_boolean_t *trigger_var,
> > +           svn_boolean_t dump_data_too,
> > +           apr_pool_t *pool);
> > +
> > +#endif

Fixed. Doxygen-friendly docstrings are a TODO.

> > +#include "svn_pools.h"
> > +#include "svn_cmdline.h"
> > +#include "svn_client.h"
> > +#include "svn_ra.h"
> > +#include "svn_repos.h"
> 
> Are all these includes really needed?

It seems only svn_repos.h is needed. Fixed.

> > +void
> > +write_hash_to_stringbuf(apr_hash_t *properties,
> > +                        svn_boolean_t deleted,
> > +                        svn_stringbuf_t **strbuf,
> > +                        apr_pool_t *pool)
> > +{
> 
> This function needs a docstring, too.

Wait. I just need to write the docstrings once, right? In the header?

> And is there no function that already does this somewhere in the svn
> libraries or in APR?

No. I copied this out from subversion/svnrdump/svnrdump.c and
refactored it a little bit.

You can see the changes I made after your review in the most recent
couple of commits on my GitHub [1].

[1]: http://github.com/artagnon/svn-dump-fast-export/commits/svn-merge

-- Ram
