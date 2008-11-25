From: "Ondrej Certik" <ondrej@certik.cz>
Subject: git fast-export | git fast-import doesn't work
Date: Tue, 25 Nov 2008 17:44:28 +0100
Message-ID: <85b5c3130811250844u498fbb97m9d1aef6e1397b8c7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Fabian Seoane" <fabian@fseoane.net>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 25 17:47:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L513z-0006OF-GT
	for gcvg-git-2@gmane.org; Tue, 25 Nov 2008 17:46:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752110AbYKYQpg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Nov 2008 11:45:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751904AbYKYQpf
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Nov 2008 11:45:35 -0500
Received: from mail-gx0-f11.google.com ([209.85.217.11]:62308 "EHLO
	mail-gx0-f11.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751741AbYKYQpf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Nov 2008 11:45:35 -0500
Received: by gxk4 with SMTP id 4so31809gxk.13
        for <git@vger.kernel.org>; Tue, 25 Nov 2008 08:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:mime-version:content-type:content-transfer-encoding
         :content-disposition:x-google-sender-auth;
        bh=JyFvvcBDEqmwE1cy9KwSN7qieML64ot9Fj6wmZkEDd4=;
        b=cps15RkaMIWZzF5E6dcM8yLj1rTHTbGhCyrZWaRswsTO6SThhCsE50I2YiigXgINvG
         0eGWWUyww0tZ5vIlyLUASr+3ViEGFZFgOna1GutXXQ+QaSYp/saDRqWphupAmfN6MG2M
         JvPrkrFIsTwY7eRHwm7S5P9PB/sHDMaRujAAM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:mime-version:content-type
         :content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=cuhkeGfXdHuEZ9xLjs2A9FXGCs1fzrB3CznmhKzVwfQVQlF+kcWitBC+80Xc4PqJTy
         Cse5wQU9Pjj6c/5V63Jzpx6CepZ1ze7vOdhr4mxfBR6kO2XcNlxZms32gR+gQuYl2mcD
         sBWM7ICqwZwIIsTbAJVIVsqQJIkdZS/1ViRV4=
Received: by 10.86.94.11 with SMTP id r11mr3094867fgb.11.1227631468517;
        Tue, 25 Nov 2008 08:44:28 -0800 (PST)
Received: by 10.86.33.8 with HTTP; Tue, 25 Nov 2008 08:44:28 -0800 (PST)
Content-Disposition: inline
X-Google-Sender-Auth: b61a9e63ad731e83
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101669>

Hi,

I would like to export our whole git repository to patches, and then
reconstruct it again from scratch. Following the man page of "git
fast-export":

$ git clone git://git.sympy.org/sympy-full-history-20081023.git
$ cd sympy-full-history-20081023
$ git fast-export --all --export-marks=marks > patches
$ cd ..
$ mkdir sympy-new
$ cd sympy-new
$ git init
$ git fast-import --export-marks=marks < ../sympy-full-history-20081023/patches
git-fast-import statistics:
---------------------------------------------------------------------
Alloc'd objects:      25000
Total objects:        21355 (       144 duplicates                  )
      blobs  :         8009 (         0 duplicates       4529 deltas)
      trees  :        10627 (       144 duplicates       9189 deltas)
      commits:         2719 (         0 duplicates          0 deltas)
      tags   :            0 (         0 duplicates          0 deltas)
Total branches:          21 (        26 loads     )
      marks:        1048576 (     10728 unique    )
      atoms:            726
Memory total:          2880 KiB
       pools:          2098 KiB
     objects:           781 KiB
---------------------------------------------------------------------
pack_report: getpagesize()            =       4096
pack_report: core.packedGitWindowSize =   33554432
pack_report: core.packedGitLimit      =  268435456
pack_report: pack_used_ctr            =      40706
pack_report: pack_mmap_calls          =       2791
pack_report: pack_open_windows        =          1 /          2
pack_report: pack_mapped              =   26177739 /   35513414
---------------------------------------------------------------------



However, the repository is very different to the original one. It
contains only 191 patches:

$ git log --pretty=oneline | wc -l
191

and it only contains couple files. Compare this with the original repository:

$ git log --pretty=oneline | wc -l
2719

What am I doing wrong? Is there some other way to do it? I also tried
"git format-patch" and "git am" and that almost works, only it changes
hashes. Is there some way to tell "git am" to preserve the hash?

Thanks,
Ondrej
