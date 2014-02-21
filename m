From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 5/6] Document a bunch of functions defined in sha1_file.c
Date: Fri, 21 Feb 2014 12:17:11 -0500 (EST)
Message-ID: <alpine.LFD.2.11.1402211216220.17677@knanqh.ubzr>
References: <1393000327-11402-1-git-send-email-mhagger@alum.mit.edu>
 <1393000327-11402-6-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Feb 21 18:17:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WGtiw-0000VF-7I
	for gcvg-git-2@plane.gmane.org; Fri, 21 Feb 2014 18:17:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933096AbaBURRO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Feb 2014 12:17:14 -0500
Received: from relais.videotron.ca ([24.201.245.36]:41189 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933095AbaBURRM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Feb 2014 12:17:12 -0500
Received: from xanadu.home ([66.130.143.177]) by VL-VM-MR004.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0N1C00F75W0NULE0@VL-VM-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 21 Feb 2014 12:17:12 -0500 (EST)
In-reply-to: <1393000327-11402-6-git-send-email-mhagger@alum.mit.edu>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242477>

On Fri, 21 Feb 2014, Michael Haggerty wrote:

> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>

Acked-by: Nicolas Pitre <nico@fluxnic.net>


> ---
>  cache.h     | 66 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
>  sha1_file.c | 26 +++++++++++++-----------
>  2 files changed, 78 insertions(+), 14 deletions(-)
> 
> diff --git a/cache.h b/cache.h
> index 1663478..e62fdec 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -659,9 +659,28 @@ extern char *git_path(const char *fmt, ...) __attribute__((format (printf, 1, 2)
>  extern char *git_path_submodule(const char *path, const char *fmt, ...)
>  	__attribute__((format (printf, 2, 3)));
>  
> +/*
> + * Return the name of the file in the local object database that would
> + * be used to store a loose object with the specified sha1.  The
> + * return value is a pointer to a statically allocated buffer that is
> + * overwritten each time the function is called.
> + */
>  extern const char *sha1_file_name(const unsigned char *sha1);
> +
> +/*
> + * Return the name of the (local) packfile with the specified sha1 in
> + * its name.  The return value is a pointer to memory that is
> + * overwritten each time this function is called.
> + */
>  extern char *sha1_pack_name(const unsigned char *sha1);
> +
> +/*
> + * Return the name of the (local) pack index file with the specified
> + * sha1 in its name.  The return value is a pointer to memory that is
> + * overwritten each time this function is called.
> + */
>  extern char *sha1_pack_index_name(const unsigned char *sha1);
> +
>  extern const char *find_unique_abbrev(const unsigned char *sha1, int);
>  extern const unsigned char null_sha1[20];
>  
> @@ -836,7 +855,19 @@ extern int check_sha1_signature(const unsigned char *sha1, void *buf, unsigned l
>  extern int move_temp_to_file(const char *tmpfile, const char *filename);
>  
>  extern int has_sha1_pack(const unsigned char *sha1);
> +
> +/*
> + * Return true iff we have an object named sha1, whether local or in
> + * an alternate object database, and whether packed or loose.  This
> + * function does not respect replace references.
> + */
>  extern int has_sha1_file(const unsigned char *sha1);
> +
> +/*
> + * Return true iff an alternate object database has a loose object
> + * with the specified name.  This function does not respect replace
> + * references.
> + */
>  extern int has_loose_object_nonlocal(const unsigned char *sha1);
>  
>  extern int has_pack_index(const unsigned char *sha1);
> @@ -1099,17 +1130,46 @@ extern struct packed_git *find_sha1_pack(const unsigned char *sha1,
>  					 struct packed_git *packs);
>  
>  extern void pack_report(void);
> +
> +/*
> + * mmap the index file for the specified packfile (if it is not
> + * already mmapped).  Return 0 on success.
> + */
>  extern int open_pack_index(struct packed_git *);
> +
> +/*
> + * munmap the index file for the specified packfile (if it is
> + * currently mmapped).
> + */
>  extern void close_pack_index(struct packed_git *);
> +
>  extern unsigned char *use_pack(struct packed_git *, struct pack_window **, off_t, unsigned long *);
>  extern void close_pack_windows(struct packed_git *);
>  extern void unuse_pack(struct pack_window **);
>  extern void free_pack_by_name(const char *);
>  extern void clear_delta_base_cache(void);
>  extern struct packed_git *add_packed_git(const char *, int, int);
> -extern const unsigned char *nth_packed_object_sha1(struct packed_git *, uint32_t);
> -extern off_t nth_packed_object_offset(const struct packed_git *, uint32_t);
> -extern off_t find_pack_entry_one(const unsigned char *, struct packed_git *);
> +
> +/*
> + * Return the SHA-1 of the nth object within the specified packfile.
> + * Open the index if it is not already open.  The return value points
> + * at the SHA-1 within the mmapped index.  Return NULL if there is an
> + * error.
> + */
> +extern const unsigned char *nth_packed_object_sha1(struct packed_git *, uint32_t n);
> +
> +/*
> + * Return the offset of the nth object within the specified packfile.
> + * The index must already be opened.
> + */
> +extern off_t nth_packed_object_offset(const struct packed_git *, uint32_t n);
> +
> +/*
> + * If the object named sha1 is present in the specified packfile,
> + * return its offset within the packfile; otherwise, return 0.
> + */
> +extern off_t find_pack_entry_one(const unsigned char *sha1, struct packed_git *);
> +
>  extern int is_pack_valid(struct packed_git *);
>  extern void *unpack_entry(struct packed_git *, off_t, enum object_type *, unsigned long *);
>  extern unsigned long unpack_object_header_buffer(const unsigned char *buf, unsigned long len, enum object_type *type, unsigned long *sizep);
> diff --git a/sha1_file.c b/sha1_file.c
> index ba62804..bb9f097 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -184,16 +184,6 @@ static void fill_sha1_path(char *pathbuf, const unsigned char *sha1)
>  	}
>  }
>  
> -/*
> - * NOTE! This returns a statically allocated buffer, so you have to be
> - * careful about using it. Do an "xstrdup()" if you need to save the
> - * filename.
> - *
> - * Also note that this returns the location for creating.  Reading
> - * SHA1 file can happen from any alternate directory listed in the
> - * DB_ENVIRONMENT environment variable if it is not found in
> - * the primary object database.
> - */
>  const char *sha1_file_name(const unsigned char *sha1)
>  {
>  	static char buf[PATH_MAX];
> @@ -214,6 +204,11 @@ const char *sha1_file_name(const unsigned char *sha1)
>  	return buf;
>  }
>  
> +/*
> + * Return the name of the pack or index file with the specified sha1
> + * in its filename.  *base and *name are scratch space that must be
> + * provided by the caller.  which should be "pack" or "idx".
> + */
>  static char *sha1_get_pack_name(const unsigned char *sha1,
>  				char **name, char **base, const char *which)
>  {
> @@ -496,7 +491,12 @@ void pack_report(void)
>  		sz_fmt(pack_mapped), sz_fmt(peak_pack_mapped));
>  }
>  
> -static int check_packed_git_idx(const char *path,  struct packed_git *p)
> +/*
> + * Open and mmap the index file at path, perform a couple of
> + * consistency checks, then record its information to p.  Return 0 on
> + * success.
> + */
> +static int check_packed_git_idx(const char *path, struct packed_git *p)
>  {
>  	void *idx_map;
>  	struct pack_idx_header *hdr;
> @@ -2449,6 +2449,10 @@ static int fill_pack_entry(const unsigned char *sha1,
>  	return 1;
>  }
>  
> +/*
> + * Iff a pack file contains the object named by sha1, return true and
> + * store its location to e.
> + */
>  static int find_pack_entry(const unsigned char *sha1, struct pack_entry *e)
>  {
>  	struct packed_git *p;
> -- 
> 1.8.5.3
> 
