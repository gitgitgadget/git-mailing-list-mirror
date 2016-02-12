From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v4 20/21] refs: add LMDB refs storage backend
Date: Fri, 12 Feb 2016 18:01:21 +0100
Message-ID: <56BE0FE1.5030407@alum.mit.edu>
References: <1454701462-3817-1-git-send-email-dturner@twopensource.com>
 <1454701462-3817-21-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
To: David Turner <dturner@twopensource.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 12 18:08:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aUHCq-00075z-5P
	for gcvg-git-2@plane.gmane.org; Fri, 12 Feb 2016 18:08:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257AbcBLRI1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2016 12:08:27 -0500
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:50351 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750886AbcBLRI0 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Feb 2016 12:08:26 -0500
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Fri, 12 Feb 2016 12:08:26 EST
X-AuditID: 1207440f-db3ff70000007e44-ea-56be0fe314cd
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id C7.72.32324.3EF0EB65; Fri, 12 Feb 2016 12:01:23 -0500 (EST)
Received: from [192.168.69.130] (p548D685F.dip0.t-ipconnect.de [84.141.104.95])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u1CH1MFi024525
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 12 Feb 2016 12:01:23 -0500
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.5.0
In-Reply-To: <1454701462-3817-21-git-send-email-dturner@twopensource.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFIsWRmVeSWpSXmKPExsUixO6iqPuYf1+YwatmQ4v5m04wWnRd6WZy
	YPJY8Pw+u8fnTXIBTFHcNkmJJWXBmel5+nYJ3BmT5ykUfNWrOPnqIXsDY59yFyMHh4SAicTT
	Tp0uRi4OIYGtjBI3dn1hgnDOM0lsfjSdpYuRk0NYwFFiw/WJYLaIgIPE5V1HmSGK2hglOl4c
	ZQVJsAnoSizqaWYCsSUE5CR6uyeBNfAKaEv8n36IGWQbi4CqRM+HNJCwqECIxPuvz1khSgQl
	Ts58AlbOKeApMW1LMzuIzSygJ7Hj+i9WCFteonnrbOYJjPyzkLTMQlI2C0nZAkbmVYxyiTml
	ubq5iZk5xanJusXJiXl5qUW6Jnq5mSV6qSmlmxgh4ci/g7FrvcwhRgEORiUeXsNbe8KEWBPL
	iitzDzFKcjApifI2PtsbJsSXlJ9SmZFYnBFfVJqTWnyIUYKDWUmE16AJKMebklhZlVqUD5OS
	5mBREudVX6LuJySQnliSmp2aWpBaBJOV4eBQkuCdy7cvTEiwKDU9tSItM6cEIc3EwQkynEtK
	pDg1LyW1KLG0JCMeFI/xxcCIBEnxAO2dDNLOW1yQmAsUhWg9xagoJc7bDpIQAElklObBjYUl
	mVeM4kBfCvOeBqniASYouO5XQIOZgAbv+L4LZHBJIkJKqoExM3dT8BnlWrYvDAX/mWqrug7F
	iWvdF0mfIHzsztSqFNMNs/Xz6vjLJA7P55pd/urPzLrV+4+aPd093Wri8+O9PgdPbGXUFc67
	XxMW+m/am+LFHh+Pu1+8bLVX0/6x1sVHU5ufn8j3SN11Z3KtgKtwUun0xg2mMw8f 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286058>

On 02/05/2016 08:44 PM, David Turner wrote:
> Add a database backend for refs using LMDB.  This backend runs git
> for-each-ref about 30% faster than the files backend with fully-packed
> refs on a repo with ~120k refs.  It's also about 4x faster than using
> fully-unpacked refs.  In addition, and perhaps more importantly, it
> avoids case-conflict issues on OS X.
> 
> LMDB has a few features that make it suitable for usage in git:
> 

0. It is licensed under the OpenLDAP Public License, which is apparently
GPL compatible [1].

[1] http://www.gnu.org/licenses/license-list.en.html#newOpenLDAP

