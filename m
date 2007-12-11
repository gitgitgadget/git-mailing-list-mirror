From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: git blame with valgrind massif
Date: Tue, 11 Dec 2007 15:57:24 -0500
Message-ID: <9e4733910712111257h20a4a916gd4747e816e4706ff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 11 21:57:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2CAn-0001T9-It
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 21:57:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752027AbXLKU51 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 15:57:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751940AbXLKU51
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 15:57:27 -0500
Received: from rv-out-0910.google.com ([209.85.198.191]:39668 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751816AbXLKU50 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 15:57:26 -0500
Received: by rv-out-0910.google.com with SMTP id k20so2165662rvb
        for <git@vger.kernel.org>; Tue, 11 Dec 2007 12:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=IkdK2BlCkJi/45vFeFaCxychAtaXHNPuxp10dCxpfdU=;
        b=s6sRdTjBvVRnyRr1EQNoJrIY9D5FysFE9cCZMkACOK8S9OL3ABs09l3Ty7IMx+amEi5x89GavXZ2uozXb9VW3ivd3RB5hZwhVgJ3tHKkXW6kXwxUdZoAIT/MW5xInMpsSxDlrkXEfaSUuOCc4kImU6ZNCvmScvdZ3oatpzDsUD0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ZKhE+LySLl2yOs33l0hq3xs5LYCq9+uDYahg8i6WFqlb5hDQVh5prtPBLDKbLaLLIWf7I94DnB5xa7b0zS1+qfcQWJit7T7ik/xItIMCMbLIdezDcVjCnYtWlOfIUGilMhKOm5InEJmPm32AwM1QR8Etg1qVRjKD7n4aT6mwgNk=
Received: by 10.141.48.10 with SMTP id a10mr3001945rvk.1197406644431;
        Tue, 11 Dec 2007 12:57:24 -0800 (PST)
Received: by 10.140.166.14 with HTTP; Tue, 11 Dec 2007 12:57:24 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67938>

I ran:
 valgrind --tool=massif --heap=yes git blame gcc/ChangeLog
it used about 2.25GB

How do you interpret the massif output?

Command: git blame gcc/ChangeLog

== 0 ===========================
Heap allocation functions accounted for 98.2% of measured spacetime

Called from:
  34.3% : 0x44EFC2: patch_delta (git-compat-util.h:235)

  24.7% : 0x45DD38: cache_or_unpack_entry (git-compat-util.h:235)

  13.1% : 0x4909FC: xdl_cha_alloc (xutils.c:113)

  12.0% : 0x461277: strbuf_grow (git-compat-util.h:268)

   5.9% : 0x40EF5A: cmd_blame (git-compat-util.h:235)

   2.6% : 0x48FA5E: xdl_prepare_env (xprepare.c:79)

   1.9% : 0x45D775: unpack_compressed_entry (git-compat-util.h:235)

   1.5% : 0x452FE5: read_index_from (git-compat-util.h:284)

   1.3% : 0x48F672: xdl_prepare_ctx (xprepare.c:162)

  and 61 other insignificant places

== 1 ===========================
Context accounted for 34.3% of measured spacetime
  0x44EFC2: patch_delta (git-compat-util.h:235)

Called from:
  34.3% : 0x45DA03: unpack_entry (sha1_file.c:1578)

---------------------------------
Context accounted for 24.7% of measured spacetime
  0x45DD38: cache_or_unpack_entry (git-compat-util.h:235)

Called from:
  24.7% : 0x45F175: read_packed_sha1 (sha1_file.c:1815)

---------------------------------
Context accounted for 13.1% of measured spacetime
  0x4909FC: xdl_cha_alloc (xutils.c:113)

Called from:
   6.6% : 0x48F75B: xdl_prepare_ctx (xprepare.c:192)

   4.0% : 0x48F83A: xdl_prepare_ctx (xprepare.c:115)

---------------------------------
Context accounted for 12.0% of measured spacetime
  0x461277: strbuf_grow (git-compat-util.h:268)

Called from:
  12.0% : 0x4617F4: strbuf_read (strbuf.c:192)

  and 2 other insignificant places

---------------------------------
Context accounted for  5.9% of measured spacetime
  0x40EF5A: cmd_blame (git-compat-util.h:235)

Called from:
   5.9% : 0x40405A: handle_internal_command (git.c:266)

---------------------------------
Context accounted for  2.6% of measured spacetime
  0x48FA5E: xdl_prepare_env (xprepare.c:79)

Called from:
   2.6% : 0x48F21A: xdl_do_diff (xdiffi.c:332)

---------------------------------
Context accounted for  1.9% of measured spacetime
  0x45D775: unpack_compressed_entry (git-compat-util.h:235)

Called from:
   1.9% : 0x45D945: unpack_entry (sha1_file.c:1606)

  and 1 other insignificant place

---------------------------------
Context accounted for  1.5% of measured spacetime
  0x452FE5: read_index_from (git-compat-util.h:284)

Called from:
   1.5% : 0x40FAD7: cmd_blame (builtin-blame.c:2075)

---------------------------------
Context accounted for  1.3% of measured spacetime
  0x48F672: xdl_prepare_ctx (xprepare.c:162)

Called from:
   0.6% : 0x48FAAB: xdl_prepare_env (xprepare.c:280)

  and 1 other insignificant place

== 2 ===========================
Context accounted for 34.3% of measured spacetime
  0x44EFC2: patch_delta (git-compat-util.h:235)
  0x45DA03: unpack_entry (sha1_file.c:1578)

Called from:
  41.7% : 0x45D9BE: unpack_entry (sha1_file.c:1567)

  33.3% : 0x45F175: read_packed_sha1 (sha1_file.c:1815)

---------------------------------
Context accounted for 24.7% of measured spacetime
  0x45DD38: cache_or_unpack_entry (git-compat-util.h:235)
  0x45F175: read_packed_sha1 (sha1_file.c:1815)

Called from:
  24.7% : 0x45F55D: read_sha1_file (sha1_file.c:1881)

---------------------------------
Context accounted for  6.6% of measured spacetime
  0x4909FC: xdl_cha_alloc (xutils.c:113)
  0x48F75B: xdl_prepare_ctx (xprepare.c:192)

Called from:
   2.9% : 0x48FAAB: xdl_prepare_env (xprepare.c:280)

   1.6% : 0x48FAD0: xdl_prepare_env (xprepare.c:285)

---------------------------------
Context accounted for  4.0% of measured spacetime
  0x4909FC: xdl_cha_alloc (xutils.c:113)
  0x48F83A: xdl_prepare_ctx (xprepare.c:115)

Called from:
   4.0% : 0x48FAAB: xdl_prepare_env (xprepare.c:280)

  and 1 other insignificant place

---------------------------------
Context accounted for 12.0% of measured spacetime
  0x461277: strbuf_grow (git-compat-util.h:268)
  0x4617F4: strbuf_read (strbuf.c:192)

Called from:
  12.0% : 0x461881: strbuf_read_file (strbuf.c:228)

---------------------------------
Context accounted for  5.9% of measured spacetime
  0x40EF5A: cmd_blame (git-compat-util.h:235)
  0x40405A: handle_internal_command (git.c:266)

Called from:
   5.9% : 0x4045C9: main (git.c:456)

---------------------------------
Context accounted for  2.6% of measured spacetime
  0x48FA5E: xdl_prepare_env (xprepare.c:79)
  0x48F21A: xdl_do_diff (xdiffi.c:332)

Called from:
   2.6% : 0x48F3B0: xdl_diff (xdiffi.c:542)

---------------------------------
Context accounted for  1.9% of measured spacetime
  0x45D775: unpack_compressed_entry (git-compat-util.h:235)
  0x45D945: unpack_entry (sha1_file.c:1606)

Called from:
   2.4% : 0x45F175: read_packed_sha1 (sha1_file.c:1815)

  and 1 other insignificant place

---------------------------------
Context accounted for  1.5% of measured spacetime
  0x452FE5: read_index_from (git-compat-util.h:284)
  0x40FAD7: cmd_blame (builtin-blame.c:2075)

Called from:
   1.5% : 0x40405A: handle_internal_command (git.c:266)

---------------------------------
Context accounted for  0.6% of measured spacetime
  0x48F672: xdl_prepare_ctx (xprepare.c:162)
  0x48FAAB: xdl_prepare_env (xprepare.c:280)

Called from:
   0.6% : 0x48F21A: xdl_do_diff (xdiffi.c:332)

=================================

End of information.  Rerun with a bigger --depth value for more.

-- 
Jon Smirl
jonsmirl@gmail.com
