From: Vicent Marti <vicent@github.com>
Subject: [ANNOUNCE] libgit2 v0.12.0
Date: Wed, 11 May 2011 01:12:46 +0300
Message-ID: <BANLkTi=NesUc=9eZp7SapkpZ2MkdgPCZHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: libgit2@librelist.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 11 00:13:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJvB5-0007JE-Av
	for gcvg-git-2@lo.gmane.org; Wed, 11 May 2011 00:13:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752852Ab1EJWNK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2011 18:13:10 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:62590 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752181Ab1EJWNI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2011 18:13:08 -0400
Received: by wwa36 with SMTP id 36so7368014wwa.1
        for <git@vger.kernel.org>; Tue, 10 May 2011 15:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:from:date
         :x-google-sender-auth:message-id:subject:to:content-type;
        bh=zlpfxD6OHTlLF/no9m3UgDnS/eO1jjtxKtg1VW883Z8=;
        b=RP1Nqf5SJ82f9zim/h2aaaAstFcH85YrES8iNQsuywwPA7jY5tPckpmJi2xiQn9oB7
         PAM8ncSnT3nQhglf7IsVQGpYECw/JDDucS3TBEmRokaTcxNn3y1RLyVT7hKddC8ZUikr
         mZmq8Idxk+QuVhokzyp39rbS5dCGyvsytSD8o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:from:date:x-google-sender-auth:message-id
         :subject:to:content-type;
        b=n/qVhHXji3zNw7Bbh81eeu/9Bgt5wkXtH8db6EW5LQiSt+5uOZj25vqmUEP7vH309R
         yzTfYR0oyfv4UBvbhgJpdfSecj9/PRl4fr4hhJJrSdqJgvGcn+kN1K0PfQoE/+p/jvKZ
         z2y7gvDj/URhPxl9MVlNPIR6b6wanEC5ADLkY=
Received: by 10.227.205.12 with SMTP id fo12mr3635134wbb.70.1305065587038;
 Tue, 10 May 2011 15:13:07 -0700 (PDT)
Received: by 10.227.137.10 with HTTP; Tue, 10 May 2011 15:12:46 -0700 (PDT)
X-Google-Sender-Auth: xLb4gik2KVd3M15DBsAVDrXnAeQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173369>

Hello everyone,

as thoroughly requested, and after much delay, here's the new minor
libgit2 release.

The release has been tagged at:

    https://github.com/libgit2/libgit2/tree/v0.12.0

A dist package can be found at:

    https://github.com/downloads/libgit2/libgit2/libgit2-0.12.0.tar.gz

The full change log follows after the message.

Thanks for your time,
Vicent

=========================

libgit2 v0.12.0 "absolutely no reason"

Hey, welcome to yet another minor libgit2 release. Sorry for the delay from
the last one. As you'll see the changelog is quite extensive -- hopefully from
now on we'll stick to more frequent minor releases.

Together with the usual bugfixes, here's a list of the new key features:

* Distfiles

	This version comes with proper distfiles as requested in #131. These are
	available in the Downloads section of the GitHub project.

* Error handling

	A new error handling API has been implemented that allows the library to
	return detailed error messages together with the generic error codes. We
	hope this will be a great when wrapping and integrating the library

	New external method to get the last detailed error message:

		+ git_lasterror(void)

	The old `git_strerror` still exists, but will be deprecated in the future
	as soon as every method in the library returns a valid error message.

	The task of writing error messages for every method is quite daunting.
	We appreciate pull requests with more error messages. Check the new error
	handling documentation in the following commit:

	https://github.com/libgit2/libgit2/commit/fa59f18d0ddbbb98d45e33934fb0efc3e2bf1557

* Redis backend

	We now have a Redis backend courtesy of Dmitry Kovega. Just like the
	SQLite backend, this allows the library to store Git objects in a Redis
	key-value store.

	The backend requires the `hiredis` library. Use `--with-redis` when
	building libgit2 to enable building the backend if `hiredis` is available.

