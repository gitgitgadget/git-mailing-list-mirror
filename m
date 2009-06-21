From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 2/7] Modify fast-export testcase to check that we correctly omit tags of trees
Date: Sun, 21 Jun 2009 08:17:51 +0200
Message-ID: <200906210817.51520.j6t@kdbg.org>
References: <1245472623-28103-1-git-send-email-newren@gmail.com> <1245472623-28103-3-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de,
	kusambite@gmail.com
To: newren@gmail.com
X-From: git-owner@vger.kernel.org Sun Jun 21 08:18:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MIGNQ-0006pn-7w
	for gcvg-git-2@gmane.org; Sun, 21 Jun 2009 08:18:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752522AbZFUGRx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jun 2009 02:17:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752181AbZFUGRw
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Jun 2009 02:17:52 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:63006 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751472AbZFUGRw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jun 2009 02:17:52 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 3EAA9CDF87;
	Sun, 21 Jun 2009 08:17:52 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id EB6AE280CF;
	Sun, 21 Jun 2009 08:17:51 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <1245472623-28103-3-git-send-email-newren@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121966>

On Samstag, 20. Juni 2009, newren@gmail.com wrote:
> -test_expect_success 'tree_tag'        'git fast-export tree_tag'
> +test_expect_success 'tree_tag'        '
> +	mkdir result &&
> +	cd result &&
> +	git init &&
> +	cd ..
> +	git fast-export tree_tag | (cd result && git fast-import)
> +'

You should make this

test_expect_success 'tree_tag' '
	mkdir result &&
	(cd result && git init) &&
	git fast-export tree_tag > fe-stream &&
	(cd result && git fast-import < fe-stream)
'

in order to (1) not remain in the wrong directory if git init fails, and (2) 
to catch failures in git fast-export.

-- Hannes
