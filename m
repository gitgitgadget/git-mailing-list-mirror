From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH 1/5] revision caching documentation: man page and technical
 discussion
Date: Fri, 07 Aug 2009 15:08:58 +1200
Message-ID: <4A7B9ACA.1060601@vilain.net>
References: <op.ux8i6lq9tdk399@sirnot.private>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Andreas Ericsson <exon@op5.se>,
	Christian Couder <christian@couder.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Nick Edelen <sirnot@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 07 05:09:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZFpk-0001Z3-Hq
	for gcvg-git-2@gmane.org; Fri, 07 Aug 2009 05:09:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756924AbZHGDJW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 23:09:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756769AbZHGDJW
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 23:09:22 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:56122 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756767AbZHGDJV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2009 23:09:21 -0400
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id 9A16021C4F3; Fri,  7 Aug 2009 15:09:04 +1200 (NZST)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id 3493821C44B;
	Fri,  7 Aug 2009 15:08:59 +1200 (NZST)
User-Agent: Mozilla-Thunderbird 2.0.0.19 (X11/20090103)
In-Reply-To: <op.ux8i6lq9tdk399@sirnot.private>
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125167>

Nick Edelen wrote:
> Before any code is introduced the full documentation is put forth.  This 
> provides a man page for the porcelain, and a technical doc in technical/.  The 
> latter describes the API, and discusses rev-cache's design, file format and 
> mechanics.
>
> Signed-off-by: Nick Edelen <sirnot@gmail.com>
>
> ---
>  Documentation/rev-cache.txt           |   51 +++++
>  Documentation/technical/rev-cache.txt |  336 +++++++++++++++++++++++++++++++++
>  2 files changed, 387 insertions(+), 0 deletions(-)
>   

A couple of minor nits here:

1. Documentation/rev-cache.txt should be
Documentation/git-rev-cache.txt, because it documents that command.

2. there are many whitespace errors:

wilber:~/src/git$ git am \[PATCH\ 1_5\]\ revision\ caching\
documentation\:\ man\ page\ and\ technical\ discussion.eml
Applying: revision caching documentation: man page and technical discussion
/home/samv/src/git/.git/rebase-apply/patch:15: trailing whitespace.
A front end for the rev-cache API is provided with the builtin utility
/home/samv/src/git/.git/rebase-apply/patch:16: trailing whitespace.
`rev-cache`.  It is mainly intended for cache slice generation and
maintenance,
/home/samv/src/git/.git/rebase-apply/patch:17: trailing whitespace.
but can also walk commits within a slice.  At the moment it is not
particularly
/home/samv/src/git/.git/rebase-apply/patch:34: trailing whitespace.
`\--stdin`:: Also read commit ids from stdin (seperated by newline,
`\--not`
/home/samv/src/git/.git/rebase-apply/patch:51: trailing whitespace.
`\--all`:: Include all objects in repository.  Will only traverse as of
cache
warning: squelched 166 whitespace errors
warning: 171 lines add whitespace errors.

Be sure to check the patch doesn't do that...

> diff --git a/Documentation/rev-cache.txt b/Documentation/rev-cache.txt
> new file mode 100755
> index 0000000..64bd051
> --- /dev/null
> +++ b/Documentation/rev-cache.txt
> @@ -0,0 +1,51 @@
> +rev-cache porcelain
> +===================
> +
> +A front end for the rev-cache API is provided with the builtin utility 
> +`rev-cache`.  It is mainly intended for cache slice generation and maintenance, 
> +but can also walk commits within a slice.  At the moment it is not particularly 
> +advanced, but is sufficient for repository administration.
>   

That last sentence is a bit unnecessarily self-doubting; "It currently
provides basic functionality" would be fine.

> +
> +It's general syntax is:
> +
> +`git-rev-cache COMMAND [options] [<commit-id>...]`
> +
> +With the commands:
>   

You should use the same structure and headings of this file as the other
man pages which are found under Documentation/git-*.txt

> +
> +`add`::
> +	Add revisions to the cache.  Reads commit ids from stdin, formatted as:
> +	`END END ... \--not START START ...`
>   

Really, it's reading a revision list; might be better to call it that. 
Can it accept the same options as git-rev-list here or just a list of
starting points/tips?  And "END" and "START" are still backwards to the
rest of git core!

> ++
> +Options:
> +
> +`\--all`:: Include all heads as ends.
> +`\--fresh`:: Exclude everything already in a cache slice.
>   

If you use the paragraph layout used by other commands you can explain a
little bit more about what you mean here.  By "Cache Slice" do you mean
"Revision Cache"?  Does that --fresh imply that all of the revisions
which were not indexed will automatically get indexed?

> +`\--stdin`:: Also read commit ids from stdin (seperated by newline, `\--not` 
> +also valid).
> +`\--legs`:: Ensure branch has no "dangling" starts (ie. is self-contained).
>   

The --legs term is a little too 'cute', is there a better way to
describe this?  And "starts" is not a real word in that context; if you
are using a technical term, you should define it..

> +`\--noobjects`:: Don't include non-commit objects.
> +
> +`walk`::
> +	Walk a cache slice based on set of commits; formatted as add.
>   

So, this works like 'rev-list' ?

"Formatted" is wrong there I think; do you mean it 'accepts the same
arguments as add' ?

> ++
> +Options:
> +
> +`\--objects`:: Include non-commit objects in traversal.
> +
>   

Which was the default?  --objects or --no-objects?

> +`fuse`::
> +	Coagulate several cache slices into a single large slice.
>   

Coagulate?  You mean, the revision caches will stop being liquid and go
gluggy, like a pool of blood clotting?

How about "combine" :-) - and the option might be better called
something simple like that, too.