* Commits

	New methods to access tree and parent data as a raw OID value
	instead of forcing a repository lookup

		+ git_commit_tree_oid(git_commit *commit)
		+ git_commit_parent_oid(git_commit *commit, unsigned int n)

* Index

	The `git_index_add` method has been split into 4 different calls
	which allow for appending and replacing in-memory entries and on-disk
	files to the index.

		+ git_index_add(git_index *index, const char *path, int stage)
		+ git_index_add2(git_index *index, const git_index_entry *source_entry)
		+ git_index_append(git_index *index, const char *path, int stage)
		+ git_index_append2(git_index *index, const git_index_entry *source_entry)

	Index entries can now also be efficiently removed from the index:

		+ git_index_remove(git_index *index, int position)

* References

	Methods to force the creation and renaming of references, even if those already
	exist on the repository.

		+ git_reference_create_symbolic_f(git_reference **ref_out,
git_repository *repo,
				const char *name, const char *target)
		+ git_reference_create_oid_f(git_reference **ref_out, git_repository *repo,
				const char *name, const git_oid *id)
		+ git_reference_rename_f(git_reference *ref, const char *new_name)

* Repository

	New auxiliary methods with repository information

		+ git_repository_is_empty(git_repository *repo)
		+ git_repository_path(git_repository *repo)
		+ git_repository_workdir(git_repository *repo)

* Signatures

	New method to create a signature with the current date/time

		+ git_signature_now(const char *name, const char *email)

* Tags

	Several wrappers to automate tag creation.

		+ git_tag_create_frombuffer(git_oid *oid, git_repository *repo,
				const char *buffer)
		+ git_tag_create_f(git_oid *oid, git_repository *repo,
				const char *tag_name, const git_oid *target,
				git_otype target_type, const git_signature *tagger,
				const char *message);
		+ git_tag_create_fo(git_oid *oid, git_repository *repo,
				const char *tag_name, const git_object *target,
				const git_signature *tagger, const char *message)

	New functionality to delete and list tags in a repository without
	having to resort to the `references` API.

		+ git_tag_delete(git_repository *repo, const char *tag_name)

		+ git_tag_list(git_strarray *tag_names, git_repository *repo)

* Trees

	All instances of `git_tree_entry` are now returned and handled
	as constant, to remind the user that these opaque types are not
	supposed to be manually free'd.

	The `git_tree_entry_2object` method now takes a `git_repository`
	argument which defines in which repository the resolved object
	should be looked up. (It is expected to be the same repository
	that contains the parent `git_tree` for the entry).

		+ git_tree_entry_2object(git_object **object_out, git_repository *repo,
				const git_tree_entry *entry)

	New opaque type `git_treebuilder` with functionality to create and
	write trees on memory

		+ git_treebuilder_create(git_treebuilder **builder_p, const git_tree *source)
		+ git_treebuilder_clear(git_treebuilder *bld)
		+ git_treebuilder_free(git_treebuilder *bld)
		+ git_treebuilder_get(git_treebuilder *bld, const char *filename)
		+ git_treebuilder_insert(git_tree_entry **entry_out, git_treebuilder *bld,
				const char *filename, const git_oid *id, unsigned int attributes)
		+ git_treebuilder_remove(git_treebuilder *bld, const char *filename)
		+ git_treebuilder_filter(git_treebuilder *bld,
				int (*filter)(const git_tree_entry *, void *), void *payload)
		+ git_treebuilder_write(git_oid *oid, git_repository *repo,
git_treebuilder *bld)

	New method to write an index file as a tree to the ODB.

		+ git_tree_create_fromindex(git_oid *oid, git_index *index)

Thanks to the usual guility parties that make this this happen, to
all the new contributors who are starting to submit pull requests, and
to the bindings developers who have to keep up with our shit.

Feedback and questions welcome on libgit2@librelist.org

Signed-off-by: Vicent Marti <tanoku@gmail.com>
