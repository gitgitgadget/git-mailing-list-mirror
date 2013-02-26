From: "jones.noamle" <lenoam@gmail.com>
Subject: gc does not clean up after itself when not enough disk space
Date: Tue, 26 Feb 2013 10:38:43 -0500
Message-ID: <512CD703.4080302@gmail.com>
References: <512CD689.4050705@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 26 16:39:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UAMca-0002oW-JB
	for gcvg-git-2@plane.gmane.org; Tue, 26 Feb 2013 16:39:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759601Ab3BZPir (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2013 10:38:47 -0500
Received: from mail-gg0-f169.google.com ([209.85.161.169]:33486 "EHLO
	mail-gg0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759546Ab3BZPir (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2013 10:38:47 -0500
Received: by mail-gg0-f169.google.com with SMTP id j5so692862ggn.28
        for <git@vger.kernel.org>; Tue, 26 Feb 2013 07:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=ip3CPUnqipGtmP/YFlSv6s1wy9nYSNubNP8yjr3W1B0=;
        b=lzsI6ITv/LNV9ICn24m4xPF/xmWUNPFFE8Qk5Cr0GZ/G3C8aDanJhJFQvbKFBFLoIb
         0rNgX7BrATjqUzHv7HUlslrWBrZDzJTtCGxZVdTGcfWuQVfNy07inpDnDTqz4f0BoHnM
         GPgF7qZGKBASfrmW/PxxBqO+HeLg3Fp6SIxT4n9JKvtDm0O/DhxYe8VYQM4iqpxaF/3i
         QbGjqT/AZxjLd/mKfEqp6DCu8/q26tRKPvBW4739eU3wgPQydmwUOZDLpCEg7s/81hFQ
         njRLktiuEGnVP+D6j0se/CwDJFg+8hIB91iCA/YjMLXbssO5lSaLkspoJvJ4VtsAeo+7
         6aMQ==
X-Received: by 10.236.82.65 with SMTP id n41mr23800626yhe.66.1361893126403;
        Tue, 26 Feb 2013 07:38:46 -0800 (PST)
Received: from [127.0.0.1] (static-71-183-108-28.nycmny.fios.verizon.net. [71.183.108.28])
        by mx.google.com with ESMTPS id e21sm1048480ani.0.2013.02.26.07.38.44
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 26 Feb 2013 07:38:45 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130215 Thunderbird/17.0.3
In-Reply-To: <512CD689.4050705@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217137>

When git gc fails on no more disk space, it leaves tmp_pack files lying 
around that consume whatever space was available (and fill up the disk 
to 100%). Shouldn't git be deleting these files?

Running git 1.7.9 on cygwin:
# git --version
git version 1.7.9
# uname -a
CYGWIN_NT-6.1-WOW64 ---- 1.7.17(0.262/5/3) 2012-10-19 14:39 i686 Cygwin


Example failure output:

# git gc
Counting objects: 44626, done.
Delta compression using up to 8 threads.
Compressing objects: 100% (7756/7756), done.
fatal: sha1 file '.git/objects/pack/tmp_pack_uJ0E5b' write error: No 
space left on device
error: failed to run repack


Thanks!
Noam
