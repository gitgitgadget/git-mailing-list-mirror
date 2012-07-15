From: Steven Michalske <smichalske@gmail.com>
Subject: Re: bzr->git: keep empty directories
Date: Sat, 14 Jul 2012 21:01:38 -0700
Message-ID: <2059FC03-7308-4BAD-B90A-451F71791187@gmail.com>
References: <87sjcuz9q7.fsf@bitburger.home.felix> <CAJDDKr5V++TtS24D=SsaPnkx==Zo8=fpvg2RNod9+-JGxWfhGQ@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Felix Natter <fnatter@gmx.net>, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 15 06:02:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SqG2K-0004W8-1f
	for gcvg-git-2@plane.gmane.org; Sun, 15 Jul 2012 06:02:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750753Ab2GOEBm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jul 2012 00:01:42 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:41603 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750703Ab2GOEBk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Jul 2012 00:01:40 -0400
Received: by pbbrp8 with SMTP id rp8so7984988pbb.19
        for <git@vger.kernel.org>; Sat, 14 Jul 2012 21:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        bh=+bBco+I2FnG0sfz8lceYpwDPtd6+eS0901H6z6Pow4w=;
        b=yYJxDNyPpriLESKXECYHaEsyIsfQc6Le1BQCHWOudctK51ZO8FJQZW+Y6RGvHAuHO5
         jiE8yxkWs89HqMdLfhepoMjbilsutDcumXVs4qd3mSJDNA+5Q5NGI67091+Qr2rUFVRp
         Vraucf/V79W/dvaW1PJdkMifSqjZsu32NGIPKZD91d2BtIf7jSLP/2Cs5E+kP3s7vXct
         qXZ6VSAkiGNK3EMr7N0a1gVP/BE/D6vRWZrRVKqI2AS8sZ1FyxX9t5+AfmoZI0cQgnYY
         yNJaVwKL2MkBBcGP+BVDauTIk9LBF8WVn86qVAt1h4SSpbmjHIMp8BZYeDCpIl1yQ1Lx
         5/fw==
Received: by 10.68.239.5 with SMTP id vo5mr16099225pbc.125.1342324899764;
        Sat, 14 Jul 2012 21:01:39 -0700 (PDT)
Received: from [192.168.1.125] (c-67-161-24-30.hsd1.ca.comcast.net. [67.161.24.30])
        by mx.google.com with ESMTPS id qx9sm1390480pbc.8.2012.07.14.21.01.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 14 Jul 2012 21:01:38 -0700 (PDT)
In-Reply-To: <CAJDDKr5V++TtS24D=SsaPnkx==Zo8=fpvg2RNod9+-JGxWfhGQ@mail.gmail.com>
X-Mailer: Apple Mail (2.1278)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201464>

Perhaps having a file named something like:

.git_foreign_scm_empty_dir  or some shorter name.

With the contents of the fast importer empty directory info put in there; If any book keeping is needed.

It also looks like you strip out meta-data.
perhaps a file like:

.git_foreign_scm_metadata

We could use the .git/config file format for storing the bookkeeping data.

Steve

On Jul 14, 2012, at 3:46 PM, David Aguilar wrote:

> On Sat, Jul 14, 2012 at 7:41 AM, Felix Natter <fnatter@gmx.net> wrote:
>> hello,
>> 
>> when converting a repo from bzr to git:
>> 
>> mkdir freeplane-git1
>> cd freeplane-git1
>> git init .
>> bzr fast-export --plain --export-marks=../marks.bzr ../trunk/ | git fast-import --export-marks=../marks.git
>> git checkout
>> 
>> Empty directories are not contained in the git working index. This is
>> because of the --plain option, which "Excludes metadata to maximise
>> interoperability" and thus does not support empty directories
>> (http://doc.bazaar.canonical.com/plugins/en/fastimport-plugin.html).
>> 
>> However, when I use "--no-plain" (which according to above documentation
>> exports empty directories), git cannot handle it:
>> 
>> $ ./freeplane2git.sh
>> Initialized empty Git repository in /home/felix/git/freeplane-git1/.git/
>> 15:56:09 Calculating the revisions to include ...
>> 15:56:09 Starting export of 4290 revisions ...
>> fatal: This version of fast-import does not support feature commit-properties.
>> fast-import: dumping crash report to .git/fast_import_crash_3915
>> bzr: broken pipe
>> 
>> I already tried to hack bzr-fastimport's exporter.py so that it does not
>> emit commit properties but emits empty directories but i was not
>> successful.
>> 
>> So is there another way to preserve empty directories or shall I report
>> a bug on bzr fast-export?
>> 
>> Many thanks in advance!
> 
> I would suggest hacking it to optionally not emit commit properties as step one.
> 
> A later enhancement would be to optionally create directories with
> empty .gitignore files, or something similar. git really doesn't care
> about empty directories.
> -- 
> David
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
