From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH/RFC 0/5] New hash table implementation
Date: Wed, 11 Sep 2013 01:27:00 +0200
Message-ID: <522FAAC4.2080601@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 11 01:27:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJXKt-0006W2-Gz
	for gcvg-git-2@plane.gmane.org; Wed, 11 Sep 2013 01:27:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751400Ab3IJX1C (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Sep 2013 19:27:02 -0400
Received: from mail-ea0-f169.google.com ([209.85.215.169]:42087 "EHLO
	mail-ea0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751136Ab3IJX1B (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Sep 2013 19:27:01 -0400
Received: by mail-ea0-f169.google.com with SMTP id k11so4274293eaj.0
        for <git@vger.kernel.org>; Tue, 10 Sep 2013 16:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=/4FO7GMegOgfbguvFpnQpXGu6XDU+GKzIohDoQvCYjo=;
        b=i4kmlPPxX03II1D5uZso59jiQRrSDOXB8qfPFJDZlnpXap4MqyEHo18hEMlu+cm4Wf
         m/v0+g5mSTt4IYuMpe0W8x+Babk3rmgG4nCGO6tsul5DvgTNuTVialUePUF/jXv5nP4I
         +/mWK7Byx0evY0x9QYRqqP8mWLCd0YeajNJN0fxmbvCeQ3WF/GO+V8KakvX5MOU6xzNM
         CZQVksmfCl1n9B63Z9hf8HA2CIuV0K5iEXh535MucYGkg1HYiPiQeZebG4i9B2itxD9U
         LpNaev4TWgySs5kD3Njuu5FFDb135vgGtaZeTbuBNNl1QgJOQEcE2Q8hPCwgOviTEymC
         KI0g==
X-Received: by 10.14.183.2 with SMTP id p2mr16606291eem.44.1378855620029;
        Tue, 10 Sep 2013 16:27:00 -0700 (PDT)
Received: from [10.1.100.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id z12sm35463506eev.6.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 10 Sep 2013 16:26:59 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234508>

Also here: https://github.com/kblees/git/tree/kb/hashmap

Hi,

this is a spin-off of my (very slowly progressing) msysgit fscache project. I needed to remove things from the hash table, which cannot be implemented efficiently in hash.[ch].

So I wrote hasmap.[ch], with these features:
- O(1) remove
- builtin entry chaining
- ready-to-use FNV-1 hash functions
- unit test
- additions are ~twice as fast
- uses less memory

Patches 2 and 5 convert existing uses of hash.[ch] to hashmap.[ch].
Patches 3 and 4 are useful optimizations of their own.

I haven't found the time to tackle name-hash.c yet, this is where remove() could come into play (to replace the CE_UNHASHED flag).

Karsten


Karsten Blees (5):
  add a hashtable implementation that supports O(1) removal
  buitin/describe.c: use new hash map implementation
  diffcore-rename.c: move code around to prepare for the next patch
  diffcore-rename.c: simplify finding exact renames
  diffcore-rename.c: use new hash map implementation

 Makefile           |   3 +
 builtin/describe.c |  53 +++++------
 diffcore-rename.c  | 185 +++++++++++++-------------------------
 hashmap.c          | 210 +++++++++++++++++++++++++++++++++++++++++++
 hashmap.h          | 200 +++++++++++++++++++++++++++++++++++++++++
 t/t0011-hashmap.sh | 236 ++++++++++++++++++++++++++++++++++++++++++++++++
 test-hashmap.c     | 258 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 995 insertions(+), 150 deletions(-)
 create mode 100644 hashmap.c
 create mode 100644 hashmap.h
 create mode 100755 t/t0011-hashmap.sh
 create mode 100644 test-hashmap.c

-- 
1.8.4.8243.gbcbdefd