> ++
> +Options:
> +
> +`\--all`:: Include all objects in repository.  Will only traverse as of cache 
> +ends if this is not specified.
>   

That sentence doesn't quite read well to me.

> +`\--noobjects`:: Don't include non-commit objects.
> +`\--ignore-size[=N]`:: Do not fuse slices of file size >= `N`.  If `N` is not 
> +given the cutoff size defaults to ~5MB.
> +
> +`index`::
> +	Regenerate the cache index.
> +
> +
> +For an explanation of the API and its inner workings, see 
> +link:technical/rev-cache.txt[technical info on rev-cache]
> diff --git a/Documentation/technical/rev-cache.txt b/Documentation/technical/rev-cache.txt
> new file mode 100755
> index 0000000..e95ec89
> --- /dev/null
> +++ b/Documentation/technical/rev-cache.txt
> @@ -0,0 +1,336 @@
> +rev-cache
> +=========
> +
> +The revision cache API ('rev-cache') provides a method for efficiently storing 
> +and accessing commit branch sections.  Such branch slices are defined by a 
> +series of top (interesting) and bottom (uninteresting) commits.  Each slice 
> +contains, per commit:
> +
> +* All intra-slice topological relations, encoded into path "channels" (see 
> +  'Mechanics' for full explanation).
> +* Object meta-data: type, SHA-1, size, date (for commits).
> +* Objects introduced in that commit, relative to slice (ie. only for non-start 
> +  commits).
> +
> +Storage data structures are not exported, in part to keep git's global scope 
> +clean, but largely because they're pretty much useless outside of rev-cache.
> +
> +The API
> +-------
> +
> +The API for 'rev-cache' is quite simple.  You can find the function prototypes 
> +in `revision.h`.
> +
> +Data Structures
> +~~~~~~~~~~~~~~~
> +
> +The `rev_cache_info` struct holds all the options and flags for the API.
> +
> +----
> +struct rev_cache_info {
> +        /* generation flags */
> +        unsigned objects : 1, 
> +                legs : 1, 
> +                make_index : 1;
> +        
> +        /* traversal flags */
> +        unsigned save_unique : 1, 
> +                add_to_pending : 1;
> +        
> +        /* fuse options */
> +        unsigned int ignore_size;
> +};
> +----
> +
> +The fields:
> +
> +`objects`:: Add non-commit objects to slice.
> +`legs`:: Ensure bottoms have no childrens.
>   

