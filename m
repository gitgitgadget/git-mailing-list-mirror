From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGit PATCH 2/2] Write to a stack log when stack is modified
Date: Wed, 20 Feb 2008 22:46:48 +0000
Message-ID: <b0943d9e0802201446g2840c3d9v576f840936253525@mail.gmail.com>
References: <20080214012119.22365.54526.stgit@yoghurt>
	 <20080214012912.22365.83207.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Wed Feb 20 23:47:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRxin-0001nR-Kn
	for gcvg-git-2@gmane.org; Wed, 20 Feb 2008 23:47:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753089AbYBTWqv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Feb 2008 17:46:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753312AbYBTWqv
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Feb 2008 17:46:51 -0500
Received: from py-out-1112.google.com ([64.233.166.181]:13397 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752923AbYBTWqu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Feb 2008 17:46:50 -0500
Received: by py-out-1112.google.com with SMTP id u52so3401015pyb.10
        for <git@vger.kernel.org>; Wed, 20 Feb 2008 14:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=8U3QfKWc5Fj//Y2aXM1/gkXg1VF6D9IqCntE8lhKhJ0=;
        b=BL+NdbmvuemTnh9ICYyJ7+5ok1M9VwD2BbwshPE35CpETaf97OaUkK7Yoy9dcpBdKEBbKZVnyUlo1RsT7ZtfRRQeXPINX48Rebe1N2/DRUvoZhaWGAizOMnOpTRkvdAvY/E2siHP6ymPU/XVSiZXMDcwpRc3OaBrJQSCqt5kVI8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GN1toGpIyFKC2Kr2ARrNZH7OmiboG1i2w0ZDRozJL8p4UCPnf/sgcYWou8TdQZNKUHvXfgQe8xpA2dzD1S+0Bze3cGbi/PHaHhZapLjzOjPHtNH2JDzivpy6UdlpIclSZViBSI+SUuE1kfiE9rldnEPhaG3VZzb60xFwop1oX7I=
Received: by 10.140.174.11 with SMTP id w11mr1380255rve.273.1203547609018;
        Wed, 20 Feb 2008 14:46:49 -0800 (PST)
Received: by 10.140.193.5 with HTTP; Wed, 20 Feb 2008 14:46:48 -0800 (PST)
In-Reply-To: <20080214012912.22365.83207.stgit@yoghurt>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74560>

On 14/02/2008, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> Create a log branch (called <branchname>.stgit) for each StGit branch=
,
>  and write to it whenever the stack is modified.

The abstractions are really nice (and I still wonder how StGIT
codebase increased that much when all I needed two years ago was a
simple script-like application to reorder commits :-)).

Anyway, I don't really like the idea of an additional commit (I don't
even like the old patch log implementation) when the stack is
modified. It needs some profiling but it has a visible impact on
stacks with a big number of patches (my last kernel release at
www.linux-arm.org/git had 80 patches and it takes a lot of time to
push them).

Can we not use some of the automatic reflog recording that GIT does
instead of writing a commit? It's cheaper to write a text file than
generating a commit. In my kernel repository I have several branches
with many patches and, even after "git gc" and repacking, it is still
slow (mainly because of git-read-tree but I'd like to reduce the
number of calls to GIT).

--=20
Catalin
