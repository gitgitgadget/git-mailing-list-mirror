From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 14/16] clone: support narrow checkout with --path option
Date: Mon, 15 Sep 2008 13:27:04 -0700
Message-ID: <7vy71t9muf.fsf@gitster.siamese.dyndns.org>
References: <1221397685-27715-1-git-send-email-pclouds@gmail.com>
 <1221397685-27715-2-git-send-email-pclouds@gmail.com>
 <1221397685-27715-3-git-send-email-pclouds@gmail.com>
 <1221397685-27715-4-git-send-email-pclouds@gmail.com>
 <1221397685-27715-5-git-send-email-pclouds@gmail.com>
 <1221397685-27715-6-git-send-email-pclouds@gmail.com>
 <1221397685-27715-7-git-send-email-pclouds@gmail.com>
 <1221397685-27715-8-git-send-email-pclouds@gmail.com>
 <1221397685-27715-9-git-send-email-pclouds@gmail.com>
 <1221397685-27715-10-git-send-email-pclouds@gmail.com>
 <1221397685-27715-11-git-send-email-pclouds@gmail.com>
 <1221397685-27715-12-git-send-email-pclouds@gmail.com>
 <1221397685-27715-13-git-send-email-pclouds@gmail.com>
 <1221397685-27715-14-git-send-email-pclouds@gmail.com>
 <1221397685-27715-15-git-send-email-pclouds@gmail.com>
 <m3r67mmu0v.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 15 22:29:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfKgo-0005BP-Tu
	for gcvg-git-2@gmane.org; Mon, 15 Sep 2008 22:28:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756223AbYIOU1Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2008 16:27:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756157AbYIOU1P
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Sep 2008 16:27:15 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:33293 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754166AbYIOU1O (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2008 16:27:14 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A0CD261C8C;
	Mon, 15 Sep 2008 16:27:11 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id A013C61C8A; Mon, 15 Sep 2008 16:27:07 -0400 (EDT)
In-Reply-To: <m3r67mmu0v.fsf@localhost.localdomain> (Jakub Narebski's message
 of "Sun, 14 Sep 2008 12:01:22 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: AD2E7F60-8364-11DD-8823-D0CFFE4BC1C1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95939>

Jakub Narebski <jnareb@gmail.com> writes:

> Second, how `--path=<narrow_spec>` interacts with `-n' (no checkout).
> Does it even have any sense? Perhaps those options should be mutually
> incompatibile (and --bare and this option too)?

Technically you could mark the index entries with no-checkout bits even
with -n, so that later checkout or branch switching would honor that, but
the branch switching would make paths that do not exist in the remote HEAD
branch but do exist in the switched-to branch appear, which would be
confusing.  So instead of supporting:

	$ git clone -n --path=Documentation/ $there work
        $ cd work
        $ git checkout next

we can support:

	$ git clone -n $there work
        $ cd work
        $ git checkout --path=Documentation/ next

which is much easier to explain and understand.
