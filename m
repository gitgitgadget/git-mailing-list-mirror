From: Jonathan Lambrechts <jonathanlambrechts@gmail.com>
Subject: git svn fetch segfault on exit
Date: Thu, 18 Jul 2013 11:21:06 +0200
Message-ID: <51E7B382.8050302@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 18 11:19:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzkN9-00010C-AA
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jul 2013 11:19:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757458Ab3GRJTe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jul 2013 05:19:34 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:63324 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752935Ab3GRJTc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jul 2013 05:19:32 -0400
Received: by mail-wg0-f44.google.com with SMTP id m15so2650457wgh.23
        for <git@vger.kernel.org>; Thu, 18 Jul 2013 02:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=5/PpFMo/euDN4Os8UyqzwyV9x+2Nprw4BCr/NlA4BEg=;
        b=FkDWW/VScn8wDB/e0+45ZSvxsXBoR1EaIrSMSYQeKvpk/3EpxJkzHA6VKIG8Yt6uK1
         y+UDa7TAdYCEql/uvwkhotaAUfBK8+DnWkHvmDc5eFmrV4XVXH84cuW97z6J483p9Zvp
         0NN2gqWQE9anjBNk1CE7TOEVw5C36TTndewhaexRBuwDNsBSk53QMiarx0LbTuUhZw94
         LTF8Mwe7+Jxy3P8ooRE7KQ9WW7EWWRgfricyJBUNsGUVfZ9D0t4/HAjxzvdSuNyAtZ9o
         LMXVQ5dLNBGkE0yPacnc6lj3boQKdrbL10EmhdNcLT1o1m7dRda/yg5U3pTBhPhSr8iF
         k5XA==
X-Received: by 10.194.249.195 with SMTP id yw3mr7180077wjc.65.1374139170816;
        Thu, 18 Jul 2013 02:19:30 -0700 (PDT)
Received: from [130.104.237.90] ([130.104.237.90])
        by mx.google.com with ESMTPSA id h8sm15142374wie.1.2013.07.18.02.19.29
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 18 Jul 2013 02:19:30 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230682>

Hi,
I'm using archlinux with git version 1.8.3.3, svn version 1.8.0 
(r1490375) and perl v5.18.0 (built for x86_64-linux-thread-multi)

Every git svn call that involves a fetch produces a segmentation fault 
on exit (but the operation succeeds).

*** Error in `/usr/bin/perl': double free or corruption (!prev): 
0x0000000002ce1ac0 ***
======= Backtrace: =========
/usr/lib/libc.so.6(+0x788ae)[0x7fd4d83798ae]
/usr/lib/libc.so.6(+0x79587)[0x7fd4d837a587]
/usr/lib/libapr-1.so.0(apr_allocator_destroy+0x1d)[0x7fd4d568e9ad]
/usr/lib/libapr-1.so.0(apr_pool_terminate+0x30)[0x7fd4d568f590]
/usr/lib/perl5/vendor_perl/auto/SVN/_Core/_Core.so(_wrap_apr_terminate+0x50)[0x7fd4d6886920]
/usr/lib/perl5/core_perl/CORE/libperl.so(Perl_pp_entersub+0x571)[0x7fd4d876f821]
/usr/lib/perl5/core_perl/CORE/libperl.so(Perl_runops_standard+0x16)[0x7fd4d8767e26]
/usr/lib/perl5/core_perl/CORE/libperl.so(Perl_call_sv+0x3b0)[0x7fd4d86f93b0]
/usr/lib/perl5/core_perl/CORE/libperl.so(Perl_call_list+0x2c7)[0x7fd4d86fb477]
/usr/lib/perl5/core_perl/CORE/libperl.so(perl_destruct+0x1321)[0x7fd4d86fca91]
/usr/bin/perl(main+0x111)[0x400e01]
/usr/lib/libc.so.6(__libc_start_main+0xf5)[0x7fd4d8322a15]
/usr/bin/perl[0x400e71]

This bug has already been reported by others on subversion mailing list 
and and archlinux bbs:
https://bugs.archlinux.org/task/36070
http://permalink.gmane.org/gmane.comp.version-control.subversion.user/114019

I tried to fix it but the problem is that I know absolutely nothing of 
perl. Anyway, I noticed that with the modifications bellow (in 
Git::SVN::Ra::new) the crash does not occur (I do not think it's a real 
fix though).

--- /usr/share/perl5/vendor_perl/Git/SVN/Ra.pm.orig    2013-07-18 
11:15:23.584625508 +0200
+++ /usr/share/perl5/vendor_perl/Git/SVN/Ra.pm    2013-07-18 
11:16:14.624622422 +0200
@@ -79,7 +79,6 @@
      SVN::_Core::svn_config_ensure($config_dir, undef);
      my ($baton, $callbacks) = 
SVN::Core::auth_open_helper(_auth_providers);
      my $config = SVN::Core::config_get_config($config_dir);
-    $RA = undef;
      my $dont_store_passwords = 1;
      my $conf_t = ${$config}{'config'};
      {
@@ -108,7 +107,7 @@
                            config => $config,
                    pool => SVN::Pool->new,
                            auth_provider_callbacks => $callbacks);
-    $RA = bless $self, $class;
+    $self = bless $self, $class;

      # Make sure its canonicalized
      $self->url($url);
@@ -118,7 +117,7 @@
      $self->{cache} = { check_path => { r => 0, data => {} },
                         get_dir => { r => 0, data => {} } };

-    return $RA;
+    return $self;
  }

  sub url {


Jonathan
