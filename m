Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639591CBEB6
	for <git@vger.kernel.org>; Wed, 30 Oct 2024 05:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730266262; cv=none; b=nErp5NOwT7nGqpjbNetpAQjGok/7kORkIKBD6RmTuN/0v1pCBEJrpg/CMTGRUdutHQdlvG8Aq5V7CRcI8kgUuWzRYLwTDvG8Fz6LOOTgznBIbGmg/euP7CVA1ZBVl+GsGqvmAw9t1z1r3x8yE+HL2Mm6hfdNNB43Yisa0gPeYxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730266262; c=relaxed/simple;
	bh=Fe7UNTY7iMHNv0ruqTOszgz4R7dY1LRAyRfard0Sm0I=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O+De+Zq6j8qs4A567txI/+ZSLpZrDXkj7VDhu3+L/rT3GoKzfRaupKilqhwe5Z9mycOUEyxdfXbvA48E4WQhLi7d32Mv71lSdehP4Dik71AouvOAbOMvZ6vHz9R6bMzTLXlfRyNcFgMLxvV09glQzjAMRyyJZZUYQVhCKMtSl3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=DhlS9Y/p; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="DhlS9Y/p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1730266257; x=1730525457;
	bh=3josHGFU/a+5aTF9PCcAIDCiqMlqkG3F8qiLjSHdM2g=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=DhlS9Y/p6/aOjrqFRTg+cPrDCgpyGrtvof3eQFmsqfhP7cOPOPqOm9gyjU6vYOhsA
	 8mPKe26m384tiJgKxeW03pD3gmM5JKU9nEJ2uLFsCHY+1P/Okf14+NlHKphiCKNAO0
	 LynuZ+6X+GqGCWSWHb0qEaXRbO4Nwmq0VdAtmuP4cRjkJhJbZ6f7QVm0mWAvxpNJxv
	 DpatSWAsAu+aOUccVQNsD8DqQyWFyBm3giVSOHEX0LJ6JydSLhXBB5mI9F7op9tf60
	 e/DFfpjzYnZ0BkFY//lKJ1U8DryDJzAmAUWuo+dg0SyXb5vmIDssD967fJR4RRW6Uo
	 GrESz/YIzucNg==
Date: Wed, 30 Oct 2024 05:30:53 +0000
To: phillip.wood@dunelm.org.uk, git@vger.kernel.org
From: Caleb White <cdwhite3@pm.me>
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 2/5] worktree: add `write_worktree_linking_files` function
Message-ID: <D58W71B3R4HV.WWTA6V6UJ9IP@pm.me>
In-Reply-To: <4a316a5f-9360-4f24-843f-bcbb5b3378c4@gmail.com>
References: <20241028-wt_relative_options-v2-0-33a5021bd7bb@pm.me> <20241028-wt_relative_options-v2-2-33a5021bd7bb@pm.me> <4a316a5f-9360-4f24-843f-bcbb5b3378c4@gmail.com>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: bff05f50973027e8176e19a56b938786e3fcb983
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue Oct 29, 2024 at 9:52 AM CDT, Phillip Wood wrote:
> On 28/10/2024 19:09, Caleb White wrote:
>> This also teachs `git worktree repair` to fix the linking files if
>> there is an absolute/relative paths but the links are correct. E.g.,
>> `git worktree repair` can be used to convert a valid worktree between
>> absolute and relative paths.
>
> This might be better as a separate step so that reviewers can
> concentrate on the correctness of write_werktree_linking_files() when
> reviewing this patch.

I'm planning on splitting this patch into separate patches for `add`,
`move`, and `repair` commands. This can likely be done in the same
patch as the `repair` command as it shouldn't be too difficult to
follow at that point.

Best,
Caleb

