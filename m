From: Dave Abrahams <dave@boostpro.com>
Subject: Re: fast-import bug?
Date: Sun, 23 Jun 2013 07:19:25 -0700
Message-ID: <m2ppvc29le.fsf@cube.gateway.2wire.net>
References: <m2zjuj2504.fsf@cube.gateway.2wire.net>
	<20130622102157.GE4676@serenity.lan>
	<m2txkp1shb.fsf@cube.gateway.2wire.net>
	<20130623110933.GG4676@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sun Jun 23 16:19:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uql8Z-0003Gz-QJ
	for gcvg-git-2@plane.gmane.org; Sun, 23 Jun 2013 16:19:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751509Ab3FWOTY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 23 Jun 2013 10:19:24 -0400
Received: from mail-gh0-f173.google.com ([209.85.160.173]:40508 "EHLO
	mail-gh0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751191Ab3FWOTX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 23 Jun 2013 10:19:23 -0400
Received: by mail-gh0-f173.google.com with SMTP id g16so2996428ghb.4
        for <git@vger.kernel.org>; Sun, 23 Jun 2013 07:19:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=TdHNpFkjq+YXF5mL9vFSBzUYJ52qA6hJ6rjOEAjk2SY=;
        b=kxHm9eTcUnxP9EFhDyBve41+0pTFQSBQKS0SNVg00k06eY2QvazhaII5ngKskAXbeP
         ioweruGPwMo4ajrgGDMC0quzkzHDAESz3RD2O/ls2pdQYQkPS3TaVckRJPs27ktxOnhk
         h+6qx6CarX/DTWoPqLZ6ToA48LK7WpzyrY+FiY0Yr/aVsZ50qKTMV+oVgfjIcNHWqJFY
         PzxqhDDnpA2CNv0ncrxHX4Ub5Kh4XTcSAOUnJ7lJvrIAUi71PXxwczBx39McMrzjDJUK
         WoONLhWMhGgxYye11lcvNB6qTn0AY7bHj8OZHhwW9NRF5NdjQ/7CjadieJ0Eg7m9XdjC
         +Vkg==
X-Received: by 10.236.146.8 with SMTP id q8mr11143216yhj.72.1371997162472;
        Sun, 23 Jun 2013 07:19:22 -0700 (PDT)
Received: from pluto.boostpro.com (107-219-149-247.lightspeed.sntcca.sbcglobal.net. [107.219.149.247])
        by mx.google.com with ESMTPSA id d91sm23352104yhq.16.2013.06.23.07.19.20
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 23 Jun 2013 07:19:21 -0700 (PDT)
Received: by pluto.boostpro.com (Postfix, from userid 501)
	id 6F0F925AA91E; Sun, 23 Jun 2013 07:19:25 -0700 (PDT)
In-Reply-To: <20130623110933.GG4676@serenity.lan> (John Keeping's message of
	"Sun, 23 Jun 2013 12:09:33 +0100")
User-Agent: Gnus/5.130006 (Ma Gnus v0.6) Emacs/24.2.93 (darwin)
X-Gm-Message-State: ALoCoQl9tl0vNC2OPqiPcsjQRreJ5AZO+P9YURfZox2YgUdodsMrwtoVYZv/WnuOi+RVcve/3qVO
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228738>


on Sun Jun 23 2013, John Keeping <john-AT-keeping.me.uk> wrote:

> On Sat, Jun 22, 2013 at 07:16:48PM -0700, Dave Abrahams wrote:
>>                                              I also note that the do=
cs
>> don't make it clear that quoting the path is mandatory if it might t=
urn
>> out to be empty.
>
> That's not quite the case.  It looks to me like quoting the path is
> mandatory if no "<dataref>" is given, and indeed the documentation sa=
ys:
>
>    Reading from the active commit
>        This form can only be used in the middle of a commit. The path
>        names a directory entry within fast-import=E2=80=99s active co=
mmit. The
>        path must be quoted in this case.
>
>                'ls' SP <path> LF

Oops; good eye.

>> > It seems to be slightly more complicated than that though, because=
 after
>> > allowing empty trees I get the "missing" message for the root tree=
=2E
>>=20
>> Yeah, I've tried to patch Git to solve this but ran into that proble=
m
>> and gave up.
>>=20
>> > This seems to be because its mode is 0 and not S_IFDIR.
>>=20
>> Aha.
>>=20
>> > With the patch below, things are working as I expect=20
>>=20
>> Awesome; works for me, too!
>>=20
>> > but I don't understand why the mode of the root is not set correct=
ly
>> > at this point.  Perhaps someone more familiar with fast-import wil=
l
>> > have some insight...
>>=20
>> Yeah... there's no bug tracker for Git, right?  So if nobody pays
>> attention to this thread, the problem will persist?
>
> Yes, but I don't see that happening particularly often.  In the worst
> case issues are normally documented by a failing test case.

The reason I ask is because from scouring this list it looks like
there's a history of people having issues with this, and someone
intended to get to a fix in sometime around 1.17.10, but nothing ever
happened.

> In this case, I think I do now understand why the mode is 0: in
> parse_ls a new tree object is created and the SHA1 of the original is
> copied in but the mode is left blank; clearly this should be set to
> S_IFDIR when the SHA1 is non-null.
>
> I think the patch I now have is correct (and addresses the "copy from
> root" scenario), but I need to spend some time understanding t9300 so
> that I can add suitable test cases.

t9300? =20

Thanks; I'll try this one too.

> -- >8 --
> diff --git a/fast-import.c b/fast-import.c
> index 23f625f..e2c9d50 100644
> --- a/fast-import.c
> +++ b/fast-import.c
> @@ -1629,7 +1629,8 @@ del_entry:
>  static int tree_content_get(
>  	struct tree_entry *root,
>  	const char *p,
> -	struct tree_entry *leaf)
> +	struct tree_entry *leaf,
> +	int allow_root)
>  {
>  	struct tree_content *t;
>  	const char *slash1;
> @@ -1641,31 +1642,39 @@ static int tree_content_get(
>  		n =3D slash1 - p;
>  	else
>  		n =3D strlen(p);
> -	if (!n)
> +	if (!n && !allow_root)
>  		die("Empty path component found in input");
>
>  	if (!root->tree)
>  		load_tree(root);
> +
> +	if (!n) {
> +		e =3D root;
> +		goto found_entry;
> +	}
> +
>  	t =3D root->tree;
>  	for (i =3D 0; i < t->entry_count; i++) {
>  		e =3D t->entries[i];
>  		if (e->name->str_len =3D=3D n && !strncmp_icase(p, e->name->str_da=
t, n)) {
> -			if (!slash1) {
> -				memcpy(leaf, e, sizeof(*leaf));
> -				if (e->tree && is_null_sha1(e->versions[1].sha1))
> -					leaf->tree =3D dup_tree_content(e->tree);
> -				else
> -					leaf->tree =3D NULL;
> -				return 1;
> -			}
> +			if (!slash1)
> +				goto found_entry;
>  			if (!S_ISDIR(e->versions[1].mode))
>  				return 0;
>  			if (!e->tree)
>  				load_tree(e);
> -			return tree_content_get(e, slash1 + 1, leaf);
> +			return tree_content_get(e, slash1 + 1, leaf, 0);
>  		}
>  	}
>  	return 0;
> +
> +found_entry:
> +	memcpy(leaf, e, sizeof(*leaf));
> +	if (e->tree && is_null_sha1(e->versions[1].sha1))
> +		leaf->tree =3D dup_tree_content(e->tree);
> +	else
> +		leaf->tree =3D NULL;
> +	return 1;
>  }
>
>  static int update_branch(struct branch *b)
> @@ -2415,7 +2424,7 @@ static void file_change_cr(struct branch *b, in=
t rename)
>  	if (rename)
>  		tree_content_remove(&b->branch_tree, s, &leaf);
>  	else
> -		tree_content_get(&b->branch_tree, s, &leaf);
> +		tree_content_get(&b->branch_tree, s, &leaf, 1);
>  	if (!leaf.versions[1].mode)
>  		die("Path %s not in branch", s);
>  	if (!*d) {	/* C "path/to/subdir" "" */
> @@ -3051,6 +3060,8 @@ static void parse_ls(struct branch *b)
>  		struct object_entry *e =3D parse_treeish_dataref(&p);
>  		root =3D new_tree_entry();
>  		hashcpy(root->versions[1].sha1, e->idx.sha1);
> +		if (!is_null_sha1(root->versions[1].sha1))
> +			root->versions[1].mode =3D S_IFDIR;
>  		load_tree(root);
>  		if (*p++ !=3D ' ')
>  			die("Missing space after tree-ish: %s", command_buf.buf);
> @@ -3065,7 +3076,7 @@ static void parse_ls(struct branch *b)
>  			die("Garbage after path in: %s", command_buf.buf);
>  		p =3D uq.buf;
>  	}
> -	tree_content_get(root, p, &leaf);
> +	tree_content_get(root, p, &leaf, 1);
>  	/*
>  	 * A directory in preparation would have a sha1 of zero
>  	 * until it is saved.  Save, for simplicity.

--=20
Dave Abrahams
