From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: What's cooking in git.git (Dec 2013, #02; Fri, 6)
Date: Sat, 07 Dec 2013 20:56:32 +0100
Message-ID: <52A37D70.3090400@gmail.com>
References: <xmqqk3fh1qrc.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 07 20:56:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VpNzS-0007Nw-CA
	for gcvg-git-2@plane.gmane.org; Sat, 07 Dec 2013 20:56:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755671Ab3LGT4b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Dec 2013 14:56:31 -0500
Received: from mail-ee0-f49.google.com ([74.125.83.49]:54272 "EHLO
	mail-ee0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755576Ab3LGT4a (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Dec 2013 14:56:30 -0500
Received: by mail-ee0-f49.google.com with SMTP id c41so853827eek.22
        for <git@vger.kernel.org>; Sat, 07 Dec 2013 11:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=WFaGW8yFsDe8M12zc1c7ZoNy8zL1wt7GhEcepl4VPIY=;
        b=oOI7qsIr2zu7a4MUkKhhJncuivqBUxMS3jyWQXSk++L3yru1cFKl2++WHmMTJcFQ9b
         fAFLfY395CqaHM9eZ2y2agrW8U/m/ZgxurM04ETRPbXjMOLFxffN+31DDlhDVo4tJ8PY
         8AliOM40M5yUHs55XHeUxFKRVFusWDVTUMc4bT9UInKHOstW09NJHvn7tCpPPRGvQ5WW
         fjm7apmlXIkVtawVzkVYmc+ZrioOAq/HkBOlAeRLrhfzZgzPjZstEfc9dV2MeOoVbbhM
         +C3PNftaw2PinBrh9CMu1KEmhiPjnWkIILO//ftMY2rfDcwof1R4VvEqH8sURTatwi04
         kggQ==
X-Received: by 10.14.207.194 with SMTP id n42mr1596273eeo.76.1386446189453;
        Sat, 07 Dec 2013 11:56:29 -0800 (PST)
Received: from [10.1.100.54] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id n1sm9570677eep.20.2013.12.07.11.56.28
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 07 Dec 2013 11:56:28 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.1.1
In-Reply-To: <xmqqk3fh1qrc.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239017>

Am 07.12.2013 00:52, schrieb Junio C Hamano:

> * kb/doc-exclude-directory-semantics (2013-11-07) 1 commit
>  - gitignore.txt: clarify recursive nature of excluded directories
> 
>  Originally merged to 'next' on 2013-11-13
> 
>  Kicked back to 'pu' to replace with a newer reroll ($gmane/237814
>  looked OK but there seems to have some loose ends in the
>  discussion).

I'm unaware of any loose ends, could you clarify?

Btw. $gmane/237814 seems to be a different topic, the version in next (and now in pu) was $gmane/237429.


> * kb/fast-hashmap (2013-11-18) 14 commits
>   (merged to 'next' on 2013-12-06 at f90be3d) 

Damn, a day too late :-) I found these two glitches today...is a fixup patch OK or should I do a reroll (or separate patch on top)?

Thanks,
Karsten

--- 8< ---
Subject: [PATCH] fixup! add a hashtable implementation that supports O(1) removal

Use 'unsigned int' for hash-codes everywhere.

Extending 'struct hashmap_entry' with an int-sized member shouldn't waste
memory on 64-bit systems. This is already documented in api-hashmap.txt,
but needs '__attribute__((__packed__))' to work. Reduces e.g.

 struct name_entry {
     struct hashmap_entry ent;
     int namelen;
     char *name;
 };

from 32 to 24 bytes.

Signed-off-by: Karsten Blees <blees@dcon.de>
---
 hashmap.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hashmap.h b/hashmap.h
index f5b3b61..b64567b 100644
--- a/hashmap.h
+++ b/hashmap.h
@@ -15,7 +15,7 @@ extern unsigned int memihash(const void *buf, size_t len);
 
 /* data structures */
 
-struct hashmap_entry {
+struct __attribute__((__packed__)) hashmap_entry {
 	struct hashmap_entry *next;
 	unsigned int hash;
 };
@@ -43,7 +43,7 @@ extern void hashmap_free(struct hashmap *map, int free_entries);
 
 /* hashmap_entry functions */
 
-static inline void hashmap_entry_init(void *entry, int hash)
+static inline void hashmap_entry_init(void *entry, unsigned int hash)
 {
 	struct hashmap_entry *e = entry;
 	e->hash = hash;
-- 
1.8.5.1.178.g0a9afc1.dirty
