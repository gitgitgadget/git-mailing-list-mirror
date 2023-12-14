Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FBD6DD19
	for <git@vger.kernel.org>; Thu, 14 Dec 2023 22:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="DZ/ygMM+"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5906988ab8dso58143eaf.0
        for <git@vger.kernel.org>; Thu, 14 Dec 2023 14:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1702592618; x=1703197418; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XC6U/5+EPSCLe4cBmeR3G5BgZF3yKcvRINv/Tb34GUk=;
        b=DZ/ygMM+XkzqE4cqJO2TUGC844RXt47CBSRVlQSpQRcUFyGzqGcxlKPvaea4y5Uqye
         g7hxLJNag0nfqIdC+DKzwjtItyYtau488ND+gwdrDsFSTPTRJGV8mj38a2uhvWIg5sZP
         sZ3kPWbrWJvlfVdtAkUJRFMpWjGi2zys6//7kzW3gYcKYZOJkf9D+5WxAbz2XgO3izPA
         DySXl+NW6dbdT70f1anzYKrNfVLD7hHwRd/SS/7T13Kr1RjaZvny42VkwKZwJsA0NN3Y
         iDmLN7kLKheiYBUX66cWKeTyFc1phfS/JlDgB4L8/1rmgMSeBbCcsXChuso6QcZldxQU
         FqFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702592618; x=1703197418;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XC6U/5+EPSCLe4cBmeR3G5BgZF3yKcvRINv/Tb34GUk=;
        b=d7vqypubHt43FNWJ4kvHhXGk4qnhpalz806E0vnD7yCOh5GBVEIwsbheoZ6YVct0G/
         BaufyJSkUrA3OuSCIPPJi6kXR5EQNObpS1ponfbeKxT9bNKtBsSIzbk35svAazQ/bBB4
         aqqYVS6r+R5RcyUs2BCB81/2WiXDM4tizqkfPWNcN6LdGwIgG7lSxuFosBcGK/1ld3U5
         m7FFq+OF3chaq78VaSCjr0q51b25FpzOr67ZldTFaSTasr12FGY3BWX+SbOW8TcuhKZn
         wroLw2CoAZoiuvSWbk8pGT9YCKaYws3aASYG08c2Hu65KAwJqThs/yP+imriZSvWKSsm
         xxsw==
X-Gm-Message-State: AOJu0YxwMa4tKizjPngfwMyekaQOFoi+qEuOPrC06rPFlvZrtYlbw2cC
	YHeaGW5+OFdpeNk2cDAsUO9Hx1Vg4bnavL/hxATjww==
X-Google-Smtp-Source: AGHT+IHVVDtPq4bIiMwwCyW2K8ssPuSlP5X/Gie/IrHg9Nrwt6mS74ImWDzTPUywwEldCvwDXqMnIw==
X-Received: by 2002:a05:6870:ec93:b0:203:1215:2582 with SMTP id eo19-20020a056870ec9300b0020312152582mr3500006oab.5.1702592617868;
        Thu, 14 Dec 2023 14:23:37 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id zl10-20020a0568716d8a00b001fb42001fa7sm4706392oab.36.2023.12.14.14.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 14:23:37 -0800 (PST)
Date: Thu, 14 Dec 2023 17:23:33 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 00/26] pack-objects: multi-pack verbatim reuse
Message-ID: <cover.1702592603.git.me@ttaylorr.com>
References: <cover.1701198172.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1701198172.git.me@ttaylorr.com>

This is a reroll of my series to implement multi-pack verbatim reuse.

Since last time, I implemented a suggestion from Peff in [1] that
requires reusable packs be disjoint with respect to the objects they are
sending, not their entire set of objects. This allows for us to
implement multi-pack reuse without the DISP chunk or the
`--extend-disjoint`, `--exclude-disjoint`, `--retain-disjoint`, etc
options from the previous round.

Besides that, much is unchanged from last time, and the bulk of the
remaining changes are from Patrick Steinhardt's review of the first 2/3
of this series.

Performance remains mostly unchanged since last time, and I was able to
achieve the following results in hyperfine on my worst-case scenario
test repository (broken into ~100 packs):

    $ hyperfine -L v single,multi -n '{v}-pack reuse' \
      'git.compile -c pack.allowPackReuse={v} pack-objects --revs --stdout --use-bitmap-index --delta-base-offset <in >/dev/null'
    Benchmark 1: single-pack reuse
      Time (mean ± σ):      6.234 s ±  0.026 s    [User: 43.733 s, System: 0.349 s]
      Range (min … max):    6.197 s …  6.293 s    10 runs

    Benchmark 2: multi-pack reuse
      Time (mean ± σ):     959.5 ms ±   2.4 ms    [User: 1133.8 ms, System: 36.3 ms]
      Range (min … max):   957.2 ms … 964.8 ms    10 runs

    Summary
      multi-pack reuse ran
        6.50 ± 0.03 times faster than single-pack reuse

As before, this series is still quite large, despite losing a fair bit
of code related to disjoint packs. After thinking on it some more, I
still couldn't come up with a satisfying way to break up this series, so
here it is presented in one big chunk. If others have ideas on how
better to present this series, please let me know.

In the meantime, thanks in advance for your review!

[1]: https://lore.kernel.org/git/20231212080332.GC1117953@coredump.intra.peff.net/

Taylor Blau (26):
  pack-objects: free packing_data in more places
  pack-bitmap-write: deep-clear the `bb_commit` slab
  pack-bitmap: plug leak in find_objects()
  midx: factor out `fill_pack_info()`
  midx: implement `BTMP` chunk
  midx: implement `midx_locate_pack()`
  pack-bitmap: pass `bitmapped_pack` struct to pack-reuse functions
  ewah: implement `bitmap_is_empty()`
  pack-bitmap: simplify `reuse_partial_packfile_from_bitmap()` signature
  pack-bitmap: return multiple packs via
    `reuse_partial_packfile_from_bitmap()`
  pack-objects: parameterize pack-reuse routines over a single pack
  pack-objects: keep track of `pack_start` for each reuse pack
  pack-objects: pass `bitmapped_pack`'s to pack-reuse functions
  pack-objects: prepare `write_reused_pack()` for multi-pack reuse
  pack-objects: prepare `write_reused_pack_verbatim()` for multi-pack
    reuse
  pack-objects: include number of packs reused in output
  git-compat-util.h: implement checked size_t to uint32_t conversion
  midx: implement `midx_preferred_pack()`
  pack-revindex: factor out `midx_key_to_pack_pos()` helper
  pack-revindex: implement `midx_pair_to_pack_pos()`
  pack-bitmap: prepare to mark objects from multiple packs for reuse
  pack-objects: add tracing for various packfile metrics
  t/test-lib-functions.sh: implement `test_trace2_data` helper
  pack-objects: allow setting `pack.allowPackReuse` to "single"
  pack-bitmap: enable reuse from all bitmapped packs
  t/perf: add performance tests for multi-pack reuse

 Documentation/config/pack.txt      |  16 +-
 Documentation/gitformat-pack.txt   |  76 +++++++
 builtin/pack-objects.c             | 169 +++++++++++----
 ewah/bitmap.c                      |   9 +
 ewah/ewok.h                        |   1 +
 git-compat-util.h                  |   9 +
 midx.c                             | 151 +++++++++++---
 midx.h                             |  12 +-
 pack-bitmap-write.c                |   9 +-
 pack-bitmap.c                      | 321 +++++++++++++++++++----------
 pack-bitmap.h                      |  19 +-
 pack-objects.c                     |  15 ++
 pack-objects.h                     |   1 +
 pack-revindex.c                    |  50 +++--
 pack-revindex.h                    |   3 +
 t/helper/test-read-midx.c          |  41 +++-
 t/perf/p5332-multi-pack-reuse.sh   |  81 ++++++++
 t/t5319-multi-pack-index.sh        |  35 ++++
 t/t5332-multi-pack-reuse.sh        | 203 ++++++++++++++++++
 t/t6113-rev-list-bitmap-filters.sh |   2 +
 t/test-lib-functions.sh            |  14 ++
 21 files changed, 1039 insertions(+), 198 deletions(-)
 create mode 100755 t/perf/p5332-multi-pack-reuse.sh
 create mode 100755 t/t5332-multi-pack-reuse.sh

