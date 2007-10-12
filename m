From: "Shun Kei Leung" <kevinlsk@gmail.com>
Subject: git-fast-import crashes
Date: Fri, 12 Oct 2007 17:42:17 +0800
Message-ID: <e66701d40710120242p6fc05148hd40d19d295373ac4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 12 11:42:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IgH2M-0006hV-Si
	for gcvg-git-2@gmane.org; Fri, 12 Oct 2007 11:42:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755618AbXJLJmU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Oct 2007 05:42:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753121AbXJLJmU
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Oct 2007 05:42:20 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:55710 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751371AbXJLJmT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Oct 2007 05:42:19 -0400
Received: by nf-out-0910.google.com with SMTP id g13so716038nfb
        for <git@vger.kernel.org>; Fri, 12 Oct 2007 02:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=1J2oiQs6YWFaoSiOjFTHKsuZ37k+atBIE0a5H5GFhnM=;
        b=rkZphFHw74MM3BsWuAKgxMXLGZ9P1EBOi0q9sXNluXS7+PrRkS2ca7BQld6J+cq6UQYE0yyP1Swhqfn09PyHboFvmwagQ7zhgv8u756kmdfDOBDx5X6iPh9nWhIM+IPpr88GmvmAwLWc/Ru/pwdqcDqNhSDQbtw/q1Fkv9L07Yc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=n7lfPR9aPa2IFvTaIQZUqP8AEzrKlN5W0ULpHx9dCeAJaymkMFWAS4PKHRlqGeqiCatuLu4XjMwupsQDdampJum/vlIeDwabi6k4COYCyhGrfmqTdQvuMh6zc12ZZZ3i084bozoGMZWEBGOvYPlV7m7bwUgYMlUXtntRYnp7FQ8=
Received: by 10.78.193.5 with SMTP id q5mr2095793huf.1192182137252;
        Fri, 12 Oct 2007 02:42:17 -0700 (PDT)
Received: by 10.78.132.20 with HTTP; Fri, 12 Oct 2007 02:42:17 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60666>

Hi all,

I am using git 1.5.3.4.206.g58ba4-dirty on Mac OS X 10.4. When I tried
to run `git-p4 rebase', it failed with a broken pipe to
`git-fast-import'. I gather the following from GDB. I am kind of
stuck. Does anyone have any idea what's going on?


Program received signal EXC_BAD_ACCESS, Could not access memory.
Reason: KERN_INVALID_ADDRESS at address: 0x64617469
in_window (win=0x5004d0, offset=3501) at sha1_file.c:701
701             off_t win_off = win->offset;
(gdb) bt
#0  in_window (win=0x5004d0, offset=3501) at sha1_file.c:701
#1  0x0000a7b0 in use_pack (p=0x500740, w_cursor=0xbfffd328,
offset=3501, left=0xbfffd2c8) at sha1_file.c:728
#2  0x0000aaa0 in unpack_object_header (p=0x64617461, w_curs=0x0,
curpos=0xbfffd330, sizep=0xbffff4ec) at sha1_file.c:1329
#3  0x0000e17c in unpack_entry (p=0x500740, obj_offset=3501,
type=0xbffff4e8, sizep=0xbffff4ec) at sha1_file.c:1591
#4  0x0000dc8c in read_packed_sha1 (sha1=0x64617461 <Address
0x64617461 out of bounds>, type=0xbffff4e8, size=0xbffff4ec) at
sha1_file.c:1811
#5  0x0000dd90 in read_sha1_file (sha1=0xbffff4f0
")S??=?P\r?6[?w?S[\021\004??", type=0xbffff4e8, size=0xbffff4ec) at
sha1_file.c:1877
#6  0x0000e020 in read_object_with_reference (sha1=0x100950b
")S??=?P\r?6[?w?S[\021\004??", required_type_name=0x0,
size=0xbffff578, actual_sha1_return=0x100950b
")S??=?P\r?6[?w?S[\021\004??") at sha1_file.c:1906
#7  0x0000450c in cmd_from_existing (b=0x10094c0) at fast-import.c:1922
#8  0x00004b3c in cmd_from (b=0x10094c0) at fast-import.c:1965
#9  0x000078a0 in cmd_new_commit () at fast-import.c:2044
#10 0x000088f0 in main (argc=213252, argv=0xbffff838) at fast-import.c:2329
(gdb) print win
$1 = (struct pack_window *) 0x5004d0
(gdb) print *win
$2 = {
  next = 0x64617461,
  base = 0x20333936 <Address 0x20333936 out of bounds>,
  offset = 22523564414626158,
  len = 1685026675,
  last_used = 795894075,
  inuse_cnt = 0
}


Regards,
Kevin Leung
