From: Andreas Ericsson <ae@op5.se>
Subject: Re: Git and Very Large Codebases
Date: Tue, 20 Apr 2010 11:43:19 +0200
Message-ID: <4BCD7737.1010709@op5.se>
References: <s2x4ef15ddc1004200158s2fc6391byfab91784036ac018@mail.gmail.com> <h2w4ef15ddc1004200200ocd9df12azf62da7419355ae7c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Brian Herman <brianherman@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 20 11:43:32 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O49zP-0005Yo-MY
	for gcvg-git-2@lo.gmane.org; Tue, 20 Apr 2010 11:43:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754248Ab0DTJn0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Apr 2010 05:43:26 -0400
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:37005 "HELO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754239Ab0DTJnZ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Apr 2010 05:43:25 -0400
Received: from source ([209.85.218.224]) by na3sys009aob106.postini.com ([74.125.148.12]) with SMTP
	ID DSNKS813O3xjLVhKYLu1KKEZFv+lKXpbx8aH@postini.com; Tue, 20 Apr 2010 02:43:24 PDT
Received: by bwz24 with SMTP id 24so5307542bwz.37
        for <git@vger.kernel.org>; Tue, 20 Apr 2010 02:43:23 -0700 (PDT)
Received: by 10.87.8.4 with SMTP id l4mr5466980fgi.1.1271756602775;
        Tue, 20 Apr 2010 02:43:22 -0700 (PDT)
Received: from clix.int.op5.se ([212.112.174.166])
        by mx.google.com with ESMTPS id l12sm6277131fgb.22.2010.04.20.02.43.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 20 Apr 2010 02:43:21 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.9.1.9) Gecko/20100330 Fedora/3.0.4-1.fc12 Thunderbird/3.0.4 ThunderGit/0.1a
In-Reply-To: <h2w4ef15ddc1004200200ocd9df12azf62da7419355ae7c@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145360>

On 04/20/2010 11:00 AM, Brian Herman wrote:
> Can git support codebases on the order of magnitude of Gigabytes?
> For example, a game developer might want to use git as their SCM
> software but their codebases can be in gigabytes in scale.
> If git cannot support this how would one begin to create this support?
> 

It depends more on the nature of the files than the size of the total
code. With large binary files and such, git will not perform very well.
On a code-tree of 1-30KiB source-code files it will perform
fantastically (compared to alternatives, that is; Nothing in the entire
world will handle multiple gigabytes faster than it can read it from
the disk).

I'd suggest splitting the repository in several different ones to
make git handle it well. Movies go in one repository, audio go in
another, pictures and whatnot in a third, and then you tie it all
together with a super-repo that holds the code and the build-system.

In repositories storing mainly binary files you go through the
gitattributes(5) man-page and set the necessary attributes for
the files in question. In your case, I'd suspect the .gitattributes
file would look something like this:

*.avi -diff -delta -crlf -merge
*.jpg -diff -delta -crlf -merge
*.mp3 -diff -delta -crlf -merge

This will prevent git from attempting delta-compression on the
files. It will also not try to create diffs from them, or perform
crlf-conversion or merge them. The gitattributes(5) man page has
more information regarding this.

Some trial and error with a small test-repository will help you
sort this out and understand what it means.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
