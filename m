Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAFC4C63
	for <git@vger.kernel.org>; Wed, 12 Jun 2024 02:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718158325; cv=none; b=d0QL7PGLKzwZATnDim7bmAqLxx7c7UWRC+itXA4iE++5dmo3UcmP9VtIV/lN1PnaWyou95bXsiJg7NY+F69VC/bXSPfXVPIjmfTxso4bwHMG3dqyX6GHtPMAj1QMhhY3AH1KZd1MEx5rLYrd/u7dTZEqSes2ALYkzl55A0KQnH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718158325; c=relaxed/simple;
	bh=wjiKcZLfvPC94uHHoSw7pG5D9Ad4GSUyYyfMeYTUnSk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aB+jVWrnkFhCqsAQ31J2NkrhE7PRnanefGfHfCt4i6FGCTfGkeEcw75XKcx6UAWxEWPzCE22CShozFjZ4tx5+8QWBy/Bk0egKtwVZwR85KRGvoS7hNsW2LVUvcQo8EsEF/9l4JgT0hwx3dNVwmfyLbIDzQv8nDxPblUk0b46njg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=jzLf+/iG; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jzLf+/iG"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 615302C5A4;
	Tue, 11 Jun 2024 22:12:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=wjiKcZLfvPC94uHHoSw7pG5D9Ad4GSUyYyfMeY
	TUnSk=; b=jzLf+/iGdz8EblLDJMAGXpzqtUaChwsywkvqrg4oyAb5aUwax1RegW
	8AqU9Bgted8yyvsO7VwkaKxLhOeyPPZhONoOBDFuv7i4RGMBzwTYJd7mzFn5Qx9v
	oH69MbsZog0kmbqjkdrFa4bJQwQvCu9N5uOr/xdkjWDm2ToZPd6Rs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3A7732C5A3;
	Tue, 11 Jun 2024 22:12:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0BCD22C5A1;
	Tue, 11 Jun 2024 22:12:00 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Victoria Dye <vdye@github.com>
Subject: Re: [PATCH 07/16] mktree: use read_index_info to read stdin lines
In-Reply-To: <8d1e1eaa70b96779416f2f48a862d31a730c4521.1718130288.git.gitgitgadget@gmail.com>
	(Victoria Dye via GitGitGadget's message of "Tue, 11 Jun 2024 18:24:39
	+0000")
References: <pull.1746.git.1718130288.gitgitgadget@gmail.com>
	<8d1e1eaa70b96779416f2f48a862d31a730c4521.1718130288.git.gitgitgadget@gmail.com>
Date: Tue, 11 Jun 2024 19:11:59 -0700
Message-ID: <xmqqplsmrjtc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 2780CCB6-2861-11EF-A073-965B910A682E-77302942!pb-smtp2.pobox.com

"Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Victoria Dye <vdye@github.com>
>
> Replace the custom input parsing of 'mktree' with 'read_index_info()', which
> handles not only the 'ls-tree' output format it already handles but also the
> other formats compatible with 'update-index'.

Yay.

> This lends some consistency
> across the commands (avoiding the need for two similar implementations for
> input parsing) and adds flexibility to mktree.
>
> Update 'Documentation/git-mktree.txt' to reflect the more permissive input
> format.

Nice.
>  DESCRIPTION
>  -----------
> -Reads standard input in non-recursive `ls-tree` output format, and creates
> -a tree object.  The order of the tree entries is normalized by mktree so
> -pre-sorting the input is not required.  The object name of the tree object
> -built is written to the standard output.
> +Reads entry information from stdin and creates a tree object from those entries.
> +The object name of the tree object built is written to the standard output.

pre-sorting is now required?  Ah, such details are left to the
section dedicated for the input format.  Makes sense.

The line is getting overly long (the first line now is exactly
80-columns); wrapping them to leave a bit of room to grow, like
at around 72-76 columns, would be appreciated.

> +INPUT FORMAT
> +------------
> +Tree entries may be specified in any of the formats compatible with the
> +`--index-info` option to linkgit:git-update-index[1]. The order of the tree
> +entries is normalized by `mktree` so pre-sorting the input by path is not
> +required.

OK.  We might want to split the description of the three-formats
into a separate file and include it in here and in the original (I'd
certainly insist doing so if we had three places that want to refer
to it), but we have only two so let's just remember to do so when we
may want to add the third place in the future.

> diff --git a/builtin/mktree.c b/builtin/mktree.c
> index 15bd908702a..5530257252d 100644
> --- a/builtin/mktree.c
> +++ b/builtin/mktree.c
> @@ -6,6 +6,7 @@
>  #include "builtin.h"
>  #include "gettext.h"
>  #include "hex.h"
> +#include "index-info.h"
>  #include "quote.h"
>  #include "strbuf.h"
>  #include "tree.h"
> @@ -93,123 +94,80 @@ static const char *mktree_usage[] = {
>  	NULL
>  };
>  
> -static void mktree_line(char *buf, int nul_term_line, int allow_missing,
> -			struct tree_entry_array *arr)
> +struct mktree_line_data {
> +	struct tree_entry_array *arr;
> +	int allow_missing;
> +};
> +
> +static int mktree_line(unsigned int mode, struct object_id *oid,
> +		       enum object_type obj_type, int stage UNUSED,
> +		       const char *path, void *cbdata)
>  {
> +	struct mktree_line_data *data = cbdata;
> +	enum object_type mode_type = object_type(mode);
>  	struct object_info oi = OBJECT_INFO_INIT;
> +	enum object_type parsed_obj_type;
>  
> +	if (obj_type && mode_type != obj_type)
> +		die("object type (%s) doesn't match mode type (%s)",
> +		    type_name(obj_type), type_name(mode_type));
>  
> +	oi.typep = &parsed_obj_type;
>  
> +	if (oid_object_info_extended(the_repository, oid, &oi,
>  				     OBJECT_INFO_LOOKUP_REPLACE |
>  				     OBJECT_INFO_QUICK |
>  				     OBJECT_INFO_SKIP_FETCH_OBJECT) < 0)
> +		parsed_obj_type = -1;
>  
> +	if (parsed_obj_type < 0) {
> +		if (data->allow_missing || S_ISGITLINK(mode)) {
> +			; /* no problem - missing objects & submodules are presumed to be of the right type */

Overlong line?

>  		} else {
> +			die("entry '%s' object %s is unavailable", path, oid_to_hex(oid));
>  		}

Each side of if/else has only a single statement block that does not
want {braces} around it.  I wonder if flipping the polarity makes it
easier to follow the logic flow:

		if (!data->allow_missing && !S_ISGITLINK(mode))
			die("...");

I wonder if we even want to do the oid_object_info_extended() when
we are expecting to see a gitlink.  We do not expect to have the
commit in our history (as it is part of the history of a submodule,
which is from a separate project), so even if we found such an
object in our object database, we do not want to do anything with
the information we learn about the object.

So I am wondering if the whole cascade should read more like

	if (S_ISGITILNK(mode)) {
		... anything goes ...
	} else if (oid_object_info_extended(...) < 0 &&
		   !data->allow_missing) {
        	... not found ...
	} else if (parsed_obj_type != mode_type) {
        	... found something different from what we expected ...
	}

The main loop, thanks to read_index_info() refactoring, got really
easier to read, i.e. compact and clear.
