From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 0/6] repack_without_refs(): convert to string_list
Date: Fri, 21 Nov 2014 15:09:04 +0100
Message-ID: <1416578950-23210-1-git-send-email-mhagger@alum.mit.edu>
References: <1416423000-4323-1-git-send-email-sbeller@google.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 21 15:09:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xrotw-0000Ji-T6
	for gcvg-git-2@plane.gmane.org; Fri, 21 Nov 2014 15:09:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758346AbaKUOJa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Nov 2014 09:09:30 -0500
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:58165 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758169AbaKUOJY (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Nov 2014 09:09:24 -0500
X-AuditID: 12074411-f79fa6d000006b8a-d8-546f478dab26
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 5F.7A.27530.D874F645; Fri, 21 Nov 2014 09:09:17 -0500 (EST)
Received: from michael.fritz.box (p5DDB272E.dip0.t-ipconnect.de [93.219.39.46])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sALE9EqO000733
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 21 Nov 2014 09:09:15 -0500
X-Mailer: git-send-email 2.1.3
In-Reply-To: <1416423000-4323-1-git-send-email-sbeller@google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrAIsWRmVeSWpSXmKPExsUixO6iqNvrnh9icLOJy6LrSjeTRUPvFWaL
	tzeXMFrcXjGf2eLfhBqLzZvbWRzYPP6+/8DksXPWXXaPBZtKPS5eUvb4vEkugDWK2yYpsaQs
	ODM9T98ugTuj/XAXS8EbhYrnu7+yNzA+luxi5OSQEDCRWPj3JTuELSZx4d56ti5GLg4hgcuM
	Ep2fDjNBOMeZJH5suAZWxSagK7Gop5kJxBYR8JI4tW4GM0gRs8B8RonZ62YygiSEBZwkbq3f
	BNbAIqAq0dH/GqyBV8BF4tXZyUANHEDr5CS2rvMGCXMClf97vpgFxBYScJT49vcKywRG3gWM
	DKsY5RJzSnN1cxMzc4pTk3WLkxPz8lKLdE31cjNL9FJTSjcxQkJLcAfjjJNyhxgFOBiVeHhX
	LM4LEWJNLCuuzD3EKMnBpCTKG2+dHyLEl5SfUpmRWJwRX1Sak1p8iFGCg1lJhLdcGCjHm5JY
	WZValA+TkuZgURLn5Vui7ickkJ5YkpqdmlqQWgSTleHgUJLgveUK1ChYlJqeWpGWmVOCkGbi
	4AQZziUlUpyal5JalFhakhEPio34YmB0gKR4gPb+B2nnLS5IzAWKQrSeYlSUEuflcQNKCIAk
	Mkrz4MbCEsYrRnGgL4V5v4G08wCTDVz3K6DBTECD/y7NBRlckoiQkmpgnPxAzKPqoYA129rE
	Wft1GhKd2y5nqjZNnC0jktr4zVo3qD16u+ck5rC/jItemIYfndUv+3/J9okpShbNTIdLvucs
	cTDNLnnQelLAtdOgvP8dB/MFidylt48fvqFna/h492TBO4zpTx8npU+aEXTLi+mk 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is basically an atomized version of Ronnie/Jonathan/Stefan's
patch [1] "refs.c: use a stringlist for repack_without_refs". But I've
actually rewritten most of it from scratch, using the original patch
as a reference.

I was reviewing the original patch and it looked mostly OK [2], but I
found it hard to read because it did several steps at once. So I tried
to make the same basic change, but one baby step at a time. This is
the result.

I'm a known fanatic about making the smallest possible changes in each
commit. The goal is to make the patch series as readable as possible,
because reviewers' time is in shorter supply than coders' time.

* Tiny little patches are IMO usually much easier to read than big
  ones, because there is less to keep in mind at a time.

* Often tiny changes (e.g., renaming variables or functions) are so
  blindingly obvious that one only has to skim them, or even trust
  that the author, with the help of the compiler, could hardly have
  made a mistake [3].

* Using baby steps keeps the author from introducing unnecessary
  changes ("code churn"), by forcing him/her to justify each change on
  its own merits.

* Using baby steps makes it harder for substantive changes to get
  overlooked or to sneak in without discussion [4].

* If there is a problem, baby commits can be bisected, usually making
  it obvious why the bug arose.

* If the mailing list doesn't like part of the series, it is usually
  easier to omit a patch from the next reroll than to extract one
  change out of a patch that contains multiple logical changes.

* It is often possible to arrange the order of the patches to give the
  patch series a good "narrative".

Some members of the community probably disagree with me. Using baby
step patches means that there is more mailing list traffic and more
commits that accumulate in the project's history. There is sometimes a
bit of extra to-and-fro as code is mutated incrementally. Or maybe
other people can just keep more complicated changes in their heads at
one time than I can.

Nevertheless, I submit this version of the patch series for your
amusement. Feel free to ignore it.

[1] http://mid.gmane.org/1416434399-2303-1-git-send-email-sbeller@google.com
[2] Problems that I noticed:

    * The commit message refers to "stringlist" where it should be
      "string_list".

    * One of the loops in prune_remote() iterates using indexes, while
      another loop (over the same string_list) uses
      for_each_string_list_item().

    * The change from using string_list_insert() to string_list_append()
      in the same function, followed by sort_string_list(), doesn't remove
      duplicates as the old version did. The commit message should
      justify that this is OK.

[3] I love the quote from C. A. R. Hoare:

        There are two ways of constructing a software design: One way
        is to make it so simple that there are obviously no
        deficiencies, and the other way is to make it so complicated
        that there are no obvious deficiencies.

    I think the same thing applies to patches.

[4] Case in point: when I was writing the commit message for patch
    3/6, I realized that string_list_insert() omits duplicates whereas
    string_list_append() obviously doesn't. This aspect of the change
    wasn't justified. Do we have to add a call to
    string_list_remove_duplicates()? It turns out that the list cannot
    contain duplicates, but it took some digging to verify this.

Michael Haggerty (6):
  prune_remote(): exit early if there are no stale references
  prune_remote(): initialize both delete_refs lists in a single loop
  prune_remote(): sort delete_refs_list references en masse
  repack_without_refs(): make the refnames argument a string_list
  prune_remote(): rename local variable
  prune_remote(): iterate using for_each_string_list_item()

 builtin/remote.c | 59 ++++++++++++++++++++++++++------------------------------
 refs.c           | 38 +++++++++++++++++++-----------------
 refs.h           | 11 ++++++++++-
 3 files changed, 57 insertions(+), 51 deletions(-)

-- 
2.1.3
