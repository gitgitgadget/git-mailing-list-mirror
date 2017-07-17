Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 038E02027C
	for <e@80x24.org>; Mon, 17 Jul 2017 00:55:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751221AbdGQAz1 (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Jul 2017 20:55:27 -0400
Received: from mail-yb0-f169.google.com ([209.85.213.169]:35783 "EHLO
        mail-yb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751200AbdGQAz0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Jul 2017 20:55:26 -0400
Received: by mail-yb0-f169.google.com with SMTP id j80so31636055ybg.2
        for <git@vger.kernel.org>; Sun, 16 Jul 2017 17:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purdea.ro; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=uMepww1A2VqW7o3bdgHsQ/G16qgDNEiiZRodQVJnmuI=;
        b=Fk0AhBeGMiXtpSdVjvZ5X4zEsPH5H3JW+2Dep6EfmNMt5nFxT/qzGUtAO/lfoLfg5G
         tz/xJhoRJh+7yH38GMXaBDv+Rcy0NFn/SHjcurEWNrejNyiUgXN9SmPLoJnG9IpPJA+o
         O5ukKA/0VUqYUWKL4lErRAKGTDgyA3fCJt2fs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=uMepww1A2VqW7o3bdgHsQ/G16qgDNEiiZRodQVJnmuI=;
        b=uRKnAjSNCOteMjHl4jpUCVXq352kiovUHt7Gbgz5/LOMqbndeZFTzJr6dH04GZ7Rpe
         OzYQzWru7YrHNAy2903LPf2lh28MUphlHv4X6PsMt+mshBbygFldILsN0npbk1th9JR3
         g2+0C4eULJEeu2f5Ii1g+aQnF/J6lJliqHryhdio4uU0uq9Qx2gMi95G4z5ZPHfM0tY3
         aW/BD+FtuygOogfBoTwrheajpourcx0Tg4Ibh/I4qJEeRKJi5dyoISeju14IZ8mIdAuY
         r5EJ2qV9Z7ZopwLARui9QpTE0QRSCxBHhyfBrV4li0sij/soMeRNkPEzBIALy3tefdXA
         +UkQ==
X-Gm-Message-State: AIVw113aPPdqdcJhsiiq1ZWTXSJOwcdtMTU6QuoqZivG57FrtO8EcaoC
        /8FQz/PQChBMP3AZhp1Ei+LoOnfYRrlpWNk=
X-Received: by 10.37.87.196 with SMTP id l187mr15280737ybb.115.1500252923229;
 Sun, 16 Jul 2017 17:55:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.189.6 with HTTP; Sun, 16 Jul 2017 17:55:07 -0700 (PDT)
X-Originating-IP: [212.2.161.242]
From:   Andrei Purdea <andrei@purdea.ro>
Date:   Mon, 17 Jul 2017 03:55:07 +0300
Message-ID: <CA+mMEgf1Pg0bbGesCFr6sY60PxR=ewKPqnkG1M3fO2qurqR=1g@mail.gmail.com>
Subject: [PATCH/RFC] diff/read-cache: don't assume empty files will filter to empty
To:     git@vger.kernel.org
Cc:     bmwill@google.com, peff@peff.net, christian.couder@gmail.co,
        junkio@cox.net
Content-Type: multipart/mixed; boundary="001a113e7ff0905113055478da0b"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--001a113e7ff0905113055478da0b
Content-Type: text/plain; charset="UTF-8"

Hey guys, please see the below patch. (please read commit message
first and then the following:)
In particular I'd like to hear comments about the changes I made to
how smudging works.
I am not confident on whether it is a good way to permanently fix the problem.
I'm wondering if there's a better way, and I am also wondering if this
will have an effect
when a user upgrades git on their system, and they already had a
repository checked out.

I know there were other approaches to smudging cache entries, for
example JGIT had
this slightly funny method:
https://github.com/eclipse/jgit/commit/c98d97731b87417b196341fa63a50fffea4e123c#diff-2c773508260c1ab8eb01b5444c3395c8L320
but since then they have reverted to the c-git way of doing things.

Any comments?

Andrei

From 296a83046e77c1d49db8d324f298280265dfb6dc Mon Sep 17 00:00:00 2001
From: Purdea Andrei <andrei.purdea@movidius.com>
Date: Tue, 11 Jul 2017 23:00:15 +0300
Subject: [PATCH] diff/read-cache: don't assume empty files will filter to
 empty

There are some projects that are based on git smudge/clean filters that won't
necessarily produce empty files when clean-ing empty files. An example of such
a project is git-fat, which stores binary files elsewhere, but uses git to
store only a reference to that binary file. The reference to the file consists
of a hash and the file size. So an empty will will produce a non-empty file
after passing it through the git-fat clean filter.

Current GIT, when it sees an empty file on git diff, it interprets it specially,
and it won't pass it through the clean filter. But in other conditions it will.
For example you can create a commit containing an empty git-fat managed file,
and in that case the file will be passed through the clean filter, and the git
repository will contain the expanded hash of an empty file. If you try to run
git diff on such a repository, it will always show this file as changed, because
git diff will compare the expanded hash that is already in the repository, to
the empty file that has not been passed through the clean filter. This will
result in files that will always show up as modified. The "changes" cannot be
committed, or checked-out to the working tree, and git will not allow us to
perform more complex operations such as rebase / merge. The only action is to
delete the file.

The patch fixes the issue in two places:

diff.c: send the file through git-clean filter even if it is empty.

read-cache.c: read-cache uses a magic number of zero-sized files to smudge
cache entries that have the same timestamp as other file modifications.
(Note: the word smudge here is unrelated to the "smudge filter" concept)
Smudged entries will have a zero file size, but the stored hash will not equal
the unique, known hash of an empty file. In the absence of clean filters that
can produce non-zero files from zero-sized files, this is a good way to
detectably corrupt a cache entry. However in the presence of git clean filters
that do this, the file will be considered smudged, and it will keep showing up
as touched by the user. That is because the stored hash is actually the hash
of the file after it has passed to the clean filter, and it's not empty anymore.
This change fixes the condition by using a different magic number of smudged
entries. It uses -1 which is the biggest possible file size stored.

Signed-off-by: Purdea Andrei <andrei@purdea.ro>
---
 diff.c       | 18 ++++++++++--------
 read-cache.c |  7 +++----
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/diff.c b/diff.c
index 00b4c8669..76bb536ce 100644
--- a/diff.c
+++ b/diff.c
@@ -2858,8 +2858,6 @@ int diff_populate_filespec(struct diff_filespec
*s, unsigned int flags)
  }
  }
  s->size = xsize_t(st.st_size);
