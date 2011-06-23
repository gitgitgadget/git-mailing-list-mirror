From: =?ISO-8859-1?Q?Andreas_K=F6hler?= <andi5.py@gmx.net>
Subject: Re: ''git submodule sync'' should not add uninitialized submodules
 to .git/config
Date: Fri, 24 Jun 2011 01:10:29 +0200
Message-ID: <4E03C7E5.4050008@gmx.net>
References: <0D2618D7-0681-4E71-B412-36D490D45B9D@gmail.com> <7v7h8c4nv3.fsf@alter.siamese.dyndns.org> <4E0390A7.8040505@web.de> <7vboxo2ne9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Maarten Billemont <lhunath@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 24 01:10:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZt2m-0006a0-KX
	for gcvg-git-2@lo.gmane.org; Fri, 24 Jun 2011 01:10:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933284Ab1FWXKf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jun 2011 19:10:35 -0400
Received: from mailout-de.gmx.net ([213.165.64.22]:50960 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932682Ab1FWXKe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jun 2011 19:10:34 -0400
Received: (qmail invoked by alias); 23 Jun 2011 23:10:32 -0000
Received: from g226106198.adsl.alicedsl.de (EHLO [192.168.178.25]) [92.226.106.198]
  by mail.gmx.net (mp020) with SMTP; 24 Jun 2011 01:10:32 +0200
X-Authenticated: #15850232
X-Provags-ID: V01U2FsdGVkX1/G6kk/597GMmS5iyShLDcfW/23GoeLIH1kuNWyZi
	5TdgwIOzdAFu9P
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.17) Gecko/20110516 Thunderbird/3.1.10
In-Reply-To: <7vboxo2ne9.fsf@alter.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176301>

Am 24.06.2011 00:28, schrieb Junio C Hamano:
---8<---
> Subject: submodule sync: do not auto-vivify uninteresting submodule
> 
> Earlier 33f072f (submodule sync: Update "submodule.<name>.url" for empty
> directories, 2010-10-08) attempted to fix a bug where "git submodule sync"
> command does not update the URL if the current superproject does not have
> a checkout of the submodule.
> 
> However, it did so by unconditionally registering submodule.$name.url to
> every submodule in the project, even the ones that the user has never
> showed interest in at all by running 'git submodule init' command. This
> caused subsequent 'git submodule update' to start cloning/updating submodules
> that are not interesting to the user at all.
> 
> Update the code so that the URL is updated from the .gitmodules file only
> for submodules that already have submodule.$name.url entries, i.e. the
> ones the user has showed interested in having a checkout.
---8<---

I think that describes the situation pretty well and the patch looks
good. I will not be able to test it before next week though, do not wait
for me.

There are two minor issues for me left.
(1) The man page of submodule sync talks about "all submodules" and not
"registered submodules". I treated it as "subsequent init" and
personally do not restrict the list of submodules, simply because my
build would not work without them.

(2) It is confusing to have registered submodules in .git/config without
a matching gitlink. Say, you switch between branch a1 with a submodule s
with url u1, to a branch without s, you git clean -xdff (url u1 is still
in .git/config, right?), and then to a branch a2 with s pointing to url
u2. This bugged me.

Ciao,
-- andi5
