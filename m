From: Matt Draisey <matt@draisey.ca>
Subject: Detached checkout will clobber branch head when using symlink HEAD
Date: Wed, 15 Oct 2008 14:24:47 -0400
Message-ID: <1224095087.5366.19.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 15 20:26:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqB4e-0000W6-To
	for gcvg-git-2@gmane.org; Wed, 15 Oct 2008 20:26:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751823AbYJOSZI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2008 14:25:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751736AbYJOSZI
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Oct 2008 14:25:08 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:40259 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751246AbYJOSZH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2008 14:25:07 -0400
Received: by ug-out-1314.google.com with SMTP id k3so1395344ugf.37
        for <git@vger.kernel.org>; Wed, 15 Oct 2008 11:25:02 -0700 (PDT)
Received: by 10.67.19.13 with SMTP id w13mr5784454ugi.35.1224095101765;
        Wed, 15 Oct 2008 11:25:01 -0700 (PDT)
Received: from ?192.168.0.100? (bas2-windsor12-1128661893.dsl.bell.ca [67.70.3.133])
        by mx.google.com with ESMTPS id u6sm151430uge.13.2008.10.15.11.24.58
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 15 Oct 2008 11:25:00 -0700 (PDT)
X-Mailer: Evolution 2.6.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98293>

The faulty code appears to be this

git 1.6.0.2.526.g5c283
builtin-checkout.c

>    481	static void update_refs_for_switch(struct checkout_opts *opts,

>    500		if (new->path) {
> 
>    511		} else if (strcmp(new->name, "HEAD")) {
>    512			update_ref(msg.buf, "HEAD", new->commit->object.sha1, NULL,
>    513				   REF_NODEREF, DIE_ON_ERR);
>    514			if (!opts->quiet) {
>    515				if (old->path)
>    516					fprintf(stderr, "Note: moving to \"%s\" which isn't a local branch\nIf you want to create a new branch from this checkout, you may do so\n(now or later) by using -b with the checkout command again. Example:\n  git checkout -b <new_branch_name>\n", new->name);
>    517				describe_detached_head("HEAD is now at", new->commit);
>    518			}
>    519		}

If HEAD is a symlink rather than a "ref:" style link this is really bad.