- if (!s->size)
- goto empty;
  if (S_ISLNK(st.st_mode)) {
  struct strbuf sb = STRBUF_INIT;

@@ -2894,12 +2892,16 @@ int diff_populate_filespec(struct
diff_filespec *s, unsigned int flags)
  s->is_binary = 1;
  return 0;
  }
- fd = open(s->path, O_RDONLY);
- if (fd < 0)
- goto err_empty;
- s->data = xmmap(NULL, s->size, PROT_READ, MAP_PRIVATE, fd, 0);
- close(fd);
- s->should_munmap = 1;
+ if (!s->size) {
+ s->data = "";
+ } else {
+ fd = open(s->path, O_RDONLY);
+ if (fd < 0)
+ goto err_empty;
+ s->data = xmmap(NULL, s->size, PROT_READ, MAP_PRIVATE, fd, 0);
+ close(fd);
+ s->should_munmap = 1;
+ }

  /*
  * Convert from working tree format to canonical git format
diff --git a/read-cache.c b/read-cache.c
index 2121b6e7b..ca306993c 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -262,9 +262,8 @@ static int ce_match_stat_basic(const struct
cache_entry *ce, struct stat *st)
  changed |= match_stat_data(&ce->ce_stat_data, st);

  /* Racily smudged entry? */
