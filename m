From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: What's cooking in git.git (Oct 2013, #03; Wed, 16)
Date: Fri, 18 Oct 2013 02:42:15 +0200
Message-ID: <526083E7.6080701@gmail.com>
References: <xmqqa9i851t8.fsf@gitster.dls.corp.google.com>	<525FB287.7020204@gmail.com>	<xmqqzjq7y6k7.fsf@gitster.dls.corp.google.com> <xmqqmwm7y5bf.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Fri Oct 18 02:42:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWy8x-0005FH-PF
	for gcvg-git-2@plane.gmane.org; Fri, 18 Oct 2013 02:42:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751277Ab3JRAmP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Oct 2013 20:42:15 -0400
Received: from mail-ea0-f176.google.com ([209.85.215.176]:56910 "EHLO
	mail-ea0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751085Ab3JRAmO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Oct 2013 20:42:14 -0400
Received: by mail-ea0-f176.google.com with SMTP id q16so1518815ead.35
        for <git@vger.kernel.org>; Thu, 17 Oct 2013 17:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=tKodYAh2QYCohmXdYACmTfaHnFtYrVKTrsmNOjWsTn8=;
        b=HTAsSM7A3ysR4JrGgXcAQsg24PaW+SGBPdYDFg5wORtIJ9D+Ck8pKBzzqY+jaDh+dK
         uxiGw5i6r3xs4WRCzjqqxp813sBoteR78ooRru6zeTt/bSSPLs7lj2mqSn/VN1Wan59D
         0TNAxtl81ZjecJx4oRWBaOni7XDmQdemSpr8tNSDqpe1Wa1ytp1a0Bu47B88wpWOdq2s
         W3vOeVZsrNwztk+8RI1Ibh6S7yjc+UVd1hw2rUtyeYjC9MaDnGiDeO03kb+uL6oyftOa
         Ih2BystlNnBq8EJp3yaUCdyUxHjBV30OWdMJUc2uX4UGnE/NIbC9T6dmO5NZht7ddO7E
         1ARQ==
X-Received: by 10.15.67.131 with SMTP id u3mr240142eex.34.1382056933909;
        Thu, 17 Oct 2013 17:42:13 -0700 (PDT)
Received: from [10.1.100.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id i1sm199585327eeg.0.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 17 Oct 2013 17:42:13 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.0.1
In-Reply-To: <xmqqmwm7y5bf.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236334>

Am 17.10.2013 23:07, schrieb Junio C Hamano:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Karsten Blees <karsten.blees@gmail.com> writes:
>>
>>> Am 16.10.2013 23:43, schrieb Junio C Hamano:
>>>> * kb/fast-hashmap (2013-09-25) 6 commits
>>>>  - fixup! diffcore-rename.c: simplify finding exact renames
>>>>  - diffcore-rename.c: use new hash map implementation
>>>>  - diffcore-rename.c: simplify finding exact renames
>>>>  - diffcore-rename.c: move code around to prepare for the next patch
>>>>  - buitin/describe.c: use new hash map implementation
>>>>  - add a hashtable implementation that supports O(1) removal
>>>>
>>>
>>> I posted a much more complete v3 [1], but somehow missed Jonathan's fixup! commit.
>>
>> Thanks; I'll replace the above with v3 and squash the fix-up in.
> 
> Interestingly, v3 applied on 'maint' and then merged to 'master'
> seems to break t3600 and t7001 with a coredump.
> 
> It would conflict with es/name-hash-no-trailing-slash-in-dirs that
> has been cooking in 'next', too; the resolution might be trivial but
> I didn't look too deeply into it.
> 

I've pushed a rebased version to https://github.com/kblees/git/commits/kb/hashmap-v3-next
(no changes yet except for Jonathan's fixup in #04 and merge resolution).

The coredumps are caused by my patch #10, which free()s cache_entries when they are removed, in combination with submodule.c::stage_updated_gitmodules (5fee9952 "submodule.c: add .gitmodules staging helper functions"), which removes a cache_entry, then modifies and re-adds the (now) free()d memory.

Can't we just use add_file_to_cache here (which replaces cache_entries by creating a copy)?


diff --git a/submodule.c b/submodule.c
index 1905d75..e388487 100644
--- a/submodule.c
+++ b/submodule.c
@@ -116,30 +116,7 @@ int remove_path_from_gitmodules(const char *path)
 
 void stage_updated_gitmodules(void)
 {
-       struct strbuf buf = STRBUF_INIT;
-       struct stat st;
-       int pos;
-       struct cache_entry *ce;
-       int namelen = strlen(".gitmodules");
-
-       pos = cache_name_pos(".gitmodules", namelen);
-       if (pos < 0) {
-               warning(_("could not find .gitmodules in index"));
-               return;
-       }
-       ce = active_cache[pos];
-       ce->ce_flags = namelen;
-       if (strbuf_read_file(&buf, ".gitmodules", 0) < 0)
-               die(_("reading updated .gitmodules failed"));
-       if (lstat(".gitmodules", &st) < 0)
-               die_errno(_("unable to stat updated .gitmodules"));
-       fill_stat_cache_info(ce, &st);
-       ce->ce_mode = ce_mode_from_stat(ce, st.st_mode);
-       if (remove_cache_entry_at(pos) < 0)
-               die(_("unable to remove .gitmodules from index"));
-       if (write_sha1_file(buf.buf, buf.len, blob_type, ce->sha1))
-               die(_("adding updated .gitmodules failed"));
-       if (add_cache_entry(ce, ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPLACE))
+       if (add_file_to_cache(".gitmodules", 0))
                die(_("staging updated .gitmodules failed"));
 }