>> Signed-off-by: Caleb White <cdwhite3@pm.me>
>> ---
>>   builtin/worktree.c |  11 +----
>>   worktree.c         | 118 +++++++++++++++++++++++++++------------------=
--------
>>   worktree.h         |  12 ++++++
>>   3 files changed, 74 insertions(+), 67 deletions(-)
>>
>> diff --git a/builtin/worktree.c b/builtin/worktree.c
>> index c1130be5890c905c0b648782a834eb8dfcd79ba5..bb06830d6fe82aa97833c6e8=
7f034115dfaa23bd 100644
>> --- a/builtin/worktree.c
>> +++ b/builtin/worktree.c
>> @@ -417,8 +417,7 @@ static int add_worktree(const char *path, const char=
 *refname,
>>   =09=09=09const struct add_opts *opts)
>>   {
>>   =09struct strbuf sb_git =3D STRBUF_INIT, sb_repo =3D STRBUF_INIT;
>> -=09struct strbuf sb =3D STRBUF_INIT, sb_tmp =3D STRBUF_INIT;
>> -=09struct strbuf sb_path_realpath =3D STRBUF_INIT, sb_repo_realpath =3D=
 STRBUF_INIT;
>> +=09struct strbuf sb =3D STRBUF_INIT;
>>   =09const char *name;
>>   =09struct strvec child_env =3D STRVEC_INIT;
>>   =09unsigned int counter =3D 0;
>> @@ -494,10 +493,7 @@ static int add_worktree(const char *path, const cha=
r *refname,
>>
>>   =09strbuf_reset(&sb);
>>   =09strbuf_addf(&sb, "%s/gitdir", sb_repo.buf);
>> -=09strbuf_realpath(&sb_path_realpath, path, 1);
>> -=09strbuf_realpath(&sb_repo_realpath, sb_repo.buf, 1);
>> -=09write_file(sb.buf, "%s/.git", relative_path(sb_path_realpath.buf, sb=
_repo_realpath.buf, &sb_tmp));
>> -=09write_file(sb_git.buf, "gitdir: %s", relative_path(sb_repo_realpath.=
buf, sb_path_realpath.buf, &sb_tmp));
>> +=09write_worktree_linking_files(sb_git, sb);
>>   =09strbuf_reset(&sb);
>>   =09strbuf_addf(&sb, "%s/commondir", sb_repo.buf);
>>   =09write_file(sb.buf, "../..");
>> @@ -581,12 +577,9 @@ static int add_worktree(const char *path, const cha=
r *refname,
>>
>>   =09strvec_clear(&child_env);
>>   =09strbuf_release(&sb);
>> -=09strbuf_release(&sb_tmp);
>>   =09strbuf_release(&symref);
>>   =09strbuf_release(&sb_repo);
>> -=09strbuf_release(&sb_repo_realpath);
>>   =09strbuf_release(&sb_git);
>> -=09strbuf_release(&sb_path_realpath);
>>   =09strbuf_release(&sb_name);
>>   =09free_worktree(wt);
>>   =09return ret;
>> diff --git a/worktree.c b/worktree.c
>> index de5c5e53a5f2a758ddf470b5d6a9ad6c66247181..f4cee73d7a1edecafdff30b6=
d5e2d9dd1365b93e 100644
>> --- a/worktree.c
>> +++ b/worktree.c
>> @@ -381,29 +381,24 @@ int validate_worktree(const struct worktree *wt, s=
truct strbuf *errmsg,
>>   void update_worktree_location(struct worktree *wt, const char *path_)
>>   {
>>   =09struct strbuf path =3D STRBUF_INIT;
>> -=09struct strbuf repo =3D STRBUF_INIT;
>> -=09struct strbuf file =3D STRBUF_INIT;
>> -=09struct strbuf tmp =3D STRBUF_INIT;
>> +=09struct strbuf dotgit =3D STRBUF_INIT;
>> +=09struct strbuf gitdir =3D STRBUF_INIT;
>>
>>   =09if (is_main_worktree(wt))
>>   =09=09BUG("can't relocate main worktree");
>>
>> -=09strbuf_realpath(&repo, git_common_path("worktrees/%s", wt->id), 1);
>> +=09strbuf_realpath(&gitdir, git_common_path("worktrees/%s/gitdir", wt->=
id), 1);
>>   =09strbuf_realpath(&path, path_, 1);
>> +=09strbuf_addf(&dotgit, "%s/.git", path.buf);
>>   =09if (fspathcmp(wt->path, path.buf)) {
>> -=09=09strbuf_addf(&file, "%s/gitdir", repo.buf);
>> -=09=09write_file(file.buf, "%s/.git", relative_path(path.buf, repo.buf,=
 &tmp));
>> -=09=09strbuf_reset(&file);
>> -=09=09strbuf_addf(&file, "%s/.git", path.buf);
>> -=09=09write_file(file.buf, "gitdir: %s", relative_path(repo.buf, path.b=
uf, &tmp));
>> +=09=09write_worktree_linking_files(dotgit, gitdir);
>>
>>   =09=09free(wt->path);
>>   =09=09wt->path =3D strbuf_detach(&path, NULL);
>>   =09}
>>   =09strbuf_release(&path);
>> -=09strbuf_release(&repo);
>> -=09strbuf_release(&file);
>> -=09strbuf_release(&tmp);
>> +=09strbuf_release(&dotgit);
>> +=09strbuf_release(&gitdir);
>>   }
>>
>>   int is_worktree_being_rebased(const struct worktree *wt,
>> @@ -582,9 +577,9 @@ static void repair_gitfile(struct worktree *wt,
>>   =09=09=09   worktree_repair_fn fn, void *cb_data)
>>   {
>>   =09struct strbuf dotgit =3D STRBUF_INIT;
>> +=09struct strbuf gitdir =3D STRBUF_INIT;
>>   =09struct strbuf repo =3D STRBUF_INIT;
>>   =09struct strbuf backlink =3D STRBUF_INIT;
>> -=09struct strbuf tmp =3D STRBUF_INIT;
>>   =09char *dotgit_contents =3D NULL;
>>   =09const char *repair =3D NULL;
>>   =09int err;
>> @@ -600,6 +595,7 @@ static void repair_gitfile(struct worktree *wt,
>>
>>   =09strbuf_realpath(&repo, git_common_path("worktrees/%s", wt->id), 1);
>>   =09strbuf_addf(&dotgit, "%s/.git", wt->path);
>> +=09strbuf_addf(&gitdir, "%s/gitdir", repo.buf);
>>   =09dotgit_contents =3D xstrdup_or_null(read_gitfile_gently(dotgit.buf,=
 &err));
>>
>>   =09if (dotgit_contents) {
>> @@ -617,18 +613,20 @@ static void repair_gitfile(struct worktree *wt,
>>   =09=09repair =3D _(".git file broken");
>>   =09else if (fspathcmp(backlink.buf, repo.buf))
>>   =09=09repair =3D _(".git file incorrect");
>> +=09else if (use_relative_paths =3D=3D is_absolute_path(dotgit_contents)=
)
>> +=09=09repair =3D _(".git file absolute/relative path mismatch");
>>
>>   =09if (repair) {
>>   =09=09fn(0, wt->path, repair, cb_data);
>> -=09=09write_file(dotgit.buf, "gitdir: %s", relative_path(repo.buf, wt->=
path, &tmp));
>> +=09=09write_worktree_linking_files(dotgit, gitdir);
>>   =09}
>>
>>   done:
>>   =09free(dotgit_contents);
>>   =09strbuf_release(&repo);
>>   =09strbuf_release(&dotgit);
>> +=09strbuf_release(&gitdir);
>>   =09strbuf_release(&backlink);
>> -=09strbuf_release(&tmp);
>>   }
>>
>>   static void repair_noop(int iserr UNUSED,
>> @@ -653,45 +651,30 @@ void repair_worktrees(worktree_repair_fn fn, void =
*cb_data)
>>
>>   void repair_worktree_after_gitdir_move(struct worktree *wt, const char=
 *old_path)
>>   {
>> -=09struct strbuf path =3D STRBUF_INIT;
>> -=09struct strbuf repo =3D STRBUF_INIT;
>>   =09struct strbuf gitdir =3D STRBUF_INIT;
>>   =09struct strbuf dotgit =3D STRBUF_INIT;
>> -=09struct strbuf olddotgit =3D STRBUF_INIT;
>> -=09struct strbuf tmp =3D STRBUF_INIT;
>>
>>   =09if (is_main_worktree(wt))
>>   =09=09goto done;
>>
>> -=09strbuf_realpath(&repo, git_common_path("worktrees/%s", wt->id), 1);
>> -=09strbuf_addf(&gitdir, "%s/gitdir", repo.buf);
>> +=09strbuf_realpath(&gitdir, git_common_path("worktrees/%s/gitdir", wt->=
id), 1);
>>
>> -=09if (strbuf_read_file(&olddotgit, gitdir.buf, 0) < 0)
>> +=09if (strbuf_read_file(&dotgit, gitdir.buf, 0) < 0)
>>   =09=09goto done;
>>
>> -=09strbuf_rtrim(&olddotgit);
>> -=09if (is_absolute_path(olddotgit.buf)) {
>> -=09=09strbuf_addbuf(&dotgit, &olddotgit);
>> -=09} else {
>> -=09=09strbuf_addf(&dotgit, "%s/worktrees/%s/%s", old_path, wt->id, oldd=
otgit.buf);
>> +=09strbuf_rtrim(&dotgit);
>> +=09if (!is_absolute_path(dotgit.buf)) {
>> +=09=09strbuf_insertf(&dotgit, 0, "%s/worktrees/%s/", old_path, wt->id);
>>   =09=09strbuf_realpath_forgiving(&dotgit, dotgit.buf, 0);
>>   =09}
>>
>>   =09if (!file_exists(dotgit.buf))
>>   =09=09goto done;
>>
>> -=09strbuf_addbuf(&path, &dotgit);
>> -=09strbuf_strip_suffix(&path, "/.git");
>> -
>> -=09write_file(dotgit.buf, "gitdir: %s", relative_path(repo.buf, path.bu=
f, &tmp));
>> -=09write_file(gitdir.buf, "%s", relative_path(dotgit.buf, repo.buf, &tm=
p));
>> +=09write_worktree_linking_files(dotgit, gitdir);
>>   done:
>> -=09strbuf_release(&path);
>> -=09strbuf_release(&repo);
>>   =09strbuf_release(&gitdir);
>>   =09strbuf_release(&dotgit);
>> -=09strbuf_release(&olddotgit);
>> -=09strbuf_release(&tmp);
>>   }
>>
>>   void repair_worktrees_after_gitdir_move(const char *old_path)
>> @@ -766,13 +749,10 @@ void repair_worktree_at_path(const char *path,
>>   =09=09=09     worktree_repair_fn fn, void *cb_data)
>>   {
>>   =09struct strbuf dotgit =3D STRBUF_INIT;
>> -=09struct strbuf realdotgit =3D STRBUF_INIT;
>>   =09struct strbuf backlink =3D STRBUF_INIT;
>>   =09struct strbuf inferred_backlink =3D STRBUF_INIT;
>>   =09struct strbuf gitdir =3D STRBUF_INIT;
>>   =09struct strbuf olddotgit =3D STRBUF_INIT;
>> -=09struct strbuf realolddotgit =3D STRBUF_INIT;
>> -=09struct strbuf tmp =3D STRBUF_INIT;
>>   =09char *dotgit_contents =3D NULL;
>>   =09const char *repair =3D NULL;
>>   =09int err;
>> @@ -784,25 +764,25 @@ void repair_worktree_at_path(const char *path,
>>   =09=09goto done;
>>
>>   =09strbuf_addf(&dotgit, "%s/.git", path);
>> -=09if (!strbuf_realpath(&realdotgit, dotgit.buf, 0)) {
>> +=09if (!strbuf_realpath(&dotgit, dotgit.buf, 0)) {
>>   =09=09fn(1, path, _("not a valid path"), cb_data);
>>   =09=09goto done;
>>   =09}
>>
>> -=09infer_backlink(realdotgit.buf, &inferred_backlink);
>> +=09infer_backlink(dotgit.buf, &inferred_backlink);
>>   =09strbuf_realpath_forgiving(&inferred_backlink, inferred_backlink.buf=
, 0);
>> -=09dotgit_contents =3D xstrdup_or_null(read_gitfile_gently(realdotgit.b=
uf, &err));
>> +=09dotgit_contents =3D xstrdup_or_null(read_gitfile_gently(dotgit.buf, =
&err));
>>   =09if (dotgit_contents) {
>>   =09=09if (is_absolute_path(dotgit_contents)) {
>>   =09=09=09strbuf_addstr(&backlink, dotgit_contents);
>>   =09=09} else {
>> -=09=09=09strbuf_addbuf(&backlink, &realdotgit);
>> +=09=09=09strbuf_addbuf(&backlink, &dotgit);
>>   =09=09=09strbuf_strip_suffix(&backlink, ".git");
>>   =09=09=09strbuf_addstr(&backlink, dotgit_contents);
>>   =09=09=09strbuf_realpath_forgiving(&backlink, backlink.buf, 0);
>>   =09=09}
>>   =09} else if (err =3D=3D READ_GITFILE_ERR_NOT_A_FILE) {
>> -=09=09fn(1, realdotgit.buf, _("unable to locate repository; .git is not=
 a file"), cb_data);
>> +=09=09fn(1, dotgit.buf, _("unable to locate repository; .git is not a f=
ile"), cb_data);
>>   =09=09goto done;
>>   =09} else if (err =3D=3D READ_GITFILE_ERR_NOT_A_REPO) {
>>   =09=09if (inferred_backlink.len) {
>> @@ -815,11 +795,11 @@ void repair_worktree_at_path(const char *path,
>>   =09=09=09 */
>>   =09=09=09strbuf_swap(&backlink, &inferred_backlink);
>>   =09=09} else {
>> -=09=09=09fn(1, realdotgit.buf, _("unable to locate repository; .git fil=
e does not reference a repository"), cb_data);
>> +=09=09=09fn(1, dotgit.buf, _("unable to locate repository; .git file do=
es not reference a repository"), cb_data);
>>   =09=09=09goto done;
>>   =09=09}
>>   =09} else {
>> -=09=09fn(1, realdotgit.buf, _("unable to locate repository; .git file b=
roken"), cb_data);
>> +=09=09fn(1, dotgit.buf, _("unable to locate repository; .git file broke=
n"), cb_data);
>>   =09=09goto done;
>>   =09}
>>
>> @@ -841,39 +821,35 @@ void repair_worktree_at_path(const char *path,
>>   =09 * in the "copy" repository. In this case, point the "copy" worktre=
e's
>>   =09 * .git file at the "copy" repository.
>>   =09 */
>> -=09if (inferred_backlink.len && fspathcmp(backlink.buf, inferred_backli=
nk.buf)) {
>> +=09if (inferred_backlink.len && fspathcmp(backlink.buf, inferred_backli=
nk.buf))
>>   =09=09strbuf_swap(&backlink, &inferred_backlink);
>> -=09}
>>
>>   =09strbuf_addf(&gitdir, "%s/gitdir", backlink.buf);
>>   =09if (strbuf_read_file(&olddotgit, gitdir.buf, 0) < 0)
>>   =09=09repair =3D _("gitdir unreadable");
>> +=09else if (use_relative_paths =3D=3D is_absolute_path(olddotgit.buf))
>> +=09=09repair =3D _("gitdir absolute/relative path mismatch");
>>   =09else {
>>   =09=09strbuf_rtrim(&olddotgit);
>> -=09=09if (is_absolute_path(olddotgit.buf)) {
>> -=09=09=09strbuf_addbuf(&realolddotgit, &olddotgit);
>> -=09=09} else {
>> -=09=09=09strbuf_addf(&realolddotgit, "%s/%s", backlink.buf, olddotgit.b=
uf);
>> -=09=09=09strbuf_realpath_forgiving(&realolddotgit, realolddotgit.buf, 0=
);
>> +=09=09if (!is_absolute_path(olddotgit.buf)) {
>> +=09=09=09strbuf_insertf(&olddotgit, 0, "%s/", backlink.buf);
>> +=09=09=09strbuf_realpath_forgiving(&olddotgit, olddotgit.buf, 0);
>>   =09=09}
>> -=09=09if (fspathcmp(realolddotgit.buf, realdotgit.buf))
>> +=09=09if (fspathcmp(olddotgit.buf, dotgit.buf))
>>   =09=09=09repair =3D _("gitdir incorrect");
>>   =09}
>>
>>   =09if (repair) {
>>   =09=09fn(0, gitdir.buf, repair, cb_data);
>> -=09=09write_file(gitdir.buf, "%s", relative_path(realdotgit.buf, backli=
nk.buf, &tmp));
>> +=09=09write_worktree_linking_files(dotgit, gitdir);
>>   =09}
>>   done:
>>   =09free(dotgit_contents);
>>   =09strbuf_release(&olddotgit);
>> -=09strbuf_release(&realolddotgit);
>>   =09strbuf_release(&backlink);
>>   =09strbuf_release(&inferred_backlink);
>>   =09strbuf_release(&gitdir);
>> -=09strbuf_release(&realdotgit);
>>   =09strbuf_release(&dotgit);
>> -=09strbuf_release(&tmp);
>>   }
>>
>>   int should_prune_worktree(const char *id, struct strbuf *reason, char =
**wtpath, timestamp_t expire)
>> @@ -1034,3 +1010,29 @@ int init_worktree_config(struct repository *r)
>>   =09free(main_worktree_file);
>>   =09return res;
>>   }
>> +
>> +void write_worktree_linking_files(struct strbuf dotgit, struct strbuf g=
itdir)
>> +{
>> +=09struct strbuf path =3D STRBUF_INIT;
>> +=09struct strbuf repo =3D STRBUF_INIT;
>> +=09struct strbuf tmp =3D STRBUF_INIT;
>> +
>> +=09strbuf_addbuf(&path, &dotgit);
>> +=09strbuf_strip_suffix(&path, "/.git");
>> +=09strbuf_realpath(&path, path.buf, 1);
>> +=09strbuf_addbuf(&repo, &gitdir);
>> +=09strbuf_strip_suffix(&repo, "/gitdir");
>> +=09strbuf_realpath(&repo, repo.buf, 1);
>> +
>> +=09if (use_relative_paths) {
>> +=09=09write_file(gitdir.buf, "%s/.git", relative_path(path.buf, repo.bu=
f, &tmp));
>> +=09=09write_file(dotgit.buf, "gitdir: %s", relative_path(repo.buf, path=
.buf, &tmp));
>> +=09} else {
>> +=09=09write_file(gitdir.buf, "%s/.git", path.buf);
>> +=09=09write_file(dotgit.buf, "gitdir: %s", repo.buf);
>> +=09}
>> +
>> +=09strbuf_release(&path);
>> +=09strbuf_release(&repo);
>> +=09strbuf_release(&tmp);
>> +}
>> diff --git a/worktree.h b/worktree.h
>> index 37e65d508ed23d3e7a29850bb938285072a3aaa6..5929089891c97318a8f5329f=
7938264c717050d5 100644
>> --- a/worktree.h
>> +++ b/worktree.h
>> @@ -217,4 +217,16 @@ void strbuf_worktree_ref(const struct worktree *wt,
>>    */
>>   int init_worktree_config(struct repository *r);
>>
>> +/**
>> + * Write the .git file and gitdir file that links the worktree to the r=
epository.
>> + *
>> + * The `dotgit` parameter is the path to the worktree's .git file, and =
`gitdir`
>> + * is the path to the repository's `gitdir` file.
>> + *
>> + * Example
>> + *  dotgit: "/path/to/foo/.git"
>> + *  gitdir: "/path/to/repo/worktrees/foo/gitdir"
>> + */
>> +void write_worktree_linking_files(struct strbuf dotgit, struct strbuf g=
itdir);
>> +
>>   #endif
>>


