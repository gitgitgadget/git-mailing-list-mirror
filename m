Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FF26FE1A
	for <git@vger.kernel.org>; Tue, 26 Mar 2024 13:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.61.206.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711458563; cv=none; b=NnBRSpArPNJnmA8uJ1RueGzcvomxMSR/aBYdPqZWBOcNsDn3EQNNjt9EOhxyzxZu0yoYCRO1UZv5lGdBSlfx0Bv9xI/uVfdO+WqLMdQIRXAVk/3UIpW+X1fCC1uHVBkrVP6enNesd0NTshMmK1tAEVOLJGnRpbMkAUW5LIp4oJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711458563; c=relaxed/simple;
	bh=/INZQXpc0GZpHpe1SDVHcCGJo6PfeaaatojOL0s4r7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T/JMk9HXX8TA8bUL/7w25UY5L/zrOEJl+hsrE4r4fRmZ0uDM5q6LWgIbIGuEutlVfd7qNGp1yZVUnEcqNxm3wkgFhew4twg0PsgDmG+sKQnVjRaFpF+rQr9q7bBBIMWKUctuplRj1zLceIGg9AS5kZNFlQdAtcq20mf8MxntQsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net; spf=pass smtp.mailfrom=gouders.net; dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b=k8mdbx4z; arc=none smtp.client-ip=202.61.206.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b="k8mdbx4z"
Received: from localhost ([193.175.198.193])
	(authenticated bits=0)
	by mx10.gouders.net (8.17.1.9/8.17.1.9) with ESMTPSA id 42QD9AlJ006357
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Tue, 26 Mar 2024 14:09:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
	t=1711458550; bh=/INZQXpc0GZpHpe1SDVHcCGJo6PfeaaatojOL0s4r7M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=k8mdbx4zYwEjVY3D8vP4F9Np9sIXP5NbAAqygqwa8nLjuFZmkhNbb1j4qaECUJQmA
	 cs53vL9jdn1vXRIefoVoX5FnfR5I886YRGLsO1cX81YD5va9p26LYdhYTb2ULT6JDr
	 nv6euIR5nDfVldn1NG/6s4VJrwM//57FnC02b6eU=
From: Dirk Gouders <dirk@gouders.net>
To: git@vger.kernel.org
Cc: Dirk Gouders <dirk@gouders.net>, Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Kyle Lippincott <spectral@google.com>
Subject: [PATCH v4 0/5] Fixes for Documentation/MyFirstObjectWalk.txt
Date: Tue, 26 Mar 2024 14:08:35 +0100
Message-ID: <20240326130902.7111-1-dirk@gouders.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1711368498.git.dirk@gouders.net>
References: <cover.1711368498.git.dirk@gouders.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 4th round of this series.

Chances are that I just waste your time with my attemt [4/5].
My appologies in advance, should this be the case.

Recently, there was a discussion [1] on the groff mailing list and I
guess I couldn't resist to try to practice what I read in the linked
resources ;-)

[1] https://lists.gnu.org/archive/html/groff/2024-03/msg00014.html

Could be that the remaining controversal part of [4/5] should just be
left untouched, because it is consuming so much time -- I summarized
all those versions, so that all incarnations can be compared in one
view:

* Original:

Asking `traverse_commit_list_filtered()` to populate the `omitted`
list means that our object walk does not perform any better than an
unfiltered object walk; all reachable objects are walked in order to
populate the list.

* v3:

Note that this means that our object walk will not perform any better
than an unfiltered object walk; all reachable objects are walked in
order to populate the list.

* Junio's suggestion (with minor rearrangement):

Note that our object walk with this function will not perform any
better than the previous unfiltered walk, because all reachable
objects need to be walked in order to populate the list of filtered
objects.

* Kyle's suggestion:

Note that requesting the list of filtered objects may have performance
implications; all reachable objects will be visited in order to
populate the list of filtered objects.

