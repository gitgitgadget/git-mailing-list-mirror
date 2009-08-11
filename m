From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] git stash: Give friendlier error when there is nothing to apply
Date: Tue, 11 Aug 2009 14:09:02 +0200
Message-ID: <200908111409.04506.trast@student.ethz.ch>
References: <4a81559c.05ae660a.591b.010b@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Ori Avtalion <ori@avtalion.name>
X-From: git-owner@vger.kernel.org Tue Aug 11 14:16:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaqGu-0000RC-64
	for gcvg-git-2@gmane.org; Tue, 11 Aug 2009 14:16:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753449AbZHKMJk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2009 08:09:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753329AbZHKMJk
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 08:09:40 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:8701 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753126AbZHKMJj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2009 08:09:39 -0400
Received: from CAS02.d.ethz.ch (129.132.178.236) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.1.375.2; Tue, 11 Aug
 2009 14:09:40 +0200
Received: from thomas.localnet (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.1.375.2; Tue, 11 Aug
 2009 14:09:17 +0200
User-Agent: KMail/1.12.0 (Linux/2.6.27.25-0.1-default; KDE/4.3.0; x86_64; ; )
In-Reply-To: <4a81559c.05ae660a.591b.010b@mx.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125529>

Ori Avtalion wrote:
>  apply_stash () {
> +	have_stash || die 'Nothing to apply'
> +
>  	git update-index -q --refresh &&
>  	git diff-files --quiet --ignore-submodules ||
>  		die 'Cannot apply to a dirty working tree, please stage your changes'
> 

This needs a guard against the case where the user says

  git stash apply $some_sha1

but his refs/stash is empty.  This could be the case, e.g., after
mistakenly blowing away the reflog with 'git stash clear' and then
going on a recovery hunt through the unreferenced commits.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
