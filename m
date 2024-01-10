Received: from bi.d.mailin.fr (bi.d.mailin.fr [185.41.28.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913F817C9
	for <git@vger.kernel.org>; Wed, 10 Jan 2024 02:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bi.d.mailin.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sendinblue.com header.i=@sendinblue.com header.b="YJNuJFXc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sendinblue.com;
 q=dns/txt; s=mail; bh=0HGxLoDcTdFAx60wbSJqI+XnwNmfIEKfx6Zv9BuC9Vo=;
 h=from:subject:date:to:cc:mime-version:content-transfer-encoding:in-reply-to:references:x-csa-complaints:list-unsubscribe-post;
        b=YJNuJFXcAJp6s2QQd2O0pPccGSCC7uIDBs2woOCqkKXw78lDAWpvvzF3tlRKP/Elf9DJKnu3yeco
        8v0ASaHx19d/GB1HNOE5UB5yBTcHQ5PGDudM76AMaYBEtsw2RLerWyh9Hevs8s+EEqencERBloae
        nDlF72jbr9XU0lAvVRs=
Received: by smtp-relay.sendinblue.com with ESMTP id 03fe3371-2b0f-4590-90ad-166b8fa4cbbb; Wed, 10 January 2024 02:03:51 +0000 (UTC)
X-Mailin-EID: MjQyODY0MDE0fmdpdEB2Z2VyLmtlcm5lbC5vcmd%2BPDIwMjQwMTEwMDIwMzQ3LjY3MzE1NS0xLWJyaXR0b24ua2VyaW5AZ21haWwuY29tPn5iaS5kLm1haWxpbi5mcg%3D%3D
Date: Tue,  9 Jan 2024 17:03:42 -0900
Subject: [PATCH v2 0/5] completion: improvements for git-bisect
Received: by brittons-large-Vivobook (Postfix, from userid 1000) id 3139C520268; Tue,  9 Jan 2024 17:03:49 -0900 (AKST)
Cc: Britton Leo Kerin <britton.kerin@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <9e180f50-4bf4-4822-9b02-2a1b50114e09@smtp-relay.sendinblue.com>
References: <9e180f50-4bf4-4822-9b02-2a1b50114e09@smtp-relay.sendinblue.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Message-Id: <03fe3371-2b0f-4590-90ad-166b8fa4cbbb@smtp-relay.sendinblue.com>
Origin-messageId: <20240110020347.673155-1-britton.kerin@gmail.com>
To: <git@vger.kernel.org>
X-sib-id: j7muBwx5t0RgAQ1sw5LU8MV3o9xAUVD3vKHltrkSpmYqwH424pZquF7yYxQV8BQkHRU0w6V0k-1pIOGzBY3EtE2KcHmxbzIwsU2yMUDM10iNv-gBKwMIppXw9pI_W8_IkE8tcpu9guCTtZkWtPNqR28UGADuoKE36eYz1F4owBcK
X-CSA-Complaints: csa-complaints@eco.de
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Feedback-ID: 185.41.28.109:6940237_-1:6940237:Sendinblue
From: "Britton Leo Kerin" <britton.kerin@gmail.com>

Bring completion for bisect up to date with current features.

I didn't hear back on my previous RFC Patch for these improvements, and
ultimately decided that simply aborting special completion efforts and
doing nothing on precondition violation is the best policy, because devs
will likely notice and users won't be irritated more than necessary.

Besides that the series has just been cleaned up a tiny bit.

Britton Leo Kerin (5):
  completion: complete new old actions, start opts
  completion: git-log opts to bisect visualize
  completion: move to maintain define-before-use
  completion: custom git-bisect terms
  completion: custom git-bisect terms

 contrib/completion/git-completion.bash | 312 +++++++++++++++----------
 1 file changed, 183 insertions(+), 129 deletions(-)

Range-diff against v1:
1:  e16264bfb9 =3D 1:  e16264bfb9 completion: complete new old actions, =
start opts
2:  90466cdfa5 ! 2:  130abe3460 completion: git-log opts to bisect =
visualize
    @@ Commit message
         accepts git-log options but not rev arguments (they are fixed to =
the
         commits under bisection).

    +    =5F=5Fgit=5Fcomplete=5Flog=5Fopts has a precondition that =
COMPREPLY be empty.  In
    +    a completion context it doesn't seem advisable to implement
    +    preconditions as noisy or hard failures, so instead it becomes a =
no-op
    +    on violation.  This should be detectable and quick to debug for =
devels,
    +    without ever aggravating a user (besides completion failure).
    +
         Signed-off-by: Britton Leo Kerin <britton.kerin@gmail.com>

      ## contrib/completion/git-completion.bash ##
    @@ contrib/completion/git-completion.bash: =5F=5Fgit=5Fdiff=5Fmerges=5F=
opts=3D=22off none on firs
      =5F=5Fgit=5Flog=5Fdate=5Fformats=3D=22relative iso8601 iso8601-strict=
 rfc2822 short local default human raw unix auto: format:=22

     -=5Fgit=5Flog ()
    --{
    ++
    ++# Check for only porcelain (i.e. not git-rev-list) option (not =
argument)
    ++# and selected option argument completions for git-log options and if=
 any
    ++# are found put them in COMPREPLY.  COMPREPLY must be empty at the =
start,
    ++# and will be empty on return if no candidates are found.
    ++=5F=5Fgit=5Fcomplete=5Flog=5Fopts ()
    + {
     -	=5F=5Fgit=5Fhas=5Fdoubledash && return
     -	=5F=5Fgit=5Ffind=5Frepo=5Fpath
    ++	[ -z =22$COMPREPLY=22 ] || return 1   # Precondition

    -+# Find only porcelain (i.e. not git-rev-list) option (not argument) =
and
    -+# selected option argument completions for git-log options and put =
them in
    -+# COMPREPLY.
    -+=5F=5Fgit=5Fcomplete=5Flog=5Fopts ()
    -+{
      	local merge=3D=22=22
      	if [ -f =22$=5F=5Fgit=5Frepo=5Fpath/MERGE=5FHEAD=22 ]; then
    - 		merge=3D=22--merge=22
     @@ contrib/completion/git-completion.bash: =5Fgit=5Flog ()
      		return
      		;;
      	esac
    -+
     +}
     +
     +=5Fgit=5Flog ()
3:  0edfb54dd5 ! 3:  d659ace9c2 completion: move to maintain =
define-before-use
    @@ contrib/completion/git-completion.bash: =5Fgit=5Farchive ()
     +=5F=5Fgit=5Flog=5Fpretty=5Fformats=3D=22oneline short medium full =
fuller reference email raw format: tformat: mboxrd=22
     +=5F=5Fgit=5Flog=5Fdate=5Fformats=3D=22relative iso8601 iso8601-strict=
 rfc2822 short local default human raw unix auto: format:=22
     +
    -+# Find only porcelain (i.e. not git-rev-list) option (not argument) =
and
    -+# selected option argument completions for git-log options and put =
them in
    -+# COMPREPLY.
    ++# Check for only porcelain (i.e. not git-rev-list) option (not =
argument)
    ++# and selected option argument completions for git-log options and if=
 any
    ++# are found put them in COMPREPLY.  COMPREPLY must be empty at the =
start,
    ++# and will be empty on return if no candidates are found.
     +=5F=5Fgit=5Fcomplete=5Flog=5Fopts ()
     +{
    ++	[ -z =22$COMPREPLY=22 ] || return 1   # Precondition
    ++
     +	local merge=3D=22=22
     +	if [ -f =22$=5F=5Fgit=5Frepo=5Fpath/MERGE=5FHEAD=22 ]; then
     +		merge=3D=22--merge=22
    @@ contrib/completion/git-completion.bash: =5Fgit=5Farchive ()
     +		return
     +		;;
     +	esac
    -+
     +}
     +
      =5Fgit=5Fbisect ()
    @@ contrib/completion/git-completion.bash: =5Fgit=5Fls=5Ftree ()
     -=5F=5Fgit=5Flog=5Fdate=5Fformats=3D=22relative iso8601 iso8601-strict=
 rfc2822 short local default human raw unix auto: format:=22
     -
     -
    --# Find only porcelain (i.e. not git-rev-list) option (not argument) =
and
    --# selected option argument completions for git-log options and put =
them in
    --# COMPREPLY.
    +-# Check for only porcelain (i.e. not git-rev-list) option (not =
argument)
    +-# and selected option argument completions for git-log options and if=
 any
    +-# are found put them in COMPREPLY.  COMPREPLY must be empty at the =
start,
    +-# and will be empty on return if no candidates are found.
     -=5F=5Fgit=5Fcomplete=5Flog=5Fopts ()
     -{
    +-	[ -z =22$COMPREPLY=22 ] || return 1   # Precondition
    +-
     -	local merge=3D=22=22
     -	if [ -f =22$=5F=5Fgit=5Frepo=5Fpath/MERGE=5FHEAD=22 ]; then
     -		merge=3D=22--merge=22
    @@ contrib/completion/git-completion.bash: =5Fgit=5Fls=5Ftree ()
     -		return
     -		;;
     -	esac
    --
     -}
     -
      =5Fgit=5Flog ()
4:  a8a730ffbe =3D 4:  c5bee633b2 completion: custom git-bisect terms
5:  44d3a36e20 ! 5:  220650f0ba completion: recognize but do not complete =
'view'
    @@ Metadata
     Author: Britton Leo Kerin <britton.kerin@gmail.com>

      ## Commit message ##
    -    completion: recognize but do not complete 'view'
    -
    -    Completing it might annoy some existing users by creating =
completion
    -    ambiguity on 'v' and 'vi' without adding anything useful in terms =
of
    -    interface discovery/recall (because 'view' is just an alias =
anyway).
    +    completion: custom git-bisect terms

         Signed-off-by: Britton Leo Kerin <britton.kerin@gmail.com>

    @@ contrib/completion/git-completion.bash: =5Fgit=5Fbisect ()
      	fi

     -	local subcommands=3D=22start bad new $term=5Fbad good old =
$term=5Fgood terms skip reset visualize replay log run help=22
    ++	# We will complete any custom terms, but still always complete the
    ++	# more usual bad/new/good/old because git bisect gives a good error
    ++	# message if these are given when not in use and that's better than
    ++	# silent refusal to complete if the user is confused.
    ++	#
     +	# We want to recognize 'view' but not complete it, because it =
overlaps
     +	# with 'visualize' too much and is just an alias for it.
    ++	#
     +	local completable=5Fsubcommands=3D=22start bad new $term=5Fbad good =
old $term=5Fgood terms skip reset visualize replay log run help=22
     +	local all=5Fsubcommands=3D=22$completable=5Fsubcommands view=22

6:  7b88549fbe < -:  ---------- completion: add comment
--
2.43.0


