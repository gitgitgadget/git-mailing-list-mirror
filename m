From: Andreas Leha <andreas.leha@med.uni-goettingen.de>
Subject: Re: make git ignore the timestamp embedded in PDFs
Date: Sat, 18 May 2013 09:42:34 +0200
Message-ID: <87ppwohgyd.fsf@med.uni-goettingen.de>
References: <87y5bhn1iw.fsf@med.uni-goettingen.de> <51928FE8.2050804@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 18 09:43:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Udbn8-0005Ep-8s
	for gcvg-git-2@plane.gmane.org; Sat, 18 May 2013 09:42:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751538Ab3ERHmy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 May 2013 03:42:54 -0400
Received: from plane.gmane.org ([80.91.229.3]:53516 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751162Ab3ERHmx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 May 2013 03:42:53 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Udbmz-00054Y-FT
	for git@vger.kernel.org; Sat, 18 May 2013 09:42:49 +0200
Received: from vpn-2052.gwdg.de ([134.76.2.52])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 18 May 2013 09:42:49 +0200
Received: from andreas.leha by vpn-2052.gwdg.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 18 May 2013 09:42:49 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: vpn-2052.gwdg.de
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Cancel-Lock: sha1:hWccqSw+aiJSNT8Exo7BlQxxMes=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224772>

Hi Hannes,

thanks for taking this up and sorry for the long delay in my answer.

Johannes Sixt <j6t@kdbg.org> writes:

> Am 14.05.2013 15:17, schrieb Andreas Leha:
>> Hi all,
>> 
>> how can I make git ignore the time stamp(s) in a PDF.  Two PDFs that
>> differ only in these time stamps should be considered identical.
>> ...
>> What I tried is a filter:
>> ,----[ ~/.gitconfig ]
>> | [filter "pdfresetdate"]
>> |         clean = pdfresetdate
>> `----
>> 
>> This 'works' as far as the committed pdf indeed has the date reset to my
>> default value.
>> 
>> However, when I re-checkout the files, they are marked modified by git.
>
> I'm using cleaned files every now and then, but not on Linux. I have
> never observed this behavior recently.
>
> If you 'git add' the file, does it keep its modified state? Does 'git

yes.

> diff' tell a difference?

no.

Here is a complete 'session':
,----
| > mkdir test
| > cd test
| > git init
| > echo '*.pdf filter=pdfresetdate' > .gitattributes
| > cp ~/PDF/score_table.pdf .
| > pdfinfo score_table.pdf
| Title:          (score_table)
| Author:         (andreas)
| Creator:        GPL Ghostscript 905 (ps2write)
| Producer:       GPL Ghostscript 9.05
| CreationDate:   Fri Feb  8 15:44:47 2013
| ModDate:        Fri Feb  8 15:44:47 2013
| Tagged:         no
| Pages:          1
| Encrypted:      no
| Page size:      595 x 842 pts (A4)
| File size:      36989 bytes
| Optimized:      no
| PDF version:    1.4
| > git add score_table.pdf
| > pdfinfo score_table.pdf
| Title:          (score_table)
| Author:         (andreas)
| Creator:        GPL Ghostscript 905 (ps2write)
| Producer:       GPL Ghostscript 9.05
| CreationDate:   Fri Feb  8 15:44:47 2013
| ModDate:        Fri Feb  8 15:44:47 2013
| Tagged:         no
| Pages:          1
| Encrypted:      no
| Page size:      595 x 842 pts (A4)
| File size:      36989 bytes
| Optimized:      no
| PDF version:    1.4
| > git commit -m "test"
| > pdfinfo score_table.pdf
| Title:          (score_table)
| Author:         (andreas)
| Creator:        GPL Ghostscript 905 (ps2write)
| Producer:       GPL Ghostscript 9.05
| CreationDate:   Fri Feb  8 15:44:47 2013
| ModDate:        Fri Feb  8 15:44:47 2013
| Tagged:         no
| Pages:          1
| Encrypted:      no
| Page size:      595 x 842 pts (A4)
| File size:      36989 bytes
| Optimized:      no
| PDF version:    1.4
| > rm score_table.pdf
| > git checkout  score_table.pdf  
| > git status
| # On branch master
| # Changes not staged for commit:
| #   (use "git add <file>..." to update what will be committed)
| #   (use "git checkout -- <file>..." to discard changes in working directory)
| #
| #       modified:   score_table.pdf
| #
| # Untracked files:
| #   (use "git add <file>..." to include in what will be committed)
| #
| #       .gitattributes
| no changes added to commit (use "git add" and/or "git commit -a")
| > pdfinfo score_table.pdf 
| Title:          (score_table)
| Author:         (andreas)
| Creator:        GPL Ghostscript 905 (ps2write)
| Producer:       GPL Ghostscript 9.05
| CreationDate:   Mon Jan  1 07:26:19 1979
| ModDate:        Mon Jan  1 07:26:19 1979
| Tagged:         no
| Pages:          1
| Encrypted:      no
| Page size:      595 x 842 pts (A4)
| File size:      37126 bytes
| Optimized:      no
| PDF version:    1.4
| > git add score_table.pdf
| > git status
| # On branch master
| # Changes to be committed:
| #   (use "git reset HEAD <file>..." to unstage)
| #
| #       modified:   score_table.pdf
| #
| # Untracked files:
| #   (use "git add <file>..." to include in what will be committed)
| #
| #       .gitattributes
| > git diff score_table.pdf
| > 
`----

Regards,
Andreas
