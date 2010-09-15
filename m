From: Kevin Ballard <kevin@sb.org>
Subject: Re: ls-files --exclude broken?
Date: Wed, 15 Sep 2010 16:21:20 -0700
Message-ID: <02BCF40A-6E66-4E19-9235-5EB271F3D685@sb.org>
References: <AANLkTimuTHvA+qjqpmz=VkCpTTiRA7imb5+ZyTVmPwYy@mail.gmail.com> <7v62y661pl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Jay Soffian <jaysoffian@gmail.com>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 16 01:21:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ow1IC-0001lb-5n
	for gcvg-git-2@lo.gmane.org; Thu, 16 Sep 2010 01:21:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753715Ab0IOXV2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Sep 2010 19:21:28 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:57005 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753600Ab0IOXV1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Sep 2010 19:21:27 -0400
Received: by pvg2 with SMTP id 2so207070pvg.19
        for <git@vger.kernel.org>; Wed, 15 Sep 2010 16:21:27 -0700 (PDT)
Received: by 10.142.152.12 with SMTP id z12mr2080947wfd.94.1284592886989;
        Wed, 15 Sep 2010 16:21:26 -0700 (PDT)
Received: from [10.8.0.89] ([69.170.160.74])
        by mx.google.com with ESMTPS id t11sm2248662wfc.22.2010.09.15.16.21.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 15 Sep 2010 16:21:26 -0700 (PDT)
In-Reply-To: <7v62y661pl.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156273>

On Sep 15, 2010, at 4:12 PM, Junio C Hamano wrote:

> Jay Soffian <jaysoffian@gmail.com> writes:
> 
>> Am I missing something really obvious here?
>> 
>> kore:~/Repos/git (master)$ git ls-files | wc -l
>>    2009
> 
> You asked it to show the cached paths (default).  Your project currently
> tracks 2009 paths in the index.
> 
>> kore:~/Repos/git (master)$ git ls-files -x \* | wc -l
>>    2009
> 
> You told that '*' is the exclude pattern for carrying out some operation,
> but you didn't tell what operation you want.  You are shown the cached
> paths (default).
> 
>> kore:~/Repos/git (master)$ git ls-files -i -x \* | wc -l
>>    2009
> 
> You told that '*' is the exclude pattern, you want only paths that match
> the exclude pattern, and chose to show files in the index (which again is
> the default) by not saying -o.
> 
> I've never found -i useful myself (actually I don't find many options the
> command has very useful anymore), but the above is how I read the ls-files
> manual page.

My impression is that -x is pretty much only useful when you're using the -o flag, as anything that's already tracked isn't supposed to be affected by exclude patterns. The argument can be made that ls-files should indeed apply the exclude pattern to other requested display modes, and in fact a reading of the -i switch seems to imply that it should. Running `git ls-files -x '*.m' -c -i` displays all files ending in .m in the index. It would seem logical that the similar `git ls-files -x '*.m' -c` should display all files that don't end in .m in the index, but it doesn't appear to apply the exclude pattern in this case. As for -i being useful, I've never actually used it myself (though obviously it can be used as a way to grep through the index via the exclude pattern), but I can imagine a 
 scenario where I want to clean up all untracked files and end up running something like `git ls-files -z -o -i --exclude-standard | xargs -0 rm`.

-Kevin Ballard