"children" is already plural and needs no 's'

> +`make_index`:: Integrate newly-made slice into index.
> +`save_unique`:: Load unique non-commit objects into `unique` field of each 
> +`commit` object.
>   

Unique how?  Do you mean, that they were introduced in this slice and
not reachable from any of the bottom/end commits?

> +`add_to_pending`:: Append unique non-commit objects to the `pending` object 
> +list in the passed `rev_info` instance.
>   

That doesn't make much sense to me either.  What does that mean?  Well,
I'll read on.

> +`ignore_size`:: If non-zero, ignore slices with size greater or equal to this.
>   

What will this ignoring mean?

> +Functions
> +~~~~~~~~~
> +
> +`init_rci`::
> +
> +        Initiate a `rev_cache_info` struct to default options.  
> +
> +`make_cache_slice`::
> +
> +        Create a cache based on an a `rev_info` instance or `commit_list` s of 
> +        "tops" and "bottoms" (defaulting to latter if `rev_info` pointer is 
> +        NULL), copying the cache SHA-1 into a passed pointer if non-zero.  A 
> +        `rev_cache_info` struct pointer can be passed to set options, while 
> +        passing NULL will set default options.  A last parameter can 
> +        optionally recieve the final cache hash.
> +
> +`make_cache_index`::
> +
> +        Add a slice to the cache index.  Requires a file descriptor, the cache 
> +        hash and the file size.  Note that this is normally called by 
> +        `make_cache_slice` under the `make_index` option.
> +
> +`get_cache_slice`::
> +
> +        Given a commit SHA-1 `get_cache_slice` will search the slice index and 
> +        return, if found, the cache-identifying SHA-1.
> +
> +`traverse_cache_slice`::
> +
> +        Traverse a specified cache slice based on:
> +
> +        * `rev_cache_info` instance (optional)
> +        * cache SHA-1 identifier
> +        * `rev_info` instance
> +        * a starting commit and commit work list
> +        * date of oldest encountered interesting commit
> +        * current `slop` (this and above mainly used in integration with 
> +          revision walker)
>   

Hmm what's a 'slop' ?

> +        
> ++
> +The output is sent to a FILO `commit_list` "queue", while any bottom commits 
> +are passed back into the work list.  If the walk is not contained within the 
> +slice, commit boundaries are also inserted into "work".
> +
> +`tops_from_slices`::
> +
> +        Will mark all top-commits in the specified cache slices with a given 
> +        flag, and add them to the rev pending list.  Will include all if no 
> +        slices are specified.
> +
> +`coagulate_cache_slices`::
> +
> +        Generate a slice based on the passed `rev_info` instance, replacing all 
> +        encountered slices with one (larger) slice.  The `ignore_size` field in 
> +        `rci`, if non-zero, will dictate which cache slice sizes to ignore in 
> +        both traversal and replacement.
> +
> +`regenerate_index`::
> +
> +        Remake cache index.
> +
> +Example Usage
> +-------------
> +
> +A few examples to demonstrate usage:
> +
> +.Creating a slice
> +----
> +/* pretend you're a porcelain for rev-cache reading from the command line */
> +struct rev_info revs;
> +struct rev_cache_info rci;
> +
> +init_revisions(&revs, 0);
> +init_rci(&rci);
> +
> +flags = 0;
> +for (i = 1; i < argc; i++) {
> +        if (!strcmp(argv[i], "--not"))
> +                flags ^= UNINTERESTING;
> +        else if(!strcmp(argv[i], "--fresh"))
> +                starts_from_slices(&revs, UNINTERESTING, 0, 0);
> +        else
> +                handle_revision_arg(argv[i], &revs, flags, 1);
> +}
> +
> +/* we want to explicitly set certain options */
> +rci.objects = 0;
> +
> +if (!make_cache_slice(&rci, &revs, 0, 0, cache_sha1))
> +        printf("made slice!  it's called %s\n", sha1_to_hex(cache_sha1));
>   