Range-diff against v1:
 1:  101d6a2841 !  1:  7d65abfa1d pack-objects: free packing_data in more places
    @@ Commit message
     
         Since these structures contain allocated fields, failing to
         appropriately free() them results in a leak. Plug that leak by
    -    introducing a free_packing_data() function, and call it in the
    +    introducing a clear_packing_data() function, and call it in the
         appropriate spots.
     
         This is a fairly straightforward leak to plug, since none of the callers
    @@ builtin/pack-objects.c: int cmd_pack_objects(int argc, const char **argv, const
      			   reuse_packfile_objects);
      
      cleanup:
    -+	free_packing_data(&to_pack);
    ++	clear_packing_data(&to_pack);
      	list_objects_filter_release(&filter_options);
      	strvec_clear(&rp);
      
    @@ midx.c: static int write_midx_internal(const char *object_dir,
      				      flags) < 0) {
      			error(_("could not write multi-pack bitmap"));
      			result = 1;
    -+			free_packing_data(&pdata);
    ++			clear_packing_data(&pdata);
     +			free(commits);
      			goto cleanup;
      		}
     +
    -+		free_packing_data(&pdata);
    ++		clear_packing_data(&pdata);
     +		free(commits);
      	}
      	/*
    @@ pack-objects.c: void prepare_packing_data(struct repository *r, struct packing_d
      	init_recursive_mutex(&pdata->odb_lock);
      }
      
    -+void free_packing_data(struct packing_data *pdata)
    ++void clear_packing_data(struct packing_data *pdata)
     +{
     +	if (!pdata)
     +		return;
    @@ pack-objects.h: struct packing_data {
      };
      
      void prepare_packing_data(struct repository *r, struct packing_data *pdata);
    -+void free_packing_data(struct packing_data *pdata);
    ++void clear_packing_data(struct packing_data *pdata);
      
      /* Protect access to object database */
      static inline void packing_data_lock(struct packing_data *pdata)
 2:  6f5ff96998 !  2:  19cdaf59c5 pack-bitmap-write: deep-clear the `bb_commit` slab
    @@ Commit message
         bb_commit` type, and make sure it is called on each member of the slab
         via the `deep_clear_bb_data()` function.
     
    +    Note that it is possible for both of the arguments to `bitmap_free()` to
    +    be NULL, but `bitmap_free()` is a noop for NULL arguments, so it is OK
    +    to pass them unconditionally.
    +
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
      ## pack-bitmap-write.c ##
    @@ pack-bitmap-write.c: struct bb_commit {
      
     +static void clear_bb_commit(struct bb_commit *commit)
     +{
    -+	free(commit->reverse_edges);
    ++	free_commit_list(commit->reverse_edges);
     +	bitmap_free(commit->commit_mask);
     +	bitmap_free(commit->bitmap);
     +}
 3:  bc38fba655 =  3:  477df6c974 pack-bitmap: plug leak in find_objects()
 4:  ccf1337305 !  4:  a06ed75af1 midx: factor out `fill_pack_info()`
    @@ midx.c: struct pack_info {
      };
      
     +static void fill_pack_info(struct pack_info *info,
    -+			   struct packed_git *p, char *pack_name,
    ++			   struct packed_git *p, const char *pack_name,
     +			   uint32_t orig_pack_int_id)
     +{
     +	memset(info, 0, sizeof(struct pack_info));
     +
     +	info->orig_pack_int_id = orig_pack_int_id;
    -+	info->pack_name = pack_name;
    ++	info->pack_name = xstrdup(pack_name);
     +	info->p = p;
     +}
     +
    @@ midx.c: static void add_pack_to_midx(const char *full_path, size_t full_path_len
     +		if (open_pack_index(p)) {
      			warning(_("failed to open pack-index '%s'"),
      				full_path);
    - 			close_pack(ctx->info[ctx->nr].p);
    -@@ midx.c: static void add_pack_to_midx(const char *full_path, size_t full_path_len,
    +-			close_pack(ctx->info[ctx->nr].p);
    +-			FREE_AND_NULL(ctx->info[ctx->nr].p);
    ++			close_pack(p);
    ++			free(p);
      			return;
      		}
      
     -		ctx->info[ctx->nr].pack_name = xstrdup(file_name);
     -		ctx->info[ctx->nr].orig_pack_int_id = ctx->nr;
     -		ctx->info[ctx->nr].expired = 0;
    -+		fill_pack_info(&ctx->info[ctx->nr], p, xstrdup(file_name),
    -+			       ctx->nr);
    ++		fill_pack_info(&ctx->info[ctx->nr], p, file_name, ctx->nr);
      		ctx->nr++;
      	}
      }
    @@ midx.c: static int write_midx_internal(const char *object_dir,
      
     -			ctx.nr++;
     +			fill_pack_info(&ctx.info[ctx.nr++], ctx.m->packs[i],
    -+				       xstrdup(ctx.m->pack_names[i]), i);
    ++				       ctx.m->pack_names[i], i);
      		}
      	}
      
 5:  c52d7e7b27 !  5:  6fdc68418f midx: implement `DISP` chunk
    @@ Metadata
     Author: Taylor Blau <me@ttaylorr.com>
     
      ## Commit message ##
    -    midx: implement `DISP` chunk
    +    midx: implement `BTMP` chunk
     
         When a multi-pack bitmap is used to implement verbatim pack reuse (that
         is, when verbatim chunks from an on-disk packfile are copied
    @@ Commit message
         It would be beneficial to be able to perform this same optimization over
         multiple packs, provided some modest constraints (most importantly, that
         the set of packs eligible for verbatim reuse are disjoint with respect
    -    to the objects that they contain).
    +    to the subset of their objects being sent).
     
         If we assume that the packs which we treat as candidates for verbatim
    -    reuse are disjoint with respect to their objects, we need to make only
    -    modest modifications to the verbatim pack-reuse code itself. Most
    -    notably, we need to remove the assumption that the bits in the
    -    reachability bitmap corresponding to objects from the single reuse pack
    -    begin at the first bit position.
    +    reuse are disjoint with respect to any of their objects we may output,
    +    we need to make only modest modifications to the verbatim pack-reuse
    +    code itself. Most notably, we need to remove the assumption that the
    +    bits in the reachability bitmap corresponding to objects from the single
    +    reuse pack begin at the first bit position.
     
         Future patches will unwind these assumptions and reimplement their
         existing functionality as special cases of the more general assumptions
    @@ Commit message
         to start at 0 for all existing cases).
     
         This patch does not yet relax any of those assumptions. Instead, it
    -    implements a foundational data-structure, the "Disjoint Packs" (`DISP`)
    -    chunk of the multi-pack index. The `DISP` chunk's contents are described
    -    in detail here. Importantly, the `DISP` chunk contains information to
    +    implements a foundational data-structure, the "Bitampped Packs" (`BTMP`)
    +    chunk of the multi-pack index. The `BTMP` chunk's contents are described
    +    in detail here. Importantly, the `BTMP` chunk contains information to
         map regions of a multi-pack index's reachability bitmap to the packs
         whose objects they represent.
     
    @@ Commit message
         used in this patch to test the new chunk's behavior). Future patches
         will begin to make use of this new chunk.
     
    -    This patch implements reading (though no callers outside of the above
    -    one perform any reading) and writing this new chunk. It also extends the
    -    `--stdin-packs` format used by the `git multi-pack-index write` builtin
    -    to be able to designate that a given pack is to be marked as "disjoint"
    -    by prefixing it with a '+' character.
    -
         [^1]: Modulo patching any `OFS_DELTA`'s that cross over a region of the
           pack that wasn't used verbatim.
     
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
    - ## Documentation/git-multi-pack-index.txt ##
    -@@ Documentation/git-multi-pack-index.txt: write::
    - 	--stdin-packs::
    - 		Write a multi-pack index containing only the set of
    - 		line-delimited pack index basenames provided over stdin.
    -+		Lines beginning with a '+' character (followed by the
    -+		pack index basename as before) have their pack marked as
    -+		"disjoint". See the "`DISP` chunk and disjoint packs"
    -+		section in linkgit:gitformat-pack[5] for more.
    - 
    - 	--refs-snapshot=<path>::
    - 		With `--bitmap`, optionally specify a file which
    -
      ## Documentation/gitformat-pack.txt ##
     @@ Documentation/gitformat-pack.txt: CHUNK DATA:
      	    is padded at the end with between 0 and 3 NUL bytes to make the
      	    chunk size a multiple of 4 bytes.
      
    -+	Disjoint Packfiles (ID: {'D', 'I', 'S', 'P'})
    -+	    Stores a table of three 4-byte unsigned integers in network order.
    ++	Bitmapped Packfiles (ID: {'B', 'T', 'M', 'P'})
    ++	    Stores a table of two 4-byte unsigned integers in network order.
     +	    Each table entry corresponds to a single pack (in the order that
     +	    they appear above in the `PNAM` chunk). The values for each table
     +	    entry are as follows:
    -+	    - The first bit position (in psuedo-pack order, see below) to
    ++	    - The first bit position (in pseudo-pack order, see below) to
     +	      contain an object from that pack.
     +	    - The number of bits whose objects are selected from that pack.
    -+	    - A "meta" value, whose least-significant bit indicates whether or
    -+	      not the pack is disjoint with respect to other packs. The
    -+	      remaining bits are unused.
    -+	    Two packs are "disjoint" with respect to one another when they have
    -+	    disjoint sets of objects. In other words, any object found in a pack
    -+	    contained in the set of disjoint packfiles is guaranteed to be
    -+	    uniquely located among those packs.
     +
      	OID Fanout (ID: {'O', 'I', 'D', 'F'})
      	    The ith entry, F[i], stores the number of OIDs with first
    @@ Documentation/gitformat-pack.txt: packs arranged in MIDX order (with the preferr
      The MIDX's reverse index is stored in the optional 'RIDX' chunk within
      the MIDX itself.
      
    -+=== `DISP` chunk and disjoint packs
    ++=== `BTMP` chunk
     +
    -+The Disjoint Packfiles (`DISP`) chunk encodes additional information
    ++The Bitmapped Packfiles (`BTMP`) chunk encodes additional information
     +about the objects in the multi-pack index's reachability bitmap. Recall
    -+that objects from the MIDX are arranged in "pseudo-pack" order (see:
    ++that objects from the MIDX are arranged in "pseudo-pack" order (see
     +above) for reachability bitmaps.
     +
     +From the example above, suppose we have packs "a", "b", and "c", with
    @@ Documentation/gitformat-pack.txt: packs arranged in MIDX order (with the preferr
     +    |a,0|a,1|...|a,9|b,0|b,1|...|b,14|c,0|c,1|...|c,19|
     +
     +When working with single-pack bitmaps (or, equivalently, multi-pack
    -+reachability bitmaps without any packs marked as disjoint),
    -+linkgit:git-pack-objects[1] performs ``verbatim'' reuse, attempting to
    -+reuse chunks of the existing packfile instead of adding objects to the
    -+packing list.
    ++reachability bitmaps with a preferred pack), linkgit:git-pack-objects[1]
    ++performs ``verbatim'' reuse, attempting to reuse chunks of the bitmapped
    ++or preferred packfile instead of adding objects to the packing list.
     +
    -+When a chunk of bytes are reused from an existing pack, any objects
    ++When a chunk of bytes is reused from an existing pack, any objects
     +contained therein do not need to be added to the packing list, saving
     +memory and CPU time. But a chunk from an existing packfile can only be
     +reused when the following conditions are met:
    @@ Documentation/gitformat-pack.txt: packs arranged in MIDX order (with the preferr
     +    (i.e. does not contain any objects which the caller didn't ask for
     +    explicitly or implicitly).
     +
    -+  - All objects stored as offset- or reference-deltas also include their
    -+    base object in the resulting pack.
    ++  - All objects stored in non-thin packs as offset- or reference-deltas
    ++    also include their base object in the resulting pack.
     +
    -+Additionally, packfiles many not contain more than one copy of any given
    -+object. This introduces an additional constraint over the set of packs
    -+we may want to reuse. The most straightforward approach is to mandate
    -+that the set of packs is disjoint with respect to the set of objects
    -+contained in each pack. In other words, for each object `o` in the union
    -+of all objects stored by the disjoint set of packs, `o` is contained in
    -+exactly one pack from the disjoint set.
    -+
    -+One alternative design choice for multi-pack reuse might instead involve
    -+imposing a chunk-level constraint that allows packs in the reusable set
    -+to contain multiple copies across different packs, but restricts each
    -+chunk against including more than one copy of such an object. This is in
    -+theory possible to implement, but significantly more complicated than
    -+forcing packs themselves to be disjoint. Most notably, we would have to
    -+keep track of which objects have already been sent during verbatim
    -+pack-reuse, defeating the main purpose of verbatim pack reuse (that we
    -+don't have to keep track of individual objects).
    -+
    -+The `DISP` chunk encodes the necessary information in order to implement
    -+multi-pack reuse over a disjoint set of packs as described above.
    -+Specifically, the `DISP` chunk encodes three pieces of information (all
    ++The `BTMP` chunk encodes the necessary information in order to implement
    ++multi-pack reuse over a set of packfiles as described above.
    ++Specifically, the `BTMP` chunk encodes three pieces of information (all
     +32-bit unsigned integers in network byte-order) for each packfile `p`
     +that is stored in the MIDX, as follows:
     +
    @@ Documentation/gitformat-pack.txt: packs arranged in MIDX order (with the preferr
     +`bitmap_nr`:: The number of bit positions (including the one at
     +  `bitmap_pos`) that encode objects from that pack `p`.
     +
    -+`disjoint`:: Metadata, including whether or not the pack `p` is
    -+  ``disjoint''. The least significant bit stores whether or not the pack
    -+  is disjoint. The remaining bits are reserved for future use.
    -+
    -+For example, the `DISP` chunk corresponding to the above example (with
    ++For example, the `BTMP` chunk corresponding to the above example (with
     +packs ``a'', ``b'', and ``c'') would look like:
     +
    -+[cols="1,2,2,2"]
    ++[cols="1,2,2"]
     +|===
    -+| |`bitmap_pos` |`bitmap_nr` |`disjoint`
    ++| |`bitmap_pos` |`bitmap_nr`
     +
     +|packfile ``a''
     +|`0`
     +|`10`
    -+|`0x1`
     +
     +|packfile ``b''
     +|`10`
     +|`15`
    -+|`0x1`
     +
     +|packfile ``c''
     +|`25`
     +|`20`
    -+|`0x1`
     +|===
     +
    -+With these constraints and information in place, we can treat each
    -+packfile marked as disjoint as individually reusable in the same fashion
    -+as verbatim pack reuse is performed on individual packs prior to the
    -+implementation of the `DISP` chunk.
    ++With this information in place, we can treat each packfile as
    ++individually reusable in the same fashion as verbatim pack reuse is
    ++performed on individual packs prior to the implementation of the `BTMP`
    ++chunk.
     +
      == cruft packs
      
      The cruft packs feature offer an alternative to Git's traditional mechanism of
     
    - ## builtin/multi-pack-index.c ##
    -@@ builtin/multi-pack-index.c: static int git_multi_pack_index_write_config(const char *var, const char *value,
    - 	return 0;
    - }
    - 
    -+#define DISJOINT ((void*)(uintptr_t)1)
    -+
    - static void read_packs_from_stdin(struct string_list *to)
    - {
    - 	struct strbuf buf = STRBUF_INIT;
    --	while (strbuf_getline(&buf, stdin) != EOF)
    --		string_list_append(to, buf.buf);
    -+	while (strbuf_getline(&buf, stdin) != EOF) {
    -+		if (*buf.buf == '+')
    -+			string_list_append(to, buf.buf + 1)->util = DISJOINT;
    -+		else
    -+			string_list_append(to, buf.buf);
    -+	}
    - 	string_list_sort(to);
    - 
    - 	strbuf_release(&buf);
    -
      ## midx.c ##
     @@
      
      #define MIDX_CHUNK_ALIGNMENT 4
      #define MIDX_CHUNKID_PACKNAMES 0x504e414d /* "PNAM" */
    -+#define MIDX_CHUNKID_DISJOINTPACKS 0x44495350 /* "DISP" */
    ++#define MIDX_CHUNKID_BITMAPPEDPACKS 0x42544d50 /* "BTMP" */
      #define MIDX_CHUNKID_OIDFANOUT 0x4f494446 /* "OIDF" */
      #define MIDX_CHUNKID_OIDLOOKUP 0x4f49444c /* "OIDL" */
      #define MIDX_CHUNKID_OBJECTOFFSETS 0x4f4f4646 /* "OOFF" */
    +@@
    + #define MIDX_CHUNK_FANOUT_SIZE (sizeof(uint32_t) * 256)
    + #define MIDX_CHUNK_OFFSET_WIDTH (2 * sizeof(uint32_t))
    + #define MIDX_CHUNK_LARGE_OFFSET_WIDTH (sizeof(uint64_t))
    ++#define MIDX_CHUNK_BITMAPPED_PACKS_WIDTH (2 * sizeof(uint32_t))
    + #define MIDX_LARGE_OFFSET_NEEDED 0x80000000
    + 
    + #define PACK_EXPIRED UINT_MAX
     @@ midx.c: struct multi_pack_index *load_multi_pack_index(const char *object_dir, int local
      
      	pair_chunk(cf, MIDX_CHUNKID_LARGEOFFSETS, &m->chunk_large_offsets,
      		   &m->chunk_large_offsets_len);
    -+	pair_chunk(cf, MIDX_CHUNKID_DISJOINTPACKS,
    -+		   (const unsigned char **)&m->chunk_disjoint_packs,
    -+		   &m->chunk_disjoint_packs_len);
    ++	pair_chunk(cf, MIDX_CHUNKID_BITMAPPEDPACKS,
    ++		   (const unsigned char **)&m->chunk_bitmapped_packs,
    ++		   &m->chunk_bitmapped_packs_len);
      
      	if (git_env_bool("GIT_TEST_MIDX_READ_RIDX", 1))
      		pair_chunk(cf, MIDX_CHUNKID_REVINDEX, &m->chunk_revindex,
    @@ midx.c: int prepare_midx_pack(struct repository *r, struct multi_pack_index *m,
     +int nth_bitmapped_pack(struct repository *r, struct multi_pack_index *m,
     +		       struct bitmapped_pack *bp, uint32_t pack_int_id)
     +{
    -+	if (!m->chunk_disjoint_packs)
    -+		return error(_("MIDX does not contain the DISP chunk"));
    ++	if (!m->chunk_bitmapped_packs)
    ++		return error(_("MIDX does not contain the BTMP chunk"));
     +
     +	if (prepare_midx_pack(r, m, pack_int_id))
    -+		return error(_("could not load disjoint pack %"PRIu32), pack_int_id);
    ++		return error(_("could not load bitmapped pack %"PRIu32), pack_int_id);
     +
     +	bp->p = m->packs[pack_int_id];
    -+	bp->bitmap_pos = get_be32(m->chunk_disjoint_packs + 3 * pack_int_id);
    -+	bp->bitmap_nr = get_be32(m->chunk_disjoint_packs + 3 * pack_int_id + 1);
    -+	bp->disjoint = !!get_be32(m->chunk_disjoint_packs + 3 * pack_int_id + 2);
    ++	bp->bitmap_pos = get_be32((char *)m->chunk_bitmapped_packs +
    ++				  MIDX_CHUNK_BITMAPPED_PACKS_WIDTH * pack_int_id);
    ++	bp->bitmap_nr = get_be32((char *)m->chunk_bitmapped_packs +
    ++				 MIDX_CHUNK_BITMAPPED_PACKS_WIDTH * pack_int_id +
    ++				 sizeof(uint32_t));
    ++	bp->pack_int_id = pack_int_id;
     +
     +	return 0;
     +}
    @@ midx.c: static size_t write_midx_header(struct hashfile *f,
      	uint32_t orig_pack_int_id;
      	char *pack_name;
      	struct packed_git *p;
    --	unsigned expired : 1;
     +
     +	uint32_t bitmap_pos;
     +	uint32_t bitmap_nr;
     +
    -+	unsigned expired : 1,
    -+		 disjoint : 1;
    + 	unsigned expired : 1;
      };
      
    - static void fill_pack_info(struct pack_info *info,
     @@ midx.c: static void fill_pack_info(struct pack_info *info,
      	info->orig_pack_int_id = orig_pack_int_id;
    - 	info->pack_name = pack_name;
    + 	info->pack_name = xstrdup(pack_name);
      	info->p = p;
     +	info->bitmap_pos = BITMAP_POS_UNKNOWN;
      }
      
      static int pack_info_compare(const void *_a, const void *_b)
    -@@ midx.c: static void add_pack_to_midx(const char *full_path, size_t full_path_len,
    - {
    - 	struct write_midx_context *ctx = data;
    - 	struct packed_git *p;
    -+	struct string_list_item *item = NULL;
    - 
    - 	if (ends_with(file_name, ".idx")) {
    - 		display_progress(ctx->progress, ++ctx->pack_paths_checked);
    -@@ midx.c: static void add_pack_to_midx(const char *full_path, size_t full_path_len,
    - 		 * should be performed independently (likely checking
    - 		 * to_include before the existing MIDX).
    - 		 */
    --		if (ctx->m && midx_contains_pack(ctx->m, file_name))
    --			return;
    --		else if (ctx->to_include &&
    --			 !string_list_has_string(ctx->to_include, file_name))
    -+		if (ctx->m && midx_contains_pack(ctx->m, file_name)) {
    - 			return;
    -+		} else if (ctx->to_include) {
    -+			item = string_list_lookup(ctx->to_include, file_name);
    -+			if (!item)
    -+				return;
    -+		}
    - 
    - 		ALLOC_GROW(ctx->info, ctx->nr + 1, ctx->alloc);
    - 
    -@@ midx.c: static void add_pack_to_midx(const char *full_path, size_t full_path_len,
    - 
    - 		fill_pack_info(&ctx->info[ctx->nr], p, xstrdup(file_name),
    - 			       ctx->nr);
    -+		if (item)
    -+			ctx->info[ctx->nr].disjoint = !!item->util;
    - 		ctx->nr++;
    - 	}
    - }
    -@@ midx.c: struct pack_midx_entry {
    - 	uint32_t pack_int_id;
    - 	time_t pack_mtime;
    - 	uint64_t offset;
    --	unsigned preferred : 1;
    -+	unsigned preferred : 1,
    -+		 disjoint : 1;
    - };
    - 
    - static int midx_oid_compare(const void *_a, const void *_b)
    -@@ midx.c: static int midx_oid_compare(const void *_a, const void *_b)
    - 	if (a->preferred < b->preferred)
    - 		return 1;
    - 
    -+	/* Sort objects in a disjoint pack last when multiple copies exist. */
    -+	if (a->disjoint < b->disjoint)
    -+		return -1;
    -+	if (a->disjoint > b->disjoint)
    -+		return 1;
    -+
    - 	if (a->pack_mtime > b->pack_mtime)
    - 		return -1;
    - 	else if (a->pack_mtime < b->pack_mtime)
    -@@ midx.c: static void midx_fanout_add_midx_fanout(struct midx_fanout *fanout,
    - 					   &fanout->entries[fanout->nr],
    - 					   cur_object);
    - 		fanout->entries[fanout->nr].preferred = 0;
    -+		fanout->entries[fanout->nr].disjoint = 0;
    - 		fanout->nr++;
    - 	}
    - }
    -@@ midx.c: static void midx_fanout_add_pack_fanout(struct midx_fanout *fanout,
    - 				cur_object,
    - 				&fanout->entries[fanout->nr],
    - 				preferred);
    -+		fanout->entries[fanout->nr].disjoint = info->disjoint;
    - 		fanout->nr++;
    - 	}
    - }
    -@@ midx.c: static struct pack_midx_entry *get_sorted_entries(struct multi_pack_index *m,
    - 		 * Take only the first duplicate.
    - 		 */
    - 		for (cur_object = 0; cur_object < fanout.nr; cur_object++) {
    --			if (cur_object && oideq(&fanout.entries[cur_object - 1].oid,
    --						&fanout.entries[cur_object].oid))
    --				continue;
    -+			struct pack_midx_entry *ours = &fanout.entries[cur_object];
    -+			if (cur_object) {
    -+				struct pack_midx_entry *prev = &fanout.entries[cur_object - 1];
    -+				if (oideq(&prev->oid, &ours->oid)) {
    -+					if (prev->disjoint && ours->disjoint)
    -+						die(_("duplicate object '%s' among disjoint packs '%s', '%s'"),
    -+						    oid_to_hex(&prev->oid),
    -+						    info[prev->pack_int_id].pack_name,
    -+						    info[ours->pack_int_id].pack_name);
    -+					continue;
    -+				}
    -+			}
    - 
    - 			ALLOC_GROW(deduplicated_entries, st_add(*nr_objects, 1),
    - 				   alloc_objects);
    --			memcpy(&deduplicated_entries[*nr_objects],
    --			       &fanout.entries[cur_object],
    -+			memcpy(&deduplicated_entries[*nr_objects], ours,
    - 			       sizeof(struct pack_midx_entry));
    - 			(*nr_objects)++;
    - 		}
     @@ midx.c: static int write_midx_pack_names(struct hashfile *f, void *data)
      	return 0;
      }
      
    -+static int write_midx_disjoint_packs(struct hashfile *f, void *data)
    ++static int write_midx_bitmapped_packs(struct hashfile *f, void *data)
     +{
     +	struct write_midx_context *ctx = data;
     +	size_t i;
    @@ midx.c: static int write_midx_pack_names(struct hashfile *f, void *data)
     +
     +		hashwrite_be32(f, pack->bitmap_pos);
     +		hashwrite_be32(f, pack->bitmap_nr);
    -+		hashwrite_be32(f, !!pack->disjoint);
     +	}
     +	return 0;
     +}
    @@ midx.c: static int write_midx_internal(const char *object_dir,
      	struct hashfile *f = NULL;
      	struct lock_file lk;
      	struct write_midx_context ctx = { 0 };
    -+	int pack_disjoint_concat_len = 0;
    ++	int bitmapped_packs_concat_len = 0;
      	int pack_name_concat_len = 0;
      	int dropped_packs = 0;
      	int result = 0;
    @@ midx.c: static int write_midx_internal(const char *object_dir,
     +		if (ctx.info[i].expired)
     +			continue;
     +		pack_name_concat_len += strlen(ctx.info[i].pack_name) + 1;
    -+		pack_disjoint_concat_len += 3 * sizeof(uint32_t);
    ++		bitmapped_packs_concat_len += 2 * sizeof(uint32_t);
      	}
      
      	/* Check that the preferred pack wasn't expired (if given). */
    @@ midx.c: static int write_midx_internal(const char *object_dir,
      		add_chunk(cf, MIDX_CHUNKID_REVINDEX,
      			  st_mult(ctx.entries_nr, sizeof(uint32_t)),
      			  write_midx_revindex);
    -+		add_chunk(cf, MIDX_CHUNKID_DISJOINTPACKS,
    -+			  pack_disjoint_concat_len, write_midx_disjoint_packs);
    ++		add_chunk(cf, MIDX_CHUNKID_BITMAPPEDPACKS,
    ++			  bitmapped_packs_concat_len,
    ++			  write_midx_bitmapped_packs);
      	}
      
      	write_midx_header(f, get_num_chunks(cf), ctx.nr - dropped_packs);
    @@ midx.h: struct multi_pack_index {
      
      	const unsigned char *chunk_pack_names;
      	size_t chunk_pack_names_len;
    -+	const uint32_t *chunk_disjoint_packs;
    -+	size_t chunk_disjoint_packs_len;
    ++	const uint32_t *chunk_bitmapped_packs;
    ++	size_t chunk_bitmapped_packs_len;
      	const uint32_t *chunk_oid_fanout;
      	const unsigned char *chunk_oid_lookup;
      	const unsigned char *chunk_object_offsets;
    @@ pack-bitmap.h: typedef int (*show_reachable_fn)(
     +	uint32_t bitmap_pos;
     +	uint32_t bitmap_nr;
     +
    -+	unsigned disjoint : 1;
    ++	uint32_t pack_int_id; /* MIDX only */
     +};
     +
      struct bitmap_index *prepare_bitmap_git(struct repository *r);
    @@ t/helper/test-read-midx.c: static int read_midx_preferred_pack(const char *objec
     +		printf("%s\n", pack_basename(pack.p));
     +		printf("  bitmap_pos: %"PRIuMAX"\n", (uintmax_t)pack.bitmap_pos);
     +		printf("  bitmap_nr: %"PRIuMAX"\n", (uintmax_t)pack.bitmap_nr);
    -+		printf("  disjoint: %s\n", pack.disjoint & 0x1 ? "yes" : "no");
     +	}
     +
     +	close_midx(midx);
    @@ t/helper/test-read-midx.c: int cmd__read_midx(int argc, const char **argv)
      }
     
      ## t/t5319-multi-pack-index.sh ##
    -@@ t/t5319-multi-pack-index.sh: test_expect_success 'reader notices too-small revindex chunk' '
    - 	test_cmp expect.err err
    +@@ t/t5319-multi-pack-index.sh: test_expect_success 'reader notices out-of-bounds fanout' '
    + 	test_cmp expect err
      '
      
    -+test_expect_success 'disjoint packs are stored via the DISP chunk' '
    ++test_expect_success 'bitmapped packs are stored via the BTMP chunk' '
     +	test_when_finished "rm -fr repo" &&
     +	git init repo &&
     +	(
    @@ t/t5319-multi-pack-index.sh: test_expect_success 'reader notices too-small revin
     +			git repack -d || return 1
     +		done &&
     +
    -+		find $objdir/pack -type f -name "*.idx" | xargs -n 1 basename | sort >packs &&
    ++		find $objdir/pack -type f -name "*.idx" | xargs -n 1 basename |
    ++		sort >packs &&
     +
     +		git multi-pack-index write --stdin-packs <packs &&
     +		test_must_fail test-tool read-midx --bitmap $objdir 2>err &&
     +		cat >expect <<-\EOF &&
    -+		error: MIDX does not contain the DISP chunk
    ++		error: MIDX does not contain the BTMP chunk
     +		EOF
     +		test_cmp expect err &&
     +
    -+		sed -e "s/^/+/g" packs >in &&
     +		git multi-pack-index write --stdin-packs --bitmap \
    -+			--preferred-pack="$(head -n1 <packs)" <in &&
    ++			--preferred-pack="$(head -n1 <packs)" <packs  &&
     +		test-tool read-midx --bitmap $objdir >actual &&
     +		for i in $(test_seq $(wc -l <packs))
     +		do
     +			sed -ne "${i}s/\.idx$/\.pack/p" packs &&
    -+			echo "  bitmap_pos: $(( $(( $i - 1 )) * 3 ))" &&
    -+			echo "  bitmap_nr: 3" &&
    -+			echo "  disjoint: yes" || return 1
    ++			echo "  bitmap_pos: $((($i - 1) * 3))" &&
    ++			echo "  bitmap_nr: 3" || return 1
     +		done >expect &&
     +		test_cmp expect actual
     +	)
     +'
    -+
    -+test_expect_success 'non-disjoint packs are detected' '
    -+	test_when_finished "rm -fr repo" &&
    -+	git init repo &&
    -+	(
    -+		cd repo &&
    -+
    -+		test_commit base &&
    -+		git repack -d &&
    -+		test_commit other &&
    -+		git repack -a &&
    -+
    -+		ls -la .git/objects/pack/ &&
    -+
    -+		find $objdir/pack -type f -name "*.idx" |
    -+			sed -e "s/.*\/\(.*\)$/+\1/g" >in &&
    -+
    -+		test_must_fail git multi-pack-index write --stdin-packs \
    -+			--bitmap <in 2>err &&
    -+		grep "duplicate object.* among disjoint packs" err
    -+	)
    -+'
     +
      test_done
 6:  541fbb442b =  6:  96f397a2b2 midx: implement `midx_locate_pack()`
 7:  3019738b52 <  -:  ---------- midx: implement `--retain-disjoint` mode
 8:  0368f7ab37 <  -:  ---------- pack-objects: implement `--ignore-disjoint` mode
 9:  b75869befb <  -:  ---------- repack: implement `--extend-disjoint` mode
10:  970bd9eaea !  7:  df9233cf0f pack-bitmap: pass `bitmapped_pack` struct to pack-reuse functions
    @@ pack-bitmap.c: int reuse_partial_packfile_from_bitmap(struct bitmap_index *bitma
      	unuse_pack(&w_curs);
     +}
     +
    ++static int bitmapped_pack_cmp(const void *va, const void *vb)
    ++{
    ++	const struct bitmapped_pack *a = va;
    ++	const struct bitmapped_pack *b = vb;
    ++
    ++	if (a->bitmap_pos < b->bitmap_pos)
    ++		return -1;
    ++	if (a->bitmap_pos > b->bitmap_pos)
    ++		return 1;
    ++	return 0;
    ++}
    ++
     +int reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
     +				       struct packed_git **packfile_out,
     +				       uint32_t *entries,
    @@ pack-bitmap.c: int reuse_partial_packfile_from_bitmap(struct bitmap_index *bitma
     +
     +			objects_nr += pack.p->num_objects;
     +		}
    ++
    ++		QSORT(packs, packs_nr, bitmapped_pack_cmp);
     +	} else {
     +		ALLOC_GROW(packs, packs_nr + 1, packs_alloc);
     +
     +		packs[packs_nr].p = bitmap_git->pack;
     +		packs[packs_nr].bitmap_pos = 0;
     +		packs[packs_nr].bitmap_nr = bitmap_git->pack->num_objects;
    -+		packs[packs_nr].disjoint = 1;
     +
     +		objects_nr = packs[packs_nr++].p->num_objects;
     +	}
 -:  ---------- >  8:  595b3b6986 ewah: implement `bitmap_is_empty()`
11:  432854b27c !  9:  d851f821fc pack-bitmap: simplify `reuse_partial_packfile_from_bitmap()` signature
    @@ builtin/pack-objects.c: static int get_object_list_from_bitmap(struct rev_info *
      		display_progress(progress_state, nr_seen);
     
      ## pack-bitmap.c ##
    -@@ pack-bitmap.c: static void reuse_partial_packfile_from_bitmap_1(struct bitmap_index *bitmap_git
    - 	unuse_pack(&w_curs);
    +@@ pack-bitmap.c: static int bitmapped_pack_cmp(const void *va, const void *vb)
    + 	return 0;
      }
      
     -int reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
    @@ pack-bitmap.c: int reuse_partial_packfile_from_bitmap(struct bitmap_index *bitma
      
     -	*entries = bitmap_popcount(reuse);
     -	if (!*entries) {
    -+	if (!bitmap_popcount(reuse)) {
    ++	if (bitmap_is_empty(reuse)) {
     +		free(packs);
      		bitmap_free(reuse);
     -		return -1;
12:  36b794d9e1 ! 10:  f551892bab pack-bitmap: return multiple packs via `reuse_partial_packfile_from_bitmap()`
    @@ builtin/pack-objects.c: static int pack_options_allow_reuse(void)
      			BUG("expected non-empty reuse bitmap");
     
      ## pack-bitmap.c ##
    -@@ pack-bitmap.c: static void reuse_partial_packfile_from_bitmap_1(struct bitmap_index *bitmap_git
    +@@ pack-bitmap.c: static int bitmapped_pack_cmp(const void *va, const void *vb)
      }
      
      void reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
13:  dca1083d8e = 11:  67e4fd8a06 pack-objects: parameterize pack-reuse routines over a single pack
14:  6f4fba861b ! 12:  9a5c38514b pack-objects: keep track of `pack_start` for each reuse pack
    @@ Commit message
         In order to compute this value correctly, we need to know not only where
         we are in the packfile we're assembling (with `hashfile_total(f)`) but
         also the position of the first byte of the packfile that we are
    -    currently reusing.
    +    currently reusing. Currently, this works just fine, since when reusing
    +    only a single pack those two values are always identical (because
    +    verbatim reuse is the first thing pack-objects does when enabled after
    +    writing the pack header).
    +
    +    But when reusing multiple packs which have one or more gaps, we'll need
    +    to account for these two values diverging.
     
         Together, these two allow us to compute the reused chunk's offset
         difference relative to the start of the reused pack, as desired.
15:  2bb01e2370 = 13:  5492d11f25 pack-objects: pass `bitmapped_pack`'s to pack-reuse functions
16:  67a8196978 ! 14:  b32742ebcb pack-objects: prepare `write_reused_pack()` for multi-pack reuse
    @@ Commit message
     
         Prepare this function for multi-pack reuse by removing the assumption
         that the bit position corresponding to the first object being reused
    -    from a given pack may not be at bit position zero.
    +    from a given pack must be at bit position zero.
     
         The changes in this function are mostly straightforward. Initialize `i`
         to the position of the first word to contain bits corresponding to that
17:  1f766648df = 15:  805c42185a pack-objects: prepare `write_reused_pack_verbatim()` for multi-pack reuse
18:  4cd9f99bfd ! 16:  55696bc1c9 pack-objects: include number of packs reused in output
    @@ builtin/pack-objects.c: int cmd_pack_objects(int argc, const char **argv, const
     +			   (uintmax_t)reuse_packfiles_used_nr);
      
      cleanup:
    - 	free_packing_data(&to_pack);
    + 	clear_packing_data(&to_pack);
19:  176c4c95ac <  -:  ---------- pack-bitmap: prepare to mark objects from multiple packs for reuse
 -:  ---------- > 17:  6ede9e0603 git-compat-util.h: implement checked size_t to uint32_t conversion
 -:  ---------- > 18:  ab0456a71e midx: implement `midx_preferred_pack()`
 -:  ---------- > 19:  14b054d272 pack-revindex: factor out `midx_key_to_pack_pos()` helper
 -:  ---------- > 20:  e99481014e pack-revindex: implement `midx_pair_to_pack_pos()`
 -:  ---------- > 21:  3e3625aebe pack-bitmap: prepare to mark objects from multiple packs for reuse
20:  46f1a03b8b ! 22:  1723cd0384 pack-objects: add tracing for various packfile metrics
    @@ builtin/pack-objects.c: int cmd_pack_objects(int argc, const char **argv, const
     +	trace2_data_intmax("pack-objects", the_repository, "packs-reused", reuse_packfiles_used_nr);
     +
      cleanup:
    - 	free_packing_data(&to_pack);
    + 	clear_packing_data(&to_pack);
      	list_objects_filter_release(&filter_options);
21:  fb764fbacc = 23:  79c830e37a t/test-lib-functions.sh: implement `test_trace2_data` helper
22:  3140a1703a ! 24:  d06b0961b5 pack-objects: allow setting `pack.allowPackReuse` to "single"
    @@ Commit message
         "single" implies the same behavior as "true", "1", "yes", and so on. But
         it will complement a new "multi" value (to be introduced in a future
         commit). When set to "single", we will only perform pack reuse on a
    -    single pack, regardless of whether or not there are multiple disjoint
    +    single pack, regardless of whether or not there are multiple MIDX'd
         packs.
     
         This requires no code changes (yet), since we only support single pack
23:  7345e39467 ! 25:  7002cf08fe pack-bitmap: reuse objects from all disjoint packs
    @@ Metadata
     Author: Taylor Blau <me@ttaylorr.com>
     
      ## Commit message ##
    -    pack-bitmap: reuse objects from all disjoint packs
    +    pack-bitmap: enable reuse from all bitmapped packs
     
         Now that both the pack-bitmap and pack-objects code are prepared to
    -    handle marking and using objects from multiple disjoint packs for
    -    verbatim reuse, allow marking objects from all disjoint packs as
    +    handle marking and using objects from multiple bitmapped packs for
    +    verbatim reuse, allow marking objects from all bitmapped packs as
         eligible for reuse.
     
         Within the `reuse_partial_packfile_from_bitmap()` function, we no longer
         only mark the pack whose first object is at bit position zero for reuse,
    -    and instead mark any pack which is flagged as disjoint by the MIDX as a
    -    reuse candidate. If no such packs exist (i.e because we are reading a
    -    MIDX written before the "DISP" chunk was introduced), then treat the
    -    preferred pack as disjoint for the purposes of reuse. This is a safe
    -    assumption to make since all duplicate objects are resolved in favor of
    -    the preferred pack.
    +    and instead mark any pack contained in the MIDX as a reuse candidate.
     
         Provide a handful of test cases in a new script (t5332) exercising
         interesting behavior for multi-pack reuse to ensure that we performed
    @@ Commit message
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
      ## Documentation/config/pack.txt ##
    -@@ Documentation/config/pack.txt: to linkgit:git-repack[1].
    +@@ Documentation/config/pack.txt: all existing objects. You can force recompression by passing the -F option
    + to linkgit:git-repack[1].
    + 
      pack.allowPackReuse::
    - 	When true or "single", and when reachability bitmaps are enabled,
    - 	pack-objects will try to send parts of the bitmapped packfile
    +-	When true or "single", and when reachability bitmaps are enabled,
    +-	pack-objects will try to send parts of the bitmapped packfile
     -	verbatim. This can reduce memory and CPU usage to serve fetches,
    -+	verbatim. When "multi", and when a multi-pack reachability bitmap is
    -+	available, pack-objects will try to send parts of all packs marked as
    -+	disjoint by the MIDX. If only a single pack bitmap is available, and
    +-	but might result in sending a slightly larger pack. Defaults to
    +-	true.
    ++	When true or "single", and when reachability bitmaps are
    ++	enabled, pack-objects will try to send parts of the bitmapped
    ++	packfile verbatim. When "multi", and when a multi-pack
    ++	reachability bitmap is available, pack-objects will try to send
    ++	parts of all packs in the MIDX.
    +++
    ++	If only a single pack bitmap is available, and
     +	`pack.allowPackReuse` is set to "multi", reuse parts of just the
    -+	bitmapped packfile. This can reduce memory and CPU usage to serve fetches,
    - 	but might result in sending a slightly larger pack. Defaults to
    - 	true.
    ++	bitmapped packfile. This can reduce memory and CPU usage to
    ++	serve fetches, but might result in sending a slightly larger
    ++	pack. Defaults to true.
      
    + pack.island::
    + 	An extended regular expression configuring a set of delta
     
      ## builtin/pack-objects.c ##
     @@ builtin/pack-objects.c: static int use_bitmap_index = -1;
    @@ builtin/pack-objects.c: static int get_object_list_from_bitmap(struct rev_info *
      		reuse_packfile_objects = bitmap_popcount(reuse_packfile_bitmap);
     
      ## pack-bitmap.c ##
    -@@ pack-bitmap.c: static void reuse_partial_packfile_from_bitmap_1(struct bitmap_index *bitmap_git
    - 	unuse_pack(&w_curs);
    - }
    - 
    -+static void make_disjoint_pack(struct bitmapped_pack *out, struct packed_git *p)
    -+{
    -+	out->p = p;
    -+	out->bitmap_pos = 0;
    -+	out->bitmap_nr = p->num_objects;
    -+	out->disjoint = 1;
    -+}
    -+
    +@@ pack-bitmap.c: static int bitmapped_pack_cmp(const void *va, const void *vb)
      void reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
      					struct bitmapped_pack **packs_out,
      					size_t *packs_nr_out,
    @@ pack-bitmap.c: void reuse_partial_packfile_from_bitmap(struct bitmap_index *bitm
      				free(packs);
      				return;
      			}
    --			if (!pack.bitmap_nr)
    ++
    + 			if (!pack.bitmap_nr)
     -				continue; /* no objects from this pack */
     -			if (pack.bitmap_pos)
     -				continue; /* not preferred pack */
    -+
    -+			if (!pack.disjoint)
     +				continue;
     +
     +			if (!multi_pack_reuse && pack.bitmap_pos) {
    @@ pack-bitmap.c: void reuse_partial_packfile_from_bitmap(struct bitmap_index *bitm
     +
     +			if (!multi_pack_reuse)
     +				break;
    -+		}
    -+
    -+		if (!packs_nr) {
    -+			/*
    -+			 * Old MIDXs (i.e. those written before the "DISP" chunk
    -+			 * existed) will not have any packs marked as disjoint.
    -+			 *
    -+			 * But we still want to perform pack reuse with the
    -+			 * special "preferred pack" as before. To do this, form
    -+			 * the singleton set containing just the preferred pack,
    -+			 * which is trivially disjoint with itself.
    -+			 *
    -+			 * Moreover, the MIDX is guaranteed to resolve duplicate
    -+			 * objects in favor of the copy in the preferred pack
    -+			 * (if one exists). Thus, we can safely perform pack
    -+			 * reuse on this pack.
    -+			 */
    -+			uint32_t preferred_pack_pos;
    -+			struct packed_git *preferred_pack;
    -+
    -+			preferred_pack_pos = midx_preferred_pack(bitmap_git);
    -+			preferred_pack = bitmap_git->midx->packs[preferred_pack_pos];
    -+
    -+			ALLOC_GROW(packs, packs_nr + 1, packs_alloc);
    -+
    -+			make_disjoint_pack(&packs[packs_nr], preferred_pack);
    -+			objects_nr = packs[packs_nr++].p->num_objects;
      		}
    - 	} else {
    + 
    + 		QSORT(packs, packs_nr, bitmapped_pack_cmp);
    +@@ pack-bitmap.c: void reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
      		ALLOC_GROW(packs, packs_nr + 1, packs_alloc);
      
    --		packs[packs_nr].p = bitmap_git->pack;
    + 		packs[packs_nr].p = bitmap_git->pack;
     -		packs[packs_nr].bitmap_pos = 0;
    --		packs[packs_nr].bitmap_nr = bitmap_git->pack->num_objects;
    --		packs[packs_nr].disjoint = 1;
    --
    -+		make_disjoint_pack(&packs[packs_nr], bitmap_git->pack);
    - 		objects_nr = packs[packs_nr++].p->num_objects;
    + 		packs[packs_nr].bitmap_nr = bitmap_git->pack->num_objects;
    ++		packs[packs_nr].bitmap_pos = 0;
    + 
    +-		objects_nr = packs[packs_nr++].p->num_objects;
    ++		objects_nr = packs[packs_nr++].bitmap_nr;
      	}
      
    + 	word_alloc = objects_nr / BITS_IN_EWORD;
     @@ pack-bitmap.c: void reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
      		word_alloc++;
      	reuse = bitmap_word_alloc(word_alloc);
    @@ pack-bitmap.c: void reuse_partial_packfile_from_bitmap(struct bitmap_index *bitm
     +	for (i = 0; i < packs_nr; i++)
     +		reuse_partial_packfile_from_bitmap_1(bitmap_git, &packs[i], reuse);
      
    - 	if (!bitmap_popcount(reuse)) {
    + 	if (bitmap_is_empty(reuse)) {
      		free(packs);
     
      ## pack-bitmap.h ##
    -@@ pack-bitmap.h: uint32_t midx_preferred_pack(struct bitmap_index *bitmap_git);
    +@@ pack-bitmap.h: struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
      void reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
      					struct bitmapped_pack **packs_out,
      					size_t *packs_nr_out,
    @@ t/t5332-multi-pack-reuse.sh (new)
     +
     +. ./test-lib.sh
     +. "$TEST_DIRECTORY"/lib-bitmap.sh
    -+. "$TEST_DIRECTORY"/lib-disjoint.sh
     +
     +objdir=.git/objects
     +packdir=$objdir/pack
     +
    -+all_packs () {
    -+	find $packdir -type f -name "*.idx" | sed -e 's/^.*\/\([^\/]\)/\1/g'
    -+}
    -+
    -+all_disjoint () {
    -+	all_packs | sed -e 's/^/+/g'
    -+}
    -+
     +test_pack_reused () {
     +	test_trace2_data pack-objects pack-reused "$1"
     +}
    @@ t/t5332-multi-pack-reuse.sh (new)
     +	grep "$1" objects | cut -d" " -f1
     +}
     +
    -+test_expect_success 'setup' '
    ++test_expect_success 'preferred pack is reused for single-pack reuse' '
    ++	test_config pack.allowPackReuse single &&
    ++
    ++	for i in A B
    ++	do
    ++		test_commit "$i" &&
    ++		git repack -d || return 1
    ++	done &&
    ++
    ++	git multi-pack-index write --bitmap &&
    ++
    ++	: >trace2.txt &&
    ++	GIT_TRACE2_EVENT="$PWD/trace2.txt" \
    ++		git pack-objects --stdout --revs --all >/dev/null &&
    ++
    ++	test_pack_reused 3 <trace2.txt &&
    ++	test_packs_reused 1 <trace2.txt
    ++'
    ++
    ++test_expect_success 'enable multi-pack reuse' '
     +	git config pack.allowPackReuse multi
     +'
     +
    -+test_expect_success 'preferred pack is reused without packs marked disjoint' '
    -+	test_commit A &&
    -+	test_commit B &&
    -+
    -+	A="$(echo A | git pack-objects --unpacked --delta-base-offset $packdir/pack)" &&
    -+	B="$(echo B | git pack-objects --unpacked --delta-base-offset $packdir/pack)" &&
    -+
    -+	git prune-packed &&
    -+
    -+	git multi-pack-index write --bitmap &&
    -+
    -+	test_must_not_be_disjoint "pack-$A.pack" &&
    -+	test_must_not_be_disjoint "pack-$B.pack" &&
    -+
    -+	: >trace2.txt &&
    -+	GIT_TRACE2_EVENT="$PWD/trace2.txt" \
    -+		git pack-objects --stdout --revs --all >/dev/null &&
    -+
    -+	test_pack_reused 3 <trace2.txt &&
    -+	test_packs_reused 1 <trace2.txt
    -+'
    -+
    -+test_expect_success 'reuse all objects from subset of disjoint packs' '
    ++test_expect_success 'reuse all objects from subset of bitmapped packs' '
     +	test_commit C &&
    ++	git repack -d &&
     +
    -+	C="$(echo C | git pack-objects --unpacked --delta-base-offset $packdir/pack)" &&
    -+
    -+	git prune-packed &&
    ++	git multi-pack-index write --bitmap &&
     +
     +	cat >in <<-EOF &&
    -+	pack-$A.idx
    -+	+pack-$B.idx
    -+	+pack-$C.idx
    ++	$(git rev-parse C)
    ++	^$(git rev-parse A)
     +	EOF
    -+	git multi-pack-index write --bitmap --stdin-packs <in &&
    -+
    -+	test_must_not_be_disjoint "pack-$A.pack" &&
    -+	test_must_be_disjoint "pack-$B.pack" &&
    -+	test_must_be_disjoint "pack-$C.pack" &&
     +
     +	: >trace2.txt &&
     +	GIT_TRACE2_EVENT="$PWD/trace2.txt" \
    -+		git pack-objects --stdout --revs --all >/dev/null &&
    ++		git pack-objects --stdout --revs <in >/dev/null &&
     +
     +	test_pack_reused 6 <trace2.txt &&
     +	test_packs_reused 2 <trace2.txt
     +'
     +
    -+test_expect_success 'reuse all objects from all disjoint packs' '
    -+	rm -fr $packdir/multi-pack-index* &&
    -+
    -+	all_disjoint >in &&
    -+	git multi-pack-index write --bitmap --stdin-packs <in &&
    -+
    -+	test_must_be_disjoint "pack-$A.pack" &&
    -+	test_must_be_disjoint "pack-$B.pack" &&
    -+	test_must_be_disjoint "pack-$C.pack" &&
    -+
    ++test_expect_success 'reuse all objects from all packs' '
     +	: >trace2.txt &&
     +	GIT_TRACE2_EVENT="$PWD/trace2.txt" \
     +		git pack-objects --stdout --revs --all >/dev/null &&
    @@ t/t5332-multi-pack-reuse.sh (new)
     +	test_packs_reused 3 <trace2.txt
     +'
     +
    -+test_expect_success 'reuse objects from first disjoint pack with middle gap' '
    -+	test_commit D &&
    -+	test_commit E &&
    -+	test_commit F &&
    ++test_expect_success 'reuse objects from first pack with middle gap' '
    ++	for i in D E F
    ++	do
    ++		test_commit "$i" || return 1
    ++	done &&
     +
     +	# Set "pack.window" to zero to ensure that we do not create any
     +	# deltas, which could alter the amount of pack reuse we perform
    @@ t/t5332-multi-pack-reuse.sh (new)
     +	# Ensure that the pack we are constructing sorts ahead of any
     +	# other packs in lexical/bitmap order by choosing it as the
     +	# preferred pack.
    -+	all_disjoint >in &&
    -+	git multi-pack-index write --bitmap --preferred-pack="pack-$D.idx" \
    -+		--stdin-packs <in &&
    -+
    -+	test_must_be_disjoint pack-$A.pack &&
    -+	test_must_be_disjoint pack-$B.pack &&
    -+	test_must_be_disjoint pack-$C.pack &&
    -+	test_must_be_disjoint pack-$D.pack &&
    ++	git multi-pack-index write --bitmap --preferred-pack="pack-$D.idx" &&
     +
     +	cat >in <<-EOF &&
     +	$(git rev-parse E)
    @@ t/t5332-multi-pack-reuse.sh (new)
     +	test_packs_reused 1 <trace2.txt
     +'
     +
    -+test_expect_success 'reuse objects from middle disjoint pack with middle gap' '
    ++test_expect_success 'reuse objects from middle pack with middle gap' '
     +	rm -fr $packdir/multi-pack-index* &&
     +
     +	# Ensure that the pack we are constructing sort into any
     +	# position *but* the first one, by choosing a different pack as
     +	# the preferred one.
    -+	all_disjoint >in &&
    -+	git multi-pack-index write --bitmap --preferred-pack="pack-$A.idx" \
    -+		--stdin-packs <in &&
    ++	git multi-pack-index write --bitmap --preferred-pack="pack-$A.idx" &&
     +
     +	cat >in <<-EOF &&
     +	$(git rev-parse E)
    @@ t/t5332-multi-pack-reuse.sh (new)
     +	test_packs_reused 1 <trace2.txt
     +'
     +
    -+test_expect_success 'omit delta with uninteresting base' '
    ++test_expect_success 'omit delta with uninteresting base (same pack)' '
     +	git repack -adk &&
     +
     +	test_seq 32 >f &&
    @@ t/t5332-multi-pack-reuse.sh (new)
     +
     +	have_delta "$(git rev-parse $delta:f)" "$(git rev-parse $base:f)" &&
     +
    -+	all_disjoint >in &&
    -+	git multi-pack-index write --bitmap --stdin-packs <in &&
    ++	git multi-pack-index write --bitmap &&
     +
     +	cat >in <<-EOF &&
     +	$(git rev-parse other)
    @@ t/t5332-multi-pack-reuse.sh (new)
     +	GIT_TRACE2_EVENT="$PWD/trace2.txt" \
     +		git pack-objects --stdout --delta-base-offset --revs <in >/dev/null &&
     +
    -+	# Even though all packs are marked disjoint, we can only reuse
    -+	# the 3 objects corresponding to "other" from the latest pack.
    ++	# We can only reuse the 3 objects corresponding to "other" from
    ++	# the latest pack.
     +	#
     +	# This is because even though we want "delta", we do not want
     +	# "base", meaning that we have to inflate the delta/base-pair
    @@ t/t5332-multi-pack-reuse.sh (new)
     +	test_packs_reused 1 <trace2.txt
     +'
     +
    ++test_expect_success 'omit delta from uninteresting base (cross pack)' '
    ++	cat >in <<-EOF &&
    ++	$(git rev-parse $base)
    ++	^$(git rev-parse $delta)
    ++	EOF
    ++
    ++	P="$(git pack-objects --revs $packdir/pack <in)" &&
    ++
    ++	git multi-pack-index write --bitmap --preferred-pack="pack-$P.idx" &&
    ++
    ++	: >trace2.txt &&
    ++	GIT_TRACE2_EVENT="$PWD/trace2.txt" \
    ++		git pack-objects --stdout --delta-base-offset --all >/dev/null &&
    ++
    ++	packs_nr="$(find $packdir -type f -name "pack-*.pack" | wc -l)" &&
    ++	objects_nr="$(git rev-list --count --all --objects)" &&
    ++
    ++	test_pack_reused $(($objects_nr - 1)) <trace2.txt &&
    ++	test_packs_reused $packs_nr <trace2.txt
    ++'
    ++
     +test_done
24:  980b318f98 = 26:  94e5ae4cf6 t/perf: add performance tests for multi-pack reuse

base-commit: 1a87c842ece327d03d08096395969aca5e0a6996
-- 
2.43.0.102.ga31d690331.dirty