- if (!ce->ce_stat_data.sd_size) {
- if (!is_empty_blob_sha1(ce->oid.hash))
- changed |= DATA_CHANGED;
+ if (ce->ce_stat_data.sd_size == (unsigned int)-1) {
+ changed |= DATA_CHANGED;
  }

  return changed;
@@ -2028,7 +2027,7 @@ static void ce_smudge_racily_clean_entry(struct
cache_entry *ce)
  * file, and never calls us, so the cached size information
  * for "frotz" stays 6 which does not match the filesystem.
  */
- ce->ce_stat_data.sd_size = 0;
+ ce->ce_stat_data.sd_size = (unsigned int)-1;
  }
 }

-- 
2.11.0

--001a113e7ff0905113055478da0b
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-diff-read-cache-don-t-assume-empty-files-will-filter.patch"
Content-Disposition: attachment; 
	filename="0001-diff-read-cache-don-t-assume-empty-files-will-filter.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_j57fk1za0

RnJvbSAyOTZhODMwNDZlNzdjMWQ0OWRiOGQzMjRmMjk4MjgwMjY1ZGZiNmRjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBQdXJkZWEgQW5kcmVpIDxhbmRyZWkucHVyZGVhQG1vdmlkaXVz
LmNvbT4KRGF0ZTogVHVlLCAxMSBKdWwgMjAxNyAyMzowMDoxNSArMDMwMApTdWJqZWN0OiBbUEFU
Q0hdIGRpZmYvcmVhZC1jYWNoZTogZG9uJ3QgYXNzdW1lIGVtcHR5IGZpbGVzIHdpbGwgZmlsdGVy
IHRvCiBlbXB0eQoKVGhlcmUgYXJlIHNvbWUgcHJvamVjdHMgdGhhdCBhcmUgYmFzZWQgb24gZ2l0
IHNtdWRnZS9jbGVhbiBmaWx0ZXJzIHRoYXQgd29uJ3QKbmVjZXNzYXJpbHkgcHJvZHVjZSBlbXB0
eSBmaWxlcyB3aGVuIGNsZWFuLWluZyBlbXB0eSBmaWxlcy4gQW4gZXhhbXBsZSBvZiBzdWNoCmEg
cHJvamVjdCBpcyBnaXQtZmF0LCB3aGljaCBzdG9yZXMgYmluYXJ5IGZpbGVzIGVsc2V3aGVyZSwg
YnV0IHVzZXMgZ2l0IHRvCnN0b3JlIG9ubHkgYSByZWZlcmVuY2UgdG8gdGhhdCBiaW5hcnkgZmls
ZS4gVGhlIHJlZmVyZW5jZSB0byB0aGUgZmlsZSBjb25zaXN0cwpvZiBhIGhhc2ggYW5kIHRoZSBm
aWxlIHNpemUuIFNvIGFuIGVtcHR5IHdpbGwgd2lsbCBwcm9kdWNlIGEgbm9uLWVtcHR5IGZpbGUK
YWZ0ZXIgcGFzc2luZyBpdCB0aHJvdWdoIHRoZSBnaXQtZmF0IGNsZWFuIGZpbHRlci4KCkN1cnJl
bnQgR0lULCB3aGVuIGl0IHNlZXMgYW4gZW1wdHkgZmlsZSBvbiBnaXQgZGlmZiwgaXQgaW50ZXJw
cmV0cyBpdCBzcGVjaWFsbHksCmFuZCBpdCB3b24ndCBwYXNzIGl0IHRocm91Z2ggdGhlIGNsZWFu
IGZpbHRlci4gQnV0IGluIG90aGVyIGNvbmRpdGlvbnMgaXQgd2lsbC4KRm9yIGV4YW1wbGUgeW91
IGNhbiBjcmVhdGUgYSBjb21taXQgY29udGFpbmluZyBhbiBlbXB0eSBnaXQtZmF0IG1hbmFnZWQg
ZmlsZSwKYW5kIGluIHRoYXQgY2FzZSB0aGUgZmlsZSB3aWxsIGJlIHBhc3NlZCB0aHJvdWdoIHRo
ZSBjbGVhbiBmaWx0ZXIsIGFuZCB0aGUgZ2l0CnJlcG9zaXRvcnkgd2lsbCBjb250YWluIHRoZSBl
eHBhbmRlZCBoYXNoIG9mIGFuIGVtcHR5IGZpbGUuIElmIHlvdSB0cnkgdG8gcnVuCmdpdCBkaWZm
IG9uIHN1Y2ggYSByZXBvc2l0b3J5LCBpdCB3aWxsIGFsd2F5cyBzaG93IHRoaXMgZmlsZSBhcyBj
aGFuZ2VkLCBiZWNhdXNlCmdpdCBkaWZmIHdpbGwgY29tcGFyZSB0aGUgZXhwYW5kZWQgaGFzaCB0
aGF0IGlzIGFscmVhZHkgaW4gdGhlIHJlcG9zaXRvcnksIHRvCnRoZSBlbXB0eSBmaWxlIHRoYXQg
aGFzIG5vdCBiZWVuIHBhc3NlZCB0aHJvdWdoIHRoZSBjbGVhbiBmaWx0ZXIuIFRoaXMgd2lsbApy
ZXN1bHQgaW4gZmlsZXMgdGhhdCB3aWxsIGFsd2F5cyBzaG93IHVwIGFzIG1vZGlmaWVkLiBUaGUg
ImNoYW5nZXMiIGNhbm5vdCBiZQpjb21taXR0ZWQsIG9yIGNoZWNrZWQtb3V0IHRvIHRoZSB3b3Jr
aW5nIHRyZWUsIGFuZCBnaXQgd2lsbCBub3QgYWxsb3cgdXMgdG8KcGVyZm9ybSBtb3JlIGNvbXBs
ZXggb3BlcmF0aW9ucyBzdWNoIGFzIHJlYmFzZSAvIG1lcmdlLiBUaGUgb25seSBhY3Rpb24gaXMg
dG8KZGVsZXRlIHRoZSBmaWxlLgoKVGhlIHBhdGNoIGZpeGVzIHRoZSBpc3N1ZSBpbiB0d28gcGxh
Y2VzOgoKZGlmZi5jOiBzZW5kIHRoZSBmaWxlIHRocm91Z2ggZ2l0LWNsZWFuIGZpbHRlciBldmVu
IGlmIGl0IGlzIGVtcHR5LgoKcmVhZC1jYWNoZS5jOiByZWFkLWNhY2hlIHVzZXMgYSBtYWdpYyBu
dW1iZXIgb2YgemVyby1zaXplZCBmaWxlcyB0byBzbXVkZ2UKY2FjaGUgZW50cmllcyB0aGF0IGhh
dmUgdGhlIHNhbWUgdGltZXN0YW1wIGFzIG90aGVyIGZpbGUgbW9kaWZpY2F0aW9ucy4KKE5vdGU6
IHRoZSB3b3JkIHNtdWRnZSBoZXJlIGlzIHVucmVsYXRlZCB0byB0aGUgInNtdWRnZSBmaWx0ZXIi
IGNvbmNlcHQpClNtdWRnZWQgZW50cmllcyB3aWxsIGhhdmUgYSB6ZXJvIGZpbGUgc2l6ZSwgYnV0
IHRoZSBzdG9yZWQgaGFzaCB3aWxsIG5vdCBlcXVhbAp0aGUgdW5pcXVlLCBrbm93biBoYXNoIG9m
IGFuIGVtcHR5IGZpbGUuIEluIHRoZSBhYnNlbmNlIG9mIGNsZWFuIGZpbHRlcnMgdGhhdApjYW4g
cHJvZHVjZSBub24temVybyBmaWxlcyBmcm9tIHplcm8tc2l6ZWQgZmlsZXMsIHRoaXMgaXMgYSBn
b29kIHdheSB0bwpkZXRlY3RhYmx5IGNvcnJ1cHQgYSBjYWNoZSBlbnRyeS4gSG93ZXZlciBpbiB0
aGUgcHJlc2VuY2Ugb2YgZ2l0IGNsZWFuIGZpbHRlcnMKdGhhdCBkbyB0aGlzLCB0aGUgZmlsZSB3
aWxsIGJlIGNvbnNpZGVyZWQgc211ZGdlZCwgYW5kIGl0IHdpbGwga2VlcCBzaG93aW5nIHVwCmFz
IHRvdWNoZWQgYnkgdGhlIHVzZXIuIFRoYXQgaXMgYmVjYXVzZSB0aGUgc3RvcmVkIGhhc2ggaXMg
YWN0dWFsbHkgdGhlIGhhc2gKb2YgdGhlIGZpbGUgYWZ0ZXIgaXQgaGFzIHBhc3NlZCB0byB0aGUg
Y2xlYW4gZmlsdGVyLCBhbmQgaXQncyBub3QgZW1wdHkgYW55bW9yZS4KVGhpcyBjaGFuZ2UgZml4
ZXMgdGhlIGNvbmRpdGlvbiBieSB1c2luZyBhIGRpZmZlcmVudCBtYWdpYyBudW1iZXIgb2Ygc211
ZGdlZAplbnRyaWVzLiBJdCB1c2VzIC0xIHdoaWNoIGlzIHRoZSBiaWdnZXN0IHBvc3NpYmxlIGZp
bGUgc2l6ZSBzdG9yZWQuCgpTaWduZWQtb2ZmLWJ5OiBQdXJkZWEgQW5kcmVpIDxhbmRyZWlAcHVy
ZGVhLnJvPgotLS0KIGRpZmYuYyAgICAgICB8IDE4ICsrKysrKysrKystLS0tLS0tLQogcmVhZC1j
YWNoZS5jIHwgIDcgKysrLS0tLQogMiBmaWxlcyBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspLCAx
MiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kaWZmLmMgYi9kaWZmLmMKaW5kZXggMDBiNGM4
NjY5Li43NmJiNTM2Y2UgMTAwNjQ0Ci0tLSBhL2RpZmYuYworKysgYi9kaWZmLmMKQEAgLTI4NTgs
OCArMjg1OCw2IEBAIGludCBkaWZmX3BvcHVsYXRlX2ZpbGVzcGVjKHN0cnVjdCBkaWZmX2ZpbGVz
cGVjICpzLCB1bnNpZ25lZCBpbnQgZmxhZ3MpCiAJCQl9CiAJCX0KIAkJcy0+c2l6ZSA9IHhzaXpl
X3Qoc3Quc3Rfc2l6ZSk7Ci0JCWlmICghcy0+c2l6ZSkKLQkJCWdvdG8gZW1wdHk7CiAJCWlmIChT
X0lTTE5LKHN0LnN0X21vZGUpKSB7CiAJCQlzdHJ1Y3Qgc3RyYnVmIHNiID0gU1RSQlVGX0lOSVQ7
CiAKQEAgLTI4OTQsMTIgKzI4OTIsMTYgQEAgaW50IGRpZmZfcG9wdWxhdGVfZmlsZXNwZWMoc3Ry
dWN0IGRpZmZfZmlsZXNwZWMgKnMsIHVuc2lnbmVkIGludCBmbGFncykKIAkJCXMtPmlzX2JpbmFy
eSA9IDE7CiAJCQlyZXR1cm4gMDsKIAkJfQotCQlmZCA9IG9wZW4ocy0+cGF0aCwgT19SRE9OTFkp
OwotCQlpZiAoZmQgPCAwKQotCQkJZ290byBlcnJfZW1wdHk7Ci0JCXMtPmRhdGEgPSB4bW1hcChO
VUxMLCBzLT5zaXplLCBQUk9UX1JFQUQsIE1BUF9QUklWQVRFLCBmZCwgMCk7Ci0JCWNsb3NlKGZk
KTsKLQkJcy0+c2hvdWxkX211bm1hcCA9IDE7CisJCWlmICghcy0+c2l6ZSkgeworCQkJcy0+ZGF0
YSA9ICIiOworCQl9IGVsc2UgeworCQkJZmQgPSBvcGVuKHMtPnBhdGgsIE9fUkRPTkxZKTsKKwkJ
CWlmIChmZCA8IDApCisJCQkJZ290byBlcnJfZW1wdHk7CisJCQlzLT5kYXRhID0geG1tYXAoTlVM
TCwgcy0+c2l6ZSwgUFJPVF9SRUFELCBNQVBfUFJJVkFURSwgZmQsIDApOworCQkJY2xvc2UoZmQp
OworCQkJcy0+c2hvdWxkX211bm1hcCA9IDE7CisJCX0KIAogCQkvKgogCQkgKiBDb252ZXJ0IGZy
b20gd29ya2luZyB0cmVlIGZvcm1hdCB0byBjYW5vbmljYWwgZ2l0IGZvcm1hdApkaWZmIC0tZ2l0
IGEvcmVhZC1jYWNoZS5jIGIvcmVhZC1jYWNoZS5jCmluZGV4IDIxMjFiNmU3Yi4uY2EzMDY5OTNj
IDEwMDY0NAotLS0gYS9yZWFkLWNhY2hlLmMKKysrIGIvcmVhZC1jYWNoZS5jCkBAIC0yNjIsOSAr
MjYyLDggQEAgc3RhdGljIGludCBjZV9tYXRjaF9zdGF0X2Jhc2ljKGNvbnN0IHN0cnVjdCBjYWNo
ZV9lbnRyeSAqY2UsIHN0cnVjdCBzdGF0ICpzdCkKIAljaGFuZ2VkIHw9IG1hdGNoX3N0YXRfZGF0
YSgmY2UtPmNlX3N0YXRfZGF0YSwgc3QpOwogCiAJLyogUmFjaWx5IHNtdWRnZWQgZW50cnk/ICov
Ci0JaWYgKCFjZS0+Y2Vfc3RhdF9kYXRhLnNkX3NpemUpIHsKLQkJaWYgKCFpc19lbXB0eV9ibG9i
X3NoYTEoY2UtPm9pZC5oYXNoKSkKLQkJCWNoYW5nZWQgfD0gREFUQV9DSEFOR0VEOworCWlmIChj
ZS0+Y2Vfc3RhdF9kYXRhLnNkX3NpemUgPT0gKHVuc2lnbmVkIGludCktMSkgeworCQljaGFuZ2Vk
IHw9IERBVEFfQ0hBTkdFRDsKIAl9CiAKIAlyZXR1cm4gY2hhbmdlZDsKQEAgLTIwMjgsNyArMjAy
Nyw3IEBAIHN0YXRpYyB2b2lkIGNlX3NtdWRnZV9yYWNpbHlfY2xlYW5fZW50cnkoc3RydWN0IGNh
Y2hlX2VudHJ5ICpjZSkKIAkJICogZmlsZSwgYW5kIG5ldmVyIGNhbGxzIHVzLCBzbyB0aGUgY2Fj
aGVkIHNpemUgaW5mb3JtYXRpb24KIAkJICogZm9yICJmcm90eiIgc3RheXMgNiB3aGljaCBkb2Vz
IG5vdCBtYXRjaCB0aGUgZmlsZXN5c3RlbS4KIAkJICovCi0JCWNlLT5jZV9zdGF0X2RhdGEuc2Rf
c2l6ZSA9IDA7CisJCWNlLT5jZV9zdGF0X2RhdGEuc2Rfc2l6ZSA9ICh1bnNpZ25lZCBpbnQpLTE7
CiAJfQogfQogCi0tIAoyLjExLjAKCg==
--001a113e7ff0905113055478da0b--