Heh, normally it's acceptable to let examples in documentation not be
complete working programs :)

> +----
> +
> +.Traversing a slice
> +----
> +/* let's say you're walking the tree with a 'work' list of current heads and a 
> + * FILO output list 'out' */
> +out = 0;
> +outp = &out;
> +
> +while (work) {
> +        struct commit *commit = pop_commit(&work);
> +        struct object *object = &commit->object;
> +        unsigned char *cache_sha1;
> +        
> +        if (cache_sha1 = get_cache_slice(object->sha1)) {
> +                /* note that this will instatiate any topo-relations 
> +                 * as it goes */
> +                if (traverse_cache_slice(&revs, cache_sha1, 
> +                        commit, 0, 0, /* use defaults */
> +                        &outp, &work) < 0)
> +                        die("I'm overreacting to a non-fatal cache error");
> +        } else {
> +                struct commit_list *parents = commit->parents;
> +                
> +                while (parents) {
> +                        struct commit *p = parents->item;
> +                        struct object *po = &p->object;
> +                        
> +                        parents = parents->next;
> +                        if (po->flags & UNINTERESTING)
> +                                continue;
> +                        
> +                        if (object->flags & UNINTERESTING)
> +                                po->flags |= UNINTERESTING;
> +                        else if (po->flags & SEEN)
> +                                continue;
> +                        
> +                        if (!po->parsed)
> +                                parse_commit(p);
> +                        insert_by_date(p, &work);
> +                }
> +                
> +                if (object->flags & (SEEN | UNINTERESTING) == 0)
> +                        outp = &commit_list_insert(commit, outp);
> +                object->flags |= SEEN;
> +        }
> +}
> +----
>   

Ok, good - perhaps needs a comment or two - not much, it's already long.

> +
> +Some Internals
> +--------------
> +
> +Although you really don't need to know anything about how rev-cache actually 
> +does its magic shizz, a bit of background may go a long way if you're wading 
> +through the source.
>   

"does its work" will do nicely..

> +
> +File Formats
> +~~~~~~~~~~~~
> +
> +A slice has a basic fixed-size header, followed by a certain number of object 
> +entries.  Commits are sorted in topo-order, and each commit entry is followed 
> +by the objects added in that commit.
>   

Starting from the top or the bottom?  And it might pay to clarify which
objects are included or not; ie objects reachable from "bottom" commits
or not.

> +
> +----
> +         -- +--------------------------------+
> +header      | object number, etc...          |
> +         -- +--------------------------------+
> +commit      | commit info                    |
> +entry       | path data                      |
> +            +--------------------------------+
> +            | tree/blob info                 |
> +            +--------------------------------+
> +            | tree/blob info                 |
> +            +--------------------------------+
> +            | ...                            |
> +         -- +--------------------------------+
> +commit      | commit info                    |
> +entry       | path data                      |
> +            +--------------------------------+
> +            | tree/blob info                 |
> +            +--------------------------------+
> +            | ...                            |
> +         -- +--------------------------------+
> +...         ...                               
> +            +--------------------------------+
> +----
> +
> +The index is somewhat similar to pack-file indexes, containing a fanout table 
> +and a list of index entries sorted by hash.
> +
> +----
> +         -- +--------------------------------+
> +header      | object #, cache #, etc.        |
> +         -- +--------------------------------+
> +cache       | SHA-1                          |
> +sha1s       | ...                            |
> +         -- +--------------------------------+
> +fanout      | fanout[0x00]                   |
> +table       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +            | fanout[0xff]                   |
> +         -- +--------------------------------+
> +index       | entry SHA-1                    |
> +entries     | cache sha1 index               |
> +            +--------------------------------+
> +            |                                |
> +            ...                               
> +            +--------------------------------+
> +----
> +
> +All the relavant structures are readily accessible in `rev-cache.c`
> +
>   

