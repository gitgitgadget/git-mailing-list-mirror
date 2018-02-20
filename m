Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70DA71F404
	for <e@80x24.org>; Tue, 20 Feb 2018 22:57:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751511AbeBTW5r (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Feb 2018 17:57:47 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:39845 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750998AbeBTW5p (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Feb 2018 17:57:45 -0500
Received: by mail-wr0-f194.google.com with SMTP id w77so18931001wrc.6
        for <git@vger.kernel.org>; Tue, 20 Feb 2018 14:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=UpHsIkpioDw/7Y1zqI42lNyrfMC52WHgxf+uBRVRfzs=;
        b=iZJRK8s69D3nHpnU9UV5OX4Za2PXI5X6DOTAxGbxg+g/6reB61aLTbpLU9eQTZzgLO
         ODwE+W8nlEWZVDyNk9Yhdwodku3spouPEV9JtsbUI38XUrL76+AcMZSdaiNj73lQ3y4d
         LEmxymXx9SKpL4DvmBwbag2tiFnLrpuV6evRueV5EWC0IdGGhAP8g79dj5bwkAipSYz5
         06/ACNjlt3/6guAtdQiHhYnlyRSHH/6B/jCmDevqJ0CRFMr6yN/CWql4XitlxCWiYgos
         eTm2qJP20B39kNETp/fdkSE4dd1yOHFSaTns/6ELPmOPgEIJYmkd4b0g2TDGzsxVRkbe
         LgOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=UpHsIkpioDw/7Y1zqI42lNyrfMC52WHgxf+uBRVRfzs=;
        b=goESX5TJaNORhBKLC+DxTSdvarXurAX5psN95iykW3PhraLJXC9I7jZEzUm344gB5J
         aWxacAjE3FT4o+yWtHUbT8GQk828HaJdbwKibow+hsnHEYRfGnyXXcLk93M/skkTELIZ
         CwuISSTfOeJ8ZuugxHt5kvD+v0C3vMcJOO57GB/sG0kz9HaugrtkQ7OnWdr5w3pJUs0F
         WkLQY/+tb2mXJ1jroVvv/NLrYJbrH4zPTWXBpZRk1VDclz+AyXD9svgAGeWNVg+JpRv8
         SPBFA8jr3VE9a+J8Jkc20cAM7/B00lj99x9ZkJ7Qsc+E9C/bCfXd4eta7kP0RZO5x4ac
         mGDg==
X-Gm-Message-State: APf1xPDwuJSb4RWhgzFBmvt1DhoVSR1fHh6rWax/k0tQwystvCKzToZE
        GeUjUzeHm62lbdh7ez839ns=
X-Google-Smtp-Source: AH8x226+VoaeWjetMAjXwEKE1tDtlcT9lRTUVe7RUzwpHkA78+n9ft2Rdm7MBzaoIBX8l203PDNi5w==
X-Received: by 10.223.178.232 with SMTP id g95mr1094140wrd.35.1519167464020;
        Tue, 20 Feb 2018 14:57:44 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id x203sm55508242wmd.11.2018.02.20.14.57.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Feb 2018 14:57:43 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com, peff@peff.net,
        jonathantanmy@google.com, szeder.dev@gmail.com, sbeller@google.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v4 04/13] commit-graph: implement write_commit_graph()
References: <4d1ee202-7d79-d73c-6e05-d0fc85db943c@gmail.com>
        <1519066406-81663-1-git-send-email-dstolee@microsoft.com>
        <1519066406-81663-5-git-send-email-dstolee@microsoft.com>
Date:   Tue, 20 Feb 2018 14:57:42 -0800
In-Reply-To: <1519066406-81663-5-git-send-email-dstolee@microsoft.com>
        (Derrick Stolee's message of "Mon, 19 Feb 2018 13:53:17 -0500")
Message-ID: <xmqqmv031d7d.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> +#define GRAPH_OID_VERSION_SHA1 1
> +#define GRAPH_OID_LEN_SHA1 20

This hardcoded 20 on the right hand side of this #define is probably
problematic.   Unless you are planning to possibly store truncated
hash value for some future hash algorithm, GRAPH_OID_LEN_$HASH should
always be the same as GIT_$HASH_RAWSZ, I would think.  IOW

    #define GRAPH_OID_LEN_SHA1 GIT_SHA1_RAWSZ

perhaps?

> +static void write_graph_chunk_fanout(struct sha1file *f,
> +				     struct commit **commits,
> +				     int nr_commits)
> +{
> +	uint32_t i, count = 0;
> +	struct commit **list = commits;
> +	struct commit **last = commits + nr_commits;
> +
> +	/*
> +	 * Write the first-level table (the list is sorted,
> +	 * but we use a 256-entry lookup to be able to avoid
> +	 * having to do eight extra binary search iterations).
> +	 */
> +	for (i = 0; i < 256; i++) {
> +		while (list < last) {
> +			if ((*list)->object.oid.hash[0] != i)
> +				break;
> +			count++;
> +			list++;
> +		}

If count and list are always incremented in unison, perhaps you do
not need an extra variable "last".  If typeof(nr_commits) is wider
than typeof(count), this loop and the next write-be32 is screwed
anyway ;-)

This comment probably applies equally to some other uses of the same
"compute last pointer to compare with running pointer for
termination" pattern in this patch.

> +		sha1write_be32(f, count);
> +	}
> +}

> +static int commit_pos(struct commit **commits, int nr_commits,
> +		      const struct object_id *oid, uint32_t *pos)
> +{

It is a bit unusual to see something_pos() that returns an integer
that does *NOT* return the position as its return value.  Dropping
the *pos parameter, and returning "mid" when commits[mid] is what we
wanted to see, and otherwise returning "-1 - first" to signal the
position at which we _would_ have found the object, if it were in
the table, would make it more consistent with the usual convention.

Don't we even have such a generalized binary search helper already
somewhere in the system?

> +static void write_graph_chunk_data(struct sha1file *f, int hash_len,
> +				   struct commit **commits, int nr_commits)
> +{
> +	struct commit **list = commits;
> +	struct commit **last = commits + nr_commits;
> +	uint32_t num_large_edges = 0;
> +
> +	while (list < last) {
> +		struct commit_list *parent;
> +		uint32_t int_id;
> +		uint32_t packedDate[2];
> +
> +...
> +		if (!parent)
> +			int_id = GRAPH_PARENT_NONE;
> +		else if (parent->next)
> +			int_id = GRAPH_LARGE_EDGES_NEEDED | num_large_edges;
> +		else if (!commit_pos(commits, nr_commits,
> +				    &(parent->item->object.oid), &int_id))
> +			int_id = GRAPH_PARENT_MISSING;
> +
> +		sha1write_be32(f, int_id);
> +
> +		if (parent && parent->next) {

This is equivalent to checking "int_id & GRAPH_LARGE_EDGES_NEEDED",
right?  Not suggesting to use the other form of checks, but trying
to see what's the best way to express it in the most readable way.

> +			do {
> +				num_large_edges++;
> +				parent = parent->next;
> +			} while (parent);

It feels somewhat wasteful to traverse the commit's parents list
only to count, without populating the octopus table (which I
understand is assumed to be minority case under this design).

> +		}
> +
> +		if (sizeof((*list)->date) > 4)
> +			packedDate[0] = htonl(((*list)->date >> 32) & 0x3);
> +		else
> +			packedDate[0] = 0;

OK, the undefined pattern in the previous round is now gone ;-)  Good.

> +		packedDate[1] = htonl((*list)->date);
> +		sha1write(f, packedDate, 8);
> +
> +		list++;
> +	}
> +}
> +
> +static void write_graph_chunk_large_edges(struct sha1file *f,
> +					  struct commit **commits,
> +					  int nr_commits)
> +{
> +	struct commit **list = commits;
> +	struct commit **last = commits + nr_commits;
> +	struct commit_list *parent;
> +
> +	while (list < last) {
> +		int num_parents = 0;
> +		for (parent = (*list)->parents; num_parents < 3 && parent;
> +		     parent = parent->next)
> +			num_parents++;
> +
> +		if (num_parents <= 2) {
> +			list++;
> +			continue;
> +		}
> +
> +		/* Since num_parents > 2, this initializer is safe. */
> +		for (parent = (*list)->parents->next; parent; parent = parent->next) {
> +			uint32_t int_id, swap_int_id;
> +			uint32_t last_edge = 0;
> +			if (!parent->next)
> +				last_edge |= GRAPH_LAST_EDGE;
> +
> +			if (commit_pos(commits, nr_commits,
> +				       &(parent->item->object.oid),
> +				       &int_id))
> +				swap_int_id = htonl(int_id | last_edge);
> +			else
> +				swap_int_id = htonl(GRAPH_PARENT_MISSING | last_edge);
> +			sha1write(f, &swap_int_id, 4);

What does "swap_" in the name of this variable mean?  For some
archs, there is no swap.  The only difference between int_id and the
variable is that its MSB may possibly be smudged with last_edge bit.

This is a tangent, but after having seen many instances of "int_id",
I started to feel that it is grossly misnamed.  We do not care about
its "int" ness---what's more significant about it is that we use can
it as a short identifier in place for a full object name, given the
table of known OIDs.  "oid_table_index" may be a better name (but
others may be able to suggest even better one).

	int pos;
	pos = commit_pos(commits, nr_commits, parent->item->object.oid);
	oid_table_pos = (pos < 0) ? GRAPH_PARENT_MISSING : pos;
	if (!parent->net)
		oid_table_pos |= GRAPH_LAST_EDGE;
	oid_table_pos = htonl(oid_table_pos);
	sha1write(f, &oid_table_pos, sizeof(oid_table_pos));

or something like that, perhaps?

> +static int commit_compare(const void *_a, const void *_b)
> +{
> +	struct object_id *a = (struct object_id *)_a;
> +	struct object_id *b = (struct object_id *)_b;
> +	return oidcmp(a, b);
> +}

I think oidcmp() takes const pointers, so there is no need to
discard constness from the parameter like this code does.  Also I
think we tend to prefer writing a_/b_ (instead of _a/_b) to appease
language lawyers who do not want us mere mortals to use names that
begin with underscore.

> +static int if_packed_commit_add_to_list(const struct object_id *oid,
> +					struct packed_git *pack,
> +					uint32_t pos,
> +					void *data)

That is a strange name.  "collect packed commits", perhaps?

> +char *write_commit_graph(const char *obj_dir)
> +{
> +	struct packed_oid_list oids;
> +	struct packed_commit_list commits;
> +	struct sha1file *f;
> +	int i, count_distinct = 0;
> +	DIR *info_dir;
> +	struct strbuf tmp_file = STRBUF_INIT;
> +	struct strbuf graph_file = STRBUF_INIT;
> +	unsigned char final_hash[GIT_MAX_RAWSZ];
> +	char *graph_name;
> +	int fd;
> +	uint32_t chunk_ids[5];
> +	uint64_t chunk_offsets[5];
> +	int num_chunks;
> +	int num_long_edges;
> +	struct commit_list *parent;
> +
> +	oids.nr = 0;
> +	oids.alloc = (int)(0.15 * approximate_object_count());

Heh, traditionalist would probably avoid unnecessary use of float
and use something like 1/4 or 1/8 ;-)  After all, it is merely a
ballpark guestimate.

> +	num_long_edges = 0;

This again is about naming, but I find it a bit unnatural to call
the edge between a chind and its octopus parents "long".  Individual
edges are not long--the only thing that is long is your "list of
edges".  Some other codepaths in this patch seems to call the same
concept with s/long/large/, which I found somewhat puzzling.

> +	for (i = 0; i < oids.nr; i++) {
> +		int num_parents = 0;
> +		if (i > 0 && !oidcmp(&oids.list[i-1], &oids.list[i]))
> +			continue;
> +
> +		commits.list[commits.nr] = lookup_commit(&oids.list[i]);
> +		parse_commit(commits.list[commits.nr]);
> +
> +		for (parent = commits.list[commits.nr]->parents;
> +		     parent; parent = parent->next)
> +			num_parents++;
> +
> +		if (num_parents > 2)
> +			num_long_edges += num_parents - 1;

OK, so we count how many entries we will record in the overflow
parent table, and...

> +
> +		commits.nr++;
> +	}
> +	num_chunks = num_long_edges ? 4 : 3;

... if we do not have any octopus commit, we do not need the chunk
for the overflow parent table.  Makes sense.

> +	strbuf_addf(&tmp_file, "%s/info", obj_dir);
> +	info_dir = opendir(tmp_file.buf);
> +
> +	if (!info_dir && mkdir(tmp_file.buf, 0777) < 0)
> +		die_errno(_("cannot mkdir %s"), tmp_file.buf);
> +	if (info_dir)
> +		closedir(info_dir);
> +	strbuf_addstr(&tmp_file, "/tmp_graph_XXXXXX");
> +
> +	fd = git_mkstemp_mode(tmp_file.buf, 0444);
> +	if (fd < 0)
> +		die_errno("unable to create '%s'", tmp_file.buf);

It is not performance critical, but it feels a bit wasteful to
opendir merely to see if something exists as a directory, and it is
misleading to the readers (it looks as if we care about what files
we already have in the directory).

The approach that optimizes for the most common case would be to

	- prepare full path to the tempfile first
	- try create with mkstemp
	  - if successful, you do not have to worry about creating
	    the directory at all, which is the most common case
        - see why mkstemp step above failed.  Was it because you
	  did not have the surrounding directory?
          - if not, there is no point continuing.  Just error out.
	  - if it was due to missing directory, try creating one.
	- try create with mkstemp
	  - if successful, all is well.
        - otherwise there isn't anything more we can do here.



> +
> +	f = sha1fd(fd, tmp_file.buf);
> +
> +	sha1write_be32(f, GRAPH_SIGNATURE);
> +
> +	sha1write_u8(f, GRAPH_VERSION);
> +	sha1write_u8(f, GRAPH_OID_VERSION);
> +	sha1write_u8(f, num_chunks);
> +	sha1write_u8(f, 0); /* unused padding byte */
> +
> +	chunk_ids[0] = GRAPH_CHUNKID_OIDFANOUT;
> +	chunk_ids[1] = GRAPH_CHUNKID_OIDLOOKUP;
> +	chunk_ids[2] = GRAPH_CHUNKID_DATA;
> +	if (num_long_edges)
> +		chunk_ids[3] = GRAPH_CHUNKID_LARGEEDGES;
> +	else
> +		chunk_ids[3] = 0;
> +	chunk_ids[4] = 0;
> +
> +	chunk_offsets[0] = 8 + GRAPH_CHUNKLOOKUP_SIZE;
> +	chunk_offsets[1] = chunk_offsets[0] + GRAPH_FANOUT_SIZE;
> +	chunk_offsets[2] = chunk_offsets[1] + GRAPH_OID_LEN * commits.nr;
> +	chunk_offsets[3] = chunk_offsets[2] + (GRAPH_OID_LEN + 16) * commits.nr;
> +	chunk_offsets[4] = chunk_offsets[3] + 4 * num_long_edges;

Do we have to care about overflowing any of the above?  For example,
the format allows only up to (1<<31)-1 commits, but did something
actually check if commits.nr at this point stayed under that limit?

