From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] doc: technical details about the index file format
Date: Tue, 01 Mar 2011 17:51:01 -0800
Message-ID: <7vpqqaffy2.fsf@alter.siamese.dyndns.org>
References: <AANLkTi=iFe=MmUiXzC_HMwueZxLJDCea+zp_-SNWvSup@mail.gmail.com>
 <1283769430-9263-1-git-send-email-pclouds@gmail.com>
 <AANLkTi=YJkk6KHChCrrazij_ziyG-Ru7kGLWc7JnUGoN@mail.gmail.com>
 <AANLkTi=hz0xRsTy5f8xhzBhu0md_iPCxvdTrEPrzYwzt@mail.gmail.com>
 <20110226100310.GA21724@do> <7vsjvb6qmt.fsf@alter.siamese.dyndns.org>
 <20110226133639.GA32442@do>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org,
	kusmabite@gmail.com, raa.lkml@gmail.com, jjuran@gmail.com,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 02 02:51:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PubDt-0006RC-IR
	for gcvg-git-2@lo.gmane.org; Wed, 02 Mar 2011 02:51:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757765Ab1CBBvW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2011 20:51:22 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:54072 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757762Ab1CBBvV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2011 20:51:21 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7EBEE4390;
	Tue,  1 Mar 2011 20:52:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+oucx22GyUuHLLbD2t+Q9dfzzEA=; b=r0kFUc
	MsIoNAhJX8gI640GYqKBOFFNENdv466HCAczXae5YvE79+hPGPsTgweSCsENrUvz
	fy8N2zjB/obOL4uo0TtIMl1Fhls2g8LM0ShbKa1gmajG70mxvZlacTBEEmLGrmfk
	30DM3ZbFJaP0W7NJSnjha9pQN4iMOL4L9Vjds=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XGI/4hqWFpGVzhsCxtSTD+XPuxESSFHC
	YPhryYitbXcYPAj/LHLscH1uC3n++lAF1mwJQqh7F2adSQ2i2qCbYmkByjCHVBsM
	PZjLvZZRpbFpjTm35XrslnJX8gI3fMtusOWaWU5P1QHJJoMetV6WQvUkggsdpo8S
	/e/2iQbOyk0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0BAC5438E;
	Tue,  1 Mar 2011 20:52:32 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9D0694380; Tue,  1 Mar 2011
 20:52:22 -0500 (EST)