Ok right so which is the on-disk container format?  The index or the
slice?  I'm a little confused..

> +Mechanics
> +~~~~~~~~~
> +
> +The most important part of rev-cache is its method of encoding topological 
> +relations.  To ensure fluid traversal and reconstruction,

Is it still fluid after coagulation?  ;-)

>  commits are related 
> +through high-level "streams"/"channels" rather than individual 
> +interconnections.  Intuitively, rev-cache stores history the way gitk shows it: 
> +commits strung up on lines, which interconnect at merges and branches.
> +
> +Each commit is associated to a given channel/path via a 'path id', and 
> +variable-length fields govern which paths (if any) are closed or opened at that 
> +object.  This means that topo-data can be preserved in only a few bytes extra 
> +per object entry.  Other information stored per entry is the sha-1 hash, type, 
> +date, size, and status in cache slice.  Here is format of an object entry, both 
> +on-disk and in-memory:
> +
> +----
> +struct object_entry {
> +        unsigned type : 3;
> +        unsigned is_end : 1;
> +        unsigned is_start : 1;
> +        unsigned uninteresting : 1;
> +        unsigned include : 1;
> +        unsigned flags : 1;
> +        unsigned char sha1[20];
> +        
> +        unsigned merge_nr : 6;
> +        unsigned split_nr : 7;
> +        unsigned size_size : 3;
> +        
> +	uint32_t date;
> +	uint16_t path;
> +        
> +        /* merge paths */
> +        /* split paths */
> +        /* size */
> +};
> +----
> +
> +An explanation of each field:
> +
> +`type`:: Object type
> +`is_end`:: The commit has some parents outside the cache slice (all if slice 
> +has legs)
> +`is_start`:: The commit has no children in cache slice
> +`uninteresting`:: Run-time flag, used in traversal
> +`include`:: Run-time flag, used in traversal (initialization)
> +`flags`:: Currently unused, extra bit
> +`sha`:: Object SHA-1 hash
> +
> +`merge_nr`:: The number of paths the current channel diverges into; the current 
> +path ends upon any merge.
> +`split_nr`:: The number of paths this commit ends; used on both merging and 
> +branching.
> +`size_size`:: Number of bytes the object size takes up.
> +
> +merge paths:: The path IDs (16-bit) that are to be created.
> +split paths:: The path IDs (16-bit) that are to be ended.
> +size:: The size split into the minimum number of bytes.
> +
> +Each path ID refers to an index in a 'path array', which stores the current 
> +status (eg. active, interestingness) of each channel.
> +
> +Due to topo-relations and boundary tracking, all of a commit's parents must be 
> +encountered before the path is reallocated.  This is achieved by using a 
> +counter system per merge: starting at the parent number, the counter is 
> +decremented as each parent is encountered (dictated by 'split paths'); at 0 the 
> +path is cleared.
> +
> +Boundary tracking is necessary because non-commits are stored relative to the 
> +commit in which they were introduced.  If a series of commits is not included 
> +in the output, the last interesting commit must be parsed manually to ensure 
> +all objects are accounted for.
> +
> +To prevent list-objects from recursing into trees that we've already taken care 
> +of, the flag `FACE_VALUE` is introduced.  An object with this flag is not 
> +explored (= "taken at face value"), significantly reducing I/O and processing 
> +time.
> +
> +(NSE)
>   

tl;dr but that's ok it's magic shizz.

Anyway looking nice ... see what I can say about the next patches.

sam
