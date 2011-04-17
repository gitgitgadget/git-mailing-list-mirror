From: Chris Packham <judge.packham@gmail.com>
Subject: Re: Generating GNU-style Changelog from git commits
Date: Sun, 17 Apr 2011 12:53:33 +1200
Message-ID: <4DAA3A0D.6070904@gmail.com>
References: <BANLkTi=j_Ge9h8+r8R-a5Fppan_2dtu5LA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: David Chanters <david.chanters@googlemail.com>
X-From: git-owner@vger.kernel.org Sun Apr 17 02:52:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QBGE4-00050d-QO
	for gcvg-git-2@lo.gmane.org; Sun, 17 Apr 2011 02:52:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753257Ab1DQAwQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Apr 2011 20:52:16 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:39274 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752969Ab1DQAwP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2011 20:52:15 -0400
Received: by pvg12 with SMTP id 12so1619149pvg.19
        for <git@vger.kernel.org>; Sat, 16 Apr 2011 17:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=GI/SpZKsk2nUGvJDDXH7dAbsY2y2JEZV3amswFNFEiE=;
        b=pVemrLBsudjAKeXTnBSWMd5QHZlkOTvYcM2SwPkiwdfIxR/nhIwwQjE92aN12GlR7X
         NZJfWsE8kYIZJ9BXTgKxCCWX2Mvq9Y/vrt9VIJ0dDMDcL0taPCPv2FZKoAZLAQqBHQcv
         MZZuQpppmz5S7o08q8XSMIjR5XynQsziEB614=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=ExZVSuoJydUPq/u0PHUjjTVFjVmvLK0nx0tEiBMgSGNrJYjm6LgEraONCI1Kfyj8wD
         xmpNME9zmA3Ye2V0YnI3ECiBDYrs9h3FU0O3bATT4abdDCjkG3njnaCC7UFtVrmroBAF
         lRItUyMMfp2WnRhI0VjfaLM1RO1b0GVtDFg/Y=
Received: by 10.143.87.3 with SMTP id p3mr1863461wfl.153.1303001534135;
        Sat, 16 Apr 2011 17:52:14 -0700 (PDT)
Received: from laptop.site (115-188-15-163.jetstream.xtra.co.nz [115.188.15.163])
        by mx.google.com with ESMTPS id z10sm5612332wfj.0.2011.04.16.17.52.11
        (version=SSLv3 cipher=OTHER);
        Sat, 16 Apr 2011 17:52:13 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.9.2.14) Gecko/20110221 SUSE/3.1.8 Thunderbird/3.1.8
In-Reply-To: <BANLkTi=j_Ge9h8+r8R-a5Fppan_2dtu5LA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171706>

On 17/04/11 10:46, David Chanters wrote:
> [Please Cc me on replies.  Thanks!]
>
> Hi,
>
> Some projects maintain a ChangeLog file, which looks something like this:
>
> 2011-01-01  David Chanters<d.c@example.com>
>          * foo/bar.c (some_function):
>           Changed static variable in some_function to auto.
>
> etc., etc.
>
> Here "foo" is some directory relative to the top-level directory the
> .git one is in.
>
> These ChangeLog files are maintained manually, irrespective of the/any
> revision control system in use.  I am wondering if it's possible if
> the project is in Git to be able to automatically append to such a
> ChangeLog file with each commit automatically, and have it formatted
> in the style above.
>
> Is this possible?  Is it a solved problem?  If not, and I wanted to
> try myself, could someone point me at the git-specific tools I'd need
> to know to use to achieve it?
>
> TIA!
> DC
> --

Shouldn't be to hard, there are numerous hooks that could be used either 
on the developer end (post-commit), on the server end (post-update) or 
even when a maintainer applies a patch (post-applypatch). See 
githooks(5) for more info on what hooks are available and what args are 
passed.

There is also the possibility of generating this changelog at the time 
of release. I'd advocate this approach as it would allow you to edit the 
changelog to make it more useful to readers.

Either way the actual format could probably be generated with 'git log 
--format' (someone else may reply with better plumbing commands, but my 
initial response is use git log).

My 2 minutes worth of reading git-log(1) got me this

   git log --format="%ai%x09%an <%ae> %n%x09* %s" REVISIONS

Which for a chunk of gits pu branch gave me this (my mail client munges 
some of the longer lines)

2011-02-17 13:54:28 -0800	Junio C Hamano <gitster@pobox.com>
	* Merge branch 'js/cherry-pick-usability' into pu
2011-02-17 12:29:33 -0800	Junio C Hamano <gitster@pobox.com>
	* Merge branch 'so/submodule-no-update-first-time' into pu
2011-02-17 12:29:32 -0800	Junio C Hamano <gitster@pobox.com>
	* Merge branch 'jc/grep--no-index-pathspec-fix' into pu
2011-02-17 09:18:46 -0700	Spencer E. Olson <olsonse@umich.edu>
	* t7406: "git submodule update {--merge|--rebase]" with new submodules
2011-02-17 09:18:45 -0700	Spencer E. Olson <olsonse@umich.edu>
	* submodule: no [--merge|--rebase] when newly cloned
2011-02-16 14:39:00 -0800	Junio C Hamano <gitster@pobox.com>
	* grep --no-index: honor pathspecs correctly
2011-02-16 05:08:23 -0500	Jay Soffian <jaysoffian@gmail.com>
	* Teach commit about CHERRY_PICK_HEAD
2011-02-16 12:20:35 -0500	Jay Soffian <jaysoffian@gmail.com>
	* Introduce CHERRY_PICK_HEAD

Which is pretty close. You could experiment with more format specifiers 
to get the info you need.

Hope that helps
- Chris