In-Reply-To: <20110226133639.GA32442@do> (Nguyen Thai Ngoc Duy's message of
 "Sat\, 26 Feb 2011 20\:36\:39 +0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: BCC2D290-446F-11E0-80D8-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168287>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> OK another try. I also add more details to tree cache. If somebody
> uses this document to create a git-compatible tool, then such a tool
> should behave the way git expects it.

Thanks.

Here is what I scribbled on top of yours (not quite polished).

 * Clarify "string of unsigned bytes";

 * Blob has two variants (regular file vs symlink), not (blob vs symlink);

 * Clarify permission mode bits;

 * Clarify ce_namelen() "too long to fit in the length field" case;

 * Clarify "." etc are forbidden as path components;

 * Match the description with the internal wording "cache-tree";

 * All types of extension begin with signature and length as explained in
   the first part. Don't repeat the "length" part in the description of
   each extension (can be mistaken as if there is a separate 32-bit size
   field inside the extension), but state what the signature for each
   extension is.

 * Don't say "Extension tag", as we have said "Extension signature" in the
   first part---be consistent;

 * Clarify the invalidation of cache-tree entries;

 * Correct description on subtree_nr field in the cache-tree;

 * Clarify the order of entries in cache-tree;



 Documentation/technical/index-format.txt |   94 ++++++++++++++++++------------
 1 files changed, 57 insertions(+), 37 deletions(-)

diff --git a/Documentation/technical/index-format.txt b/Documentation/technical/index-format.txt
index 89e410a..8923f6f 100644
--- a/Documentation/technical/index-format.txt
+++ b/Documentation/technical/index-format.txt
@@ -9,21 +9,21 @@ GIT index format
    - A 12-byte header consisting of
 
      4-byte signature:
-       The signature is { 'D', 'I', 'R', 'C' }
+       The signature is { 'D', 'I', 'R', 'C' } (stands for "dircache")
 
      4-byte version number:
        The current supported versions are 2 and 3.
 
      32-bit number of index entries.
 
-   - A number of sorted index entries
+   - A number of sorted index entries (see below).
 
    - Extensions
 
      Extensions are identified by signature. Optional extensions can
      be ignored if GIT does not understand them.
 
-     GIT currently supports tree cache and resolve undo extensions.
+     GIT currently supports cached tree and resolve undo extensions.
 
      4-byte extension signature. If the first byte is 'A'..'Z' the
      extension is optional and can be ignored.
@@ -38,8 +38,9 @@ GIT index format
 == Index entry
 
   Index entries are sorted in ascending order on the name field,
-  interpreted as a string of unsigned bytes. Entries with the same
-  name are sorted by their stage field.
+  interpreted as a string of unsigned bytes (i.e. memcmp() order, no
+  localization, no special casing of directory separator '/'). Entries
+  with the same name are sorted by their stage field.
 
   32-bit ctime seconds, the last time a file's metadata changed
     this is stat(2) data
@@ -62,12 +63,13 @@ GIT index format
   32-bit mode, split into (high to low bits)
 
     4-bit object type
-      valid values in binary are 1000 (blob), 1010 (symbolic link)
+      valid values in binary are 1000 (regular file), 1010 (symbolic link)
       and 1110 (gitlink)
 
     3-bit unused
 
-    9-bit unix permission (only 0755 and 0644 are valid)
+    9-bit unix permission. Only 0755 and 0644 are valid for regular files.
+    Symbolic links and gitlinks have value 0 in this field.
 
   32-bit uid
     this is stat(2) data
@@ -76,11 +78,11 @@ GIT index format
     this is stat(2) data
 
   32-bit file size
-    This is the on-disk size from stat(2)
+    This is the on-disk size from stat(2), truncated to 32-bit.
 
   160-bit SHA-1 for the represented object
 
-  A 16-bit field split into (high to low bits)
+  A 16-bit 'flags' field split into (high to low bits)
 
     1-bit assume-valid flag
 
@@ -88,7 +90,8 @@ GIT index format
 
     2-bit stage (during merge)
 
-    12-bit name length if the length is less than 0x0FFF
+    12-bit name length if the length is less than 0xFFF; otherwise 0xFFF
+    is stored in this field.
 
   (Version 3) A 16-bit field, only applicable if the "extended flag"
   above is 1, split into (high to low bits).
@@ -103,63 +106,80 @@ GIT index format
 
   Entry path name (variable length) relative to top level directory
     (without leading slash). '/' is used as path separator. The special
-    paths ".", ".." and ".git" (without quotes) are disallowed.
+    path components ".", ".." and ".git" (without quotes) are disallowed.
     Trailing slash is also disallowed.
 
     The exact encoding is undefined, but the '.' and '/' characters
-    are encoded in 7-bit ASCII and the encoding cannot contain a nul
-    byte. Generally a superset of ASCII.
+    are encoded in 7-bit ASCII and the encoding cannot contain a NUL
+    byte (iow, this is a UNIX pathname).
 
   1-8 nul bytes as necessary to pad the entry to a multiple of eight bytes
   while keeping the name NUL-terminated.
 
 == Extensions
 
-=== Tree cache
+=== Cached tree
 
-  Tree cache extension contains pre-computed hashes for trees that can
+  Cached tree extension contains pre-computed hashes for trees that can
   be derived from the index. It helps speed up tree object generation
   from index for a new commit.
 
   When a path is updated in index, the path must be invalidated and
   removed from tree cache.
 
-  - Extension tag { 'T', 'R', 'E', 'E' }
+  The signature for this extension is { 'T', 'R', 'E', 'E' }.
 
-  - 32-bit size
+  A series of entries fill the entire extension; each of which
+  consists of:
 
-  - A number of entries
+  - NUL-terminated path component (relative to its parent directory);
 
-     NUL-terminated tree name
+  - ASCII decimal number of entries in the index that is covered by the
+    tree this entry represents (entry_count);
 
-     Blank-terminated ASCII decimal number of entries in this tree
+  - A space (ASCII 32);
 
-     Newline-terminated position of this tree in the parent tree. 0 for
-     the root tree
+  - ASCII decimal number that represents the number of subtrees this
+    tree has;
 
-     160-bit SHA-1 for this tree and it's children
+  - A newline (ASCII 10); and
+
+  - 160-bit object name for the object that would result from writing
+    this span of index as a tree.
+  
+  An entry can be in an invalidated state and is represented by having -1
+  in the entry_count field.
+
+  The entries are written out in the top-down, depth-first order.  The
+  first entry represents the root level of the repository, followed by the
+  first subtree---let's call this A---of the root level (with its name
+  relative to the root level), followed by the first subtree of A (with
+  its name relative to A), ...
 
 === Resolve undo
 
-  A conflict is represented in index as a set of higher stage entries.
+  A conflict is represented in the index as a set of higher stage entries.
   When a conflict is resolved (e.g. with "git add path"), these higher
-  stage entries will be removed and a stage-0 entry with proper
-  resoluton is added.
+  stage entries will be removed and a stage-0 entry with proper resoluton
+  is added.
 
-  Resolve undo extension saves these higher stage entries so that
-  conflicts can be recreated (e.g. with "git checkout -m"), in case
-  users want to redo a conflict resolution from scratch.
+  When these higher stage entries are removed, they are saved in the
+  resolve undo extension, so that conflicts can be recreated (e.g. with
+  "git checkout -m"), in case users want to redo a conflict resolution
+  from scratch.
 
-  - Extension tag { 'R', 'E', 'U', 'C' }
+  The signature for this extension is { 'R', 'E', 'U', 'C' }.
 
-  - 32-bit size
+  A series of entries fill the entire extension; each of which
+  consists of:
 
-  - A number of conflict entries
+  - NUL-terminated pathname the entry describes (relative to the root of
+    the repository, i.e. full pathname);
 
-    NUL-terminated conflict path
+  - Three NUL-terminated ASCII octal numbers, entry mode of entries in
+    stage 1 to 3 (a missing stage is represented by "0" in this field);
+    and
 
-    Three NUL-terminated ASCII octal numbers, entry mode of entries in
-    stage 1 to 3.
+  - At most three 160-bit object names of the entry in stages from 1 to 3
+    (nothing is written for a missing stage).
 
-    At most three 160-bit SHA-1s of the entry in three stages from 1
-    to 3. SHA-1 is not saved for any stage with entry mode zero.
