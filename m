From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: ANNOUNCE: git-imerge -- Incremental merge and rebase for git
Date: Sun, 14 Jul 2013 07:33:27 +0200
Message-ID: <51E23827.6010601@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jul 14 07:33:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyEwP-0006qO-TM
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jul 2013 07:33:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751189Ab3GNFdb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jul 2013 01:33:31 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:59822 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751212Ab3GNFda (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Jul 2013 01:33:30 -0400
X-AuditID: 1207440f-b7f786d000001f20-da-51e2382ac44a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 2C.F6.07968.A2832E15; Sun, 14 Jul 2013 01:33:30 -0400 (EDT)
Received: from [192.168.69.140] (p4FDD4B13.dip0.t-ipconnect.de [79.221.75.19])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r6E5XSHl007841
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Sun, 14 Jul 2013 01:33:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130623 Thunderbird/17.0.7
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKIsWRmVeSWpSXmKPExsUixO6iqKtl8SjQYN4sbouuK91MDowenzfJ
	BTBGcdskJZaUBWem5+nbJXBnfJp2g7XgomjF0sMr2BoYPwh2MXJySAiYSCxrOMkMYYtJXLi3
	nq2LkYtDSOAyo8SX66vZIZwXTBITjp1nBaniFdCW2PtrDhOIzSKgKjG39wRYnE1AV2JRTzNQ
	nINDVCBM4spvVYhyQYmTM5+wgNgiQCW7nl1lA7GFBVwlWlZ9A1vMLKAj8a7vAZQtL7H97Rzm
	CYy8s5C0z0JSNgtJ2QJG5lWMcok5pbm6uYmZOcWpybrFyYl5ealFuiZ6uZkleqkppZsYIcHE
	v4Oxa73MIUYBDkYlHt4L+x8GCrEmlhVX5h5ilORgUhLl3a73KFCILyk/pTIjsTgjvqg0J7X4
	EKMEB7OSCO8yZaAcb0piZVVqUT5MSpqDRUmcV32Jup+QQHpiSWp2ampBahFMVoaDQ0mC96cZ
	UKNgUWp6akVaZk4JQpqJgxNkOJeUSHFqXkpqUWJpSUY8KMLii4ExBpLiAdorbg6yt7ggMRco
	CtF6ilGX48CPLe8ZhVjy8vNSpcR5HUGKBECKMkrz4FbAUscrRnGgj4V5TUCqeIBpB27SK6Al
	TEBLbq+6D7KkJBEhJdXA2O/PEByqw/DCpmlG2oXFnSyz7MMvy906sM7xtp2xY8jOZRMdaxue
	8s98IB9n3XujK17/y+Wr1Ro3L04t5LTN3LtsWu/EuF8L7pe7Ktjxv5oSk2hkuTRnVrt5JFfG
	d0YHS0PW5Av6x+yaVM67t2d6NO0oSXdezBlv/dpfvvr0VJfYVRXzpb2UWIozEg21 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230309>

I've alluded to this little project of mine on the mailing list before,
but I've never really announced it properly.  So here we go...

git-imerge [1] is an open-source tool that helps you perform difficult
Git merges and rebases by allowing conflicts to be resolved
incrementally.  The tool breaks the full merge down into pairwise merges
of one commit from each branch.  When a pairwise merge conflicts, the
tool asks you to resolve the conflict, which is hopefully small enough
to be tractable.  Each completed pairwise merge is recorded as a step
towards completing the full merge.  When all of the pairwise merges are
done, the results can be converted into a merge or rebase as you choose.

git-imerge has two primary goals:

* Reduce the pain of resolving merge conflicts to its unavoidable
  minimum, by finding and presenting the smallest possible conflicts,
  namely those between the changes introduced by one commit from each
  branch.

* Allow a merge to be saved, tested, interrupted, published, and
  collaborated on while it is in progress.

The hope is to rescue that branch that has diverged so far from master
that merging it seems intractable and the only alternative seems to be
to abandon the branch and start again.  (I think we've all been there!)

I think that it is easiest to understand the concept of incremental
merging visually, and therefore I recommend the video of my git-imerge
presentation [2] from the GitMerge 2013 conference (20 min) as a good
introduction.  The full slides for that talk are available in the
git-imerge repository under doc/presentations/GitMerge-2013.  At the
same conference, I was interviewed about git-imerge by Thomas Ferris
Nicolaisen for his GitMinutes Podcast #12 [3].

To learn how to use the git-imerge tool itself, I suggest the blog
article "git-imerge: A Practical Introduction" [4] and also the help
built unto the command ("git-imerge --help" and "git-imerge SUBCOMMAND
--help").  If you want more information, the theory and benefits of
incremental merging are described in minute detail in a series of blog
articles [5].

git-imerge is still experimental, due to a lack of time to work on it.
But it is already (cautiously) usable, and I am very excited about the
idea and would love to get feedback and help from the community.

Michael

[1] https://github.com/mhagger/git-imerge
[2] http://www.youtube.com/watch?v=FMZ2_-Ny_zc
[3]
http://episodes.gitminutes.com/2013/06/gitminutes-12-git-merge-2013-part-4.html
[4]
http://softwareswirl.blogspot.com/2013/05/git-imerge-practical-introduction.html
[5] http://softwareswirl.blogspot.com/search/label/git-imerge

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