* My new attempt (v4):

This list of filtered objects may have performance implications,
however, because despite filtering objects, the possibly much larger
set of all reachable objects must be processed in order to populate
that list.

--
Changes in v4:
* Used the proper `git show` for references in [1/5] and [3/5]
* Another attempt to write clear speach in [4/5]

Changes in v3:
* Reword the description in [4/5]
* Add a missing slash in [5/5]

Changes in v2:
* Added Emily to Cc in the hope for a review
* Remove superfluous tags from [1/5] and [3/5]
* Replace bashism `|&` by `2>&1 |` in [5/5]
--
Dirk Gouders (5):
  MyFirstObjectWalk: use additional arg in config_fn_t
  MyFirstObjectWalk: fix misspelled "builtins/"
  MyFirstObjectWalk: fix filtered object walk
  MyFirstObjectWalk: fix description for counting omitted objects
  MyFirstObjectWalk: add stderr to pipe processing

 Documentation/MyFirstObjectWalk.txt | 37 ++++++++++++++++-------------
 1 file changed, 21 insertions(+), 16 deletions(-)

Range-diff against v3:
1:  0eeb4b78ac ! 1:  102cbc54c4 MyFirstObjectWalk: use additional arg in config_fn_t
    @@ Metadata
      ## Commit message ##
         MyFirstObjectWalk: use additional arg in config_fn_t
     
    -    Commit a4e7e317 (config: add ctx arg to config_fn_t) added a fourth
    -    argument to config_fn_t but did not change relevant function calls
    -    in Documentation/MyFirstObjectWalk.txt.
    +    Commit a4e7e317f8 (config: add ctx arg to config_fn_t, 2023-06-28)
    +    added a fourth argument to config_fn_t but did not change relevant
    +    function calls in Documentation/MyFirstObjectWalk.txt.
     
         Fix those calls and the example git_walken_config() to use
         that additional argument.
2:  3122ae2472 = 2:  5fb7953f31 MyFirstObjectWalk: fix misspelled "builtins/"
3:  f21348ab80 ! 3:  b88518df0b MyFirstObjectWalk: fix filtered object walk
    @@ Metadata
      ## Commit message ##
         MyFirstObjectWalk: fix filtered object walk
     
    -    Commit f0d2f849 (MyFirstObjectWalk: update recommended usage)
    -    changed a call of parse_list_objects_filter() in a way that
    -    probably never worked: parse_list_objects_filter() always needed a
    -    pointer as its first argument.
    +    Commit f0d2f84919 (MyFirstObjectWalk: update recommended usage,
    +    2022-03-09) changed a call of parse_list_objects_filter() in a way
    +    that probably never worked: parse_list_objects_filter() always needed
    +    a pointer as its first argument.
     
         Fix this by removing the CALLOC_ARRAY and passing the address of
         rev->filter to parse_list_objects_filter() in accordance to
4:  cfa4b9ce50 ! 4:  11510630af MyFirstObjectWalk: fix description for counting omitted objects
    @@ Documentation/MyFirstObjectWalk.txt: points to the same tree object as its grand
     -reachable objects are walked in order to populate the list.
     +filter, like with `git log --filter=<spec> --filter-print-omitted`. To do this,
     +change `traverse_commit_list()` to `traverse_commit_list_filtered()`, which is
    -+able to populate an `omitted` list. Note that this means that our object walk
    -+will not perform any better than an unfiltered object walk; all reachable
    -+objects are walked in order to populate the list.
    ++able to populate an `omitted` list.  This list of filtered objects may have
    ++performance implications, however, because despite filtering objects, the possibly
    ++much larger set of all reachable objects must be processed in order to
    ++populate that list.
      
      First, add the `struct oidset` and related items we will use to iterate it:
      
5:  c571abb49d = 5:  8920313ee2 MyFirstObjectWalk: add stderr to pipe processing
-- 
2.43.0

