From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: can we prevent reflog deletion when branch is deleted?
Date: Sat, 01 Jun 2013 05:00:07 +0200
Message-ID: <51A963B7.6060002@alum.mit.edu>
References: <CAMK1S_jY1tDCkyOamX8XNW9g8Dzf6yN9znwN6he-EVcOkBM1fQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Elijah Newren <newren@gmail.com>
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 01 05:00:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uic3F-0007Bx-LG
	for gcvg-git-2@plane.gmane.org; Sat, 01 Jun 2013 05:00:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755013Ab3FADAO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 May 2013 23:00:14 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:56896 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752695Ab3FADAM (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 31 May 2013 23:00:12 -0400
X-AuditID: 12074413-b7f226d000000902-d4-51a963ba9559
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id B5.9A.02306.AB369A15; Fri, 31 May 2013 23:00:11 -0400 (EDT)
Received: from [192.168.69.140] (p57A24466.dip0.t-ipconnect.de [87.162.68.102])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r51308t7006118
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 31 May 2013 23:00:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130510 Thunderbird/17.0.6
In-Reply-To: <CAMK1S_jY1tDCkyOamX8XNW9g8Dzf6yN9znwN6he-EVcOkBM1fQ@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMKsWRmVeSWpSXmKPExsUixO6iqLs7eWWgweU8i64r3UwW81q+MFus
	fnyH3YHZY+esu+wenzfJBTBFcdskJZaUBWem5+nbJXBnvPywhaVgLWfFttYu1gbGY+xdjBwc
	EgImEp/2qnQxcgKZYhIX7q1n62Lk4hASuMwo0fNkLTOEc55JYunmcywgVbwC2hIft/YzgzSz
	CKhKPLutBxJmE9CVWNTTzARiiwqESbxfNpUVolxQ4uTMJywg5SICmhLvLyWDhJkFfCQ+79gM
	Vi4s4CzxvW8tG4gtJBAgcXrfJrBNnAKBElN/rwQ7k1lAXWL9PCGIVnmJ7W/nME9gFJiFZMEs
	hKpZSKoWMDKvYpRLzCnN1c1NzMwpTk3WLU5OzMtLLdI118vNLNFLTSndxAgJVOEdjLtOyh1i
	FOBgVOLhNVixIlCINbGsuDL3EKMkB5OSKO/O6JWBQnxJ+SmVGYnFGfFFpTmpxYcYJTiYlUR4
	8+cAlfOmJFZWpRblw6SkOViUxHnVlqj7CQmkJ5akZqemFqQWwWRlODiUJHgnJwENFSxKTU+t
	SMvMKUFIM3FwggznkhIpTs1LSS1KLC3JiAdFaHwxMEZBUjxAe2tB2nmLCxJzgaIQracYdTlm
	/Jj8jlGIJS8/L1VKnLcVpEgApCijNA9uBSwtvWIUB/pYmLcSpIoHmNLgJr0CWsIEtOSJ9XKQ
	JSWJCCmpBsY0g26h9LSL7x+cPD7BMm/h/1N39NN+FB7j7uZnfKyinLm6wMZq1ZM3zmue3Ntl
	WvZ5k7cY48a3nMF32nTU7x5hf+u8e+atfV9DZVWv3f7wpvv9/AThVZ/bZtXPWDqx 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226101>

On 06/01/2013 03:31 AM, Sitaram Chamarty wrote:
> Is there a way to prevent reflog deletion when the branch is deleted?
> The last entry could simply be a line where the second SHA is all 0's.

This is a known problem.  The technical reason that this is not trivial
to solve is the possibility of a directory/file conflict between old
reflog files and references that might be created subsequently (which in
turn is a limitation of how loose references and reflogs are mapped to
filenames):

    git branch foo
    git branch -d foo
    git branch foo/bar

Under your proposal, the second line would retain the reflog file for
foo, which is named ".git/logs/refs/heads/foo".  But the third line
wants to create a file ".git/logs/refs/heads/foo/bar".  The existence of
the "foo" file prevents the creation of a "foo" directory.

A similar problem exists if "foo" and "foo/bar" are exchanged in the
above example.

Peff proposed a solution to this problem [1], but AFAIK it is not making
progress.

Michael

[1]
http://thread.gmane.org/gmane.comp.version-control.git/201715/focus=201752

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