> 1. It is relatively lightweight; it requires only one header file, and
> the library code takes under 64k at runtime.
> 
> 2. It is well-tested: it's been used in OpenLDAP for years.
> 
> 3. It's very fast.  LMDB's benchmarks show that it is among
> the fastest key-value stores.
> 
> 4. It has a relatively simple concurrency story; readers don't
> block writers and writers don't block readers.
> 
> Ronnie Sahlberg's original version of this patchset used tdb.  The
> major disadvantage of tdb is that tdb is hard to build on OS X.  It's
> also not in homebrew.  So lmdb seemed simpler.
> 
> To test this backend's correctness, I hacked test-lib.sh and
> test-lib-functions.sh to run all tests under the refs backend. Dozens
> of tests use manual ref/reflog reading/writing, or create submodules
> without passing --ref-storage to git init.  If those tests are
> changed to use the update-ref machinery or test-refs-lmdb-backend (or,
> in the case of packed-refs, corrupt refs, and dumb fetch tests, are
> skipped), the only remaining failing tests are the git-new-workdir
> tests and the gitweb tests.

Would it possible to build your "hack" into the test suite? For example,
perhaps one could implement an option that requests tests to use LMDB
wherever possible and skip the tests that are not LMDB-compatible. Over
time, we could try to increase the fraction of tests that are
LMDB-compatible by (for example) using `git update-ref` and `git
rev-parse` rather than reading/writing reference files via the
filesystem directly.

Otherwise, I'm worried that LMDB support will bitrot quickly because it
will be too much of a nuisance to exercise the code.

> Signed-off-by: David Turner <dturner@twopensource.com>
> ---
>  .gitignore                                     |    1 +
>  Documentation/config.txt                       |    7 +
>  Documentation/git-clone.txt                    |    3 +-
>  Documentation/git-init.txt                     |    2 +-
>  Documentation/technical/refs-lmdb-backend.txt  |   52 +
>  Documentation/technical/repository-version.txt |    5 +
>  Makefile                                       |   12 +
>  configure.ac                                   |   33 +
>  contrib/workdir/git-new-workdir                |    3 +
>  refs.c                                         |    3 +
>  refs.h                                         |    2 +
>  refs/lmdb-backend.c                            | 2052 ++++++++++++++++++++++++
>  setup.c                                        |   11 +-
>  test-refs-lmdb-backend.c                       |   64 +
>  transport.c                                    |    7 +-
>  15 files changed, 2250 insertions(+), 7 deletions(-)
>  create mode 100644 Documentation/technical/refs-lmdb-backend.txt
>  create mode 100644 refs/lmdb-backend.c
>  create mode 100644 test-refs-lmdb-backend.c
> 
> diff --git a/.gitignore b/.gitignore
> index 1c2f832..87d45a2 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -199,6 +199,7 @@
>  /test-path-utils
>  /test-prio-queue
>  /test-read-cache
> +/test-refs-lmdb-backend
>  /test-regex
>  /test-revision-walking
>  /test-run-command
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 06d3659..bc222c9 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1153,6 +1153,13 @@ difftool.<tool>.cmd::
>  difftool.prompt::
>  	Prompt before each invocation of the diff tool.
>  
> +extensions.refsStorage::
> +	Type of refs storage backend. Default is to use the original
> +	files based ref storage.  When set to "lmdb", refs are stored in
> +	the lmdb database backend.  This setting reflects the refs
> +	backend that is currently in use; it is not possible to change
> +	the backend by changing this setting.
> +

Let's give the users a pointer to how they *can* change this setting. Maybe

	Type of refs storage backend. Default is to use the original
	files based ref storage.  When set to "lmdb", refs are stored in
	an LMDB database.  This setting reflects the refs storage
	backend that was chosen via the --ref-storage option when the
	repository was originally created. It is currently
	not possible to change the refs storage backend of an
	existing repository.


>  fetch.recurseSubmodules::
>  	This option can be either set to a boolean value or to 'on-demand'.
>  	Setting it to a boolean changes the behavior of fetch and pull to
> diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
> index 68f56a7..b9c52ce 100644
> --- a/Documentation/git-clone.txt
> +++ b/Documentation/git-clone.txt
> @@ -227,7 +227,8 @@ objects from the source repository into a pack in the cloned repository.
>  
>  --ref-storage=<name>::
>  	Type of ref storage backend. Default is to use the original files
> -	based ref storage.
> +	based ref storage. Set to "lmdb" to store refs in the lmdb database
> +	backend.

Should the second "lmdb" be upper-case? Maybe also in other places where
the LMDB database is being referred to?

>  
>  <repository>::
>  	The (possibly remote) repository to clone from.  See the
> [...]

I still haven't reviewed the actual lmdb-backend code. I guess I'm going
to have to make myself an LMDB expert one of these days...

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
