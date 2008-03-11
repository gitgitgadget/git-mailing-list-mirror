From: "Whit Armstrong" <armstrong.whit@gmail.com>
Subject: Solaris test failure for git-1.5.4.4 -- t1300-repo-config.sh seg fault
Date: Tue, 11 Mar 2008 14:06:54 -0400
Message-ID: <8ec76080803111106w26e074eal35915ec634816cc7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 11 19:09:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZ8sz-0000zz-ML
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 19:07:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751848AbYCKSG7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2008 14:06:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751794AbYCKSG6
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Mar 2008 14:06:58 -0400
Received: from rv-out-0910.google.com ([209.85.198.185]:14634 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751213AbYCKSG5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2008 14:06:57 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1526481rvb.1
        for <git@vger.kernel.org>; Tue, 11 Mar 2008 11:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=c7TjguMeqFQOt6u9Wcm1IbTfQZqX6YynqM01n5KcX6A=;
        b=D4O/sJlogdDVzvNZ76YxLQKBetQqJ/6RkN5lRQ29XAp3q6/EkK+rsCLCPxN0xGXYOjy4A0iVwX6HhsZ5YKdBVyNOJ85cpZNMKq7ccVk/5WqJv/PFnebqeIgRFodQK7i4Vr1nEKRq4iJQzda9JP+qfB05rd5BeUr4X2d3FmD0NHc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=wrpp7L5CvUqYuaOyfYNMBp5wSUznWH8S0zWMJX/r0VuwoOrhVGrgxp0xrocgiXNlgLM649kThACFZYHEOGkdZXXhd19A9zj3EkXPUu6cZZySm96AZPkKxBo0fObi59YfpZvf5RuL7j05J5jb66PPhG4oJSAoxvnSWlMKW05p3AQ=
Received: by 10.141.15.19 with SMTP id s19mr4538348rvi.205.1205258814582;
        Tue, 11 Mar 2008 11:06:54 -0700 (PDT)
Received: by 10.141.201.19 with HTTP; Tue, 11 Mar 2008 11:06:54 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76890>

xs5-trd-p1.grn:warmstro> uname -a
SunOS xs5-trd-p1.grn.tudor.com 5.9 Generic_118558-38 sun4u sparc
SUNW,Sun-Fire-V240 Solaris


from:  bash t1300-repo-config.sh -v -i

* expecting failure:

        git config bool.nobool foobar &&
        git config --bool --get bool.nobool
fatal: bad config value for 'bool.nobool' in .git/config
*   ok 60: invalid bool (--get)

* expecting failure:

        git config --bool bool.nobool foobar
t1300-repo-config.sh: line -186:   319 Segmentation Fault      (core
dumped) git config --bool bool.nobool foobar
* FAIL 61: invalid bool (set)


                git config --bool bool.nobool foobar
xs5-trd-p1.grn:warmstro>


and the core file:

xs5-trd-p1.grn:warmstro> pwd
/home/warmstro/download/solaris/git-1.5.4.4/t/trash
xs5-trd-p1.grn:warmstro> dbx ../../git core
For information about new features see `help changes'
To remove this message, put `dbxenv suppress_startup_message 7.4' in your .dbxrc
Reading git
core file header read successfully
Reading ld.so.1
Reading libcurl.so.3.0.0
Reading libz.so.1
Reading libsocket.so.1
Reading libnsl.so.1
Reading libc.so.1
Reading libdl.so.1
Reading libmp.so.2
Reading libc_psr.so.1
program terminated by signal SEGV (no mapping at the fault address)
0xfefb46a4: strlen+0x0080:      ld       [%o1], %o2
Current function is report
   11           vsnprintf(msg, sizeof(msg), err, params);
(dbx) where
  [1] strlen(0x0, 0x0, 0xffbfed90, 0x7efefeff, 0x81010100, 0xff00), at
0xfefb46a4
  [2] _doprnt(0x279b08, 0x0, 0x0, 0x0, 0x0, 0x0), at 0xff0078e8
  [3] vsnprintf(0xffbfee00, 0x100, 0x279b08, 0xffbff010, 0x66,
0xff02862c), at 0xff009958
=>[4] report(prefix = 0x2799ac "fatal: ", err = 0x279b08 "bad config
value for '%s' in %s", params = 0xffbff010), line 11 in "usage.c"
  [5] die_builtin(err = 0x279b08 "bad config value for '%s' in %s",
params = 0xffbff010), line 23 in "usage.c"
  [6] die(err = 0x279b08 "bad config value for '%s' in %s", ...), line
75 in "usage.c"
  [7] git_config_int(name = 0xffbff57e "bool.nobool", value =
0xffbff58a "foobar"), line 287 in "config.c"
  [8] git_config_bool(name = 0xffbff57e "bool.nobool", value =
0xffbff58a "foobar"), line 309 in "config.c"
  [9] normalize_value(key = 0xffbff57e "bool.nobool", value =
0xffbff58a "foobar"), line 158 in "builtin-config.c"
  [10] cmd_config(argc = 3, argv = 0xffbff3dc, prefix = (nil)), line
366 in "builtin-config.c"
  [11] run_command(p = 0x292380, argc = 4, argv = 0xffbff3d8), line
259 in "git.c"
  [12] handle_internal_command(argc = 4, argv = 0xffbff3d8), line 385 in "git.c"
  [13] main(argc = 4, argv = 0xffbff3d8), line 449 in "git.c"
(dbx)
(dbx) list
   11           vsnprintf(msg, sizeof(msg), err, params);
   12           fprintf(stderr, "%s%s\n", prefix, msg);
   13   }
   14
   15   static NORETURN void usage_builtin(const char *err)
   16   {
   17           fprintf(stderr, "usage: %s\n", err);
   18           exit(129);
   19   }
   20
(dbx)
