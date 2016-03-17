From: Duy Nguyen <pclouds@gmail.com>
Subject: [RFC] Code reorgnization
Date: Thu, 17 Mar 2016 18:11:36 +0700
Message-ID: <20160317111136.GA21745@lanh>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 17 12:11:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agVqC-0006hH-NO
	for gcvg-git-2@plane.gmane.org; Thu, 17 Mar 2016 12:11:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932903AbcCQLLg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2016 07:11:36 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:34018 "EHLO
	mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932832AbcCQLLf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2016 07:11:35 -0400
Received: by mail-pf0-f171.google.com with SMTP id x3so116698099pfb.1
        for <git@vger.kernel.org>; Thu, 17 Mar 2016 04:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=QrYgfXHBtywAZ6Y7nipQYuMTCYyy+y07yAMhCHgeLj4=;
        b=d2y/iRahAKj5sxR5unJzsE03Y3E6DvjDyqpBGA3nsetBWbRVLzIPr8xPAuLWepjv0H
         vcDOXOvvmgCB6FaXMctXAvtFvQeYRFaLKNqyPtXJkJ4HcJGyvQzuVpsawEdvfgWKoJHe
         ELj5YXm3xe37myUOaaLkvzLyqYLY91FwdqWvPVIz3RQJuwYC77w4dE2aBeZPjXrzNhlm
         TK6dkEN5u89+KZOA+2V/TItFbexCQ8wrTk1S2W46tlMZqXmzzuoBMG8bLEoUBXtXClVc
         cSJaAoIwN8q8YF24M6r1hUEEVaK2beHQNHc1d19gbaiIZnJG0i5p7n5gEXFSAyUWFM5u
         c/DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=QrYgfXHBtywAZ6Y7nipQYuMTCYyy+y07yAMhCHgeLj4=;
        b=mn3Kh904enihN/bjnyfcUcj6DIKnFlp1PNruSP2xuIzvA2UkpST0dZ4glwGZpZFRTe
         mYTG8wFZEXT8tgvlLU4qNXI3DZvKAVPokGMJZGs1Zc+iLUP4zi0c27GqO0cAXbrsy9OR
         MWuuI1Kw3Otn7QBKJvG6SZF9sUxbVzS+ZoF0EBd9z784MMntBei9R6/LM5d8gwIymsga
         gYQYjGrY06aODuSQJqnc3PiDdY5vXPErpabQU2qurOSpb2iPtVqOpmvxGRSVv0zc8s13
         EPW3i4lCJS8UtdvlWxDf0cUp9AmW9QVfjylP7izmN9OjLaqceTr3J7umylVI7c5w4PWt
         eQ0g==
X-Gm-Message-State: AD7BkJIWk3oClgdEtNYS/Msjxe55LEf81jbnCZxhbgDm8trpBHOynNOH1sfp0LYBLvluZA==
X-Received: by 10.66.175.110 with SMTP id bz14mr13893823pac.41.1458213094371;
        Thu, 17 Mar 2016 04:11:34 -0700 (PDT)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id vy6sm12547392pac.38.2016.03.17.04.11.30
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Mar 2016 04:11:32 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Thu, 17 Mar 2016 18:11:36 +0700
Content-Disposition: inline
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289098>

Git's top directory is crowded and I think it's agreed that moving
test-* to t/helper is a good move. I just wanted to check if we could
take this opportunity (after v2.8.0) to move some other files too. I
propose the following new subdirs

lib
---
This contains files that are about data structures or algorithms. Very
general purpose. This directory includes

argv-array.[ch] base85.c column.[ch] delta.h diff-delta.c hashmap.[ch]
hex.c khash.h kwset.[ch] levenshtein.[ch] mergesort.[ch] patch-delta.c
prio-queue.[ch] sha1-array.[ch] sha1-lookup.[ch] strbuf.[ch]
string-list.[ch] url.[ch] urlmatch.[ch] utf8.[ch] varint.[ch]
versioncmp.c wildmatch.[ch]

odb
---
The grouping of object database files is to easily make connections
between them. Unlike, for example, diff-related files which either
start with "diff" or has that word in the file name to make
connections.

alloc.c blob.[ch] bulk-checkin.[ch] commit-slab.h commit.[ch]
object.[ch] pack.h pack-revindex.[ch] replace_object.c sha1_file.c
streaming.[ch] tag.[ch] tree.[ch]

index
-----
For the same reason of odb subdir. This directory contains

cache-tree.[ch] name-hash.c preload-index.c read-cache.c
split-index.[ch] unpack-trees.[ch]

sys (or maybe util or support)
------------------------------
These are still general purpose but is usually system-related. They
are still far away from git's core logic. I want to separate them to
make it easier to spot "important" files at top dir.

abspath.c color.[ch] copy.c csum-file.[ch] ctype.c date.c editor.c
exec_cmd.[ch] gettext.[ch] gettext.h gpg-interface.[ch] ident.c
lockfile.[ch] mailinfo.[ch] mailmap.[ch] pager.c parse-options-cb.c
parse-options.[ch] pathspec.[ch] pkt-line.[ch] progress.[ch]
prompt.[ch] quote.[ch] run-command.[ch] sideband.[ch] sigchain.[ch]
symlinks.c tar.h tempfile.[ch] thread-utils.[ch] trace.[ch]
unix-socket.[ch] usage.c userdiff.[ch] wrapper.c write_or_die.c zlib.c

Good? Bad? Ugly?
--
Duy
